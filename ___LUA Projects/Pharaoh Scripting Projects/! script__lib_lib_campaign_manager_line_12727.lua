----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--
--	CAMPAIGN_MANAGER
--
---	@set_environment campaign
---	@class campaign_manager Campaign Manager
--- @alias cm
--- @index_pos 1
--- @desc The campaign manager is the main interface object in the campaign scripting environment. It provides a number of features and quality-of-life improvements in its own right, and also wraps the <a href="../../scripting_doc.html">game interface</a> that the campaign model provides to script. Any calls made to the campaign manager that the campaign manager doesn't provide itself are passed through to this game interface.
--- @desc The underlying game interface (the episodic scripting interface) is documented separately, in an html file that is generated when a campaign is run. It may be viewed <a href="../../scripting_doc.html">here</a>. If this link is dead, start a campaign and try again.
--- @desc Some of the features and quality-of-life improvements that the campaign manager offers:
--- @desc <ul><li>Support functions for saving and loading persistent values to and from the savegame.</li>
--- @desc <li>Registering functions to be called when game creation events occur (new/existing game, single/multiplayer).</li>
--- @desc <li>Stores information about the game for easy retrieval, such as the key of the local player faction.</li>
--- @desc <li>Functions to scroll the camera.</li>
--- @desc <li>Registering timer callbacks to call functions in the future.</li>
--- @desc <li>Showing advice.</li>
--- @desc <li>Faction turn start events.</li>
--- @desc <li>Helper functions for moving and creating armies and agents.</li>
--- @desc <li>Random number generation.</li>
--- @desc <li>Triggering events a number of turns in the future.</li>
--- @desc <li>Validation/output wrappers for a variety of game interface functions.</li>
--- @desc And more!
--- @desc A campaign manager object is automatically created when the scripts load in campaign configuration. It is called <code>cm</code>.

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

local EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE = 5;

settlement_prepend_str = "settlement:";

-- __save_counter, used to determine if this is a new game
__save_counter = 0;


function get_cm()
     if core:get_static_object("campaign_manager") then
          return core:get_static_object("campaign_manager");
     else
          script_error("get_cm() called but no campaign manager created as yet");
     end;
end;

campaign_manager = { -- default values should not be nil, otherwise they'll fail if looked up
     name = "",
     name_is_set = false,
     game_interface = false,
     cinematic = false,
     tm = false, -- timer manager
     factions = {},
     model_is_created = false,
     game_is_running = false,
     pre_first_tick_callbacks = {},
     first_tick_callbacks = {},
     first_tick_callbacks_sp_new = {},
     first_tick_callbacks_sp_each = {},
     first_tick_callbacks_mp_new = {},
     first_tick_callbacks_mp_each = {},
     saving_game_callbacks = {},
     post_saving_game_callbacks = {},
     loading_game_callbacks = {},
     linear_sequence_configurations = {},
     saved_values = {},
     long_savegame_strings_map = {},
     long_savegame_strings_lookup = {},
     checkpoints_lookup = {},
     checkpoints_indexed = {},
     started_from_checkpoint = false,
     savegame_version = 0,
     game_is_loaded = false,
     is_multiplayer_campaign = false,
     local_faction_name = "",
     human_factions = {},
     has_local_faction_initialized_event_been_triggered = false,
     factions_at_campaign_start = {},
     use_cinematic_borders_for_automated_cutscenes = true,
     ui_hiding_enabled = true,
     locomotion_failed_warning_enabled = true,

     -- cached local player culture and subculture keys
     local_faction_culture_key = "",
     local_faction_subculture_key = "",

     -- save counters
     save_counter = 0,

     -- ui locking
     ui_locked_for_mission = false,

     -- advice
     pre_dismiss_advice_callbacks = {},
     PROGRESS_ON_ADVICE_FINISHED_REPOLL_TIME = 0.2,
     advice_enabled = true,
     progress_on_advice_dismissed_str = "progress_on_advice_dismissed",
     progress_on_advice_finished_str = "progress_on_advice_finished",
     modify_advice_str = "modify_advice",
     next_advice_location = false,
     show_advice_finished_callback = false,

     -- campaign ui
     campaign_ui_manager = false,

     -- objective and infotext managers
     objectives = false,
     infotext = false,

     -- help page manager
     hpm = false,

     -- mission managers
     mission_managers = {},

     -- turn countdown events
     turn_countdown_events = {},

     -- event error logs saved to savegame
     event_error_logs = {},

     -- intervention manager
     intervention_manager = false,

     -- intervention max cost points per session constant
     campaign_intervention_max_cost_points_per_session = 100,

     -- turn number modifier
     turn_number_modifier = 0,

     -- records whether we're in a battle sequence
     -- if a player battle this will be between the PendingBattle event and the camera being returned to player control post-battle
     -- if not a player battle this will be between the PendingBattle event and the BattleCompleted event
     processing_battle = false, -- saved into savegame

     -- diplomacy panel context listener
     diplomacy_panel_context_listener_started = false,

     -- faction region change monitor
     faction_region_change_list = {},

     -- event feed message suppression
     all_event_feed_messages_suppressed = false,

     -- pending battle cache
     pbc_data = {},

     -- cutscene list & debug mode
     active_cutscene = nil,
     is_campaign_cutscene_debug = false,

     -- scripted subtitles
     subtitles_component_created = false,
     subtitles_visible = false,

     -- chapter mission list
     chapter_missions = {},

     -- settlement viewpoint bearing overrides
     settlement_viewpoint_bearings = {},

     -- cached camera records
     cached_camera_records = {},

     -- notify on character movement monitors
     notify_on_character_movement_active_monitors = {},

     -- mp queries
     progress_on_all_clients_ui_triggers = {},
     mp_queries = {},
     mp_query_count = 0
};


-- set campaign_manager to be of custom type TYPE_CAMPAIGN_MANAGER
set_class_custom_type_and_tostring(campaign_manager, TYPE_CAMPAIGN_MANAGER);










----------------------------------------------------------------------------
--- @section Creation
--- @desc A campaign manager is automatically created when the script libraries are loaded - see the page on @campaign_script_structure - so there should be no need for client scripts to call @campaign_manager:new themselves. The campaign manager object created is called <code>cm</code>, which client scripts can make calls on.
----------------------------------------------------------------------------


--- @function new
--- @desc Creates and returns a campaign manager. If one has already been created it returns the existing campaign manager. Client scripts should not need to call this as it's already called, and a campaign manager set up, within the script libraries. However the script libraries cannot know the name of the campaign, so client scripts will need to set this using @campaign_manager:set_campaign_name.
--- @p [opt="<unnamed>"] string campaign name
--- @return campaign_manager campaign manager
function campaign_manager:new(name)
     -- see if a campaign manager has already been registered and return it if it has
     local cm = core:get_static_object("campaign_manager");
     if cm then
          return cm;
     end;

     -- set a temporary name for the campaign manager if one was not supplied
     local name_is_set = false;
     if name then
          name_is_set = true;
     else
          name = "<unnamed>";
     end;

     if not is_string(name) then
          script_error("ERROR: Attempted to create campaign manager but supplied name [" ..
          tostring(name) .. "] is not a string or nil");
          return false;
     end;

     -- set up campaign manager object
     local cm = {};

     -- set 'cm' to derive from self ('campaign_manager')
     set_object_class(cm, self);

     cm.name = name;
     cm.name_is_set = name_is_set;
     cm.factions = {};
     cm.game_is_running = false;
     cm.pre_first_tick_callbacks = {};
     cm.first_tick_callbacks = {};
     cm.first_tick_callbacks_sp_new = {};
     cm.first_tick_callbacks_sp_each = {};
     cm.first_tick_callbacks_mp_new = {};
     cm.first_tick_callbacks_mp_each = {};
     cm.saving_game_callbacks = {};
     cm.post_saving_game_callbacks = {};
     cm.loading_game_callbacks = {};
     cm.human_factions = {};
     cm.factions_at_campaign_start = {}
     cm.pre_dismiss_advice_callbacks = {};
     cm.hyperlink_click_listeners = {};
     cm.mission_succeeded_callbacks = {};
     cm.saved_values = {};
     cm.long_savegame_strings_map = {};
     cm.long_savegame_strings_lookup = {};
     cm.mission_managers = {};
     cm.turn_countdown_events = {};
     cm.notify_on_character_movement_active_monitors = {};
     cm.linear_sequence_configurations = {};
     cm.mp_queries = {};
     cm.progress_on_all_clients_ui_triggers = {};
     cm.event_error_logs = {};
     cm.checkpoints_lookup = {};
     cm.checkpoints_indexed = {};

     -- tooltip mouseover listeners
     cm.tooltip_mouseover_listeners = {};
     cm.active_tooltip_mouseover_listeners = {};

     -- faction region change monitor
     cm.faction_region_change_list = {};

     -- key stealing
     cm.stolen_keys = {};
     cm.user_input_stolen = false;
     cm.escape_key_stolen = false;

     -- starts infotext and objectives managers automatically
     cm.infotext = infotext_manager:new();
     cm.objectives = objectives_manager:new();
     -- cm.objectives:set_debug();
     cm.hpm = help_page_manager:new();

     -- stops infotext being added if advice is navigated
     core:add_listener(
          "advice_navigation_listener",
          "ComponentLClickUp",
          function(context) return context.string == "button_previous" or context.string == "button_next" end,
          function(context) cm.infotext:cancel_add_infotext() end,
          true
     );

     -- start pending battle cache
     cm.pbc_data = {
          attacker_data = {
               armies = {}
          },
          defender_data = {
               armies = {}
          }
     };
     cm:start_pending_battle_cache();

     -- list of chapter missions
     cm.chapter_missions = {};

     -- cached camera positions
     cm.cached_camera_records = {};

     -- overwrite out() with a custom output function for campaign
     getmetatable(out).__call = function(t, input) -- t is the 'this' object
          -- support for printing other types of objects
          if not is_string(input) then
               if is_number(input) or is_nil(input) or is_boolean(input) then
                    input = tostring(input);
               elseif is_uicomponent(input) then
                    out("%%%%% uicomponent (more output on ui tab):");
                    out("%%%%% " .. uicomponent_to_str(input));
                    output_uicomponent(input);
                    return;
               else
                    cm:output_campaign_obj(input);
                    return;
               end;
          end;

          input = input or "";

          local timestamp = get_timestamp();
          local output_str = timestamp .. string.format("%" .. 11 - string.len(timestamp) .. "s", " ");

          -- add in all required tab chars
          for i = 1, out.tab_levels["out"] do
               output_str = output_str .. "\t";
          end;

          output_str = output_str .. input;
          print(output_str);

          -- logfile output
          if __write_output_to_logfile then
               local file = io.open(__logfile_path, "a");
               if file then
                    file:write("[out] " .. output_str .. "\n");
                    file:close();
               end;
          end;
     end;

     -- output
     if name_is_set then
          out("Starting campaign manager for " .. name .. " campaign");
     else
          out("Starting campaign manager, name is not currently set");
     end;

     -- start listener for the NewSession event
     core:add_listener(
          "campaign_manager_new_session_listener",
          "NewSession",
          true,
          function(context)
               -- set up proper link to game_interface object
               local game_interface = GAME(context);
               cm.game_interface = game_interface;
               cm.cinematic = game_interface:cinematic();

               -- Create a link to the game interface object in the global registry. This is used by autotest scripts (which are also responsible for its deletion)
               _G.campaign_env = core:get_env();

               -- overwrite previous index entry
               set_object_class(self, game_interface);
          end,
          true
     );

     core:add_listener(
          "campaign_manager_local_faction_initialized_event",
          "LocalFactionInitialized",
          true,
          function(context)
               cm:local_faction_initialized_event(context)
          end,
          false
     );

     -- start listener for the WorldCreated event: when it's received, start campaign listeners that must start before the first tick
     core:add_listener(
          "campaign_manager_world_created_listener",
          "WorldCreated",
          true,
          function(context)
               cm.model_is_created = true;

               local is_multiplayer_campaign = cm.game_interface:model():is_multiplayer();

               -- Complete setup of the timer manager
               cm.tm:setup_after_campaign_world_created();

               -- start listeners for tracking whether we're processing a battle.
               -- this has to be done now as some UI panels will open before the first tick
               cm:start_processing_battle_listeners(is_multiplayer_campaign);

               -- prevent UI input if this is a new singleplayer game, to prevent players from being able to skip any intro cutscene before it gets a chance to play
               if cm:is_new_game() and not is_multiplayer_campaign then
                    cm:steal_user_input(true);

                    -- if user input has been stolen then check whether any cutscenes have been registered on the first tick - if none have, then release user input (as no intro cutscene is loaded to do it for us)
                    -- (this is a bit of a hack)
                    cm:add_first_tick_callback_sp_new(
                         function()
                              if not self.active_cutscene then
                                   cm:steal_user_input(false);
                              end
                         end
                    );
               end;
          end,
          true
     );


     -- start listener for the FirstTickAfterWorldCreated event: generally used
     -- by users to kick off startup scripts
     core:add_listener(
          "campaign_manager_first_tick_listener",
          "FirstTickAfterWorldCreated",
          true,
          function(context)
               cm:first_tick(context);
          end,
          true
     );

     -- Load the event error log and check it when the game is loaded
     cm:add_loading_game_callback(
          function()
               local event_error_logs = cm.event_error_logs;
               if event_error_logs then
                    if is_table(event_error_logs) then
                         if #event_error_logs > EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE then
                              -- we are loading more errors than we can support, so rebuild the list at the smaller size
                              local new_event_error_logs = {};

                              for i = #event_error_logs + 1 - EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE, #event_error_logs do
                                   table.insert(new_event_error_logs, event_error_logs[i]);
                              end;

                              event_error_logs = new_event_error_logs;
                              cm:set_saved_value("event_error_logs", event_error_logs);
                         end;
                    else
                         script_error("WARNING: loading game, but event_error_logs value in savegame is of type [" ..
                         type(event_error_logs) ..
                         "] which is not a table. Will set it to be a blank table. Value is: " ..
                         tostring(event_error_logs));
                         event_error_logs = {};
                         cm:set_saved_value("event_error_logs", event_error_logs);
                    end;
               else
                    event_error_logs = {};
               end;
               cm:check_event_errors_on_startup();
          end
     );

     -- start listeners for the SavingGame and LoadingGame events
     core:add_listener(
          "campaign_manager_saving_game_listener",
          "SavingGame",
          true,
          function(context)
               cm:saving_game(context);
          end,
          true
     );

     core:add_listener(
          "campaign_manager_loading_game_listener",
          "LoadingGame",
          true,
          function(context)
               cm:loading_game(context);
          end,
          true
     );

     -- declare some lookup listeners
     core:declare_lookup_listener(
          "faction_turn_start_listeners_by_name",
          "FactionTurnStart",
          function(context)
               return context:faction():name();
          end
     );

     core:declare_lookup_listener(
          "faction_turn_start_listeners_by_culture",
          "FactionTurnStart",
          function(context)
               return context:faction():culture();
          end
     );

     core:declare_lookup_listener(
          "faction_turn_start_listeners_by_subculture",
          "FactionTurnStart",
          function(context)
               return context:faction():subculture();
          end
     );

     core:add_listener(
          "cm_advice_history_cleared",
          "AdviceCleared",
          true,
          function()
               lock_all_tutorial_cards()
          end,
          true
     )

     -- Create the timer manager, although it won't be fully operational until the WorldCreated event is received
     cm.tm = timer_manager:new_campaign(cm);
     core.tm = cm.tm;

     -- start UITrigger monitor process
     cm:start_progress_on_all_clients_ui_triggered_monitor();

     cm:start_mp_query_listener();

     -- register this object as a static object with the core (only one may exist at a time)
     core:add_static_object("campaign_manager", cm);

     return cm;
end;

----------------------------------------------------------------------------
--- @section Usage
--- @desc Once created, which happens automatically when the script libraries are loaded, functions on the campaign manager object may be called in the form showed below.
--- @new_example Specification
--- @example cm:<i>&lt;function_name&gt;</i>(<i>&lt;args&gt;</i>)
--- @new_example Creation and Usage
--- @example cm = campaign_manager:new()		-- object automatically set up by script libraries
--- @example
--- @example -- within campaign script
--- @example cm:set_campaign_name("test_campaign")
----------------------------------------------------------------------------








----------------------------------------------------------------------------
--- @section Campaign Name
--- @desc Client scripts should set a name for the campaign using @campaign_manager:set_campaign_name before making other calls. This name is used for output and for loading campaign scripts.
----------------------------------------------------------------------------


--- @function set_campaign_name
--- @desc Sets the name of the campaign. This is used for some output, but is mostly used to determine the file path to the campaign script folder which is partially based on the campaign name. If the intention is to use @campaign_manager:require_path_to_campaign_folder or @campaign_manager:require_path_to_campaign_faction_folder to load in script files from a path based on the campaign name, then a name must be set first. The name may also be supplied to @campaign_manager:new when creating the campaign manager.
--- @p @string campaign name
function campaign_manager:set_campaign_name(name)
     if not is_string(name) then
          script_error("ERROR: set_campaign_name() called but supplied name [" .. tostring(name) .. "] is not a string");
          return false;
     end;
     self.name = name;
     self.name_is_set = true;
     out("Campaign name has been set to " .. name);
end;

--- @function get_campaign_name
--- @desc Returns the name of the campaign.
--- @return string campaign name
function campaign_manager:get_campaign_name()
     return self.name;
end;

----------------------------------------------------------------------------
--- @section Loading Campaign Script Files
--- @desc One important role of the campaign manager is to assist in the loading of script files related to the campaign. By current convention, campaign scripts are laid out in the following structure:
--- @desc <table class="simple"><tr><td><code>script/campaign/</code></td><td>scripts related to all campaigns</td></tr><tr><td><code>script/campaign/%campaign_name%/</code></td><td>scripts related to the current campaign</td></tr><tr><td><code>script/campaign/%campaign_name%/factions/%faction_name%/</code></td><td>scripts related to a particular faction in the current campaign (when that faction is being played)</td></tr></table>
--- @desc The functions in this section allow the paths to these script files to be derived from the campaign/faction name, and for scripts to be loaded in. @campaign_manager:load_local_faction_script is the easiest method for loading in scripts related to the local faction. @campaign_manager:load_global_script is a more general-purpose function to load a script with access to the global environment.
----------------------------------------------------------------------------


--- @function get_campaign_folder
--- @desc Returns a static path to the campaign script folder (currently "data/script/campaign")
--- @return string campaign folder path
function campaign_manager:get_campaign_folder()
     return "data/script/campaign";
end;

--- @function require_path_to_campaign_folder
--- @desc Adds the current campaign's folder to the path, so that the lua files related to this campaign can be loaded with the <code>require</code> command. This function adds the root folder for this campaign based on the campaign name i.e. <code>script/campaign/%campaign_name%/</code>, and also the factions subfolder within this. A name for this campaign must have been set with @campaign_manager:new or @campaign_manager:set_campaign_name prior to calling this function.
function campaign_manager:require_path_to_campaign_folder()
     -- don't proceed if no campaign name has been set
     if not self.name_is_set then
          script_error(
          "ERROR: require_path_to_campaign_folder() called but no campaign name set, call set_campaign_name() first");
          return false;
     end;

     package.path = package.path .. ";" .. self:get_campaign_folder() .. "/" .. self.name .. "/factions/?.lua" .. ";"
     package.path = package.path .. ";" .. self:get_campaign_folder() .. "/" .. self.name .. "/?.lua"
end;

--- @function require_path_to_campaign_faction_folder
--- @desc Adds the player faction's script folder for the current campaign to the lua path (<code>script/campaign/%campaign_name%/factions/%player_faction_name%/</code>), so that scripts related to the faction can be loaded with the <code>require</code> command. Unlike @campaign_manager:require_path_to_campaign_folder this can only be called after the game state has been created. A name for this campaign must have been set with @campaign_manager:new or @campaign_manager:set_campaign_name prior to calling this function.
function campaign_manager:require_path_to_campaign_faction_folder()
     -- don't proceed if no campaign name has been set
     if not self.name_is_set then
          script_error(
          "ERROR: require_path_to_campaign_folder() called but no campaign name set, call set_campaign_name() first");
          return false;
     end;

     if not self.game_is_running then
          script_error(
          "ERROR: require_path_to_campaign_folder() called but game has not yet been created - call this later in the load sequence");
          return false;
     end;

     local local_faction_name = self:get_local_faction_name(true);

     if not local_faction_name then
          script_error(
          "ERROR: require_path_to_campaign_faction_folder() called but no local faction could be found - has it been called too early during the load sequence, or during an autotest?");
          return false;
     end;

     package.path = package.path ..
     ";" .. self:get_campaign_folder() .. "/" .. self.name .. "/factions/" .. local_faction_name .. "/?.lua" .. ";"
end;

--- @function load_global_script
--- @desc This function attempts to load a lua script from all folders currently on the path, and, when loaded, sets the environment of the loaded file to match the global environment. This is used when loading scripts within a block (within if statement that is testing for the file's existence, for example) - loading the file with <code>require</code> would not give it access to the global environment.
--- @desc Call @campaign_manager:require_path_to_campaign_folder and/or @campaign_manager:require_path_to_campaign_faction_folder if required to include these folders on the path before loading files with this function, if required. Alternatively, use @campaign_manager:load_local_faction_script for a more automated method of loading local faction scripts.
--- @desc If the script file fails to load cleanly, a script error will be thrown.
--- @p string script name
--- @p [opt=false] boolean single player only

--- @new_example Loading faction script
--- @desc This script snippet requires the path to the campaign faction folder, then loads the "faction_script_loader" script file, when the game is created.
--- @example cm:add_pre_first_tick_callback(
--- @example 	function()
--- @example 		if cm:get_local_faction_name(true) then
--- @example 			cm:require_path_to_campaign_faction_folder();
--- @example
--- @example 			if cm:load_global_script("faction_script_loader") then
--- @example 				out("Faction scripts loaded");
--- @example 			end;
--- @example 		end;
--- @example 	end
--- @example );
--- @result Faction scripts loaded
function campaign_manager:load_global_script(scriptname, single_player_only)
     if single_player_only and self:is_multiplayer() then
          return false;
     end;

     if package.loaded[scriptname] then
          return package.loaded[scriptname];
     end;

     local package_path = string.gsub(scriptname, "%.", "/");
     local file = loadfile(package_path);

     if file then
          -- the file has been loaded correctly - set its environment, record that it's been loaded, then execute it
          out("Loading script " .. scriptname .. ".lua");
          out.inc_tab();

          setfenv(file, core:get_env());
          local lua_module = file(scriptname);
          package.loaded[scriptname] = lua_module or true;

          out.dec_tab();
          out(scriptname .. ".lua script loaded");
          return package.loaded[scriptname];
     end;

     -- the file was not loaded correctly, however loadfile doesn't tell us why. Here we try and load it again with require which is more verbose
     local success, err_code = pcall(function() require(scriptname) end);

     script_error("ERROR: Tried to load script " ..
     scriptname .. " without success - either the script is not present or it is not valid. See error below");
     out("*************");
     out("Returned lua error is:");
     out(err_code);
     out("*************");

     return false;
end;

--- @function load_local_faction_script
--- @desc Loads a script file in the factions subfolder that corresponds to the name of the local player faction, with the supplied string appellation attached to the end of the script filename. This function is the preferred method for loading in local faction-specific script files. It calls @campaign_manager:require_path_to_campaign_faction_folder internally to set up the path, and uses @campaign_manager:load_global_script to perform the loading. It must not be called before the game is created.
--- @p string script name appellation
--- @return @boolean file loaded successfully
--- @new_example
--- @desc Assuming a faction named <code>fact_example</code> in a campaign named <code>main_test</code>, the following script would load in the script file <code>script/campaigns/main_test/factions/fact_example/fact_example_start.lua</code>.
--- @example cm:add_pre_first_tick_callback(
--- @example 	function()
--- @example 		cm:load_local_faction_script("_start");
--- @example 	end
--- @example );
function campaign_manager:load_local_faction_script(name_appellation, single_player_only)
     if name_appellation then
          if not is_string(name_appellation) then
               script_error("ERROR: load_local_faction_script() called but supplied name appellation [" ..
               tostring(name_appellation) .. "] is not a string");
               return false;
          end;
     else
          name_appellation = "";
     end;

     local local_faction_name = self:get_local_faction_name(true);

     if not local_faction_name then
          out("Not loading local faction scripts as no local faction could be determined");
          return false;
     end;

     local script_name = local_faction_name .. name_appellation;

     if not vfs.exists("script/campaign/" .. self:get_campaign_name() .. "/factions/" .. local_faction_name .. "/" .. script_name .. ".lua") then
          script_error("ERROR: load_local_faction_script() couldn't find faction script called [" ..
          script_name .. "] for faction [" .. local_faction_name .. "]");
          return false;
     end;

     -- include path to scripts in script/campaigns/<campaign_name>/factions/<faction_name>/* associated with this campaign/faction
     self:require_path_to_campaign_faction_folder();


     out("Loading faction script " .. script_name .. " for faction " .. local_faction_name);

     out.inc_tab();

     -- faction scripts loaded here - function will return true if the load succeeded
     if self:load_global_script(script_name, single_player_only) then
          out.dec_tab();
          out("Faction scripts loaded");
          return true;
     else
          out.dec_tab();
     end;

     return false;
end;

--- @function load_exported_files
--- @desc Loads all lua script files with filenames that contain the supplied string from the target directory. This is used to load in exported files e.g. export_ancillaries.lua, as the asset graph system may create additional files with an extension of this name for each DLC, where needed (e.g. export_ancillaries_dlcxx.lua). The target directory is "script" by default.
--- @p string filename, Filename subset of script file(s) to load.
--- @p [opt="script"] string path, Path of directory to load script files from, from working data. This should be supplied without leading or trailing "/" separators.
--- @new_example
--- @desc Assuming a faction named <code>fact_example</code> in a campaign named <code>main_test</code>, the following script would load in the script file <code>script/campaigns/main_test/factions/fact_example/fact_example_start.lua</code>.
--- @new_example
--- @desc Loads all script files from the "script" folder which contain "export_triggers" as a subset of their name.
--- @example cm:load_exported_files("export_triggers")
function campaign_manager:load_exported_files(filename, path_str)
     if not is_string(filename) then
          script_error("ERROR: load_exported_files() called but no string filename supplied");
          return false;
     end;

     if path_str and not is_string(path_str) then
          script_error("ERROR: load_exported_files() called but supplied path [" ..
          tostring(path_str) .. "] is not a string");
          return false;
     end;

     path_str = path_str or "script";
     package.path = package.path .. ";" .. path_str .. "/?.lua;";

     local all_files_str = self.game_interface:filesystem_lookup("/" .. path_str .. "/", filename .. "*.lua");

     if not is_string(all_files_str) or string.len(all_files_str) == 0 then
          script_error("WARNING: load_exported_files() couldn't find any files with supplied name " .. filename);
          return;
     end;

     local files_to_load = {};
     local pointer = 1;

     while true do
          local next_separator = string.find(all_files_str, ",", pointer);

          if not next_separator then
               -- this is the last entry
               table.insert(files_to_load, string.sub(all_files_str, pointer));
               break;
          end;

          table.insert(files_to_load, string.sub(all_files_str, pointer, next_separator - 1));

          pointer = next_separator + 1;
     end;

     -- strip the path off the start and the .lua off the end
     for i = 1, #files_to_load do
          local current_str = files_to_load[i];

          -- find the last '\' or '/' character
          local pointer = 1;
          while true do
               local next_separator = string.find(current_str, "\\", pointer) or string.find(current_str, "/", pointer);

               if next_separator then
                    pointer = next_separator + 1;
               else
                    -- this is the last separator
                    if pointer > 1 then
                         current_str = string.sub(current_str, pointer);
                    end;
                    break;
               end;
          end;

          -- remove the .lua suffix, if any
          local suffix = string.sub(current_str, string.len(current_str) - 3);

          if string.lower(suffix) == ".lua" then
               current_str = string.sub(current_str, 1, string.len(current_str) - 4);
          end;

          files_to_load[i] = current_str;

          out.inc_tab();
          self:load_global_script(current_str);
          out.dec_tab();
     end;
end;

----------------------------------------------------------------------------
--- @section Loading Game
--- @desc Early in the campaign loading sequence the <code>LoadingGame</code> event is triggered by the game code, even when starting a new game. At this time, scripts are able to load script values saved into the savegame using @campaign_manager:load_named_value. These values can then be used by client scripts to set themselves into the correct state.
--- @desc Functions that perform the calls to @campaign_manager:load_named_value may be registered with @campaign_manager:add_loading_game_callback, so that they get called when the <code>LoadingGame</code> event is triggered.
--- @desc The counterpart function to @campaign_manager:load_named_value is @campaign_manager:save_named_value, which is used when the game saves to save values to the save file.
--- @desc See also @campaign_manager:set_saved_value and @campaign_manager:get_saved_value, which can be used at any time by client scripts to read and write values that will automatically saved and loaded to the save game.
--- @desc In the game loading sequence, the <code>LoadingGame</code> event is received before the game is created and the first tick.

--- @example cm:add_loading_game_callback(
--- @example	function(context)
--- @example		player_progression = cm:load_named_value("player_progression", 0, context);
--- @example 	end
--- @example )
----------------------------------------------------------------------------


local function get_saved_value_separator_str()
     return ":::";
end;


local function get_saved_value_terminator_str()
     return ";;;";
end;


-- Because of idiosyncracies in the behaviour of loadstring(), we swap out special characters like ", ', \\ and \n in strings within tables we want to save (this is done in table.tostring). This function restores the table after loading to its original state.
local function post_loadstring_table_fixup(t)
     for key, value in pairs(t) do
          local value_type = type(value);
          if value_type == "table" then
               post_loadstring_table_fixup(value);
          elseif value_type == "string" then
               t[key] = string_special_chars_post_load_fixup(t[key]);
          end;
     end;
end;


--- @function add_loading_game_callback
--- @desc Adds a callback to be called when the <code>LoadingGame</code> event is received from the game. This callback will be able to load information from the savegame with @campaign_manager:load_named_value. See also @campaign_manager:add_saving_game_callback and @campaign_manager:save_named_value to save the values that will be loaded here.
--- @desc Note that it is preferable for client scripts to use this function rather than listen for the <code>LoadingGame</code> event themselves as it preserves the ordering of certain setup procedures.
--- @p function callback, Callback to call. When calling this function the campaign manager passes it a single context argument, which can then be passed through in turn to @campaign_manager:load_named_value.
function campaign_manager:add_loading_game_callback(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_loading_game_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.loading_game_callbacks, callback);
end;

-- called internally when the LoadingGame event is received
function campaign_manager:loading_game(context)
     local counter = core:get_unique_counter();

     out("");
     out("********************************************************************************");
     out(self.name .. " event has occurred:: LoadingGame");
     out("\toutput is shown on the savegame console spool - unique counter for this output is [" .. counter .. "]");

     out.cache_tab("savegame");
     out.savegame("");
     out.savegame("********************************************************************************");
     out.savegame(self.name .. " event has occurred:: LoadingGame");
     out.inc_tab("savegame");
     out.savegame("unique counter for this output is [" .. counter .. "]");

     self.game_is_loaded = true;

     -- what version savegame is this?
     self.savegame_version = self:load_named_value("savegame_version", 0, context);

     --
     --
     -- Load long savegame strings map first, and build a lookup table
     local long_savegame_strings_map = self:load_named_value("long_savegame_strings_map", {}, context);
     local long_savegame_strings_lookup = {};
     for i = 1, #long_savegame_strings_map do
          long_savegame_strings_lookup[long_savegame_strings_map[i].name] = true;
     end;

     self.long_savegame_strings_map = long_savegame_strings_map;
     self.long_savegame_strings_lookup = long_savegame_strings_lookup;
     --

     -- loading library values
     self.save_counter = self:load_named_value("__save_counter", 0, context);

     -- only perform these actions if this is not a new game
     if not self:is_new_game() then
          self.processing_battle = self:load_named_value("is_processing_battle", false, context);

          if self.savegame_version == 0 then
               self:load_values_from_string_v1(self:load_named_value("saved_values", "", context));
          else
               self:load_values_from_string_v2(self:load_named_value("saved_values", "", context));
          end;

          -- set up the help page manager even if the tweaker disabling scripts is set
          self.hpm:load_history_from_string(self:load_named_value("help_page_history", "", context));

          local mission_managers_str = self:load_named_value("mission_managers", "", context);
          local intervention_manager_state_str = self:load_named_value("intervention_manager_state", "", context);

          -- Pending attackers and defenders used to be saved as a long string, with data separated by ',' and '$'.
          -- Now, it's saved in its native table form. But for older saves, still attempt to load from the string.
          self.pbc_data = self:load_named_value("pending_battle_cache_data", {}, context);
          if is_empty_table(self.pbc_data) then
               -- Older save detected - attempt to load pending battle cache data from the separate values it used to be saved as
               self.pbc_data.attacker_data = {
                    armies = {}
               };
               self.pbc_data.defender_data = {
                    armies = {}
               };

               -- load pending battle cache strings and then build the tables from them
               local pbc_attacker_str = self:load_named_value("pending_battle_cached_attacker_str", "", context);
               local pbc_defender_str = self:load_named_value("pending_battle_cached_defender_str", "", context);

               if pbc_attacker_str ~= "" then
                    self.pbc_data.attacker_data.armies = self:pending_battle_cache_table_from_string(pbc_attacker_str);
               end;
               if pbc_defender_str ~= "" then
                    self.pbc_data.defender_data.armies = self:pending_battle_cache_table_from_string(pbc_defender_str);
               end;

               self.pbc_data.attacker_data.value = self:load_named_value("pending_battle_cached_attacker_value", 0,
                    context);
               self.pbc_data.defender_data.value = self:load_named_value("pending_battle_cached_defender_value", 0,
                    context);

               self.pbc_data.attacker_data.strength = self:load_named_value("pending_battle_cached_attacker_strength", 0,
                    context);
               self.pbc_data.defender_data.strength = self:load_named_value("pending_battle_cached_defender_strength", 0,
                    context);
          end;

          self:turn_countdown_events_from_string(self:load_named_value("turn_countdown_events", "", context));
          self:faction_region_change_monitor_from_str(self:load_named_value("faction_region_change_monitor", "", context));

          self.event_error_logs = self:load_named_value("event_error_logs", {}, context);

          self:add_first_tick_callback(
               function()
                    self:mission_managers_from_string(mission_managers_str);
                    self:get_intervention_manager():state_from_string(intervention_manager_state_str);
               end
          );
     end;

     -- invasion manager state
     load_invasion_manager(context);

     -- process loading game callbacks
     for i = 1, #self.loading_game_callbacks do
          self.loading_game_callbacks[i](context);
     end;

     out.dec_tab("savegame");
     out.savegame("********************************************************************************");
     out.savegame("");
     out.restore_tab("savegame");

     out("********************************************************************************");
     out("");
end;

--- @function load_named_value
--- @desc Loads a named value from the savegame. This may only be called as the game is being loaded, and must be passed the context object supplied by the <code>LoadingGame</code> event. Values are saved and loaded from the savegame with a string name, and the values themselves can be a boolean, a number, a string, or a table containing booleans, numbers or strings.
--- @p string value name, Value name. This must be unique within the savegame, and should match the name the value was saved with, with @campaign_manager:save_named_value.
--- @p object default value, Default value, in case the value could not be loaded from the savegame. The default value supplied here is used to determine/must match the type of the value being loaded.
--- @p userdata context, Context object supplied by the <code>LoadingGame</code> event.
function campaign_manager:load_named_value(name, default, context)
     if not is_string(name) then
          script_error("ERROR: load_named_value() called but supplied value name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if default == nil then
          script_error("ERROR: load_named_value() called but no default value supplied");
          return false;
     end;

     if not context then
          script_error("ERROR: load_named_value() called but no context supplied");
          return false;
     end;

     if type(default) == "table" then
          local table_save_state = self:load_named_string(name, "", context);

          -- check that we have a value to convert to a table
          if table_save_state then
               local table_func = loadstring(table_save_state);

               if is_function(table_func) then
                    local retval = table_func();
                    if is_table(retval) then
                         post_loadstring_table_fixup(retval);
                         out.savegame("Loading value " .. name .. " [" .. tostring(retval) .. "]");
                         return retval;
                    end;
               end;
          end;

          return default;
     elseif is_string(default) then
          return self:load_named_string(name, default, context);
     else
          local retval = self.game_interface:load_named_value(name, default, context);
          out.savegame("Loading value " .. name .. " [" .. tostring(retval) .. "]");
          return retval;
     end;
end;

-- Load a string value from the savegame, potentially recombining it from multiple string values if a long string mapping exists
function campaign_manager:load_named_string(name, default, context)
     -- If we don't have any long string lookup for a variable with this name then just return it without any recombining
     if not self.long_savegame_strings_lookup[name] then
          return self.game_interface:load_named_value(name, default, context);
     end;

     -- Recombine this string from many in the savegame
     local str_table = {};

     local long_savegame_strings_map = self.long_savegame_strings_map;

     for i = 1, #long_savegame_strings_map do
          local current_map = long_savegame_strings_map[i];
          if current_map.name == name then
               local current_str = self.game_interface:load_named_value(current_map.long_str_name, "", context);
               table.insert(str_table, current_str);
          end;
     end;

     return table.concat(str_table);
end;

--- @function get_saved_value
--- @desc Retrieves a value saved using the saved value system. Values saved using @campaign_manager:set_saved_value are added to an internal register within the campaign manager, and are automatically saved and loaded with the game, so there is no need to register callbacks with @campaign_manager:add_loading_game_callback or @campaign_manager:add_saving_game_callback. Once saved with @campaign_manager:set_saved_value, values can be accessed with this function.
--- @desc Values are stored and accessed by a string name. Values can be booleans, numbers or strings.
--- @p string value name
--- @return object value
function campaign_manager:get_saved_value(name)
     return self.saved_values[name];
end;

--- @function get_cached_value
--- @desc Retrieves or generates a value saved using the saved value system. When called, the function looks up a value by supplied name using @campaign_manager:get_saved_value. If it exists it is returned, but if it doesn't exist a supplied function is called which generates the cached value. This value is saved with the supplied name, and also returned. A value is generated the first time this function is called, therefore, and is retrieved from the savegame on subsequent calls with the same arguments. If the supplied function doesn't return a value, a script error is triggered.
--- @p string value name
--- @p function generator callback
--- @return object value
function campaign_manager:get_cached_value(saved_value_name, generator_callback)
     if not is_string(saved_value_name) then
          script_error("ERROR: get_cached_value() called but supplied saved value name [" ..
          tostring(saved_value_name) .. "] is not a string");
          return false;
     end;

     if not is_function(generator_callback) then
          script_error("ERROR: get_cached_value() called but supplied generator callback [" ..
          tostring(generator_callback) .. "] is not a function");
          return false;
     end;

     local saved_value = self:get_saved_value(saved_value_name);

     if not is_nil(saved_value) then
          return saved_value;
     end;

     saved_value = generator_callback();

     if is_nil(saved_value) then
          script_error("ERROR: get_cached_value() generator callback did not return a valid value, returned value is [" ..
          tostring(saved_value) .. "]");
     else
          self:set_saved_value(saved_value_name, saved_value);
     end;

     return saved_value;
end;

-- called internally when the game loads, to load values saved with set_saved_value
function campaign_manager:load_values_from_string_v1(str)
     if not is_string(str) then
          script_error("ERROR: load_values_from_string() called but supplied string [" ..
          tostring(str) .. "] is not a string");
          return false;
     end;

     local pointer = 1;

     while true do
          local next_separator = string.find(str, ":", pointer);

          if not next_separator then
               break;
          end;

          local value_name = string.sub(str, pointer, next_separator - 1);
          pointer = next_separator + 1;

          next_separator = string.find(str, ":", pointer);

          if not next_separator then
               script_error("ERROR: load_values_from_string() called but supplied str is malformed: " .. str);
               return false;
          end;

          local value_type = string.sub(str, pointer, next_separator - 1);
          pointer = next_separator + 1;

          next_separator = string.find(str, ":", pointer);

          if not next_separator then
               script_error("ERROR: load_values_from_string() called but supplied str is malformed: " .. str);
               return false;
          end;

          local value_length = string.sub(str, pointer, next_separator - 1);
          local num_value_length = tonumber(value_length);

          if not num_value_length then
               script_error("ERROR: load_values_from_string() called, but retrieved value_length [" ..
               tostring(value_length) .. "] could not be converted to a number in string: " .. str);
               return false;
          end;

          pointer = next_separator + 1;

          local value = string.sub(str, pointer, pointer + num_value_length - 1);

          if value_type == "boolean" then
               if value == "true" then
                    value = true;
               else
                    value = false;
               end;
          elseif value_type == "number" then
               local value_number = tonumber(value);

               if not value_number then
                    script_error("ERROR: load_values_from_string() called, but couldn't convert loaded numeric value [" ..
                    value .. "] to a number in string: " .. str);
                    return false;
               else
                    value = value_number;
               end;
          elseif value_type ~= "string" then
               script_error("ERROR: load_values_from_string() called, but couldn't recognise supplied value type [" ..
               tostring(value_type) .. "] in string: " .. str);
               return false;
          end;

          pointer = pointer + num_value_length + 1;

          self:set_saved_value(value_name, value);
     end;
end;

function campaign_manager:load_values_from_string_v2(str)
     if not is_string(str) then
          script_error("ERROR: load_values_from_string() called but supplied string [" ..
          tostring(str) .. "] is not a string");
          return false;
     end;

     local pointer = 1;

     -- Separator str ":::"
     -- Terminator str ";;;"
     local separator_str = get_saved_value_separator_str();
     local terminator_str = get_saved_value_terminator_str();
     local separator_str_len = string.len(separator_str);
     local terminator_str_len = string.len(terminator_str);

     -- First, see if there is a count at the start of the string. Older savegames won't have it. If it's there, it will be in the format
     -- <num>;;; and its presence will allow us to verify the number of saved values being loaded again.
     local saved_count;

     do
          local next_separator = string.find(str, separator_str, pointer);
          local next_terminator = string.find(str, terminator_str, pointer);
          if next_separator and next_terminator and next_separator > next_terminator then
               -- The first terminator str ";;;" is before the first separator ":::", which must mean that the count is present
               local count_str = string.sub(str, pointer, next_terminator - 1);
               if count_str then
                    local count_num = tonumber(count_str);
                    if count_num then
                         saved_count = count_num;
                    end;
               end;

               -- position the pointer immediately after the first terminator
               pointer = next_terminator + terminator_str_len;
          end;
     end;

     local count = 0;
     while true do
          -- Format is:
          -- value_name:::value_type:::value_length:::value;;;
          local next_separator = string.find(str, separator_str, pointer);

          if not next_separator then
               break;
          end;

          -- Do an explicit test for a peculiar form of corruption that seems to be creeping in, where a number value followed by a terminator (e.g. 88;;;) is appearing in the middle of the saved string.
          -- This looks suspiciously like residual count validation values hanging around from previous savegames but I'm not sure how this can happen. Hopefully we can track it down.
          do
               local next_terminator = string.find(str, terminator_str, pointer);
               if next_terminator and next_terminator < next_separator then
                    local corrupted_name = string.sub(str, pointer, next_separator - 1);

                    -- Repair the pointer so that it jumps over the broken value
                    pointer = next_terminator + terminator_str_len;

                    -- string.sub(str, pointer, next_separator - 1)
                    script_error(
                    "WARNING: Attempting to load saved values but the saved value string is corrupted. A new value is being read but the next terminator is before the next separator. The corrupted value name [" ..
                    corrupted_name ..
                    "] will be recovered to [" ..
                    string.sub(str, pointer, next_separator - 1) .. "] so it should be safe to proceed");
               end;
          end;

          local value_name = string.sub(str, pointer, next_separator - 1);

          pointer = next_separator + separator_str_len;

          next_separator = string.find(str, separator_str, pointer);

          if not next_separator then
               script_error("ERROR: load_values_from_string() called but supplied str is malformed: " .. str);
               return false;
          end;

          local value_type = string.sub(str, pointer, next_separator - 1);
          pointer = next_separator + separator_str_len;

          next_separator = string.find(str, separator_str, pointer);

          if not next_separator then
               script_error("ERROR: load_values_from_string() called but supplied str is malformed: " .. str);
               return false;
          end;

          local value_length = string.sub(str, pointer, next_separator - 1);
          local num_value_length = tonumber(value_length);

          if not num_value_length then
               script_error("ERROR: load_values_from_string() called, but retrieved value_length [" ..
               tostring(value_length) .. "] could not be converted to a number in string: " .. str);
               return false;
          end;

          pointer = next_separator + separator_str_len;

          local value = string.sub(str, pointer, pointer + num_value_length - 1);

          if value_type == "boolean" then
               if value == "true" then
                    value = true;
               else
                    value = false;
               end;
          elseif value_type == "number" then
               local value_number = tonumber(value);

               if not value_number then
                    -- try replacing any "." characters with "," and vice versa
                    local value_copy = string.gsub(value, "%.", ",");

                    value_number = tonumber(value_copy);
                    if not value_number then
                         value_copy = string.gsub(value, ",", ".");
                         value_number = tonumber(value_copy);
                         if not value_number then
                              script_error(
                              "ERROR: load_values_from_string() called, but couldn't convert loaded numeric value [" ..
                              value .. "] to a number in string: " .. str);
                              return false;
                         end;
                    end;
               end;
               value = value_number;
          elseif value_type == "table" then
               local table_func = loadstring(value);

               if is_function(table_func) then
                    local t = table_func();
                    if is_table(t) then
                         post_loadstring_table_fixup(t);
                         value = t;
                    else
                         script_error(
                         "ERROR: load_values_from_string() called, but loaded table value (reproduced after this script error) with name [" ..
                         value_name .. "] could not be converted into a table - how can this be?");
                    end;
               else
                    script_error(
                    "ERROR: load_values_from_string() called, but loaded table value (reproduced after this script error) with name [" ..
                    value_name ..
                    "] could not be converted into a function by loadstring() - how can this be? table_func is " ..
                    tostring(table_func));
               end;
          elseif value_type ~= "string" then
               script_error("ERROR: load_values_from_string() called, but couldn't recognise supplied value type [" ..
               tostring(value_type) .. "] in string: " .. str);
               return false;
          end;

          count = count + 1;
          self:set_saved_value(value_name, value);

          pointer = pointer + num_value_length + terminator_str_len;
     end;

     if saved_count and count ~= saved_count then
          script_error("ERROR: loading values from string but while [" ..
          saved_count ..
          "] values were supposed to have been saved, [" ..
          count .. "] were loaded. This is a serious error, please investigate immediately");
     end;
end;

-----------------------------------------------------------------------------
--- @section Saving Game
--- @desc These are the complementary functions to those in the @"campaign_manager:Loading Game" section. When the player saves the game, the <code>SavingGame</code> event is triggered by the game. At this time, variables may be saved to the savegame using @campaign_manager:save_named_value. Callbacks that make calls to this function may be registered with @campaign_manager:add_saving_game_callback, so that they get called at the correct time.
-----------------------------------------------------------------------------


--- @function add_saving_game_callback
--- @desc Registers a callback to be called when the game is being saved. The callback can then save individual values with @campaign_manager:save_named_value.
--- @p function callback, Callback to call. When calling this function the campaign manager passes it a single context argument, which can then be passed through in turn to @campaign_manager:save_named_value.
function campaign_manager:add_saving_game_callback(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_saving_game_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.saving_game_callbacks, callback);
end;

--- @function add_post_saving_game_callback
--- @desc Add a callback to be called after the game has been saved. These callbacks are called last in the saving sequence, and only the first time the game is saved after they have been added.
--- @p function callback, Callback to call. When calling this function the campaign manager passes it a single context argument.
function campaign_manager:add_post_saving_game_callback(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_post_saving_game_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.post_saving_game_callbacks, callback);
end;

-- savegame version - increment this if savegame-breaking changes are made
local SAVEGAME_VERSION = 1;


-- called internally when the game saves
function campaign_manager:saving_game(context)
     local counter = core:get_unique_counter();

     self.long_savegame_strings_map = {};
     self.long_savegame_strings_lookup = {};

     out("");
     out("********************************************************************************");
     out(self.name .. " event has occurred:: SavingGame");
     out("\toutput is shown on the savegame console spool - unique counter for this output is [" ..
     counter .. "]. Savegame version is [" .. SAVEGAME_VERSION .. "]");

     out.cache_tab("savegame");
     out.savegame("");
     out.savegame("********************************************************************************");
     out.savegame(self.name .. " event has occurred:: SavingGame");
     out.inc_tab("savegame");
     out.savegame("unique counter for this output is [" ..
     counter .. "]. Savegame version is [" .. SAVEGAME_VERSION .. "]");

     -- increment the save_counter value
     self.save_counter = self.save_counter + 1;

     self:save_named_value("savegame_version", SAVEGAME_VERSION, context);

     -- process saving game callbacks
     for i = 1, #self.saving_game_callbacks do
          self.saving_game_callbacks[i](context);
     end;

     -- saving library values
     self:save_named_value("__save_counter", self.save_counter, context);
     self:save_named_value("saved_values", self:saved_values_to_string(), context);
     self:save_named_value("mission_managers", self:mission_managers_to_string(), context);
     self:save_named_value("intervention_manager_state", self:get_intervention_manager():state_to_string(), context);
     self:save_named_value("turn_countdown_events", self:turn_countdown_events_to_string(), context);
     self:save_named_value("faction_region_change_monitor", self:faction_region_change_monitor_to_str(), context);
     self:save_named_value("help_page_history", self.hpm:help_page_history_to_string(), context);
     self:save_named_value("is_processing_battle", self.processing_battle, context);
     self:save_named_value("event_error_logs", self:process_table_save(self.event_error_logs), context);
     self:save_named_value("factions_at_campaign_start", self.factions_at_campaign_start, context);

     -- Save pending battle cache data
     self:save_named_value("pending_battle_cache_data", self.pbc_data, context);

     -- invasion manager state
     save_invasion_manager(context);

     out.dec_tab("savegame");
     out.savegame("********************************************************************************");
     out.savegame("");
     out.restore_tab("savegame");

     out("********************************************************************************");
     out("");

     -- process post-saving game callbacks
     for i = 1, #self.post_saving_game_callbacks do
          self.post_saving_game_callbacks[i](context);
     end;

     -- make sure post-saving-game callbacks only happen once
     self.post_saving_game_callbacks = {};

     -- save the map of any long savegame strings last of all
     self:save_named_value("long_savegame_strings_map", self:process_table_save(self.long_savegame_strings_map), context);
end;

--- @function save_named_value
--- @desc Saves a named value from the savegame. This may only be called as the game is being saved, and must be passed the context object supplied by the <code>SavingGame</code> event. Values are saved (and loaded) from the savegame with a string name, and the values themselves can be a boolean, a number, a string, or a table containing booleans, numbers or strings.
--- @p string value name, Value name. This must be unique within the savegame, and will be used by @campaign_manager:load_named_value later to load the value.
--- @p object value, Value to save.
--- @p userdata context, Context object supplied by the <code>SavingGame</code> event.
function campaign_manager:save_named_value(name, value, context)
     if not is_string(name) then
          script_error("ERROR: save_named_value() called but supplied value name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if value == nil then
          script_error("ERROR: save_named_value() called but no value supplied");
          return false;
     end;

     if not context then
          script_error("ERROR: save_named_value() called but no context supplied");
          return false;
     end;

     out.savegame("Saving value " .. name .. " [" .. tostring(value) .. "]");
     if type(value) == "table" then
          local table_save_state = self:process_table_save(value);
          self:process_string_save(name, table_save_state, context);
     elseif is_string(value) then
          self:process_string_save(name, value, context);
     else
          self.game_interface:save_named_value(name, value, context);
     end;
end;

-- Called internally when a table needs to be saved.
-- Returns a string representation of a table.
function campaign_manager:process_table_save(tab)
     -- The -1 flag disables any max-depth checking, a table with a cyclical reference will cause an infinite loop
     local str = "return " .. table.tostring(tab, true, -1);
     return str;
end;

local string_saving_char_limit = 65535;

function campaign_manager:process_string_save(name, str, context)
     -- We have a character limit of 65535 on our strings. If this string is shorter than this then just go ahead and save it.
     local str_len = str:len();
     if str_len <= string_saving_char_limit then
          return self.game_interface:save_named_value(name, str, context);
     end;

     -- The string we're trying to save is longer than the character limit, so break it up into multiple smaller chunks
     local long_savegame_strings_map = self.long_savegame_strings_map;

     local start_ptr = 1;

     while true do
          local end_ptr = start_ptr + string_saving_char_limit - 1;
          local final_pass = false;

          if end_ptr > str_len then
               -- This is the final section of the input string
               end_ptr = str_len;
               final_pass = true;
          end;

          local current_substr = str:sub(start_ptr, end_ptr);

          local long_str_id = #long_savegame_strings_map + 1;
          local long_str_name = "long_string_" .. long_str_id;

          -- Save this chunk
          self.game_interface:save_named_value(long_str_name, current_substr, context);

          -- Add a record of this chunk mapped to the original string name, so that we can reconstitute it later
          table.insert(
               long_savegame_strings_map,
               {
                    name = name,
                    long_str_name = long_str_name
               }
          );

          if final_pass then
               break;
          end;

          start_ptr = end_ptr + 1;
     end;
end;

--- @function set_saved_value
--- @desc Sets a value to be saved using the saved value system. Values saved using this function are added to an internal register within the campaign manager, and are automatically saved and loaded with the game, so there is no need to register callbacks with @campaign_manager:add_loading_game_callback or @campaign_manager:add_saving_game_callback. Once saved with this function, the value can be accessed at any time with @campaign_manager:get_saved_value.
--- @desc Values are stored and accessed by a string name. Values can be of type @boolean, @number, @string or @table, where that table itself contains only booleans, numbers, string or other tables. Repeated calls to set_saved_value with the same name are legal, and will just overwrite the value of the value stored with the supplied name.
--- @p string value name, Value name.
--- @p object value, Value. Can be a boolean, number, string or table.
function campaign_manager:set_saved_value(name, value)
     if not is_string(name) then
          script_error("ERROR: set_saved_value() called but supplied name [" .. tostring(name) .. "] is not a string");
          return false;
     end;

     if string.find(name, ":") then
          script_error("ERROR: set_saved_value() called but supplied name [" ..
          name .. "] contains a : character, this is illegal");
          return false;
     end;

     if is_table(value) then
          -- validate this value if it's a table (don't do this in the release game as it'll be slow)
          if core:is_debug_config() and not self:validate_saved_table_value(value) then
               local separator_str = get_saved_value_separator_str();
               script_error("ERROR: set_saved_value() called with key name [" ..
               name ..
               "] and table value [" ..
               tostring(value) ..
               "] but this table contains a string containing \"" ..
               separator_str .. "\" - this is invalid, not saving. Dumping table to console after this error message.");
               -- out(table.tostring(value));
               return false;
          end;
     elseif not (is_boolean(value) or is_number(value) or is_string(value)) then
          script_error("ERROR: set_saved_value() called but supplied value [" ..
          tostring(name) .. "] is not a boolean, number, string or a table");
          return false;
     end;

     self.saved_values[name] = value;
end;

-- validates a table for set_saved_value by making sure that it does not contain a string containing a colon
function campaign_manager:validate_saved_table_value(t)
     local separator_str = get_saved_value_separator_str();
     for key, value in pairs(t) do
          if is_string(value) and string.find(value, separator_str) then
               return false;
          elseif is_table(value) and not self:validate_saved_table_value(value) then
               return false;
          end;
     end;
     return true;
end;

-- internal function for creating string from all saved values when saving
function campaign_manager:saved_values_to_string()
     local str_table = {};
     local saved_values = self.saved_values;
     local insert = table.insert;

     local separator_str = get_saved_value_separator_str();
     local terminator_str = get_saved_value_terminator_str();

     local count = 0;

     for value_name, value in pairs(saved_values) do
          -- Search for separator string or terminator string in the value_name and attempt to recover if they are found there.
          if string.find(value_name, separator_str) then
               local half_value_length = math.ceil(string.len(value_name));
               local new_value_name;

               local str_start, str_finish = string.find(value_name, separator_str);
               if str_start < half_value_length then
                    new_value_name = string.sub(value_name, 1, str_start - 1);
               else
                    new_value_name = string.sub(value_name, str_finish + 1);
               end;

               script_error(
               "WARNING: saved_values_to_string() called but an attempt was made to save a value with name [" ..
               value_name ..
               "] that contains a separator string [" ..
               separator_str ..
               "]. This is illegal. Will attempt to recover to value name [" ..
               new_value_name .. "] but this is a serious error and should be reported.");
          end;

          if string.find(value_name, terminator_str) then
               local half_value_length = math.ceil(string.len(value_name));
               local new_value_name;

               local str_start, str_finish = string.find(value_name, terminator_str);
               if str_start < half_value_length then
                    new_value_name = string.sub(value_name, 1, str_start - 1);
               else
                    new_value_name = string.sub(value_name, str_finish + 1);
               end;

               script_error(
               "WARNING: saved_values_to_string() called but an attempt was made to save a value with name [" ..
               value_name ..
               "] that contains a terminator string [" ..
               terminator_str ..
               "]. This is illegal. Will attempt to recover to value name [" ..
               new_value_name .. "] but this is a serious error and should be reported.");
          end;

          if is_table(value) then
               local str = self:process_table_save(value);

               insert(str_table, value_name);
               insert(str_table, separator_str);
               insert(str_table, "table");
               insert(str_table, separator_str);
               insert(str_table, string.len(str));
               insert(str_table, separator_str);
               insert(str_table, str);
               insert(str_table, terminator_str);
          else
               insert(str_table, value_name);
               insert(str_table, separator_str);
               insert(str_table, type(value));
               insert(str_table, separator_str);
               insert(str_table, string.len(tostring(value)));
               insert(str_table, separator_str);
               insert(str_table, tostring(value));
               insert(str_table, terminator_str);
          end;

          count = count + 1;
     end;

     -- insert the number of saved values so that we can verify this on load
     insert(str_table, 1, count .. terminator_str);

     return table.concat(str_table);
end;

--- @function save
--- @desc Instructs the campaign game to save, either with a supplied filename or, if no filename is supplied, as an autosave at the next opportunity. An optional completion callback may be supplied.
--- @desc The function returns whether the save operation succeeded. This return value is always <code>true</code> if no filename was supplied to the function, as the underlying function @episodic_scripting:autosave_at_next_opportunity is used for saving and this will succeed eventually. When a filename is supplied the underlying function @episodic_scripting:save_game is used to make a single attempt to save the game. This can fail if the game is not in the correct state at the time the save is attempted.
--- @p [opt=nil] @string filename, Filename to save as. If @nil or a blank string is supplied then the game will be autosaved.
--- @p [opt=nil] @function callback, Completion callback. If supplied, this is called when the save procedure is completed.
--- @p [opt=nil] @boolean lock afterwards, Lock saving functionality after saving is completed. If <code>true</code> is supplied here then the saving is disabled, if <code>false</code> is supplied then saving is enabled. If @nil is supplied, then the restriction on saving is restored to what it was prior to this function being called.
--- @p [opt=false] @boolean suppress callback on failure, Don't call the supplied completion callback if the save operation fails. Save operations can fail if a filename is supplied (so autosaving is not used, which would wait for an opportunity to save) and the game is not in a position to save at this time. By default, the completion callback is called if the operation fails.
--- @r @boolean save operation succeeded
function campaign_manager:save(filename, callback, lock_afterwards, suppress_callback_on_failure)
     if filename and not validate.is_string(filename) then
          return false;
     end;

     if callback and not validate.is_function(callback) then
          return false;
     end;

     local saving_previously_disabled = self.game_interface:is_saving_disabled();

     if saving_previously_disabled then
          self:disable_saving_game(false);
     end;

     if is_nil(lock_afterwards) then
          lock_afterwards = saving_previously_disabled;
     else
          lock_afterwards = not not lock_afterwards;
     end;

     local save_succeeded = true;

     -- Define a post-save callback
     local function post_save_callback()
          self:disable_saving_game(lock_afterwards);

          if is_function(callback) and (save_succeeded or not suppress_callback_on_failure) then
               callback();
          end;
     end;

     if filename and string.len(filename) > 0 then
          save_succeeded = self:save_game(filename);
          post_save_callback();
     else
          self:add_post_saving_game_callback(post_save_callback);
          self:autosave_at_next_opportunity();
     end;

     return save_succeeded;
end;

-- Event Error logging
-- This function is called from core if an event has been triggered in campaign and caused a script failure. The campaign manager maintains a log of these errors in the savegame.
function campaign_manager:log_event_error(event_name, error, traceback, establishing_callstack, is_event_condition)
     -- make a string of which faction(s) is/are currently processing their turn
     local faction_list_table = {};
     local turn_number;

     if self.model_is_created then
          turn_number = self:turn_number();

          -- cm:whose_turn_is_it() may return a faction list in future if simultaneous turns appear, so support this function returning either a string or a faction list
          local whose_turn_is_it_result = cm:whose_turn_is_it();
          if is_string(whose_turn_is_it_result) then
               table.insert(faction_list_table, whose_turn_is_it_result);
          elseif is_factionlist(whose_turn_is_it_result) then
               for _, faction in model_pairs(whose_turn_is_it_result) do
                    table.insert(faction_list_table, faction:name());
               end;
          end;
     else
          turn_number = "<couldn't determine turn number>";
          table.insert(faction_list_table, "<error occurred during load before model created>");
     end;

     table.insert(
          self.event_error_logs,
          {
               event_name = event_name,
               error = error,
               traceback = traceback,
               establishing_callstack = establishing_callstack,
               is_event_condition = is_event_condition,
               turn_number = turn_number,
               whose_turn_is_it = table.concat(faction_list_table, ", ")
          }
     );

     if #self.event_error_logs > EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE then
          if not cm:get_saved_value("event_error_log_size_warning_issued") then
               script_error(
               "WARNING: log_event_error() called but the size of the event error log has exceeded the max size [" ..
               EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE ..
               "], some errors will be pruned - the script has failed a lot in this game, please investigate this");
               cm:set_saved_value("event_error_log_size_warning_issued", true);
          end;

          -- remove the oldest log entry
          table.remove(self.event_error_logs, 1);
     end;
end;

function campaign_manager:check_event_errors_on_startup()
     local num_errors = #self.event_error_logs;
     if num_errors > 0 then
          out("");
          out("");
          out("");
          out("******************************************************");
          out("check_event_errors_on_startup() is listing " ..
          num_errors .. " event error" .. (num_errors == 1 and "" or "s") .. ":");
          out("******************************************************");
          out("");

          for i = 1, num_errors do
               local current_entry = self.event_error_logs[i];
               out("ERROR " .. i .. " of " .. num_errors);
               out("");
               out("Event which provoked error: " .. current_entry.event_name);
               out("Turn number on which error occurred: " .. current_entry.turn_number);
               out("Whose turn it was when error occurred: " .. current_entry.whose_turn_is_it);
               out("Error message: " .. current_entry.error);
               out("Traceback of failed script:");
               out(current_entry.traceback);
               out("Callstack of script which set up the listener:");
               out(current_entry.establishing_callstack);
               if current_entry.is_event_condition then
                    out(
                    "It was the listener's condition test that generated the error, not the callback that is called once the condition is passed");
               else
                    out("The listener's callback generated the error, not the condition test");
               end;

               out("");
          end;

          out("******************************************************");
          out("");

          local error_message =
          "ERROR: check_event_errors_on_startup() has found script failure records in this savegame - the script has failed in the past, so scripted behaviour may be broken. The errors are printed above this message in the Lua console output.";
          if #self.event_error_logs == EVENT_ERROR_SAVEGAME_LOG_MAX_SIZE then
               error_message = error_message ..
               "\n*** NOTE: the max number of errors has been recorded, which implies that more errors have happened but they have been culled";
          end;

          script_error(error_message);
     end;
end;

----------------------------------------------------------------------------
--- @section First Tick
--- @desc The <code>FirstTickAfterWorldCreated</code> event is triggered by the game model when loading is complete and it starts to run time forward. At this point, the game can be considered "running". The campaign manager offers a suite of functions, listed in this section, which allow registration of callbacks to get called when the first tick occurs in a variety of situations e.g. new versus loaded campaign, singleplayer versus multiplayer etc.
--- @desc Callbacks registered with @campaign_manager:add_pre_first_tick_callback are called before any other first-tick callbacks. Next to be called are callbacks registered for a new game with @campaign_manager:add_first_tick_callback_new, @campaign_manager:add_first_tick_callback_sp_new or @campaign_manager:add_first_tick_callback_mp_new, which are called before each-game callbacks registered with @campaign_manager:add_first_tick_callback_sp_each or @campaign_manager:add_first_tick_callback_mp_each. Last to be called are global first-tick callbacks registered with @campaign_manager:add_first_tick_callback.
--- @desc Note that when the first tick occurs the loading screen is likely to still be on-screen, so it may be prudent to stall scripts that wish to display things on-screen with @core:progress_on_loading_screen_dismissed.
----------------------------------------------------------------------------


--- @function add_pre_first_tick_callback
--- @desc Registers a function to be called before any other first tick callbacks. Callbacks registered with this function will be called regardless of what mode the campaign is being loaded in.
--- @p function callback
function campaign_manager:add_pre_first_tick_callback(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_pre_first_tick_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.pre_first_tick_callbacks, callback);
end;

--- @function add_first_tick_callback
--- @desc Registers a function to be called when the first tick occurs. Callbacks registered with this function will be called regardless of what mode the campaign is being loaded in.
--- @p function callback
function campaign_manager:add_first_tick_callback(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks, callback);
end;

--- @function add_first_tick_callback_sp_new
--- @desc Registers a function to be called when the first tick occurs in a new singleplayer game.
--- @p function callback
function campaign_manager:add_first_tick_callback_sp_new(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback_sp_new() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks_sp_new, callback);
end;

--- @function add_first_tick_callback_sp_each
--- @desc Registers a function to be called when the first tick occurs in a singleplayer game, whether new or loaded from a savegame.
--- @p function callback
function campaign_manager:add_first_tick_callback_sp_each(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback_sp_new() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks_sp_each, callback);
end;

--- @function add_first_tick_callback_mp_new
--- @desc Registers a function to be called when the first tick occurs in a new multiplayer game.
--- @p function callback
function campaign_manager:add_first_tick_callback_mp_new(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback_mp_new() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks_mp_new, callback);
end;

--- @function add_first_tick_callback_mp_each
--- @desc Registers a function to be called when the first tick occurs in a multiplayer game, whether new or loaded from a savegame.
--- @p function callback
function campaign_manager:add_first_tick_callback_mp_each(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback_mp_new() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks_mp_each, callback);
end;

--- @function add_first_tick_callback_new
--- @desc Registers a function to be called when the first tick occurs in a new game, whether singleplayer or multiplayer.
--- @p function callback
function campaign_manager:add_first_tick_callback_new(callback)
     if not is_function(callback) then
          script_error(self.name ..
          " ERROR: add_first_tick_callback_new() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.first_tick_callbacks_mp_new, callback);
     table.insert(self.first_tick_callbacks_sp_new, callback);
end;

-- Early initialization of local faction which can be used in some UI events before the world has been created
function campaign_manager:local_faction_initialized_event(context)
     self.has_local_faction_initialized_event_been_triggered = true

     local local_faction_name = false
     local local_faction = context:local_faction()
     if local_faction and not local_faction:is_null_interface() then
          local_faction_name = local_faction:name()
          self.local_faction_culture_key = local_faction:culture()
          self.local_faction_subculture_key = local_faction:subculture()
     end

     self.local_faction_name = local_faction_name
end

-- called internally when first tick occurs
function campaign_manager:first_tick(context)
     out.cache_tab();
     out("");
     out("********************************************************************************");
     out(self.name .. " event has occurred:: FirstTickAfterWorldCreated");
     out.inc_tab();

     -- store a link to the campaign manager on _G, as autotest scripts need it occasionally and they can't access it here
     _G.cm = self;

     local model = self.game_interface:model();
     self.is_multiplayer_campaign = model:is_multiplayer();

     local local_faction_name = false;
     local human_factions = {};
     local factions_at_campaign_start = {}

     -- build a list of human factions, and work out which faction is local
     do
          local faction_list = model:world():faction_list();

          for i = 0, faction_list:num_items() - 1 do
               local faction = faction_list:item_at(i);
               local faction_name = faction:name();

               table.insert(factions_at_campaign_start, faction_name)

               if faction:is_human() then
                    if model:faction_is_local(faction_name) then
                         local_faction_name = faction_name;

                         -- cached local player culture and subculture keys
                         self.local_faction_culture_key = faction:culture();
                         self.local_faction_subculture_key = faction:subculture();
                    end;
                    table.insert(human_factions, faction_name);
               end;
          end;

          if not local_faction_name then
               script_error(
               "WARNING: campaign manager couldn't find a local faction - this should only happen in autoruns");
          end;
     end;

     self.local_faction_name = local_faction_name;
     self.human_factions = human_factions;
     self.factions_at_campaign_start = factions_at_campaign_start

     self.game_is_running = true;

     -- start a listener for all faction turn starts so that client scripts can query whos turn it is
     -- also fire a custom event if it's the player's turn
     core:add_listener(
          "faction_currently_processing",
          "FactionTurnStart",
          true,
          function(context)
               if context:faction():name() == local_faction_name then
                    out("");
                    out("********************************************************************************");
                    out("* player faction " .. local_faction_name .. " is starting turn " .. model:turn_number());
                    out("********************************************************************************");
                    out.inc_tab();
                    out("triggering event ScriptEventPlayerFactionTurnStart");

                    -- reset this flag here, as if there's a script failure it can get stuck
                    self.processing_battle = false;

                    core:trigger_event("ScriptEventPlayerFactionTurnStart", context:faction());

                    -- add a listener for "EventFeedEventRecordedEvent" at the start of the player's turn
                    core:add_listener(
                         "EventFeedEventRecordedEvent",
                         "EventFeedEventRecordedEvent",
                         true,
                         function(context)
                              core:trigger_event("ScriptEventPlayerFactionEventFeedEventRecorded", context:event_key());
                         end,
                         true
                    );
               end;
          end,
          true
     );

     -- start a listener for the local faction ending a turn which produces output and fires a custom scripted event
     core:add_listener(
          "ScriptEventPlayerFactionTurnEnd",
          "FactionTurnEnd",
          function(context) return context:faction():name() == local_faction_name end,
          function(context)
               out.dec_tab();
               out("********************************************************************************");
               out("********************************************************************************");
               core:trigger_event("ScriptEventPlayerFactionTurnEnd", context:faction());

               -- remove the "EventFeedEventRecordedEvent" listener as it triggers a lot during the end-turn sequence
               core:remove_listener("EventFeedEventRecordedEvent");
          end,
          true
     );

     self.game_interface:suppress_all_event_feed_event_types(false);

     -- mainly for autotesting, but other scripts can listen for it too
     core:trigger_event("ScriptEventGlobalCampaignManagerCreated");

     -- mark in the advice history that the player has started a campaign
     common.set_advice_history_string_seen("player_has_started_campaign");

     self:process_first_tick_callbacks(context);

     out.dec_tab();
     out("********************************************************************************");
     out("");
     out.restore_tab();
end;

function campaign_manager:process_first_tick_callbacks(context)
     -- process pre first-tick callbacks
     for i = 1, #self.pre_first_tick_callbacks do
          self.pre_first_tick_callbacks[i](context);
     end;

     if self:is_multiplayer() then
          if self:is_new_game() then
               -- process new mp callbacks
               for i = 1, #self.first_tick_callbacks_mp_new do
                    self.first_tick_callbacks_mp_new[i](context);
               end;
          end;

          -- process each mp callbacks
          for i = 1, #self.first_tick_callbacks_mp_each do
               self.first_tick_callbacks_mp_each[i](context);
          end;
     else
          if self:is_new_game() then
               -- process new sp callbacks
               for i = 1, #self.first_tick_callbacks_sp_new do
                    self.first_tick_callbacks_sp_new[i](context);
               end;
          end;

          -- process each sp callbacks
          for i = 1, #self.first_tick_callbacks_sp_each do
               self.first_tick_callbacks_sp_each[i](context);
          end;
     end;

     -- process shared callbacks
     for i = 1, #self.first_tick_callbacks do
          self.first_tick_callbacks[i](context);
     end;
end;

----------------------------------------------------------------------------
--- @section FactionTurnStart Lookup Listeners
--- @desc It's common for campaign scripts to want to execute some code when a faction starts its turn. Client scripts will typically use @core:add_listener to listen for the <code>FactionTurnStart</code> event and then query the event context to determine if it's the correct faction, usually by comparing the faction's name with a known string. This straightforward approach becomes more problematic as more listeners are added, and with a game full of content several dozen listeners can all be responding each time a faction starts its turn, all querying the faction name.
--- @desc To circumvent this problem, client scripts can instead register listeners with @campaign_manager:add_faction_turn_start_listener_by_name. The campaign manager stores these in a lookup table internally, which a lot more computationally efficient than having several dozen client scripts all query the faction name every time a faction starts a turn.
----------------------------------------------------------------------------


--- @function add_faction_turn_start_listener_by_name
--- @desc Adds a listener for the <code>FactionTurnStart</code> event which triggers if a faction with the supplied faction name starts a turn.
--- @p @string listener name, Name by which this listener can be later cancelled using @campaign_manager:remove_faction_turn_start_listener_by_name if necessary. It is valid to have multiple listeners with the same name.
--- @p @string faction name, Faction name to watch for, from the <code>factions</code> database table.
--- @p @function callback, Callback to call if a faction with the specified name starts a turn.
--- @p @boolean persistent, Is this a persistent listener. If this value is <code>false</code> the listener will stop the first time the callback is triggered. If <code>true</code>, the listener will continue until cancelled with @campaign_manager:remove_faction_turn_start_listener_by_name.
function campaign_manager:add_faction_turn_start_listener_by_name(listener_name, faction_name, callback, persistent)
     core:add_lookup_listener_callback("faction_turn_start_listeners_by_name", listener_name, faction_name, callback,
          persistent);
end;

--- @function remove_faction_turn_start_listener_by_name
--- @desc Removes a listener that was previously added with @campaign_manager:add_faction_turn_start_listener_by_name. Calling this won't affect other faction turn start listeners.
--- @p @string listener name
function campaign_manager:remove_faction_turn_start_listener_by_name(listener_name)
     core:remove_lookup_listener_callback("faction_turn_start_listeners_by_name", listener_name);
end;

--- @function add_faction_turn_start_listener_by_culture
--- @desc Adds a listener for the <code>FactionTurnStart</code> event which triggers if a faction with the supplied culture key starts a turn.
--- @p @string listener name, Name by which this listener can be later cancelled using @campaign_manager:remove_faction_turn_start_listener_by_culture if necessary. It is valid to have multiple listeners with the same name.
--- @p @string culture key, Culture key to watch for, from the <code>cultures</code> database table.
--- @p @function callback, Callback to call if a faction of the specified culture starts a turn.
--- @p @boolean persistent, Is this a persistent listener. If this value is <code>false</code> the listener will stop the first time the callback is triggered. If <code>true</code>, the listener will continue until cancelled with @campaign_manager:remove_faction_turn_start_listener_by_culture.
function campaign_manager:add_faction_turn_start_listener_by_culture(listener_name, culture_name, callback, persistent)
     core:add_lookup_listener_callback("faction_turn_start_listeners_by_culture", listener_name, culture_name, callback,
          persistent);
end;

--- @function remove_faction_turn_start_listener_by_culture
--- @desc Removes a listener that was previously added with @campaign_manager:add_faction_turn_start_listener_by_culture. Calling this won't affect other faction turn start listeners.
--- @p @string listener name
function campaign_manager:remove_faction_turn_start_listener_by_culture(listener_name)
     core:remove_lookup_listener_callback("faction_turn_start_listeners_by_culture", listener_name);
end;

--- @function add_faction_turn_start_listener_by_subculture
--- @desc Adds a listener for the <code>FactionTurnStart</code> event which triggers if a faction with the supplied subculture key starts a turn.
--- @p @string listener name, Name by which this listener can be later cancelled using @campaign_manager:remove_faction_turn_start_listener_by_subculture if necessary. It is valid to have multiple listeners with the same name.
--- @p @string subculture key, Subculture key to watch for, from the <code>subcultures</code> database table.
--- @p @function callback, Callback to call if a faction of the specified subculture starts a turn.
--- @p @boolean persistent, Is this a persistent listener. If this value is <code>false</code> the listener will stop the first time the callback is triggered. If <code>true</code>, the listener will continue until cancelled with @campaign_manager:remove_faction_turn_start_listener_by_culture.
function campaign_manager:add_faction_turn_start_listener_by_subculture(listener_name, subculture_name, callback,
                                                                        persistent)
     core:add_lookup_listener_callback("faction_turn_start_listeners_by_subculture", listener_name, subculture_name,
          callback, persistent);
end;

--- @function remove_faction_turn_start_listener_by_subculture
--- @desc Removes a listener that was previously added with @campaign_manager:add_faction_turn_start_listener_by_subculture. Calling this won't affect other faction turn start listeners.
--- @p @string listener name
function campaign_manager:remove_faction_turn_start_listener_by_subculture(listener_name)
     core:remove_lookup_listener_callback("faction_turn_start_listeners_by_subculture", listener_name);
end;

----------------------------------------------------------------------------
--- @section Output
----------------------------------------------------------------------------


--- @function output_campaign_obj
--- @desc Prints information about certain campaign objects (characters, regions, factions or military force) to the console. Preferably don't call this - just call <code>out(object)</code> insead.
--- @p function callback
function campaign_manager:output_campaign_obj(input, verbosity)
     -- possible values of verbosity: 0 = full version, 1 = abridged, 2 = one line summary
     verbosity = verbosity or 0;

     if verbosity == 2 then
          out(self:campaign_obj_to_string(input));
          return;
     end;

     -- CHARACTER
     if is_character(input) then
          if verbosity == 0 then
               out("");
               out("CHARACTER:");
               out("==============================================================");
          end;
          out.inc_tab();
          out("cqi:\t\t\t" .. tostring(input:command_queue_index()));
          out("faction:\t\t\t" .. input:faction():name());
          out("forename:\t\t" .. input:get_forename());
          out("surname:\t\t" .. input:get_surname());
          out("type:\t\t\t" .. input:character_type_key());
          out("subtype:\t\t\t" .. input:character_subtype_key());
          if input:has_region() then
               if verbosity == 0 then
                    out("region:");
                    out.inc_tab();
                    self:output_campaign_obj(input:region(), 1);
                    out.dec_tab();
               else
                    out("region:\t" .. self:campaign_obj_to_string(input:region()));
               end;
          else
               out("region:\t<no region>");
          end;
          out("logical position:\t[" ..
          tostring(input:logical_position_x()) .. ", " .. tostring(input:logical_position_y()) .. "]");
          out("display position:\t[" ..
          tostring(input:display_position_x()) .. ", " .. tostring(input:display_position_y()) .. "]");

          if input:has_military_force() then
               if verbosity == 0 then
                    out("military force:");
                    out.inc_tab();
                    self:output_campaign_obj(input:military_force(), 1);
                    out.dec_tab();
               else
                    out("military force:\t<commanding> " .. self:campaign_obj_to_string(input:military_force()));
               end;
          else
               out("military force:\t<not commanding>");
          end;

          out("has residence:\t" .. tostring(input:has_garrison_residence()));

          if not verbosity == 0 then
               out("is male:\t" .. tostring(input:is_male()));
               out("age:\t" .. tostring(input:age()));
               out("loyalty:\t" .. tostring(input:loyalty()));
               out("gravitas:\t" .. tostring(input:gravitas()));
               out("is embedded:\t" .. tostring(input:is_embedded_in_military_force()));
          end;

          out.dec_tab();

          if verbosity == 0 then
               out("==============================================================");
               out("");
          end;


          -- REGION
     elseif is_region(input) then
          if verbosity == 0 then
               out("");
               out("REGION:");
               out("==============================================================");
          end;
          out.inc_tab();
          out("name:\t\t\t" .. input:name());


          if verbosity == 0 then
               out("owning faction:");
               out.inc_tab();
               self:output_campaign_obj(input:owning_faction(), 1);
               out.dec_tab();
          else
               out("owning faction:\t" .. self:campaign_obj_to_string(input:owning_faction()));
          end;

          if input:has_governor() then
               if verbosity == 0 then
                    out("governor:");
                    out.inc_tab();
                    self:output_campaign_obj(input:governor(), 1);
                    out.dec_tab();
               else
                    out("governor:\t\t " .. self:campaign_obj_to_string(input:governor()));
               end;
          else
               out("governor:\t\t<no governor>");
          end;

          if input:garrison_residence():has_army() then
               if verbosity == 0 then
                    out("garrisoned army:");
                    out.inc_tab();
                    self:output_campaign_obj(input:garrison_residence():army(), 1);
                    out.dec_tab();
               else
                    out("garrisoned army: " .. self:campaign_obj_to_string(input:garrison_residence():army()));
               end;
          else
               out("garrisoned army:\t<no army>");
          end;

          if input:garrison_residence():has_navy() then
               if verbosity == 0 then
                    out("garrisoned navy:");
                    out.inc_tab();
                    self:output_campaign_obj(input:garrison_residence():navy(), 1);
                    out.dec_tab();
               else
                    out("garrisoned navy: " .. self:campaign_obj_to_string(input:garrison_residence():navy()));
               end;
          else
               out("garrisoned navy:\t<no navy>");
          end;

          out("under siege:\t\t" .. tostring(input:garrison_residence():is_under_siege()));

          if verbosity == 0 then
               out("num buildings:\t" .. tostring(input:num_buildings()));
               out("public order:\t\t" .. tostring(input:public_order()));
               out("majority religion:\t" .. input:majority_religion());
          end;

          out.dec_tab();

          if verbosity == 0 then
               out("==============================================================");
               out("");
          end;


          -- FACTION
     elseif is_faction(input) then
          if verbosity == 0 then
               out("");
               out("FACTION:");
               out("==============================================================");
          end;
          out.inc_tab();
          out("name:\t\t" .. input:name());
          out("human:\t" .. tostring(input:is_human()));
          out("regions:\t" .. tostring(input:region_list():num_items()));

          if verbosity == 0 then
               local region_list = input:region_list();
               out.inc_tab();
               for i = 0, region_list:num_items() - 1 do
                    out(i .. ":\t" .. self:campaign_obj_to_string(region_list:item_at(i)));
               end;
               out.dec_tab();
          end;

          if input:has_faction_leader() then
               if verbosity == 0 then
                    out("faction leader:");
                    out.inc_tab();
                    self:output_campaign_obj(input:faction_leader(), 1);
                    out.dec_tab();
               else
                    out("faction leader: " .. self:campaign_obj_to_string(input:faction_leader()));
               end;
          else
               out("faction leader:\t<none>");
          end;

          out("characters:\t" .. tostring(input:character_list():num_items()));

          if verbosity == 0 then
               local character_list = input:character_list();
               out.inc_tab();
               for i = 0, character_list:num_items() - 1 do
                    out(i .. ":\t" .. self:campaign_obj_to_string(character_list:item_at(i)));
               end;
               out.dec_tab();
          end;

          out("mil forces:\t" .. tostring(input:military_force_list():num_items()));

          if verbosity == 0 then
               local military_force_list = input:military_force_list();
               out.inc_tab();
               for i = 0, military_force_list:num_items() - 1 do
                    out(i .. ":\t" .. self:campaign_obj_to_string(military_force_list:item_at(i)));
               end;
               out.dec_tab();
          end;

          if verbosity == 0 then
               out("state religion:\t" .. tostring(input:state_religion()));
               out("culture:\t" .. tostring(input:culture()));
               out("subculture:\t" .. tostring(input:subculture()));
               out("treasury:\t" .. tostring(input:treasury()));
               out("tax level:\t" .. tostring(input:tax_level()));
               out("losing money:\t" .. tostring(input:losing_money()));
               out("food short.:\t" .. tostring(input:has_food_shortage()));
               out("imperium:\t" .. tostring(input:imperium_level()));
          end;

          out.dec_tab();

          if verbosity == 0 then
               out("==============================================================");
               out("");
          end;


          -- MILITARY FORCE
     elseif is_militaryforce(input) then
          if verbosity == 0 then
               out("");
               out("MILITARY FORCE:");
               out("==============================================================");
          end;
          out.inc_tab();
          if input:has_general() then
               if verbosity == 0 then
                    out("general:");
                    out.inc_tab();
                    self:output_campaign_obj(input:general_character(), 1);
                    out.dec_tab();
               else
                    out("general:\t" .. self:campaign_obj_to_string(input:general_character()));
               end;
          else
               out("general:\t<none>");
          end;

          out("is army:\t" .. tostring(input:is_army()));
          out("is navy:\t" .. tostring(input:is_navy()));
          out("faction:\t\t" .. self:campaign_obj_to_string(input:faction()));
          out("units:\t\t" .. tostring(input:unit_list():num_items()));

          if verbosity == 0 then
               local unit_list = input:unit_list();
               out.inc_tab();
               for i = 0, unit_list:num_items() - 1 do
                    out(i .. ":\t" .. self:campaign_obj_to_string(unit_list:item_at(i)));
               end;
               out.dec_tab();
          end;

          out("characters:\t" .. tostring(input:character_list():num_items()));

          if verbosity == 0 then
               local char_list = input:character_list();
               out.inc_tab();
               for i = 1, char_list:num_items() - 1 do
                    out(i .. ":\t" .. self:campaign_obj_to_string(char_list:item_at(i)));
               end;
               out.dec_tab();
          end;

          out("residence:\t" .. tostring(input:has_garrison_residence()));

          if verbosity == 0 then
               out("mercenaries:\t" .. tostring(input:contains_mercenaries()));
               out("upkeep:\t" .. tostring(input:upkeep()));
               out("is_armed_citizenry:\t" .. tostring(input:is_armed_citizenry()));
          end;

          out.dec_tab();

          if verbosity == 0 then
               out("==============================================================");
               out("");
          end;
     else
          script_error("WARNING: output_campaign_obj() did not recognise input " .. tostring(input));
     end;
end;

--- @function campaign_obj_to_string
--- @desc Returns a string summary description when passed certain campaign objects. Supported object types are character, region, faction, military force, and unit.
--- @p object campaign object
--- @return string summary of object
function campaign_manager:campaign_obj_to_string(input)
     if is_character(input) then
          return ("CHARACTER cqi[" .. tostring(input:command_queue_index()) .. "], faction[" .. input:faction():name() .. "], forename[" .. input:get_forename() .. "], surname[" .. input:get_surname() .. "], logical pos[" .. input:logical_position_x() .. ", " .. input:logical_position_y() .. "]");
     elseif is_region(input) then
          return ("REGION name[" .. input:name() .. "], owning faction[" .. input:owning_faction():name() .. "]");
     elseif is_faction(input) then
          return ("FACTION name[" .. input:name() .. "], num regions[" .. tostring(input:region_list():num_items()) .. "]");
     elseif is_militaryforce(input) then
          local gen_details = ""

          if input:has_general() then
               local char = input:general_character();
               gen_details = "general cqi[" ..
               tostring(char:command_queue_index()) ..
               "], logical pos [" .. char:logical_position_x() .. ", " .. char:logical_position_y() .. "]";
          else
               gen_details = "general: [none], logical pos[unknown]";
          end;

          return ("MILITARY_FORCE faction[" .. input:faction():name() .. "] units[" .. tostring(input:unit_list():num_items()) .. "], " .. gen_details .. "], upkeep[" .. tostring(input:upkeep()) .. "]");
     elseif is_unit(input) then
          return ("UNIT key[" .. input:unit_key() .. "], strength[" .. tostring(input:percentage_proportion_of_full_strength()) .. "]");
     else
          return "<campaign object [" .. tostring(input) .. "] not recognised>";
     end;
end;

----------------------------------------------------------------------------
--- @section Timer Callbacks
--- @desc Timer functionality - the ability for scripts to say that a function should be called after a certain interval (e.g. a second) - is provided by the @timer_manager object. The functions in this section provide a pass-through interface to the equivalent functions on the timer manager.
--- @desc During the end-turn sequence the update rate of the campaign model can accelerate wildly. This will cause a function registered to be called after five seconds to happen near-instantly during the end turn sequence, for example. To ameliorate this effect, the timer manager will automatically check the real world time once the interval has completed. If the real world time is less than would be expected then the callback is retried repeatedly until the real world interval has elapsed.
----------------------------------------------------------------------------


--- @function callback
--- @desc Calls the supplied function after the supplied interval in seconds using a timer synchronised to the campaign model. A string name for the callback may optionally be provided to allow the callback to be cancelled later.
--- @desc This function call is passed through to @timer_manager:callback - this @campaign_manager alias is provided purely for convenience.
--- @p @function callback to call, Callback to call.
--- @p @number interval, Interval in seconds after to which to call the callback.
--- @p [opt=nil] @string name, Callback name. If supplied, this callback can be cancelled at a later time (before it triggers) with @campaign_manager:remove_callback.
function campaign_manager:callback(callback, interval, name)
     self.tm:callback(callback, interval, name);
end;

--- @function repeat_callback
--- @desc Calls the supplied function repeatedly after the supplied period in seconds using a timer synchronised to the campaign model. A string name for the callback may optionally be provided to allow the callback to be cancelled. Cancelling the callback is the only method to stop a repeat callback, once started.
--- @desc This function call is passed through to @timer_manager:callback - this @campaign_manager alias is provided purely for convenience.
--- @p @function callback to call, Callback to call.
--- @p @number time, Time in seconds after to which to call the callback, repeatedly. The callback will be called each time this interval elapses.
--- @p [opt=nil] @string name, Callback name. If supplied, this callback can be cancelled at a later time with @campaign_manager:remove_callback.
function campaign_manager:repeat_callback(callback, interval, name)
     self.tm:repeat_callback(callback, interval, name);
end;

--- @function remove_callback
--- @desc Removes a callback previously added with @campaign_manager:callback or @campaign_manager:repeat_callback by name. All callbacks with a name matching that supplied will be cancelled and removed.
--- @desc This function call is passed through to @timer_manager:remove_callback - this @campaign_manager alias is provided purely for convenience.
--- @p @string name, Name of callback to remove.
function campaign_manager:remove_callback(name)
     self.tm:remove_callback(name);
end;

--- @function real_callback
--- @desc Adds a real callback to be called after the supplied interval has elapsed. Real timers are synchronised to UI updates, not to the game model - see @"timer_manager:Real Timers" for more information.
--- @desc This function call is passed through to @timer_manager:real_callback - this @campaign_manager alias is provided purely for convenience.
--- @p @function callback, Callback to call.
--- @p @number interval, Interval after which to call the callback. This should be in milliseconds, regardless of game mode.
--- @p [opt=nil] @string name, Callback name, by which it may be later removed with @campaign_manager:remove_real_callback. If omitted the callback may not be cancelled.
function campaign_manager:real_callback(callback, interval, name)
     self.tm:real_callback(callback, interval, name);
end;

--- @function repeat_real_callback
--- @desc Adds a repeating real callback to be called each time the supplied interval elapses. Real timers are synchronised to UI updates, not to the game model - see @"timer_manager:Real Timers" for more information.
--- @desc This function call is passed through to @timer_manager:repeat_real_callback - this @campaign_manager alias is provided purely for convenience.
--- @p @function callback, Callback to call.
--- @p @number interval, Repeating interval after which to call the callback. This should be in milliseconds, regardless of game mode.
--- @p [opt=nil] @string name, Callback name, by which it may be later removed with @campaign_manager:remove_real_callback. If omitted the repeating callback may not be cancelled.
function campaign_manager:repeat_real_callback(callback, interval, name)
     self.tm:repeat_real_callback(callback, interval, name);
end;

--- @function remove_real_callback
--- @desc Removes a real callback previously added with @campaign_manager:real_callback or @campaign_manager:repeat_real_callback by name. All callbacks with a name matching that supplied will be cancelled and removed.
--- @desc This function call is passed through to @timer_manager:remove_real_callback - this @campaign_manager alias is provided purely for convenience.
--- @p @string name, Name of callback to remove.
function campaign_manager:remove_real_callback(name)
     self.tm:remove_real_callback(name);
end;

----------------------------------------------------------------------------
--- @section Loading Linear Sequence Campaign Files
--- @desc It's sometimes desirable to set up a linear sequence of campaign content that involves a series of different loading configurations. The most common example of this would be some introductory content for a campaign - for example a short campaign tutorial, followed by a scripted battle, followed by a wider campaign tutorial, followed by another scripted battle, followed by the open world campaign. The various campaign sections in such a setup will likely be housed in different files, and for this kind of gameplay sequence to work the loading scripts must be able to work out which files to load in each case, based on values saved into both the savegame and the scripted value registry. This quickly becomes an involved problem to solve as the system has to cope with being loaded into from a savegame, surviving a handler reset, loading into a specified state because of tweaker values (for debugging), as well as handling normal progression.
--- @desc The functions described in this section provide a simple interface to set up such linear sequences of campaign gameplay, where A leads to B leads to C and so on. There is no limit to the number of campaign segments that may be chained together using this system.
--- @desc Client scripts may establish one or more configurations by making calls to @campaign_manager:add_linear_sequence_configuration. When all configurations are established @campaign_manager:load_linear_sequence_configuration may be called, which picks a configuration and loads the local faction script file specified in that configuration. During the running of that script (or any scripted battle that subsequently loads), another configuration may be set up as the next configuration to load by setting the svr boolean of that second configuration to <code>true</code>. When the campaign script next loads (unless from the frontend or a savegame) it will pick the new configuration based on the value of the svr boolean.
--- @desc When adding a configuration a tweaker may be specified in the call to @campaign_manager:add_linear_sequence_configuration. By setting this same tweaker prior to the game starting the configuration loader can be forced to load that configuration.
----------------------------------------------------------------------------


--- @function add_linear_sequence_configuration
--- @desc Adds a linear sequence configuration. All added linear sequences will be queried when @campaign_manager:load_linear_sequence_configuration is called, with one being picked and loaded based on the game state.
--- @desc The name, svr boolean, and tweaker name (where set) of each configuration must be unique compared to other configurations.
--- @p @string name, Script name for this configuration. This must not contain spaces. The name of a saved value which gets saved with the campaign is derived from this name.
--- @p @string filename, Appellation of script file to be passed to @campaign_manager:load_local_faction_script (which performs the actual script loading) if this configuration is chosen by @campaign_manager:load_linear_sequence_configuration.
--- @p @string svr bool, Name of a scripted value registry boolean which, if set, causes this configuration to be loaded. When the transition from some other configuration to this configuration is desired, the game scripts should set this boolean value to <code>true</code> with @scriptedvalueregistry:SaveBool. The next time the campaign scripts load and @campaign_manager:load_linear_sequence_configuration, this configuration will be chosen. Once chosen in this manner, the svr boolean is set back to <code>false</code> again.
--- @p [opt=false] @boolean is default, Make this the default configuration if no other is chosen. Only one default configuration may be set.
--- @p [opt=false] @string tweaker, Name of tweaker value which, if set, forces this configuration to be chosen for loading. This is used for debugging scripts and forcing the game to start in a particular configuration.
function campaign_manager:add_linear_sequence_configuration(name, filename, svr_bool, is_default, tweaker)
     if not is_string(name) then
          script_error("ERROR: add_linear_sequence_configuration() called but supplied configuration name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_string(filename) then
          script_error("ERROR: add_linear_sequence_configuration() called but supplied filename appelation [" ..
          tostring(filename) .. "] is not a string");
          return false;
     end;

     if not is_string(svr_bool) then
          script_error("ERROR: add_linear_sequence_configuration() called but supplied svr boolean name [" ..
          tostring(svr_bool) .. "] is not a string");
          return false;
     end;

     if tweaker and not is_string(tweaker) then
          script_error("ERROR: add_linear_sequence_configuration() called but supplied tweaker name [" ..
          tostring(tweaker) .. "] is not a string or nil");
          return false;
     end;

     -- check that the supplied values are unique where they should be
     for i = 1, #self.linear_sequence_configurations do
          local current_config = self.linear_sequence_configurations[i];

          if current_config.name == name then
               script_error("ERROR: add_linear_sequence_configuration() called but a configuration with supplied name [" ..
               name .. "] has already been added");
               return false;
          end;

          if current_config.svr_bool == svr_bool then
               script_error(
               "ERROR: add_linear_sequence_configuration() called but a configuration with supplied svr boolean name [" ..
               svr_bool .. "] has already been added");
               return false;
          end;

          if tweaker and current_config.tweaker == tweaker then
               script_error(
               "ERROR: add_linear_sequence_configuration() called but a configuration with supplied tweaker name [" ..
               tweaker .. "] has already been added");
               return false;
          end;

          if is_default and current_config.is_default then
               script_error("ERROR: add_linear_sequence_configuration() is attempting to set configuration with name [" ..
               name ..
               "] to be default but a configuration with name [" ..
               current_config.name .. "] is already set to be default");
               return false;
          end;
     end;

     -- assembly a configuration record and add it
     table.insert(
          self.linear_sequence_configurations,
          {
               name = name,
               filename = filename,
               svr_bool = svr_bool,
               is_default = not not is_default,
               tweaker = tweaker
          }
     );
end;

--- @function load_linear_sequence_configuration
--- @desc Picks a configuration previously added with @campaign_manager:add_linear_sequence_configuration and loads it, based on certain values:
--- @desc <ul><li>The function first looks at svr boolean values for each configuration. If one is set then that configuration is chosen, and the boolean is set back to false. These booleans should be individual set to <code>true</code> by client scripts when they wish to transition from loading scripts in one configuration to another.</li>
--- @desc <li>If no svr boolean is set and it's a new game, the function checks the value of the tweaker specified by each configuration. If any tweaker is set then that configuration is loaded.</li>
--- @desc <li>If no svr boolean is set and it's a not a new game, the function checks to see if a saved value exists corresponding to any configuration. If one is found then that configuration is loaded.</li>
--- @desc <li>If no configuration has been loaded so far then a registry value derived from the name of each configuration is checked, which would indicate that the handler has been forceably reset. If any configuration matches then that configuration is loaded.</li>
--- @desc <li>If still no configuration has been loaded then all configurations are checked to see if there's a default. If there is a default configuration then it is loaded.</li></ul>
function campaign_manager:load_linear_sequence_configuration()
     if self:is_multiplayer() then
          script_error(
          "WARNING: load_linear_sequence_configuration() called in multiplayer mode - linear sequences are only valid in singleplayer mode");
          return;
     end;

     local linear_sequence_configurations = self.linear_sequence_configurations;
     local campaign_config_to_load = false;

     -- check svr booleans that are explicitly set up per-configuration first
     -- these should be set when transitioning from one game config to another
     for i = 1, #linear_sequence_configurations do
          local current_config = linear_sequence_configurations[i];
          if current_config.svr_bool and core:svr_load_bool(current_config.svr_bool) then
               -- the svr boolean for this configuration is set to true - set it back to false and load with this config
               core:svr_save_bool(current_config.svr_bool, false);
               out("Will load scripts in " ..
               current_config.name ..
               " configuration as svr boolean " .. current_config.svr_bool .. " is set and it's a new game");
               campaign_config_to_load = current_config;
          end;
     end;

     -- if no svr values were set..
     if not campaign_config_to_load then
          if self:is_new_game() then
               -- this is a new game, check if any tweaker values that would force us to load in to a particular config are set
               if not campaign_config_to_load then
                    for i = 1, #linear_sequence_configurations do
                         local current_tweaker_name = linear_sequence_configurations[i].tweaker;
                         if current_tweaker_name and core:is_tweaker_set(current_tweaker_name) then
                              campaign_config_to_load = linear_sequence_configurations[i];
                              out("load_linear_sequence_configuration() will load scripts in " ..
                              campaign_config_to_load.name ..
                              " configuration as tweaker " .. current_tweaker_name .. " is set and it's a new game");
                              break;
                         end;
                    end;
               end;
          else
               -- this is a saved game, check campaign saved values
               for i = 1, #linear_sequence_configurations do
                    if self:get_saved_value("bool_load_" .. linear_sequence_configurations[i].name) then
                         campaign_config_to_load = linear_sequence_configurations[i];
                         out("load_linear_sequence_configuration() will load scripts in " ..
                         campaign_config_to_load.name ..
                         " configuration as bool_load_" .. campaign_config_to_load.name .. " is set in savegame");
                         break;
                    end;
               end;
          end;
     end;

     -- Check persistent bool values last of all - these help scripts reload into the correct environment if a handler reset has been done
     -- It's important we also check if the previous game mode was campaign, as we only want to enter this block when doing a handler reset. If we exited from a campaign that set a persistent boolean
     -- (e.g. prologue) back to the frontend, and then in to another campaign that was set up to be the default (e.g. main campaign), this guards against the non-default campaign being loaded again in this circumstance.
     if not campaign_config_to_load and core:previous_game_mode_was_campaign() then
          local svr = core:get_svr();
          for i = 1, #linear_sequence_configurations do
               if svr:LoadPersistentBool("pbool_load_" .. linear_sequence_configurations[i].name) then
                    campaign_config_to_load = linear_sequence_configurations[i];
                    out("load_linear_sequence_configuration() will load scripts in " ..
                    campaign_config_to_load.name ..
                    " configuration as persistent svr value pbool_load_" .. campaign_config_to_load.name .. " is set");
                    break;
               end;
          end;
     end;

     -- pick the default config if no other config loaded
     if not campaign_config_to_load then
          for i = 1, #linear_sequence_configurations do
               if linear_sequence_configurations[i].is_default then
                    campaign_config_to_load = linear_sequence_configurations[i];
                    out("load_linear_sequence_configuration() will load scripts in " ..
                    campaign_config_to_load.name ..
                    " configuration as it is the default and we're not being told to load anything else");
                    break;
               end;
          end;
     end;

     if campaign_config_to_load then
          -- Set pbool and saved value of this config to true, and other configs to false.
          -- Persistent booleans instruct the game to load back into this mode in the event of a handle reset.
          -- Saved booleans instruct the game to load back into this mode if it's saved and reloaded.
          local svr = core:get_svr();
          svr:SavePersistentBool("pbool_load_" .. campaign_config_to_load.name, true);
          self:set_saved_value("bool_load_" .. campaign_config_to_load.name, true);

          for i = 1, #linear_sequence_configurations do
               local current_config = linear_sequence_configurations[i];
               if current_config.name ~= campaign_config_to_load.name then
                    svr:SavePersistentBool("pbool_load_" .. current_config.name, false);
                    self:set_saved_value("bool_load_" .. current_config.name, false);
               end;
          end;

          -- load script
          self:load_local_faction_script(campaign_config_to_load.filename, true); -- sp only
     else
          script_error(
          "ERROR: load_linear_sequence_configuration() couldn't determine a campaign configuration in which to load");
     end;
end;

----------------------------------------------------------------------------
--- @section Linear Sequence Checkpoints
--- @desc Within a linear sequence of gameplay, such as a tutorial campaign, it's common to want to allow the game to be saved (either manually by the player, or automatically by script) and reloaded. Such gameplay sequences are often tightly scripted, and to be able to rebuild the script from a savegame in the correct state and allow it to seamlessly resume is not always trivial.
--- @desc The linear sequence checkpoint functions aim to provide a toolset to help solve this problem. They grant support for scripts to add, pass through and reload from checkpoints, which should be sequentially encountered as the script progresses.
--- @desc <ul><li>Checkpoints may be declared with @campaign_manager:add_checkpoint. Checkpoints are re-entry points, from which the script may start after loading from a savegame (or a new game). Each checkpoint is set up with a callback that is called if that checkpoint is reloaded in to, which should resume the game from that point.</li>
--- @desc <li>As well as a callback, each checkpoint is also associated with a numeric id value. As the script progresses through the linear sequence/tutorial and passes through successive checkpoints, the numeric id associated with each checkpoint should increase. It would be illegal for the script to reach a checkpoint with id 100 on turn two and to then reach a checkpoint with id 50 on turn three, for example.</li>
--- @desc <li>To opt-in to the checkpoint system, the function @campaign_manager:start_from_checkpoint can be called somewhere on the first tick. This calls the callback associated with the last checkpoint reached. If no checkpoints have been marked as reached yet, then the callback associated with the checkpoint with the lowest numeric id is called.</li>
--- @desc <li>As the script progresses through the tutorial/linear sequence, it can mark that a checkpoint has been reached with the @campaign_manager:checkpoint_reached function. By default, the game gets automatically saved when this happens.</li>
--- @desc <li>Zero or more setup functions may also also be associated with a checkpoint with the @campaign_manager:add_checkpoint_setup_callback function. If the game is reloaded in to a checkpoint, then any setup functions associated with it <b>and all previously-reached checkpoints</b> are called in sequence. This is different to the main checkpoint functions set up with @campaign_manager:add_checkpoint, of which exactly one will be called when @campaign_manager:start_from_checkpoint is invoked.</li>
--- @desc <li>Calls to @campaign_manager:add_checkpoint and @campaign_manager:add_checkpoint_setup_callback should be made in the root of the script, or in some other place that ensures that checkpoint data is all set up correctly before @campaign_manager:start_from_checkpoint is called.</li>
--- @desc <li>@campaign_manager:get_current_checkpoint can be called which returns the id of the most recently reached checkpoint.</li></ul>

--- @example cm:add_first_tick_callback(
--- @example 	function()
--- @example		-- Start from a checkpoint when the first tick occurs. If no checkpoint has been reached
--- @example		-- in the savegame, the callback of the checkpoint with the lowest ID is called.
--- @example		cm:start_from_checkpoint()
--- @example	end
--- @example );
--- @example
--- @example -- START CHECKPOINT 1 DECLARATION --
--- @example cm:add_checkpoint(
--- @example 	1,
--- @example 	function(is_loading_game, checkpoint_id)
--- @example 		out("*** Loading first checkpoint - the script should start here!")
--- @example
--- @example 		-- Wait 10 seconds to simulate some scripted stuff happening and then reach the second checkpoint
--- @example 		cm:callback(
--- @example 			function()
--- @example 				out("*** Reaching second checkpoint after ten seconds, game will now save")
--- @example 				cm:checkpoint_reached(2, continue_from_second_checkpoint)
--- @example 			end,
--- @example 			10
--- @example 		)
--- @example 	end
--- @example )
--- @example
--- @example cm:add_checkpoint_setup_callback(
--- @example 	1,
--- @example 	function(is_loading_game, checkpoint_id)
--- @example 		out("*** Setup function associated with first checkpoint called - we're loading in to checkpoint " .. checkpoint_id)
--- @example 	end
--- @example )
--- @example -- END CHECKPOINT 1 DECLARATION --
--- @example
--- @example
--- @example -- START CHECKPOINT 2 DECLARATION --
--- @example cm:add_checkpoint(
--- @example 	2,
--- @example 	function(is_loading_game, checkpoint_id)
--- @example 		out("*** Loading from second checkpoint")
--- @example 		continue_from_second_checkpoint(is_loading_game, checkpoint_id)
--- @example 	end
--- @example )
--- @example
--- @example cm:add_checkpoint_setup_callback(
--- @example 	2,
--- @example 	function(is_loading_game, checkpoint_id)
--- @example 		out("*** Setup function associated with second checkpoint called - we're loading in to checkpoint " .. checkpoint_id)
--- @example 	end
--- @example )
--- @example -- END CHECKPOINT 2 DECLARATION --
--- @example
--- @example function continue_from_second_checkpoint(is_loading_game, checkpoint_id)
--- @example 	out("*** Continuing from second checkpoint, have we just loaded in: " .. tostring(is_loading_game))
--- @example end
--- @result <i>on first load, output from system omitted</i>:
--- @result
--- @result *** Setup function associated with first checkpoint called - we're loading in to checkpoint 1
--- @result *** Loading first checkpoint - the script should start here!
--- @result *** Reaching second checkpoint after ten seconds, game will now save
--- @result *** Continuing from second checkpoint, have we just loaded in: false
--- @result
--- @result <i>on load of savegame</i>:
--- @result
--- @result *** Setup function associated with first checkpoint called - we're loading in to checkpoint 2
--- @result *** Setup function associated with second checkpoint called - we're loading in to checkpoint 2
--- @result *** Loading from second checkpoint
--- @result *** Continuing from second checkpoint, have we just loaded in: true



----------------------------------------------------------------------------


--- @function add_checkpoint
--- @desc Adds a checkpoint, from which a linear sequence script (such as a tutorial) may potentially reload. The checkpoint is associated with a numeric id, a callback, and optionally a @string name. If supplied, the name is used for output.
--- @desc Checkpoints should be added using calls to this function when a linear sequence script loads. As such a script progresses through its events over time, it may mark checkpoints that have been added as reached by calling @campaign_manager:checkpoint_reached. If the script is saved and reloaded, and @campaign_manager:start_from_checkpoint is called after reloading, then the callback associated with the checkpoint most recently reached will be called. This callback should aim to resume the linear scripted sequence from the correct place.
--- @p @number checkpoint id, Numeric checkpoint id. This should be a positive number, unique amongst added checkpoints. As a linear script progresses, each checkpoint it reaches should be associated with an ascending id value e.g. 10, 11, 12 on turn one, 20, 21, 22, 23 on turn two and so on. ID values do not have to be sequential - it is up to the scripter how they are spaced - but they must be ascending in the order that the checkpoints are reached. For example, if the script reaches a checkpoint with id 10, it is illegal to try and later reach a checkpoint with id 5.
--- @p @function callback, Callback associated with the checkpoint. This callback is called if the system decides to restart from this checkpoint when @campaign_manager:start_from_checkpoint is called. It may optionally be called when the checkpoint is reached.
--- @p_long_desc The callback, when called, will be passed two arguments - a @boolean indicating whether the game is loading (if <code>false</code> then this means that the checkpoint has been reached without reloading), and the @number checkpoint id value.
--- @p [opt=false] @boolean call when checkpoint reached, Call the checkpoint callback when the checkpoint is reached, as well as when the checkpoint is restarted-from. By default, when @campaign_manager:checkpoint_reached is called to mark a checkpoint as reached the associated callbacks are not called - they are only called if the game is subsequently reloaded. Pass <code>true</code> in here to also call the callbacks associated with a checkpoint when the checkpoint is reached.
--- @p [opt=nil] @string name, Checkpoint name. This is only used for output and doesn't affect the checkpoint behaviour.
function campaign_manager:add_checkpoint(checkpoint_id, callback, call_when_checkpoint_reached, checkpoint_name)
     if not validate.is_positive_number(checkpoint_id) then
          return false;
     end;

     if self.checkpoints_lookup[checkpoint_id] then
          script_error("ERROR: add_checkpoint() called but a checkpoint with id [" ..
          checkpoint_id .. "] has already been declared");
          return false;
     end;

     if not validate.is_function(callback) then
          return false;
     end;

     local checkpoints_indexed = self.checkpoints_indexed;

     if checkpoint_name then
          if not validate.is_string(checkpoint_name) then
               return false;
          end;

          for i = 1, #checkpoints_indexed do
               if checkpoints_indexed[i].name == checkpoint_name then
                    script_error("ERROR: add_checkpoint() called but a checkpoint with name [" ..
                    checkpoint_name .. "] has already been declared");
                    return false;
               end;
          end;
     end;

     -- Create a checkpoint record and add it to both the lookup and indexed tables
     local checkpoint_record = {
          id = checkpoint_id,
          callback = callback,
          call_when_checkpoint_reached = call_when_checkpoint_reached,
          name = checkpoint_name,
          setup_callbacks = {}
     };

     -- add the checkpoint_record to the checkpoints_lookup table
     self.checkpoints_lookup[checkpoint_id] = checkpoint_record;

     -- add the checkpoint_record to the checkpoints_indexed table, ensuring that it is sorted by ascending id order
     for i = #checkpoints_indexed, 0, -1 do
          if i == 0 or checkpoints_indexed[i].id <= checkpoint_id then
               table.insert(checkpoints_indexed, i + 1, checkpoint_record);
               break;
          end;
     end;
end;

--- @function add_checkpoint_setup_callback
--- @desc Adds a setup callback, associated with a previously-added checkpoint. The checkpoint is specified by numeric id, which should match the id given when the checkpoint was set up with @campaign_manager:add_checkpoint.
--- @desc When @campaign_manager:start_from_checkpoint is called, the main callback associated with the checkpoint most recently reached is called. Before that resumption callback is called, however, any setup callbacks added with this function that are associated with the most-recently reached callback <b>and all checkpoints prior to it</b> are called. The setup callbacks are called in ascending order of checkpoint id. For example, if the script resumes from a checkpoint with id 50, any setup callbacks associated with checkpoint 10 are called first, then any with checkpoint 20, checkpoint 30, checkpoint 40 and finally checkpoint 50 (assuming checkpoints with these ids are set up).
--- @desc When called, each setup checkpoint is passed a @boolean value that indicates whether the script has reloaded, and also the numeric id of the most recently reached checkpoint.
--- @p @number checkpoint id, Numeric id of the checkpoint to associate this setup callback with.
--- @p @function callback, Setup callback.
--- @p [opt=false] @boolean call when checkpoint reached, Call this setup callback when the associated checkpoint is reached, not just when the script is restarting.
function campaign_manager:add_checkpoint_setup_callback(checkpoint_id, callback, call_when_checkpoint_reached)
     if not validate.is_positive_number(checkpoint_id) then
          return false;
     end;

     local checkpoint_record = self.checkpoints_lookup[checkpoint_id];

     if not checkpoint_record then
          script_error("ERROR: add_checkpoint_setup_callback() called but no checkpoint with id [" ..
          checkpoint_id .. "] has been declared");
          return false;
     end;

     if not validate.is_function(callback) then
          return false;
     end;

     -- Create checkpoint setup callback record and add it to the relevant checkpoint_record
     table.insert(
          checkpoint_record.setup_callbacks,
          {
               callback = callback,
               call_when_checkpoint_reached = call_when_checkpoint_reached
          }
     );
end;

--- @function set_checkpoint_prefix
--- @desc Sets a prefix to use for constructed savegame names in the checkpoint system. If a checkpoint has been set to save the game with a constructed name (set via arguments to @campaign_manager:checkpoint_reached when it is called) then a prefix is added to the savegame name. By default this is the player's faction name in singleplayer, and "MP Campaign" in multiplayer, but an alternative may be set with this function.
--- @p @string checkpoint prefix
function campaign_manager:set_checkpoint_prefix(str)
     if not validate.is_string(str) then
          return false;
     end;

     self.checkpoint_prefix = str;
end;

--- @function set_checkpoint_names_use_checkpoint_id
--- @desc Sets whether the checkpoint system should insert the checkpoint ID in any constructed checkpoint names. This behaviour is disabled by default, but may be enabled with this function.
--- @p [opt=true] @boolean value
function campaign_manager:set_checkpoint_names_use_checkpoint_id(value)
     if value == false then
          self.checkpoint_names_use_checkpoint_id = false;
     else
          self.checkpoint_names_use_checkpoint_id = true;
     end;
end;

--- @function checkpoint_reached
--- @desc Marks a checkpoint as reached. The checkpoint should have been previously set up with @campaign_manager:add_checkpoint. The checkpoint reached is specified by numeric id.
--- @desc When a checkpoint is reached, the id of that checkpoint is updated within the savegame data, and by default the game is also saved which commits that update to file. Should the saved game get saved (either by checkpoint_reached, later in script, or by the player) and subsequently reloaded, and should @campaign_manager:start_from_checkpoint be called in script during the loading sequence, then the callback associated with the last-reached checkpoint by @campaign_manager:add_checkpoint is called. Each callback associated with a checkpoint should aim to resume the script from that checkpoint.
--- @desc When a checkpoint is reached the system may optionally call callbacks associated with that checkpoint that were added with @campaign_manager:add_checkpoint or @campaign_manager:add_checkpoint_setup_callback. Callbacks added with those functions are normally only called when the game is reloaded, but may be flagged to also get called when the associated checkpoint is reached.
--- @desc If a continue callback is supplied to this function then it is called after the checkpoint data is updated and (optionally) the campaign is saved. This callback should continue the script after the checkpoint is reached. It is not called when the game is reloaded - the callback supplied by @campaign_manager:add_checkpoint is called in this case.
--- @p @number checkpoint id, ID value of checkpoint reached.
--- @p [opt=nil] @function continue callback, Callback to call once the game is successfully saved. This callback should continue the script. If no value is provided here then but no post-update callback will be called.
--- @p [opt=true] @boolean should save, Specifies whether the game should be saved as the checkpoint is reached. The game is saved by default, but this operation will cause a noticeable pause in the game so it may not be desirable to save at each and every checkpoint. Supply <code>false</code> as argument here to not save the game after this checkpoint is reached.
--- @p [opt=false] @boolean save with name, Specifies whether the game should save with a named savegame. If the game is to be saved (set by the previous parameter) and this argument is set to <code>true</code>, then the game will be saved with a name constructed by the a prefix (which can be set with @campaign_manager:set_checkpoint_prefix), the checkpoint id if @campaign_manager:set_checkpoint_names_use_checkpoint_id has been set, and the checkpoint name. If the argument is set to <code>false</code> then the game is autosaved.
--- @r @boolean save succeeded - save operation succeeded, if it was attempted. If no save was attempted then <code>true</code> is returned. Save operations can fail if a filename was supplied to this function - this prompts the function to attempt a single direct save with @episodic_scripting:save_game instead of an autosave with @episodic_scripting:autosave_at_next_opportunity, and direct save operations can fail if the game is in the wrong state at that moment. A script error is also thrown if the save fails.
function campaign_manager:checkpoint_reached(checkpoint_id, post_save_callback, should_save, save_with_name)
     if not validate.is_positive_number(checkpoint_id) then
          return false;
     end;

     if should_save ~= false then
          should_save = true;
     end;

     if post_save_callback and not validate.is_function(post_save_callback) then
          return false;
     end;

     -- Error if we've already reached a checkpoint with id greater than or equal to this one
     local previous_checkpoint_id = self:get_saved_value("checkpoint_last_reached");
     if previous_checkpoint_id and previous_checkpoint_id >= checkpoint_id then
          script_error("ERROR: checkpoint_reached() called but supplied checkpoint id [" ..
          tostring(checkpoint_id) ..
          "] is not greater than the id of the previously-reached checkpoint [" ..
          previous_checkpoint_id .. "]. Checkpoints should be reached in ascending order");
          return false;
     end;

     local checkpoint_record = self.checkpoints_lookup[checkpoint_id];

     -- Error if no checkpoint is associated with the supplied checkpoint id
     if not checkpoint_record then
          script_error("ERROR: checkpoint_reached() called but no checkpoint with supplied id [" ..
          checkpoint_id .. "] has previously been declared");
          return false;
     end;

     -- Seet the specified checkpoint as the last checkpoint reached
     self:set_saved_value("checkpoint_last_reached", checkpoint_id);

     out("");
     if checkpoint_record.name then
          out("### Checkpoint reached with name [" .. checkpoint_record.name .. "] and id [" .. checkpoint_id .. "]");
     else
          out("### Checkpoint reached with id [" .. checkpoint_id .. "]");
     end;
     out("");

     local save_succeeded = true;

     -- Save if we should
     if should_save then
          local filename;

          -- If we should save with a name then construct one. Otherwise, leave filename as nil, which means that the system will autosave
          if save_with_name then
               local prefix;

               if self.checkpoint_prefix then
                    prefix = self.checkpoint_prefix;
               elseif self:is_multiplayer() then
                    prefix = "MP Campaign"
               else
                    prefix = common.get_localised_string("factions_screen_name_" .. self:get_local_faction_name());
               end;

               filename = prefix ..
               (self.checkpoint_names_use_checkpoint_id and (" " .. checkpoint_id .. " - ") or " - ") ..
               checkpoint_record.name;
          end;

          save_succeeded = self:save(
               filename,
               function()
                    self:call_checkpoint_reached_callbacks(checkpoint_record, post_save_callback);
               end
          );

          if not save_succeeded then
               script_error("WARNING: checkpoint reached with id [" ..
               checkpoint_id .. "] but the savegame operation failed - the game was not saved");
          end;
     else
          self:call_checkpoint_reached_callbacks(checkpoint_record, post_save_callback);
     end;

     return save_succeeded;
end;

-- Internal function to call callbacks when a checkpoint is reached
function campaign_manager:call_checkpoint_reached_callbacks(checkpoint_record, post_save_callback)
     -- Call any setup callbacks that are marked to be called at this time
     local setup_callbacks = checkpoint_record.setup_callbacks;
     for i = 1, #setup_callbacks do
          if setup_callbacks[i].call_when_checkpoint_reached then
               setup_callbacks[i].callback(false, checkpoint_id);
          end;
     end;

     -- Call the main callback if it's marked to be called at this time
     if checkpoint_record.call_when_checkpoint_reached then
          checkpoint_record.callback(false, checkpoint_id);
     end;

     if is_function(post_save_callback) then
          post_save_callback(false, checkpoint_id);
     end;
end;

--- @function start_from_checkpoint
--- @desc Attempt to start from a checkpoint. If using the checkpoint system, it is recommended to call this function somewhere on the first tick.
--- @desc The checkpoint that was most recently marked as reached with @campaign_manager:checkpoint_reached in the savegame will be looked up. If no checkpoint was marked as reached in the savegame then the checkpoint with the lowest numeric id is looked up instead. If no checkpoints have been added, then an error is generated.
--- @desc When starting from a particular checkpoint, any setup callbacks associated with all checkpoints leading up to that particular checkpoint are called in sequence. For example, when starting from checkpoint 3, all setup functions associated with checkpoint 1, then with checkpoint 2, then with checkpoint 3 are called. Finally, the main callback associated with checkpoint 3 is called, which should aim to resume the script from that point.
function campaign_manager:start_from_checkpoint()
     if self.started_from_checkpoint then
          script_error(
          "ERROR: start_from_checkpoint() called but we have already started from a checkpoint? This function should not be called more than once in any campaign session");
          return false;
     end;

     local checkpoint_id = self:get_saved_value("checkpoint_last_reached");

     local checkpoints_indexed = self.checkpoints_indexed;
     if #checkpoints_indexed == 0 then
          script_error(
          "ERROR: start_from_checkpoint() called but no checkpoints have been registered. Ensure that calls to add_checkpoint() come before any call to start_from_checkpoint()")
          return false;
     end;

     local checkpoint_record;

     if checkpoint_id then
          -- Lookup the checkpoint record corresponding to the checkpoint id from the savegame
          checkpoint_record = self.checkpoints_lookup[checkpoint_id];

          if not checkpoint_record then
               script_error("ERROR: start_from_checkpoint() called and a checkpoint id of [" ..
               checkpoint_id ..
               "] was determined but no corresponding checkpoint record was found. No checkpoint will be loaded!");
               return false;
          end;
     else
          -- No checkpoint id found in the savegame, so take the first from the indexed list (it will have the lowest id value)
          checkpoint_record = checkpoints_indexed[1];
          checkpoint_id = checkpoint_record.id;
     end;

     self.started_from_checkpoint = true;

     out("");
     if checkpoint_record.name then
          out("### Starting from checkpoint with name [" ..
          checkpoint_record.name .. "] and id [" .. checkpoint_id .. "]");
     else
          out("### Starting from checkpoint with id [" .. checkpoint_id .. "]");
     end;
     out("");

     -- Call the setup callbacks associated with each checkpoint record up to and including the record looked up
     for i = 1, #checkpoints_indexed do
          local current_checkpoint_record = checkpoints_indexed[i];

          local setup_callbacks = current_checkpoint_record.setup_callbacks;
          for j = 1, #setup_callbacks do
               setup_callbacks[j].callback(true, checkpoint_id);
          end;

          -- Exit the loop if we've iterated up to the current checkpoint
          if current_checkpoint_record == checkpoint_record then
               break;
          end;
     end;

     checkpoint_record.callback(true, checkpoint_id);
end;

--- @function get_current_checkpoint
--- @desc Returns the id of the most recently reached checkpoint. If no checkpoint has been reached then @nil is returned.
--- @r @number checkpoint id
function campaign_manager:get_current_checkpoint()
     return self:get_saved_value("checkpoint_last_reached");
end;

----------------------------------------------------------------------------
--- @section General Querying
----------------------------------------------------------------------------


--- @function is_multiplayer
--- @desc Returns true if the campaign is multiplayer.
--- @return boolean is multiplayer campaign
function campaign_manager:is_multiplayer()
     local model_interface = self:model()
     if model_interface then
          return model_interface:is_multiplayer()
     else
          script_error(
          "ERROR: an attempt was made to call is_multiplayer() before the campaign model is ready. This call needs to happen later in the loading sequence")
          return false
     end
end

--- @function is_new_game
--- @desc Returns true if the campaign is new. A campaign is "new" if it has been saved only once before - this save occurs during startpos processing.
--- @desc Note that if the script fails during startpos processing, the counter will not have been saved and it's value will be 0 - in this case, the game may report that it's not new when it is. If you experience a campaign that behaves as if it's loading into a savegame when starting from fresh, it's probably because the script failed during startpos processing.
--- @return boolean is new game
function campaign_manager:is_new_game()
     if not self.game_is_loaded then
          script_error(self.name ..
          " WARNING: is_new_game() called before the game has loaded, this call should happen later in the loading process. Returning false.");
          return false;
     end;

     return (self.save_counter == 1); -- save_counter is 0 before the startpos is reprocessed and saved, 1 after the startpos is reprocessed, > 1 after the player first saves
end;

--- @function is_game_loaded
--- @desc Returns whether the <code>LoadingGame</code> has been received. If this is true, then data from the savegame will have been loaded and will be ready to query.
--- @return @boolean game is loaded
function campaign_manager:is_game_loaded()
     return self.game_is_loaded;
end;

--- @function is_model_created
--- @desc Returns whether the campaign model and game interfaces have been created. This becomes true when the <code>WorldCreated</code> event is received.
--- @return @boolean model is created
function campaign_manager:is_model_created()
     return self.model_is_created;
end;

--- @function is_game_running
--- @desc Returns whether or not the game is loaded and time is ticking.
--- @return boolean is game started
function campaign_manager:is_game_running()
     return self.game_is_running;
end;

--- @function model
--- @desc Returns a handle to the game @model at any time (after the game has been created).
--- @return object model
function campaign_manager:model()
     local model_interface = self.game_interface:model();
     if is_model(model_interface) then
          return model_interface
     else
          script_error(
          "ERROR: an attempt was made to call model() before the campaign model is ready. This call needs to happen later in the loading sequence");
          return false;
     end;
end;

--- @function get_game_interface
--- @desc Returns a handle to the raw episodic scripting interface. Generally it's not necessary to call this function, as calls made on the campaign manager which the campaign manager doesn't itself provide are passed through to the episodic scripting interface, but a direct handle to the episodic scripting interface may be sought with this function if speed of repeated access.
--- @return object game_interface
function campaign_manager:get_game_interface()
     if not self.game_interface then
          script_error(
          "ERROR: get_game_interface() called but game_interface object has not been created - call this later in the load sequence");
          return false;
     end;

     return self.game_interface;
end;

--- @function get_difficulty
--- @desc Returns the current combined campaign difficulty. This is returned as an integer value by default, or a string if a single <code>true</code> argument is passed in.
--- @desc <table class="simple"><tr><td><strong>string</strong></td><td><strong>number</strong></td></tr><tr><td>easy</td><td>1</td></tr><tr><td>normal</td><td>2</td></tr><tr><td>hard</td><td>3</td></tr><tr><td>very hard</td><td>4</td></tr><tr><td>legendary</td><td>5</td></tr></table>
--- @desc Note that the numbers returned above are different from those returned by the <code>combined_difficulty_level()</code> function on the campaign model.
--- @p [opt=false] boolean return as string
--- @return object difficulty integer or string
function campaign_manager:get_difficulty(return_as_string)
     local difficulty = self:model():combined_difficulty_level();

     if self:get_local_faction_name(true) then
          if difficulty == 0 then
               difficulty = 2; -- normal
          elseif difficulty == -1 then
               difficulty = 3; -- hard
          elseif difficulty == -2 then
               difficulty = 4; -- very hard
          elseif difficulty == -3 then
               difficulty = 5; -- legendary
          else
               difficulty = 1; -- easy
          end;
     else
          -- autorun
          if difficulty == 0 then
               difficulty = 2; -- normal
          elseif difficulty == 1 then
               difficulty = 3; -- hard
          elseif difficulty == 2 then
               difficulty = 4; -- very hard
          elseif difficulty == 3 then
               difficulty = 5; -- legendary
          else
               difficulty = 1; -- easy
          end;
     end;

     if return_as_string then
          local difficulty_string = "easy";

          if difficulty == 2 then
               difficulty_string = "normal";
          elseif difficulty == 3 then
               difficulty_string = "hard";
          elseif difficulty == 4 then
               difficulty_string = "very hard";
          elseif difficulty == 5 then
               difficulty_string = "legendary";
          end;

          return difficulty_string;
     end;

     return difficulty;
end;

--- @function local_faction_exists
--- @desc Returns whether a local faction exists. This should only return <code>false</code> in an autotest without a local faction.
--- @return @boolean local faction exists
function campaign_manager:has_local_faction()
     return not not self.local_faction_name;
end;

--- @function get_local_faction_name
--- @desc Returns the local player faction name. This must be called after the game is created. Beware of using this in multiplayer - making changes to the model based on the identity of the local faction is a fast route to causing a desync. If called in multiplayer the function throws a script error and fails, unless <code>true</code> is passed in as an argument to force the result. In doing so, the calling script acknowledges the risk.
--- @p [opt=false] boolean force result
--- @return string local faction name
function campaign_manager:get_local_faction_name(force)
     if not self.game_is_running and not self.has_local_faction_initialized_event_been_triggered then
          script_error(self.name .. " ERROR: get_local_faction_name() called before game has been created");
          return false;
     end;

     if self:is_multiplayer() and not force then
          script_error(self.name ..
          " ERROR: get_local_faction_name() called but this is a multiplayer game, reconsider or force this usage. Please bug this.");
          return false;
     end;

     return self.local_faction_name;
end;

--- @function get_local_faction
--- @desc Returns the local player faction object.
--- @p [opt=false] boolean force result, Force the result to be returned instead of erroring in multiplayer.
--- @r @faction faction
function campaign_manager:get_local_faction(force)
     if not self.game_is_running and not self.has_local_faction_initialized_event_been_triggered then
          script_error(self.name .. " ERROR: get_local_faction() called before game has been created");
          return false;
     end;

     if self:is_multiplayer() and not force then
          script_error(self.name ..
          " ERROR: get_local_faction() called but this is a multiplayer game, reconsider or force this usage. Please bug this.");
          return false;
     end;

     if not self.local_faction_name then
          if not common.is_autotest() then
               script_error(self.name ..
               " WARNING: get_local_faction() called but no local faction has been set - this should only happen in autoruns. False will be returned");
          end
          return false;
     end;

     return self:get_faction(self.local_faction_name);
end;

--- @function get_human_factions
--- @desc Returns a numerically-indexed table containing the string keys of all human factions within the game.
--- @return table human factions
function campaign_manager:get_human_factions()
     if not self.game_is_running then
          script_error(self.name .. " ERROR: get_human_factions() called before game has been created");
          return false;
     end;

     -- make a copy so that our version is not modified by calling scripts
     local retval = {};
     for i = 1, #self.human_factions do
          retval[i] = self.human_factions[i];
     end;

     return retval;
end;

--- @function is_human_factions_turn
--- @desc Returns whether it's currently the turn of a human player-controlled faction.
--- @r @boolean is any human faction's turn
function campaign_manager:is_human_factions_turn()
     return self:model():world():whose_turn_is_it():is_human();
end;

--- @function get_factions_at_campaign_start
--- @desc Returns a numerically-indexed table containing the string keys of all factions at the start of the game.
--- @return table factions at campaign start
function campaign_manager:get_factions_at_campaign_start()
     if not self.game_is_running then
          script_error(self.name .. " ERROR: get_factions_at_campaign_start() called before game has been created")
          return false
     end;

     -- make a copy so that our version is not modified by calling scripts
     local retval = {};
     for i = 1, #self.factions_at_campaign_start do
          retval[i] = self.factions_at_campaign_start[i]
     end

     return retval
end;

--- @function get_local_faction_culture
--- @desc Returns the cached culture key of the local human player. If no local faction has been set then a blank string is returned - this should only happen in autoruns.
--- @return @string local faction culture
function campaign_manager:get_local_faction_culture()
     return self.local_faction_culture_key;
end;

--- @function get_local_faction_subculture
--- @desc Returns the cached subculture key of the local human player. If no local faction has been set then a blank string is returned - this should only happen in autoruns.
--- @return @string local faction subculture
function campaign_manager:get_local_faction_subculture()
     return self.local_faction_subculture_key;
end;

--- @function whose_turn_is_it
--- @desc Returns the faction key of the faction whose turn it is currently.
--- @return string faction key
function campaign_manager:whose_turn_is_it()
     return self:model():world():whose_turn_is_it():name();
end;

--- @function is_local_players_turn
--- @desc Returns <code>true</code> if it's the local player's turn.
--- @return boolean is local player's turn
function campaign_manager:is_local_players_turn()
     return self:whose_turn_is_it() == self:get_local_faction_name(true);
end;

--- @function is_processing_battle
--- @desc Returns true if a battle is currently happening on-screen. This is set to true when the pre-battle panel opens, and is set to false when the battle sequence is over and any related camera animations have finished playing.
--- @return boolean battle is happening
function campaign_manager:is_processing_battle()
     return self.processing_battle or self.processing_battle_completing;
end;

--- @function is_pending_battle_active
--- @desc Returns whether a pending battle is active (i.e. we are immediately pre-battle or post-battle). If the pending battle is active the function will also return whether the battle has been fought (note however that on the first tick when returning from battle this will still be false).
--- @r @boolean is a pending battle active
--- @r @boolean active pending battle has been fought already
function campaign_manager:is_pending_battle_active()
     local pb = self:model():pending_battle();

     if pb:is_active() then
          return true, pb:has_been_fought();
     end;

     return false, false;
end;

--- @function get_pending_battle_general_for_faction
--- @desc Returns the pending battle general for the specified faction if it is participant in the battle or false
--- @p @faction faction
--- @p [opt=true] boolean should_include_secondary_participants, Whether we should check in the secondary participants list too
--- @r @character the general from the specified faction or false if the faction is not participant in the battle
--- @r @boolean is_from_attacking_side, is the returned general from the attacking side
function campaign_manager:get_pending_battle_general_for_faction(faction, should_include_secondary_participants)
     if should_include_secondary_participants ~= false then
          should_include_secondary_participants = true
     end

     if not is_faction(faction) then
          script_error("ERROR: get_pending_battle_general_for_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object")
          return false, false
     end

     local pb = self:model():pending_battle()

     if pb:has_attacker() and pb:attacker():faction():command_queue_index() == faction:command_queue_index() then
          return pb:attacker(), true
     elseif pb:has_defender() and pb:defender():faction():command_queue_index() == faction:command_queue_index() then
          return pb:defender(), false
     end

     if should_include_secondary_participants then
          local secondary_attackers = pb:secondary_attackers()
          for i = 0, secondary_attackers:num_items() - 1 do
               local general = secondary_attackers:item_at(i)
               if general:faction():command_queue_index() == faction:command_queue_index() then
                    return general, true
               end
          end

          local secondary_defenders = pb:secondary_defenders()
          for i = 0, secondary_defenders:num_items() - 1 do
               local general = secondary_defenders:item_at(i)
               if general:faction():command_queue_index() == faction:command_queue_index() then
                    return general, false
               end
          end
     end

     return false, false
end

--- @function is_faction_participant_in_pending_battle
--- @desc Checks whether the specified faction is participant in the pending battle
--- @p @faction faction
--- @p [opt=true] boolean should_include_secondary_participants, Whether we should check in the secondary participants list too
--- @r @boolean is the specified faction participant in the pending battle
--- @r @boolean is_from_attacking_side, is the specified faction from the attacking side
function campaign_manager:is_faction_participant_in_pending_battle(faction, should_include_secondary_participants)
     local general, is_from_attacking_side = self:get_pending_battle_general_for_faction(faction,
          should_include_secondary_participants)
     return not not general, is_from_attacking_side
end

--- @function get_pending_battle_general_for_primary_enemy_faction
--- @desc Returns the pending battle general of the primary enemy army of the specified faction or false if the specified faction is not participant in the battle
--- @p @faction our_faction
--- @r @character the general for the enemy of the specified faction or false if the specified faction is not participant in the battle
--- @r @boolean is_from_attacking_side, is the returned general from the attacking side
function campaign_manager:get_pending_battle_general_for_primary_enemy_faction(our_faction)
     local is_our_faction_participant, is_our_faction_from_attacking_side = self
     :is_faction_participant_in_pending_battle(our_faction, true --[[should_include_secondary_participants--]])

     if not is_our_faction_participant then
          return false, false
     end

     if is_our_faction_from_attacking_side then
          return not self:model():pending_battle():defender():is_null_interface() and
          self:model():pending_battle():defender(), false
     else
          return not self:model():pending_battle():attacker():is_null_interface() and
          self:model():pending_battle():attacker(), true
     end
end

--- @function turn_number
--- @desc Returns the turn number, including any modifier set with @campaign_manager:set_turn_number_modifier
--- @return number turn number
function campaign_manager:turn_number()
     return self.game_interface:model():turn_number() + self.turn_number_modifier;
end;

--- @function set_turn_number_modifier
--- @desc Sets a turn number modifier. This offsets the result returned by @campaign_manager:turn_number by the supplied modifier. This is useful for campaign setups which include optional additional turns (e.g. one or two turns at the start of a campaign to teach players how to play the game), but still wish to trigger events on certain absolute turns. For example, some script may wish to trigger an event on turn five of a standard campaign, but this would be turn six if a one-turn optional tutorial at the start of the campaign was played through - in this case a turn number modifier of 1 could be set if not playing through the tutorial.
--- @p number modifier
function campaign_manager:set_turn_number_modifier(modifier)
     if not is_number(modifier) or math.floor(modifier) ~= modifier then
          script_error("ERROR: set_turn_number_modifier() called but supplied modifier [" ..
          tostring(modifier) .. "] is not an integer");
          return false;
     end;

     self.turn_number_modifier = modifier;
end;

--- @function null_interface
--- @desc Returns a scripted-generated object that emulates a campaign null interface.
--- @return null_interface
function campaign_manager:null_interface()
     local null_interface = {};

     null_interface.is_null_interface = function() return true end;

     return null_interface;
end;

--- @function help_page_seen
--- @desc Returns whether the advice history indicates that a specific help page has been viewed by the player.
--- @p string help page name
--- @return boolean help page viewed
function campaign_manager:help_page_seen(page_name)
     return common.get_advice_history_string_seen(page_name) or
     common.get_advice_history_string_seen("script_link_campaign_" .. page_name);
end;

----------------------------------------------------------------------------
--- @section Building Queries & Modification
----------------------------------------------------------------------------


--- @function building_exists_in_province
--- @desc Returns whether the supplied building exists in the supplied province.
--- @p string building key
--- @p string province key
--- @return boolean building exist
function campaign_manager:building_exists_in_province(building_key, province_key)
     if not is_string(building_key) then
          script_error("ERROR: building_exists_in_province() called but supplied building key [" ..
          tostring(building_key) .. "] is not a string");
          return false;
     end;

     if not is_string(province_key) then
          script_error("ERROR: building_exists_in_province() called but supplied province key [" ..
          tostring(province_key) .. "] is not a string");
          return false;
     end;

     local region_list = self:model():world():region_manager():region_list();

     for i = 0, region_list:num_items() - 1 do
          local current_region = region_list:item_at(i);
          if current_region:province_name() == province_key and current_region:building_exists(building_key) then
               return true;
          end;
     end;

     return false;
end;

--- @function building_chain_exists_in_region
--- @desc Returns whether the supplied building chain exists in the supplied region.
--- @p string chain key
--- @p @region region
--- @return false or the level of the building from this chain if such building exists
function campaign_manager:building_chain_exists_in_region(chain_key, region_interface)
     if not is_string(chain_key) then
          script_error("ERROR: building_chain_exists_in_region() called but supplied chain key [" ..
          tostring(chain_key) .. "] is not a string")
          return false
     end

     if not is_region(region_interface) then
          script_error(
          "ERROR: building_chain_exists_in_region() called but supplied region is not a REGION_SCRIPT_INTERFACE")
          return false
     end

     local building_list = region_interface:settlement():building_list()
     local num_buildings = building_list:num_items()

     for i = 0, num_buildings - 1 do
          local current_building = building_list:item_at(i)

          if current_building:chain() == chain_key then
               return current_building:level()
          end
     end

     return false
end

--- @function max_chain_level_in_faction
--- @desc Returns the level of the highest tier building from the supplied chain in all of the regions of the supplied faction or false if a building from this chain doesn't exist in the faction
--- @p string chain key
--- @p @faction faction
--- @return number -1 if there is no building from this chain or the level of the highest tier building from the supplied chain in all of the regions of the supplied faction
function campaign_manager:max_chain_level_in_faction(chain_key, faction_interface)
     if not is_string(chain_key) then
          script_error("ERROR: building_chain_exists_in_region() called but supplied chain key [" ..
          tostring(chain_key) .. "] is not a string")
          return -1
     end

     if not is_faction(faction_interface) then
          script_error(
          "ERROR: building_chain_exists_in_region() called but supplied faction is not a FACTION_SCRIPT_INTERFACE")
          return -1
     end

     local regions = faction_interface:region_list()
     local num_regions = regions:num_items()

     local max_level = -1

     for i = 0, num_regions - 1 do
          local current_region = regions:item_at(i)
          local chain_level = cm:building_chain_exists_in_region(chain_key, current_region)

          if chain_level then
               max_level = math.max(max_level, chain_level)
          end
     end

     return max_level
end

--- @function get_building_from_building_chain
--- @desc Returns the building level name for the building from the supplied chain at the supplied level
--- @p string chain key
--- @p number level
function campaign_manager:get_building_from_building_chain(chain_key, level)
     if not is_string(chain_key) then
          script_error("ERROR: get_building_from_building_chain() called but supplied chain key [" ..
          tostring(chain_key) .. "] is not a string")
          return -1
     end

     if not is_number(level) or level < 0 then
          script_error("ERROR: get_building_from_building_chain() called but supplied level [" ..
          tostring(level) .. "] is not positive number")
     end

     return self.game_interface:get_building_from_building_chain(chain_key, level)
end

--- @function get_building_create_cost
--- @desc Returns the creation cost record key for the building level with the given key
--- @p string building level key
function campaign_manager:get_building_create_cost_record_key(building_level_key)
     if not is_string(building_level_key) then
          script_error("ERROR: get_building_create_cost_record_key() called but supplied building_level_key [" ..
          tostring(building_level_key) .. "] is not a string")
          return -1
     end

     return self.game_interface:get_building_create_cost_record_key(building_level_key)
end

--- @function get_building_conversion_cost
--- @desc Returns the conversion cost record key for the building level with the given key
--- @p string building level key
function campaign_manager:get_building_conversion_cost_record_key(building_level_key)
     if not is_string(building_level_key) then
          script_error("ERROR: get_building_conversion_cost_record_key() called but supplied building_level_key [" ..
          tostring(building_level_key) .. "] is not a string")
          return -1
     end

     return self.game_interface:get_building_conversion_cost_record_key(building_level_key)
end

--- @function get_building_repair_override_cost_record_key
--- @desc Returns the repair override cost record key for the building level with the given key
--- @p string building level key
function campaign_manager:get_building_repair_override_cost_record_key(building_level_key)
     if not is_string(building_level_key) then
          script_error("ERROR: get_building_repair_override_cost_record_key() called but supplied building_level_key [" ..
          tostring(building_level_key) .. "] is not a string")
          return -1
     end

     return self.game_interface:get_building_repair_override_cost_record_key(building_level_key)
end

--- @function is_building_excluded_from_corvee_labour
--- @desc Returns whether building level with key is excluded from corvee labour
--- @p string building level key
function campaign_manager:is_building_excluded_from_corvee_labour(building_level_key)
     if not is_string(building_level_key) then
          script_error("ERROR: is_building_excluded_from_corvee_labour() called but supplied building_level_key [" ..
          tostring(building_level_key) .. "] is not a string")
          return nil
     end

     return self.game_interface:is_building_excluded_from_corvee_labour(building_level_key)
end

--- @function get_building_refund_cost
--- @desc Returns how much resources would be refunded for the building
--- @p string building_interface the script interface of the building
function campaign_manager:get_building_refund_cost(building_interface)
     local cost = cm:create_new_custom_resource_cost()
     if building_interface and not building_interface:is_null_interface() then
          local salvage_modifier = cm:model():get_campaign_variable_by_name("building_salvage_cost_modifier")
          local salvage_modifier_damaged = cm:model():get_campaign_variable_by_name(
          "building_salvage_cost_modifier_damaged")
          local salvage_modifier_ruined = cm:model():get_campaign_variable_by_name(
          "building_salvage_cost_modifier_ruined")

          local current_resource_cost = cm:create_new_custom_resource_cost()

          local creation_cost_record_key = cm:get_building_create_cost_record_key(building_interface:name())
          current_resource_cost:get_cost_from_record(creation_cost_record_key)

          local hp = building_interface:percent_health()

          if hp == 100 then
               current_resource_cost:multiply_by(salvage_modifier)
          elseif hp == 0 then
               current_resource_cost:multiply_by(salvage_modifier_ruined)
          else
               current_resource_cost:multiply_by(salvage_modifier_damaged)
          end
          cost:add(current_resource_cost)
     else
          script_error("ERROR: get_building_refund_cost() called but supplied building_inteface is not valid!")
     end
     return cost
end

----------------------------------------------------------------------------
--- @section Character Queries & Modification
----------------------------------------------------------------------------


--- @function get_garrison_commander_of_region
--- @desc Returns the garrison commander character of the settlement in the supplied region.
--- @p region region object
--- @return character garrison commander
function campaign_manager:get_garrison_commander_of_region(region)
     if not is_region(region) then
          script_error("ERROR: get_garrison_commander_of_region() called but supplied object [" ..
          tostring(region) .. "] is not a valid region");
          return false;
     end

     if region:is_abandoned() then
          return false;
     end;

     local faction = region:owning_faction();

     if not is_faction(faction) then
          return false;
     end;

     local character_list = faction:character_list();

     out.inc_tab();
     for i = 0, character_list:num_items() - 1 do
          local character = character_list:item_at(i);

          if character:has_military_force() and character:military_force():is_armed_citizenry() and character:has_region() and character:region() == region then
               return character;
          end;
     end;
     out.dec_tab();
end;

--- @function get_closest_general_to_position_from_faction
--- @desc Returns the general within the supplied faction that's closest to the supplied logical co-ordinates.
--- @p object faction, Faction specifier. This can be a faction object or a string faction name.
--- @p number x, Logical x co-ordinate.
--- @p number y, Logical y co-ordinate.
--- @p [opt=false] boolean include garrison commanders, Includes garrison commanders in the search results if set to <code>true</code>.
--- @return character closest character
function campaign_manager:get_closest_general_to_position_from_faction(faction, x, y, consider_garrison_commanders)
     return self:get_closest_character_to_position_from_faction(faction, x, y, true, consider_garrison_commanders);
end;

--- @function get_closest_character_to_position_from_faction
--- @desc Returns the character within the supplied faction that's closest to the supplied logical co-ordinates.
--- @p object faction, Faction specifier. This can be a faction object or a string faction name.
--- @p number x, Logical x co-ordinate.
--- @p number y, Logical y co-ordinate.
--- @p [opt=false] boolean general characters only, Restrict search results to generals.
--- @p [opt=false] boolean include garrison commanders, Includes garrison commanders in the search results if set to <code>true</code>.
--- @return character closest character
function campaign_manager:get_closest_character_to_position_from_faction(faction, x, y, generals_only,
                                                                         consider_garrison_commanders)
     generals_only = not not generals_only;
     consider_garrison_commanders = not not consider_garrison_commanders;

     if not generals_only then
          consider_garrison_commanders = true;
     end;

     if not is_faction(faction) then
          local faction_found = false;

          if is_string(faction) then
               faction = cm:get_faction(faction);
               if faction then
                    faction_found = true;
               end;
          end;

          if not faction_found then
               script_error("ERROR: get_closest_character_to_position_from_faction() called but supplied faction [" ..
               tostring(faction) .. "] is not a valid faction, or a string name of a faction");
               return false;
          end;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: get_closest_character_to_position_from_faction() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return false;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: get_closest_character_to_position_from_faction() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return false;
     end;

     local char_list = faction:character_list();
     local closest_char = false;
     local closest_distance_squared = 100000000;

     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i);

          -- if we aren't only looking for generals OR if we are and this is a general AND if we are considering garrison commanders OR if we aren't and it is a general proceed
          if not generals_only or (self:char_is_general(current_char) and current_char:has_military_force() and (consider_garrison_commanders or not current_char:military_force():is_armed_citizenry())) then
               local current_char_x, current_char_y = self:char_logical_pos(current_char);
               local current_distance_squared = distance_squared(x, y, current_char_x, current_char_y);
               if current_distance_squared < closest_distance_squared then
                    closest_char = current_char;
                    closest_distance_squared = current_distance_squared;
               end;
          end;
     end;

     return closest_char, closest_distance_squared ^ 0.5;
end;

--- @function get_general_at_position_all_factions
--- @desc Returns the general character stood at the supplied position, regardless of faction. Garrison commanders are not returned.
--- @p number x, Logical x co-ordinate.
--- @p number y, Logical y co-ordinate.
--- @return character general character
function campaign_manager:get_general_at_position_all_factions(x, y)
     local faction_list = cm:model():world():faction_list();

     for i = 0, faction_list:num_items() - 1 do
          local faction = faction_list:item_at(i);

          local military_force_list = faction:military_force_list();

          for j = 0, military_force_list:num_items() - 1 do
               local mf = military_force_list:item_at(j);

               if mf:has_general() and not mf:is_armed_citizenry() then
                    local character = mf:general_character();

                    if character:logical_position_x() == x and character:logical_position_y() == y then
                         return character;
                    end;
               end;
          end;
     end;

     return false;
end;

--- @function get_character_by_cqi
--- @desc Returns a character by it's command queue index. If no character with the supplied cqi is found then <code>false</code> is returned.
--- @p number cqi
--- @return character character
function campaign_manager:get_character_by_cqi(cqi)
     if is_string(cqi) then
          cqi = tonumber(cqi);
     end;

     if not is_number(cqi) then
          script_error("get_character_by_cqi() called but supplied cqi [" ..
          tostring(cqi) .. "] is not a number or a string that converts to a number");
          return false;
     end;

     local model = self:model();
     if model:has_character_command_queue_index(cqi) then
          return model:character_for_command_queue_index(cqi);
     end;

     return false;
end;

--- @function get_family_member_by_cqi
--- @desc Returns a family member by it's command queue index. If no character with the supplied cqi is found then <code>false</code> is returned.
--- @p number cqi
--- @return family_member family_member
function campaign_manager:get_family_member_by_cqi(cqi)
     if is_string(cqi) then
          cqi = tonumber(cqi)
     end

     if not is_number(cqi) then
          script_error("get_family_member_by_cqi() called but supplied cqi [" ..
          tostring(cqi) .. "] is not a number or a string that converts to a number")
          return false
     end

     local model = self:model()
     if model:has_family_member_command_queue_index(cqi) then
          return model:family_member_for_command_queue_index(cqi)
     end

     return false
end

--- function char_name_to_string
--- @desc Returns the supplied character's full localised name as a string for output.
--- @p character character
--- @r @string character name
function campaign_manager:char_name_to_string(character)
     local forename = character:get_forename();
     local surname = character:get_surname();

     if not forename or forename == "" then
          forename = "<no forename>";
     else
          forename = common.get_localised_string(forename);
     end;

     if not surname or surname == "" then
          return forename;
     end;

     -- localised surnames can sometimes be blank, so only return the forename in this case
     local localised_surname = common.get_localised_string(surname);
     if not string.match(localised_surname, "[^%s]") then
          -- localised_surname didn't contain any non-space characters
          return forename;
     end;

     return forename .. " " .. localised_surname;
end;

--- @function get_character
--- @desc Returns a character by character lookup string. If no character with the supplied character lookup string is found then first is returned.
--- @p string character lookup string
--- @return character character
function campaign_manager:get_character(char_str)
     if not is_string(char_str) then
          script_error("ERROR: get_character() called but supplied character lookup [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     return self.game_interface:get_character(char_str);
end;

--- @function get_character_by_mf_cqi
--- @desc Returns the commander of a military force by the military force's command queue index. If no military force with the supplied cqi is found or it has no commander then <code>false</code> is returned.
--- @p number military force cqi
--- @return character general character
function campaign_manager:get_character_by_mf_cqi(cqi)
     local mf = self:get_military_force_by_cqi(cqi);

     if mf and mf:has_general() then
          return mf:general_character();
     end;

     return false;
end;

--- @function get_character_by_fm_cqi
--- @desc Returns a character by family member command queue index. If no family member interface with the supplied cqi could be found then <code>false</code> is returned.
--- @p @number family member cqi
--- @r character character
function campaign_manager:get_character_by_fm_cqi(cqi)
     local family_member = self:model():family_member_for_command_queue_index(cqi);

     if not family_member:is_null_interface() then
          local character = family_member:character();
          if not character:is_null_interface() then
               return character;
          end;
     end;

     return false;
end;

--- @function char_display_pos
--- @desc Returns the x/y display position of the supplied character.
--- @p character character
--- @return number x display co-ordinate
--- @return number y display co-ordinate
function campaign_manager:char_display_pos(character)
     if not is_character(character) then
          script_error("ERROR: char_display_pos() called but supplied object [" ..
          tostring(character) .. "] is not a character");
          return 0, 0;
     end;

     return character:display_position_x(), character:display_position_y();
end;

--- @function char_logical_pos
--- @desc Returns the x/y logical position of the supplied character.
--- @p character character
--- @return number x logical co-ordinate
--- @return number y logical co-ordinate
function campaign_manager:char_logical_pos(character)
     if not is_character(character) then
          script_error("ERROR: char_logical_pos() called but supplied object [" ..
          tostring(character) .. "] is not a character");
          return 0, 0;
     end;

     return character:logical_position_x(), character:logical_position_y();
end;

--- @function character_is_army_commander
--- @desc Returns <code>true</code> if the character is a general at the head of a moveable army (not a garrison), <code>false</code> otherwise.
--- @p character character
--- @return boolean is army commander
function campaign_manager:character_is_army_commander(character)
     if not is_character(character) then
          script_error("ERROR: char_is_army_commander() called but supplied object [" ..
          tostring(character) .. "] is not a character");
          return false;
     end;

     if not character:has_military_force() then
          return false;
     end;

     local military_force = character:military_force();

     return military_force:has_general() and military_force:general_character() == character and
     not military_force:is_armed_citizenry();
end;

--- @function char_lookup_str
--- @desc Various game interface functions lookup characters using a lookup string. This function converts a @character into a lookup string that can be used by code functions to find that same character. It may also be supplied a character cqi in place of a character object.
--- @p @character character, Character or character cqi. A @family_member script interface may also be supplied.
--- @r @string lookup string
function campaign_manager:char_lookup_str(obj)
     if is_number(obj) or is_string(obj) then
          return "character_cqi:" .. obj;
     elseif is_character(obj) then
          return "character_cqi:" .. obj:cqi();
     elseif is_family_member(obj) then
          return "family_member_cqi:" .. obj:command_queue_index()
     end;

     script_error("ERROR: char_lookup_str() called but supplied object [" .. tostring(obj) .. "] not recognised");
     return "";
end;

--- @function char_lookup_str_fm
--- @desc Various game interface functions lookup characters using a lookup string. This function converts a @family_member into a lookup string that can be used by code functions to find the related character. It may also be supplied a family member cqi in place of a family member object.
--- @desc This function is related to and does the same job as @campaign_manager:char_lookup_str. The main difference between them is that a number or string supplied to @campaign_manager:char_lookup_str is assumed to be a cqi identifying a character interface, while a number/string supplied to this function is assumed to be a cqi identifying a family member interface.
--- @p @family_member family member, Family member or @number/@string family member cqi. A @character script interface may also be supplied.
--- @r @string lookup string
function campaign_manager:char_lookup_str_fm(obj)
     if is_number(obj) or is_string(obj) then
          return "family_member_cqi:" .. obj;
     elseif is_family_member(obj) then
          return "family_member_cqi:" .. obj:command_queue_index();
     elseif is_character(obj) then
          return "character_cqi:" .. obj:cqi();
     end;

     script_error("ERROR: char_lookup_str() called but supplied object [" .. tostring(obj) .. "] not recognised");
     return "";
end;

--- @function char_in_owned_region
--- @desc Returns <code>true</code> if the supplied character is in a region their faction controls, <code>false</code> otherwise.
--- @p character character
--- @return boolean stood in owned region
function campaign_manager:char_in_owned_region(character)
     return character:has_region() and (character:region():owning_faction() == character:faction());
end;

--- @function char_has_army
--- @desc Returns <code>true</code> if the supplied character has a land army military force, <code>false</code> otherwise.
--- @p character character
--- @return boolean has army
function campaign_manager:char_has_army(character)
     return character:has_military_force() and character:military_force():is_army();
end;

--- @function char_has_navy
--- @desc Returns <code>true</code> if the supplied character has a navy military force, <code>false</code> otherwise.
--- @p character character
--- @return boolean has navy
function campaign_manager:char_has_navy(character)
     return character:has_military_force() and character:military_force():is_navy();
end;

--- @function char_is_agent
--- @desc Returns <code>true</code> if the supplied character is not a general, a colonel or a minister, <code>false</code> otherwise.
--- @p character character
--- @return boolean is agent
function campaign_manager:char_is_agent(character)
     return not (character:character_type("general") or character:character_type("colonel") or character:character_type("minister"));
end;

--- @function char_is_general
--- @desc Returns <code>true</code> if the supplied character is of type 'general', <code>false</code> otherwise.
--- @p character character
--- @return boolean is general
function campaign_manager:char_is_general(character)
     return character:character_type("general");
end;

--- @function char_is_victorious_general
--- @desc Returns <code>true</code> if the supplied character is a general that has been victorious (when?), <code>false</code> otherwise.
--- @p character character
--- @return boolean is victorious general
function campaign_manager:char_is_victorious_general(character)
     return character:character_type("general") and character:won_battle();
end;

--- @function char_is_defeated_general
--- @desc Returns <code>true</code> if the supplied character is a general that has been defeated (when?), <code>false</code> otherwise.
--- @p character character
--- @return boolean is defeated general
function campaign_manager:char_is_defeated_general(character)
     return character:character_type("general") and not character:won_battle();
end;

--- @function char_is_general_with_army
--- @desc Returns <code>true</code> if the supplied character is a general and has an army, <code>false</code> otherwise. This includes garrison commanders - to only return true if the army is mobile use @campaign_manager:char_is_mobile_general_with_army.
--- @p character character
--- @return boolean is general with army
function campaign_manager:char_is_general_with_army(character)
     return self:char_is_general(character) and self:char_has_army(character);
end;

--- @function char_is_mobile_general_with_army
--- @desc Returns <code>true</code> if the supplied character is a general, has an army, and can move around the campaign map, <code>false</code> otherwise.
--- @p character character
--- @return boolean is general with army
function campaign_manager:char_is_mobile_general_with_army(character)
     return self:char_is_general_with_army(character) and not character:military_force():is_armed_citizenry();
end;

--- @function char_is_general_with_navy
--- @desc Returns <code>true</code> if the supplied character is a general with a military force that is a navy, <code>false</code> otherwise.
--- @p character character
--- @return boolean is general with navy
function campaign_manager:char_is_general_with_navy(character)
     return cm:char_is_general(character) and self:char_has_navy(character);
end;

--- @function char_is_governor
--- @desc Returns <code>true</code> if the supplied character is the governor of a region, <code>false</code> otherwise.
--- @p character character
--- @return boolean is governor
function campaign_manager:char_is_governor(character)
     return character:has_region() and character:region():has_governor() and character:region():governor() == character;
end

--- @function char_is_in_region_list
--- @desc Returns <code>true</code> if the supplied character is currently in any region from a supplied list, <code>false</code> otherwise.
--- @p character character
--- @p table table of region keys
--- @return boolean is in region list
function campaign_manager:char_is_in_region_list(character, region_list)
     return table_contains(region_list, character:region():name());
end;

--- @function get_closest_visible_character_of_subculture
--- @desc Returns the closest character of the supplied subculture to the supplied faction. The subculture and faction are both specified by string key.
--- @desc Use this function sparingly, as it is quite expensive.
--- @p string faction key
--- @p string subculture key
--- @return character closest visible character
function campaign_manager:get_closest_visible_character_of_subculture(faction_key, subculture_key)
     local faction = cm:get_faction(faction_key);

     if not faction then
          script_error(
          "ERROR: get_closest_visible_character_of_culture() called but couldn't find faction with supplied key [" ..
          tostring(faction_key) .. "]");
          return false;
     end;

     if not is_string(subculture_key) then
          script_error("ERROR: get_closest_visible_character_of_culture() called but supplied subculture key [" ..
          tostring(subculture_key) .. "] is not a string");
          return false;
     end;

     local closest_char = false;
     local closest_char_dist = 1000000000;

     -- get a list of chars of the supplied culture
     local faction_list = faction:factions_met();
     for i = 0, faction_list:num_items() - 1 do
          local current_faction = faction_list:item_at(i);

          if current_faction:subculture() == subculture_key then
               local char_list = current_faction:character_list();

               for j = 0, char_list:num_items() - 1 do
                    local current_char = char_list:item_at(j);

                    if current_char:is_visible_to_faction(faction_key) and (self:char_is_agent(current_char) or self:char_is_general(current_char)) then
                         local closest_player_char, closest_player_char_dist = self:get_closest_character_from_faction(
                         faction, current_char:logical_position_x(), current_char:logical_position_y());

                         if closest_player_char_dist < closest_char_dist then
                              closest_char_dist = closest_player_char_dist;
                              closest_char = current_char;
                         end;
                    end;
               end;
          end;
     end;

     local closest_char_dist = closest_char_dist ^ 0.5;

     return closest_char, closest_char_dist;
end;

--- @function get_closest_character_from_faction
--- @desc Returns the closest character from the supplied faction to the supplied position. This includes characters such as politicians and garrison commanders that are not extant on the map.
--- @p faction faction
--- @p number x
--- @p number y
--- @return character closest character
function campaign_manager:get_closest_character_from_faction(faction, x, y)
     local closest_distance = 1000000000;
     local closest_character = false;

     local char_list = faction:character_list();

     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i);

          local current_distance = distance_squared(x, y, current_char:logical_position_x(),
               current_char:logical_position_y());
          if current_distance < closest_distance then
               closest_distance = current_distance;
               closest_character = current_character;
          end;
     end;

     return closest_character, closest_distance;
end;

--- @function character_can_reach_character
--- @desc Returns <code>true</code> if the supplied source character can reach the supplied target character this turn, <code>false</code> otherwise. The underlying test on the model interface returns false-positives if the source character has no action points - this wrapper function works around this problem by testing the source character's action points too.
--- @p character source character
--- @p character target character
--- @return boolean can reach
function campaign_manager:character_can_reach_character(source_char, target_char)
     if not is_character(source_char) then
          script_error("ERROR: character_can_reach_character() called but supplied source character [" ..
          tostring(source_char) .. "] is not a character");
          return false;
     end;

     if not is_character(target_char) then
          script_error("ERROR: character_can_reach_character() called but supplied target character [" ..
          tostring(target_char) .. "] is not a character");
          return false;
     end;

     return source_char:action_points_remaining_percent() > 0 and
     self:model():character_can_reach_character(source_char, target_char);
end;

--- @function character_can_reach_settlement
--- @desc Returns <code>true</code> if the supplied source character can reach the supplied target settlement this turn, <code>false</code> otherwise. The underlying test on the model interface returns false-positives if the source character has no action points - this wrapper function works around this problem by testing the source character's action points too.
--- @p character source character
--- @p settlement target settlement
--- @return boolean can reach
function campaign_manager:character_can_reach_settlement(source_char, target_settlement)
     if not is_character(source_char) then
          script_error("ERROR: character_can_reach_settlement() called but supplied source character [" ..
          tostring(source_char) .. "] is not a character");
          return false;
     end;

     if not is_settlement(target_settlement) then
          script_error("ERROR: character_can_reach_settlement() called but supplied target settlement [" ..
          tostring(target_settlement) .. "] is not a settlement");
          return false;
     end;

     return source_char:action_points_remaining_percent() > 0 and
     self:model():character_can_reach_settlement(source_char, target_settlement);
end;

--- @function general_with_forename_exists_in_faction_with_force
--- @desc Returns <code>true</code> if a general with a mobile military force exists in the supplied faction with the supplied forename. Faction and forename are specified by string key.
--- @p string faction key, Faction key.
--- @p string forename key, Forename key in the full localisation lookup format i.e. <code>[table]_[column]_[record_key]</code>.
--- @return boolean general exists
function campaign_manager:general_with_forename_exists_in_faction_with_force(faction_name, char_forename)
     local faction = cm:get_faction(faction_name);

     if not faction then
          return false;
     end;

     local char_list = faction:character_list();

     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i);

          if current_char:get_forename() == char_forename and cm:char_is_general(current_char) and current_char:has_military_force() and not current_char:military_force():is_armed_citizenry() then
               return true;
          end;
     end;

     return false;
end;

--- @function get_highest_ranked_general_for_faction
--- @desc Returns the general character in the supplied faction of the highest rank. The faction may be supplied as a faction object or may be specified by key.
--- @p object faction, Faction, either by faction object or by string key.
--- @return character highest ranked character
function campaign_manager:get_highest_ranked_general_for_faction(faction)
     if is_string(faction) then
          faction = cm:get_faction(faction)
     end;

     if not is_faction(faction) then
          script_error("ERROR: get_highest_ranked_general_for_faction() called but supplied object [" ..
          tostring(faction) .. "] is not a faction");
          return false;
     end;

     local char_list = faction:character_list();

     local current_rank = 0;
     local chosen_char = nil;
     local char_x = 0;
     local char_y = 0;

     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i);

          if self:char_is_general_with_army(current_char) then
               local rank = current_char:rank();

               if rank > current_rank then
                    chosen_char = current_char;
                    current_rank = rank;
               end;
          end;
     end;

     if chosen_char then
          return chosen_char;
     else
          return false;
     end;
end;

--- @function remove_all_units_from_general
--- @desc Removes all units from the military force the supplied general character commands.
--- @p character general character
--- @return number number of units removed
function campaign_manager:remove_all_units_from_general(character)
     if not is_character(character) then
          script_error("ERROR: remove_all_units_from_general() called but supplied character [" ..
          tostring(character) .. "] is not a character");
          return false;
     end;

     if not character:has_military_force() then
          return 0;
     end;

     local count = 0;
     local char_str = self:char_lookup_str(character);

     local unit_list = character:military_force():unit_list();

     for i = 1, unit_list:num_items() - 1 do
          self:remove_unit_from_character(char_str, unit_list:item_at(i):unit_key());
          count = count + 1;
     end;

     return count;
end;

--- @function grant_units_to_character_by_position_from_faction
--- @desc Grants one or more units, specified by string key(s), to a military force by character lookup. The military force is specified by its faction key and logical co-ordinates.
--- @p @string faction key, Faction key.
--- @p @number x, Logical x co-ordinate.
--- @p @number y, Logical y co-ordinate.
--- @p ... units, Units to add, specified by one or more @string variables.
function campaign_manager:grant_units_to_character_by_position_from_faction(faction_key, log_x, log_y, ...)
     if not is_string(faction_key) then
          script_error("ERROR: grant_units_to_character_by_position_from_faction() but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string")
          return false;
     end;

     local faction = cm:get_faction(faction_key);

     if not faction then
          script_error("ERROR: grant_units_to_character_by_position_from_faction() but no faction with supplied key [" ..
          faction_key .. "] could be found")
          return false;
     end;

     if not is_number(log_x) then
          script_error("ERROR: grant_units_to_character_by_position_from_faction() but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a number")
          return false;
     end;

     if not is_number(log_y) then
          script_error("ERROR: grant_units_to_character_by_position_from_faction() but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a number")
          return false;
     end;

     for i = 1, arg.n do
          if not is_string(arg[i]) then
               script_error("ERROR: grant_units_to_character_by_position_from_faction() but supplied unit key [" ..
               tostring(arg[i]) .. "] at vararg element [" .. i .. "] is not a string");
               return false;
          end;
     end;

     local character = cm:get_closest_general_to_position_from_faction(faction, log_x, log_y);

     if not character then
          script_error("ERROR: grant_units_to_character_by_position_from_faction() but no character at position [" ..
          log_x .. ", " .. log_y .. "] from faction with key [" .. faction_key .. "] could be found");
          return false;
     end;

     local character_str = cm:char_lookup_str(character);
     local output_str = "Adding units to character with cqi [" ..
     character:command_queue_index() ..
     "], position [" .. log_x .. ", " .. log_y .. "] from faction [" .. faction_key .. "] - units [";

     for i = 1, arg.n do
          cm:grant_unit_to_character(character_str, false, arg[i]);
          if i == arg.n then
               output_str = output_str .. arg[i] .. ",";
          else
               output_str = output_str .. arg[i] .. "]";
          end;
     end;

     out(output_str);
end;

-----------------------------------------------------------------------------
--- @section Dynasty Helpers
-----------------------------------------------------------------------------
--- @function is_character_ruler_of_dynasty
--- @desc Returns whether the character is a ruler of a dynasty
--- @p character general character
--- @return boolean is the character a ruler
function campaign_manager:is_character_ruler_of_dynasty(character)
     if not character or character:is_null_interface() or not character:is_faction_leader() then
          return false
     end
     local faction_key = character:faction():name()
     local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(faction_key)
     if not legitimacy_path then
          return false
     end
     return legitimacy_path.political_states_system:is_ruler(faction_key)
end

--- @function get_dynasty_ruled_by_character
--- @desc Returns the dynasty of which this character is a ruler
--- @p character general character
--- @return string key of the dynasty
function campaign_manager:get_dynasty_ruled_by_character(character)
     if not cm:is_character_ruler_of_dynasty(character) then
          return ""
     end

     local faction_key = character:faction():name()
     local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(faction_key)
     return legitimacy_path.config.dynasty_line_key
end

--- @function is_faction_ruler_of_dynasty
--- @desc Returns whether the faction is a ruler of a dynasty
--- @p faction faction
--- @return boolean key is the faction a ruler of a dynasty
function campaign_manager:is_faction_ruler_of_dynasty(faction)
     if not faction or faction:is_null_interface() then
          return false
     end

     local faction_key = faction:name()
     local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(faction_key)
     if not legitimacy_path then
          return false
     end
     return legitimacy_path.political_states_system:is_ruler(faction_key)
end

--- @function get_dynasty_ruled_by_faction
--- @desc Returns the dynasty of which this faction is a ruler
--- @p faction faction
--- @return string key of the dynasty
function campaign_manager:get_dynasty_ruled_by_faction(faction)
     if not cm:is_faction_ruler_of_dynasty(faction) then
          return ""
     end

     local faction_key = faction:name()
     local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(faction_key)
     return legitimacy_path.config.dynasty_line_key
end

-----------------------------------------------------------------------------
--- @section Faction Queries & Modification
-----------------------------------------------------------------------------


--- @function get_faction
--- @desc Gets a faction object by its string key. If no faction with the supplied key could be found then <code>false</code> is returned.
--- @p string faction key
--- @return faction faction
function campaign_manager:get_faction(key)
     if not is_string(key) then
          script_error("ERROR: get_faction() called but supplied faction name [" .. tostring(key) .. "] is not a string");
          return false;
     end;

     if string.find(key, "rebels") then
          return self:model():faction_for_command_queue_index(1)
     end

     local world = self:model():world();

     if world:faction_exists(key) then
          return world:faction_by_key(key);
     end;

     return false;
end;

--- @function faction_can_afford_resource_cost
--- @desc Returns <code>true</code> if the specified faction has access to all listed resources and has the required amount of them
--- @p faction faction object
--- @p table in the format {{"res_key1", val1}, {"res_key2", val1} ... } or {{key = "res_key1", amount = 5} ... }
--- @return faction can afford the specified resource cost
function campaign_manager:faction_can_afford_resource_cost(faction, resources)
     if not is_faction(faction) then
          script_error("ERROR: faction_can_afford_resource_cost() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false
     end

     for _, v in ipairs(resources) do
          local key = v.key or v[1]
          local amount = v.amount or v[2]

          if not faction:has_pooled_resource(key) or
              faction:pooled_resource(key):value() < amount then
               return false
          end
     end

     return true
end

--- @function faction_contains_building
--- @desc Returns <code>true</code> if territories controlled by the supplied faction contain the supplied building. This won't work for horde buildings.
--- @p faction faction object
--- @p string building key
--- @return faction contains building
function campaign_manager:faction_contains_building(faction, building_key)
     if not is_faction(faction) then
          script_error("ERROR: faction_contains_building() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local region_list = faction:region_list();

     for i = 0, region_list:num_items() - 1 do
          local region = region_list:item_at(i);

          if region:building_exists(building_key) then
               return true;
          end;
     end;

     return false;
end;

--- @function num_characters_of_type_in_faction
--- @desc Returns the number of characters of the supplied type in the supplied faction.
--- @p faction faction object
--- @p string character type
--- @return number number of characters
function campaign_manager:num_characters_of_type_in_faction(faction, agent_type)
     if not is_faction(faction) then
          script_error("ERROR: num_characters_of_type_in_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local character_list = faction:character_list();

     if character_list:num_items() == 0 then
          return 0;
     end;

     local num_found = 0;
     for i = 0, character_list:num_items() - 1 do
          if character_list:item_at(i):character_type(agent_type) then
               num_found = num_found + 1;
          end;
     end;

     return num_found;
end;

--- @function num_characters_with_skill_in_faction
--- @desc Returns the number of characters in the supplied faction which have the supplied skill
--- @p faction faction object
--- @p string skill record key
--- @return number number of characters
function campaign_manager:num_characters_with_skill_in_faction(faction, skill_key)
     if not is_faction(faction) then
          script_error("ERROR: num_characters_of_type_in_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local character_list = faction:character_list();

     if character_list:num_items() == 0 then
          return 0;
     end;

     local num_found = 0;
     for i = 0, character_list:num_items() - 1 do
          if character_list:item_at(i):has_skill(skill_key) then
               num_found = num_found + 1;
          end;
     end;

     return num_found;
end;

--- @function kill_all_armies_for_faction
--- @desc Kills all armies in the supplied faction.
--- @p faction faction object
--- @return number number of armies killed
function campaign_manager:kill_all_armies_for_faction(faction)
     if not is_faction(faction) then
          script_error("ERROR: kill_all_armies_for_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local military_force_list = faction:military_force_list();
     local count = 0;

     for i = 0, military_force_list:num_items() - 1 do
          local mf = military_force_list:item_at(i);

          if mf:has_general() then
               self:kill_character(mf:general_character():command_queue_index(), true);
               count = count + 1;
          end;
     end;

     if count == 0 then
          return 0;
     elseif count == 1 then
          out("### kill_all_armies_for_faction() just killed 1 force for faction " .. faction:name() .. " ###");
     else
          out("### kill_all_armies_for_faction() just killed " ..
          tostring(count) .. " forces for faction " .. faction:name() .. " ###");
     end;
     return count;
end;

--- @function get_trespasser_list_for_faction
--- @desc Returns a table of cqis of characters that are both at war with the specified faction and also trespassing on its territory.
--- @p faction faction object
--- @return table of character command queue indexes
function campaign_manager:get_trespasser_list_for_faction(faction)
     if not is_faction(faction) then
          script_error("ERROR: get_trespasser_list_for_faction() called but supplied object [" ..
          tostring(faction) .. "] is not a faction");
          return false;
     end;

     local retval = {};
     local faction_name = faction:name();

     -- go through all factions. If the current faction is at war with the specified faction, go through the
     -- current faction's military force leaders. If the character is in the subject faction's territory, note
     -- that character's cqi and faction in the table to return.
     local faction_list = faction:model():world():faction_list();

     for i = 0, faction_list:num_items() - 1 do
          local current_faction = faction_list:item_at(i);

          if faction:at_war_with(current_faction) then
               local military_force_list = current_faction:military_force_list();

               for j = 0, military_force_list:num_items() - 1 do
                    local military_force = military_force_list:item_at(j);

                    if military_force:has_general() then
                         local character = military_force:general_character();

                         if character:has_region() and character:region():owning_faction():name() == faction_name then
                              table.insert(retval, character:command_queue_index());
                         end;
                    end;
               end;
          end;
     end;

     return retval;
end;

--- @function number_of_units_in_faction
--- @desc Returns the number of units in all military forces in the supplied faction. The optional second parameter, if <code>true</code>, specifies that units in armed citizenry armies should not be considered in the calculation.
--- @p faction faction object
--- @p [opt=false] boolean exclude armed citizenry
--- @return number number of units
function campaign_manager:number_of_units_in_faction(faction, exclude_armed_citizenry)
     if not is_faction(faction) then
          script_error("ERROR: number_of_units_in_faction() called but supplied object [" ..
          tostring(faction) .. "] is not a faction");
          return false;
     end;

     local military_force_list = faction:military_force_list();
     local num_units = 0;

     for i = 0, military_force_list:num_items() - 1 do
          local mf = military_force_list:item_at(i);

          if not exclude_armed_citizenry or not mf:is_armed_citizenry() then
               num_units = num_units + mf:unit_list():num_items();
          end;
     end;

     return num_units;
end;

--- @function faction_has_full_military_force
--- @desc Returns <code>true</code> if the supplied faction has a military force with 20 units in it, or <code>false</code> otherwise. Armed citizenry/garrison armies are excluded from this check.
--- @p faction faction object
--- @return @boolean has full military force
function campaign_manager:faction_has_full_military_force(faction)
     if not is_faction(faction) then
          script_error("ERROR: faction_has_full_military_force() called but supplied object [" ..
          tostring(faction) .. "] is not a faction");
          return false;
     end;

     local military_force_list = faction:military_force_list();
     for i = 0, military_force_list:num_items() - 1 do
          if not military_force_list:item_at(i):is_armed_citizenry() and military_force_list:item_at(i):unit_list():num_items() >= 20 then
               return true;
          end;
     end;

     return false;
end;

--- @function faction_is_alive
--- @desc Returns true if the supplied faction has a home region or any military forces. Note that what constitutes as "alive" for a faction changes between different projects so use with care.
--- @p faction faction object
--- @return boolean faction is alive
function campaign_manager:faction_is_alive(faction)
     if not is_faction(faction) then
          script_error("ERROR: faction_is_alive() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     return faction:has_home_region() or faction:military_force_list():num_items() > 0;
end;

--- @function faction_of_culture_is_alive
--- @desc Returns true if any faction with a culture corresponding to the supplied key is alive (uses @campaign_manager:faction_is_alive).
--- @p string culture key
--- @return boolean any faction is alive
function campaign_manager:faction_of_culture_is_alive(culture_key)
     if not is_string(culture_key) then
          script_error("ERROR: faction_of_culture_is_alive() called but supplied culture key [" ..
          tostring(culture_key) .. "] is not a string");
          return false;
     end;

     local faction_list = cm:model():world():faction_list();

     for i = 0, faction_list:num_items() - 1 do
          local faction = faction_list:item_at(i);

          if faction:culture() == culture_key then
               if self:faction_is_alive(faction) then
                    return true;
               end;
          end;
     end;

     return false;
end;

--- @function faction_of_subculture_is_alive
--- @desc Returns true if any faction with a subculture corresponding to the supplied key is alive (uses @campaign_manager:faction_is_alive).
--- @p string subculture key
--- @return boolean any faction is alive
function campaign_manager:faction_of_subculture_is_alive(subculture_key)
     if not is_string(subculture_key) then
          script_error("ERROR: faction_of_subculture_is_alive() called but supplied subculture key [" ..
          tostring(subculture_key) .. "] is not a string");
          return false;
     end;

     local faction_list = cm:model():world():faction_list();

     for i = 0, faction_list:num_items() - 1 do
          local faction = faction_list:item_at(i);

          if faction:subculture() == subculture_key then
               if self:faction_is_alive(faction) then
                    return true;
               end;
          end;
     end;

     return false;
end;

--- @function faction_has_armies_in_enemy_territory
--- @desc Returns <code>true</code> if the supplied faction has any armies in the territory of factions it's at war with, <code>false</code> otherwise.
--- @p faction faction
--- @return boolean has armies in enemy territory
function campaign_manager:faction_has_armies_in_enemy_territory(faction)
     if not is_faction(faction) then
          script_error("ERROR: faction_has_armies_in_enemy_territory() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local mf_list = faction:military_force_list();

     for i = 0, mf_list:num_items() - 1 do
          local current_mf = mf_list:item_at(i);
          if current_mf:has_general() and not current_mf:is_armed_citizenry() then
               local character = current_mf:general_character();
               if character:has_region() then
                    local region = character:region();
                    if not region:is_abandoned() then
                         local owning_faction = region:owning_faction();
                         if not owning_faction:is_null_interface() and owning_faction:at_war_with(faction) then
                              return character;
                         end;
                    end;
               end;
          end;
     end;

     return false;
end;

--- @function faction_has_armies_in_region
--- @desc Returns <code>true</code> if the supplied faction has any armies in the supplied region, <code>false</code> otherwise.
--- @p faction faction
--- @p region region
--- @return boolean armies in region
function campaign_manager:faction_has_armies_in_region(faction, region)
     local mf_list = faction:military_force_list();

     for i = 0, mf_list:num_items() - 1 do
          local current_mf = mf_list:item_at(i);
          if current_mf:has_general() and not current_mf:is_armed_citizenry() then
               local character = current_mf:general_character();
               if character:has_region() and character:region() == region then
                    return character;
               end;
          end;
     end;

     return false;
end;

--- @function faction_has_nap_with_faction
--- @desc Returns <code>true</code> if the supplied faction has any armies in the supplied region, <code>false</code> otherwise.
--- @p faction faction
--- @p region region
--- @return boolean armies in region
function campaign_manager:faction_has_nap_with_faction(faction_a, faction_b)
     if not is_faction(faction_a) then
          script_error("ERROR: faction_has_nap_with_faction() called but first supplied faction [" ..
          tostring(faction_a) .. "] is not a faction object");
          return false;
     end;

     if not is_faction(faction_b) then
          script_error("ERROR: faction_has_nap_with_faction() called but second supplied faction [" ..
          tostring(faction_b) .. "] is not a faction object");
          return false;
     end;

     local nap_list = faction_a:factions_non_aggression_pact_with();
     for i = 0, nap_list:num_items() - 1 do
          if nap_list:item_at(i) == faction_b then
               return true;
          end;
     end;
     return false;
end;

--- @function faction_has_trade_agreement_with_faction
--- @desc Returns <code>true</code> if the supplied faction has any armies in the supplied region, <code>false</code> otherwise.
--- @p faction faction
--- @p region region
--- @return boolean armies in region
function campaign_manager:faction_has_trade_agreement_with_faction(faction_a, faction_b)
     if not is_faction(faction_a) then
          script_error("ERROR: faction_has_trade_agreement_with_faction() called but first supplied faction [" ..
          tostring(faction_a) .. "] is not a faction object");
          return false;
     end;

     if not is_faction(faction_b) then
          script_error("ERROR: faction_has_trade_agreement_with_faction() called but second supplied faction [" ..
          tostring(faction_b) .. "] is not a faction object");
          return false;
     end;

     local trade_list = faction_a:factions_trading_with();
     for i = 0, trade_list:num_items() - 1 do
          if trade_list:item_at(i) == faction_b then
               return true;
          end;
     end;
     return false;
end;

--- @function num_regions_controlled_in_province_by_faction
--- @desc Returns the number of regions controlled by a specified faction in a supplied province.
--- @p @province province, Province to query.
--- @p @faction faction, Faction to query.
--- @return @number number of controlled regions
--- @return @number total number of regions
function campaign_manager:num_regions_controlled_in_province_by_faction(province, faction)
     local count = 0;
     local region_list = province:regions();

     for i = 0, region_list:num_items() - 1 do
          if region_list:item_at(i):owning_faction() == faction then
               count = count + 1;
          end;
     end;

     return count, region_list:num_items();
end;

--- @function num_provinces_controlled_by_faction
--- @desc Returns the number of complete provinces controlled by the specified faction, as well as the number of provinces in which the faction owns territory and is only one settlement away from complete control.
--- @p @faction faction, Faction to query.
--- @return @number number of provinces controlled
--- @return @number number of provinces almost controlled (one settlement away from completion)
function campaign_manager:num_provinces_controlled_by_faction(faction)
     if not is_faction(faction) then
          script_error("ERROR: num_provinces_controlled_by_faction() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local region_list = faction:region_list();
     local checked_provinces = {};
     local num_controlled_provinces = 0;
     local num_almost_controlled_provinces = 0;

     for i = 0, region_list:num_items() - 1 do
          local current_region = region_list:item_at(i);
          local current_region_province_name = current_region:province_name();

          -- check this province if it's not already been checked
          if not checked_provinces[current_region_province_name] then
               checked_provinces[current_region_province_name] = true;

               local num_regions_controlled_by_faction, num_regions_in_province = self
               :num_regions_controlled_in_province_by_faction(current_region:province(), faction);

               if num_regions_controlled_by_faction == num_regions_in_province then
                    num_controlled_provinces = num_controlled_provinces + 1;
               elseif num_regions_controlled_by_faction + 1 == num_regions_in_province then
                    num_almost_controlled_provinces = num_almost_controlled_provinces + 1;
               end;
          end;
     end;

     return num_controlled_provinces, num_almost_controlled_provinces;
end;

--- @function faction_contains_agents
--- @desc Returns <code>true</code> if the supplied faction has any agents in its character list, or <code>false</code> otherwise. The function may also be instructed to return a table of all agents in the faction, either by their character interfaces or their command-queue indexes.
--- @p @faction faction, Subject faction.
--- @p [opt=false] @boolean return list, Instructs the function to also return a @table of either their character interfaces or cqi's (which of these to use is set by the third parameter to this function).
--- @p [opt=false] @boolean return by cqi, Instructs the function to return a list of cqis instead of a list of character interfaces. If characters are stored by cqi their character interfaces may later be looked up using @campaign_manager:get_character_by_cqi. Character interfaces are volatile and may not be stored over time. This argument is not used if the second argument is not set to <code>true</code>.
--- @return @boolean faction has agents
--- @return @table list of agents, by either cqi or character interface, or @nil if the second argument is not set to <code>true</code>.
function campaign_manager:faction_contains_agents(faction, return_list, return_by_cqi)
     if not is_faction(faction) then
          script_error("ERROR: faction_has_agents() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     local agent_list = {};

     local char_list = faction:character_list();
     for i = 0, char_list:num_items() - 1 do
          local current_char = char_list:item_at(i);
          if self:char_is_agent(current_char) then
               if return_list then
                    if return_by_cqi then
                         table.insert(agent_list, current_char:command_queue_index());
                    else
                         table.insert(agent_list, current_char);
                    end;
               else
                    return true;
               end;
          end;
     end;

     if return_list then
          return #agent_list > 0, agent_list;
     end;

     return false;
end;

--- @function faction_contains_character_of_subtype
--- @desc Returns <code>true</code> if the supplied faction contains any character of the supplied subtype, or <code>false</code> otherwise. If the return characters flag is set, then a table containing all matching characters is also returned.
--- @p faction faction
--- @p [opt=nil] @string character subtype, Character subtype key, from the <code>agent_subtypes</code> table.
--- @p [opt=false] @boolean return characters, Instructs the function to return a list containing all characters.
--- @return @boolean faction contains matching characters
--- @return @table list of matching character objects, if option is set
function campaign_manager:faction_contains_character_of_subtype(faction, subtype, should_return_characters)
     if not is_faction(faction) then
          script_error("ERROR: faction_contains_character_of_subtype() called but supplied faction [" ..
          tostring(faction) .. "] is not a faction object");
          return false;
     end;

     if subtype and not is_string(subtype) then
          script_error("ERROR: faction_contains_character_of_subtype() called but supplied character subtype key [" ..
          tostring(subtype) .. "] is not a string");
          return false;
     end;

     local character_list = faction:character_list();
     local char_list_to_return;

     if should_return_characters then
          char_list_to_return = {};
     end;

     for i = 0, character_list:num_items() - 1 do
          if character_list:item_at(i):character_subtype(subtype) then
               if should_return_characters then
                    table.insert(char_list_to_return, character_list:item_at(i));
               else
                    return true;
               end;
          end;
     end;

     return #char_list_to_return > 0, char_list_to_return;
end;

--- @function faction_set_free_instant_constructions
--- @desc Sets number of free instant constructions available to a faction
--- @p faction_key which faction we want to modify
--- @p free_instant_constructions new value for number of free instant constructions available to the supplied faction
--- @return @boolean whether the call was successful
function campaign_manager:faction_set_free_instant_constructions(faction_key, free_instant_constructions)
     if not is_string(faction_key) then
          script_error("ERROR: faction_set_free_instant_constructions() called but supplied faction_key [" ..
          tostring(faction_key) .. "] is not a string")
          return false
     end

     if not is_number(free_instant_constructions) then
          script_error(
          "ERROR: faction_set_free_instant_constructions() called but supplied free_instant_constructions [" ..
          tostring(free_instant_constructions) .. "] is not a number")
          return false
     end

     self.game_interface:faction_set_free_instant_constructions(faction_key, free_instant_constructions)
     return true
end

-----------------------------------------------------------------------------
--- @section Garrison Residence Queries
-----------------------------------------------------------------------------

-- This is not correct in the context of Pharaoh where there are ERS
--- @function garrison_contains_building
--- @desc Returns <code>true</code> if the supplied garrison residence contains a building with the supplied key, <code>false</code> otherwise.
--- @p garrison_residence garrison residence
--- @p string building key
--- @return boolean garrison contains building
function campaign_manager:garrison_contains_building(garrison, building_key)
     if not is_garrisonresidence(garrison) then
          script_error("ERROR: garrison_contains_building() called but supplied garrison residence [" ..
          tostring(garrison) .. "] is not a garrison residence object");
          return false;
     end;

     if not is_string(building_key) then
          script_error("ERROR: garrison_contains_building() called but supplied building key [" ..
          tostring(building_key) .. "] is not a string");
          return false;
     end;

     for i = 0, garrison:region():slot_list():num_items() - 1 do
          local slot = garrison:region():slot_list():item_at(i);

          if slot:has_building() and slot:building():name() == building_key then
               return true;
          end;
     end;

     return false;
end;

--- @function garrison_contains_building_chain
--- @desc Returns <code>true</code> if the supplied garrison residence contains a building with the supplied chain key, <code>false</code> otherwise.
--- @p garrison_residence garrison residence
--- @p string building chain key
--- @return boolean garrison contains building
function campaign_manager:garrison_contains_building_chain(garrison, chain_key)
     if not is_garrisonresidence(garrison) then
          script_error("ERROR: garrison_contains_building_chain() called but supplied garrison residence [" ..
          tostring(garrison) .. "] is not a garrison residence object");
          return false;
     end;

     if not is_string(chain_key) then
          script_error("ERROR: garrison_contains_building_chain() called but supplied building chain key [" ..
          tostring(chain_key) .. "] is not a string");
          return false;
     end;

     for i = 0, garrison:region():slot_list():num_items() - 1 do
          local slot = garrison:region():slot_list():item_at(i);

          if slot:has_building() and slot:building():chain() == chain_key then
               return true;
          end;
     end;

     return false;
end;

--- @function garrison_contains_building_superchain
--- @desc Returns <code>true</code> if the supplied garrison residence contains a building with the supplied superchain key, <code>false</code> otherwise.
--- @p garrison_residence garrison residence
--- @p string building superchain key
--- @return boolean garrison contains building
function campaign_manager:garrison_contains_building_superchain(garrison, superchain_key)
     if not is_garrisonresidence(garrison) then
          script_error("ERROR: garrison_contains_building_superchain() called but supplied garrison residence [" ..
          tostring(garrison) .. "] is not a garrison residence object");
          return false;
     end;

     if not is_string(superchain_key) then
          script_error("ERROR: garrison_contains_building_superchain() called but supplied building superchain key [" ..
          tostring(superchain_key) .. "] is not a string");
          return false;
     end;

     for i = 0, garrison:region():slot_list():num_items() - 1 do
          local slot = garrison:region():slot_list():item_at(i);

          if slot:has_building() and slot:building():superchain() == superchain_key then
               return true;
          end;
     end;

     return false;
end;

--- @function get_armed_citizenry_from_garrison
--- @desc Returns the garrison army from a garrison residence. By default this returns the land army armed citizenry - an optional flag instructs the function to return the naval armed citizenry instead.
--- @p garrison_residence garrison residence, Garrison residence.
--- @p [opt=false] boolean get naval, Returns the naval armed citizenry army, if set to <code>true</code>.
--- @return boolean armed citizenry army
function campaign_manager:get_armed_citizenry_from_garrison(garrison, naval_force_only)
     if not is_garrisonresidence(garrison) then
          script_error("ERROR: get_armed_citizenry_from_garrison() called but supplied garrison residence [" ..
          tostring(garrison) .. "] is not a garrison residence object");
          return false;
     end;

     -- return land force or naval force, depending on what the value of this flag is
     naval_force_only = not not naval_force_only;

     local mf_list = garrison:faction():military_force_list();

     for i = 0, mf_list:num_items() - 1 do
          local current_mf = mf_list:item_at(i);

          if current_mf:is_armed_citizenry() and current_mf:garrison_residence() == garrison then
               if naval_force_only then
                    if current_mf:is_navy() then
                         return current_mf;
                    end;
               else
                    if current_mf:is_army() then
                         return current_mf;
                    end;
               end;
          end;
     end;

     return false;
end;

-----------------------------------------------------------------------------
--- @section Military Force Queries and Modifications
-----------------------------------------------------------------------------


--- @function get_military_force_by_cqi
--- @desc Returns a military force by it's command queue index. If no military force with the supplied cqi is found then <code>false</code> is returned.
--- @p number cqi
--- @return military_force military force
function campaign_manager:get_military_force_by_cqi(cqi)
     if is_string(cqi) then
          cqi = tonumber(cqi);
     end;

     if not is_number(cqi) then
          script_error("get_military_force_by_cqi() called but supplied cqi [" ..
          tostring(cqi) .. "] is not a number or a string that converts to a number");
          return false;
     end;

     local model = self:model();
     if model:has_military_force_command_queue_index(cqi) then
          return model:military_force_for_command_queue_index(cqi);
     end;

     return false;
end;

--- @function get_strongest_military_force_from_faction
--- @desc Returns the strongest military force from the specified faction. Nil is returned if the faction contains no military forces.
--- @p @string faction key, Faction key, from the <code>factions</code> table.
--- @p [opt=false] @boolean include garrisons, Include garrision armies.
--- @return military_force strongest military force
function campaign_manager:get_strongest_military_force_from_faction(faction_key, include_garrison_armies)
     if not is_string(faction_key) then
          script_error("ERROR: get_strongest_military_force_from_faction() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return false;
     end;

     local faction = self:get_faction(faction_key);

     if not faction then
          script_error("ERROR: get_strongest_military_force_from_faction() called but no faction with supplied key [" ..
          faction_key .. "] could be found");
          return false;
     end;

     local military_force_list = faction:military_force_list();
     local highest_strength = 0;
     local strongest_military_force;

     for i = 0, military_force_list:num_items() - 1 do
          local current_mf = military_force_list:item_at(i);

          if include_garrison_armies or not current_mf:is_armed_citizenry() then
               local current_mf_strength = current_mf:strength();
               if current_mf_strength > highest_strength then
                    highest_strength = current_mf_strength;
                    strongest_military_force = current_mf;
               end;
          end;
     end;

     return strongest_military_force;
end;

--- @function military_force_average_strength
--- @desc Returns the average strength of all units in the military force. This is expressed as a percentage (0-100), so a returned value of 75 would indicate that the military force had lost 25% of its strength through casualties.
--- @p military_force military force
--- @return number average strength percentage
function campaign_manager:military_force_average_strength(military_force)
     if not is_militaryforce(military_force) then
          script_error("ERROR: military_force_average_strength() called but supplied military force [" ..
          tostring(military_force) .. "] is not a military force object");
          return false;
     end;

     local unit_list = military_force:unit_list();
     local num_units = unit_list:num_items();

     if num_units == 0 then
          return 0;
     end;

     local cumulative_health = 0;

     for i = 0, num_units - 1 do
          cumulative_health = cumulative_health + unit_list:item_at(i):percentage_proportion_of_full_strength();
     end;

     return (cumulative_health / num_units);
end;

--- @function num_mobile_forces_in_force_list
--- @desc Returns the number of military forces that are not armed-citizenry in the supplied military force list.
--- @p military_force_list military force list
--- @return number number of mobile forces
function campaign_manager:num_mobile_forces_in_force_list(military_force_list)
     if not is_militaryforcelist(military_force_list) then
          script_error("ERROR: num_mobile_forces_in_force_list() called but supplied military force list [" ..
          tostring(military_force_list) .. "] is not a military_force_list object");
          return false;
     end;

     local count = 0;

     for i = 0, military_force_list:num_items() - 1 do
          if not military_force_list:item_at(i):is_armed_citizenry() then
               count = count + 1;
          end;
     end;

     return count;
end;

--- @function proportion_of_unit_class_in_military_force
--- @desc Returns the unary proportion (0-1) of units in the supplied military force which are of the supplied unit class.
--- @p military_force military force
--- @p string unit class
--- @return proportion units of unit class
function campaign_manager:proportion_of_unit_class_in_military_force(military_force, unit_class)
     if not is_militaryforce(military_force) then
          script_error("ERROR: proportion_of_unit_class_in_military_force() called but supplied military force [" ..
          tostring(military_force) .. "] is not a military force object");
          return false;
     end;

     if not is_string(unit_class) then
          script_error("ERROR: proportion_of_unit_class_in_military_force() called but supplied unit class [" ..
          tostring(unit_class) .. "] is not a string");
          return false;
     end;

     local unit_list = military_force:unit_list();

     local num_items = unit_list:num_items();

     if num_items == 0 then
          return 0;
     end;

     local num_found = 0;
     for i = 0, num_items - 1 do
          if unit_list:item_at(i):unit_class() == unit_class then
               num_found = num_found + 1;
          end;
     end;

     return (num_found / num_items);
end;

--- @function military_force_contains_unit_type_from_list
--- @desc Returns <code>true</code> if the supplied military force contains any units of a type contained in the supplied unit type list, <code>false</code> otherwise.
--- @p military_force military force, Military force.
--- @p table unit type list, Unit type list. This must be supplied as a numerically indexed table of strings.
--- @return force contains unit from type list
function campaign_manager:military_force_contains_unit_type_from_list(military_force, unit_type_list)
     if not is_militaryforce(military_force) then
          script_error("ERROR: military_force_contains_unit_type_from_list() called but supplied military force [" ..
          tostring(military_force) .. "] is not a military force object");
          return false;
     end;

     if not is_table(unit_type_list) then
          script_error("ERROR: military_force_contains_unit_type_from_list() called but supplied  [" ..
          tostring(unit_type_list) .. "] is not a string");
          return false;
     end;

     for i = 0, military_force:unit_list():num_items() - 1 do
          local unit = military_force:unit_list():item_at(i);
          if table_contains(unit_type_list, unit:unit_key()) then
               return true;
          end;
     end;
     return false;
end;

--- @function military_force_contains_unit_class_from_list
--- @desc Returns <code>true</code> if the supplied military force contains any units of a class contained in the supplied unit class list, <code>false</code> otherwise.
--- @p military_force military force, Military force.
--- @p table unit class list, Unit class list. This must be supplied as a numerically indexed table of strings.
--- @return force contains unit from class list
function campaign_manager:military_force_contains_unit_class_from_list(military_force, unit_class_list)
     if not is_militaryforce(military_force) then
          script_error("ERROR: military_force_contains_unit_type_from_list() called but supplied military force [" ..
          tostring(military_force) .. "] is not a military force object");
          return false;
     end;

     if not is_table(unit_class_list) then
          script_error("ERROR: military_force_contains_unit_type_from_list() called but supplied  [" ..
          tostring(unit_class_list) .. "] is not a string");
          return false;
     end;

     for i = 0, military_force:unit_list():num_items() - 1 do
          if table_contains(unit_class_list, military_force:unit_list():item_at(i):unit_class()) then
               return true;
          end;
     end;
     return false;
end;

--- @function force_from_general_cqi
--- @desc Returns the force whose commanding general has the passed cqi. If no force is found then <code>false</code> is returned.
--- @p number general cqi
--- @return military force force
function campaign_manager:force_from_general_cqi(general_cqi)
     local general_obj = cm:model():character_for_command_queue_index(general_cqi);

     if general_obj:is_null_interface() == false then
          if general_obj:has_military_force() then
               return general_obj:military_force();
          end
     end
     return false;
end;

--- @function military_force_monetary_value
--- @desc Returns the monetary value of all of the units in the force. This would be the cost of this force in a custom battle.
--- @p @number military force cqi
--- @r @number value
function campaign_manager:military_force_monetary_value(force_cqi)
     local force_obj = cm:model():military_force_for_command_queue_index(force_cqi);
     local force_value = 0;

     if force_obj:is_null_interface() == false then
          local unit_list = force_obj:unit_list();

          for i = 0, unit_list:num_items() - 1 do
               local unit = unit_list:item_at(i);

               if unit:is_null_interface() == false then
                    force_value = force_value +
                    (unit:get_unit_custom_battle_cost() * unit:percentage_proportion_of_full_strength() * 0.01);
               end
          end
     end
     return force_value;
end

--- @function disallow_army_occupation_decision
--- @desc Disallows the army from performing one or more specific occupation decisions.
--- @p @number force cqi, Command-queue index value of subject military force.
--- @p @string occupation decision, Occupation decision or decisions. This can be a single string, or a @table of string occupation decisions.
function campaign_manager:disallow_army_occupation_decision(force_cqi, occupation_decision)
     if not is_number(force_cqi) then
          script_error("ERROR: disallow_army_occupation_decision() called but supplied force_cqi number [" ..
          tostring(force_cqi) .. "] is not a number");
          return false
     end

     if is_string(occupation_decision) then
          self.game_interface:disallow_army_occupation_decision(force_cqi, occupation_decision);
          return
     end

     if is_table(occupation_decision) then
          for _, occ_dec in ipairs(occupation_decision) do
               if not is_string(occ_dec) then
                    script_error(
                    "ERROR: disallow_army_occupation_decision() called but supplied occupation_decision array [" ..
                    tostring(occupation_decision) .. "] has an item that is not a string");
                    return false
               end
          end

          for _, occ_dec in ipairs(occupation_decision) do
               self.game_interface:disallow_army_occupation_decision(force_cqi, occ_dec);
          end

          return
     end

     script_error("ERROR: disallow_army_occupation_decision() called but supplied occupation_decision string or array [" ..
     tostring(occupation_decision) .. "] is neither a string nor a number");
     return false
end

-----------------------------------------------------------------------------
--- @section Region and Province Queries & Modification
-----------------------------------------------------------------------------


--- @function get_region
--- @desc Returns a region object with the supplied region name. If no such region is found then <code>false</code> is returned.
--- @p string region name
--- @return region region
function campaign_manager:get_region(region_name)
     if not is_string(region_name) then
          script_error("ERROR: get_region() called but supplied region name [" ..
          tostring(region_name) .. "] is not a string");
          return false;
     end;

     local region = self:model():world():region_manager():region_by_key(region_name);

     if is_region(region) then
          return region;
     end;

     return false;
end;

--- @function get_province
--- @desc Returns a province object with the supplied province name. If no such province is found then <code>false</code> is returned.
--- @p string province name
--- @return province province
function campaign_manager:get_province(province_name)
     if not is_string(province_name) then
          script_error("ERROR: get_province() called but supplied province name [" ..
          tostring(province_name) .. "] is not a string");
          return false;
     end;

     local province = self:model():world():province_manager():province_for_province_key(province_name);

     if is_province(province) then
          return province;
     end;

     return false;
end;

--- @function is_region_owned_by_faction
--- @desc Returns a region object with the supplied region name. If no such region is found then <code>false</code> is returned.
--- @p string region name
--- @p string faction name
--- @return region region
function campaign_manager:is_region_owned_by_faction(region_name, faction_name)
     if not is_string(region_name) then
          script_error("ERROR: is_region_owned_by_faction() called but supplied region name [" ..
          tostring(region_name) .. "] is not a string");
          return false;
     end;

     if not is_string(faction_name) then
          script_error("ERROR: is_region_owned_by_faction() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     local region = self:model():world():region_manager():region_by_key(region_name);

     if not is_region(region) then
          script_error("ERROR: is_region_owned_by_faction() called but couldn't find a region with supplied name [" ..
          tostring(region_name) .. "]");
          return false;
     end;

     return (region:owning_faction():name() == faction_name);
end;

--- @function region_has_neighbours_of_other_religion
--- @desc Returns <code>true</code> if a specified region has any neighbouring regions with a different religion, <code>false</code> otherwise.
--- @p region subject region
--- @return boolean region has neighbour of different religion
function campaign_manager:region_has_neighbours_of_other_religion(region)
     if not is_region(region) then
          script_error("ERROR: region_has_neighbours_of_other_religion() called but supplied region [" ..
          tostring(region) .. "] is not a region object");
          return false;
     end;

     local majority_religion = region:majority_religion();

     for i = 0, region:adjacent_region_list():num_items() - 1 do
          if majority_religion ~= region:adjacent_region_list():item_at(i):majority_religion() then
               return true;
          end;
     end;

     return false;
end;

--- @function instantly_upgrade_building_in_region_slot
--- @desc Instantly upgrades the building in the supplied slot to the supplied building key.
--- @p @slot slot
--- @p @string target building key
function campaign_manager:instantly_upgrade_building_in_region_slot(slot, target_building_key)
     if not is_string(target_building_key) then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string");
          return false;
     end;

     self.game_interface:region_slot_instantly_upgrade_building(slot, target_building_key);
end;

--- @function instantly_upgrade_building_in_region
--- @desc Instantly upgrades the building in the supplied slot number of the supplied region to the supplied building key.
--- @p string region key
--- @p number slot number
--- @p string target building key
function campaign_manager:instantly_upgrade_building_in_region(region_key, slot_num, target_building_key)
     if not is_string(region_key) then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(slot_num) then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number");
          return false;
     end;

     if not is_string(target_building_key) then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string");
          return false;
     end;

     local region = cm:get_region(region_key)

     if not region then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region");
          return false;
     end

     local slot_list = region:slot_list()

     if slot_num > slot_list:num_items() then
          script_error("ERROR: instantly_upgrade_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has");
          return false;
     end

     local slot = slot_list:item_at(slot_num - 1)

     self.game_interface:region_slot_instantly_upgrade_building(slot, target_building_key);
end;

--- @function instantly_build_building_in_region
--- @desc Instantly builds the building in the supplied slot number of the supplied region to the supplied building key.
--- @p string region key
--- @p number slot number
--- @p string target building key
--- @p [opt=false] boolean ignore_costs, whether to ignore the costs and build for free, or expend the resources and dev points
function campaign_manager:instantly_build_building_in_region(region_key, slot_num, target_building_key, ignore_costs)
     if not is_string(region_key) then
          script_error("ERROR: instantly_build_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     if not is_number(slot_num) then
          script_error("ERROR: instantly_build_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number")
          return false
     end

     if not is_string(target_building_key) then
          script_error("ERROR: instantly_build_building_in_region() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string")
          return false
     end

     ignore_costs = not not ignore_costs

     self.game_interface:instantly_build_building(region_key .. ":" .. tostring(slot_num), target_building_key,
          ignore_costs)
     return true
end

--- @function instantly_downgrade_building_in_region
--- @desc Instantly downgrades the building in the supplied slot number of the supplied region.
--- @p string region key
--- @p number slot number
--- @p [opt=false] boolean recoup_costs
--- @p [opt=false] boolean silent
function campaign_manager:instantly_downgrade_building_in_region(region_key, slot_num, recoup_costs, silent)
     if not is_string(region_key) then
          script_error("ERROR: instantly_downgrade_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     if not is_number(slot_num) then
          script_error("ERROR: instantly_downgrade_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number")
          return false
     end

     recoup_costs = recoup_costs and true or false
     silent = silent and true or false

     self.game_interface:instantly_downgrade_building(region_key .. ":" .. tostring(slot_num), recoup_costs, silent)
     return true
end

--- @function queue_building_construction_in_region
--- @desc Builds the building in the supplied slot number of the supplied region to the supplied building key. It automatically substracts the building cost or convertion cost for that building. Will expend conversion cost rather than building cost if conversion is possible. Turns to complete will override the construction time, use 0 for instant construction.
--- @p string region key
--- @p number slot number
--- @p string target building key
--- @p [opt=-1] number turns_to_complete, override the number of turns to complete the building, 0 - for instant completion, -1 - do not override
--- @p [opt=false] boolean ignore_costs, whether to ignore the costs and build for free, or expend the resources and dev points
function campaign_manager:queue_building_construction_in_region(region_key, slot_num, target_building_key,
                                                                turns_to_complete, ignore_costs)
     if turns_to_complete == nil then
          turns_to_complete = -1
     end

     if ignore_costs == nil then
          ignore_costs = false
     end

     if not is_string(region_key) then
          script_error("ERROR: queue_building_construction_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(slot_num) then
          script_error("ERROR: queue_building_construction_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number");
          return false;
     end;

     if not is_string(target_building_key) then
          script_error("ERROR: queue_building_construction_in_region() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string");
          return false;
     end;

     if not is_number(turns_to_complete) then
          script_error("ERROR: queue_building_construction_in_region() called but supplied turns_to_complete [" ..
          tostring(turns_to_complete) .. "] is not a number");
          return false
     end

     if not is_boolean(ignore_costs) then
          script_error("ERROR: queue_building_construction_in_region() called but supplied ignore_costs [" ..
          tostring(ignore_costs) .. "] is not a boolean");
          return false
     end

     local region = cm:get_region(region_key)

     if not region then
          script_error("ERROR: queue_building_construction_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region");
          return false;
     end

     local slot_list = region:slot_list()

     if slot_num > slot_list:num_items() then
          script_error("ERROR: queue_building_construction_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has");
          return false;
     end

     self.game_interface:queue_building_construction(region:name() .. ":" .. tostring(slot_num - 1), target_building_key,
          turns_to_complete, ignore_costs);
end;

--- @function queue_building_construction_in_force
--- @desc Builds the supplied building key in the supplied slot index number in the supplied military force. It automatically substracts the building cost or convertion cost for that building. Will expend conversion cost rather than building cost if conversion is possible. Turns to complete will override the construction time, use 0 for instant construction.
--- @p string force_cqi, military force command queue index
--- @p number slot_index, military force slot index
--- @p string target_building_key, the building key to queue construction
--- @p [opt=-1] number turns_to_complete, override the number of turns to complete the building, 0 - for instant completion, -1 - do not override
--- @p [opt=false] boolean ignore_costs, whether to ignore the costs and build for free, or expend the resources and dev points
function campaign_manager:queue_building_construction_in_force(force_cqi, slot_index, target_building_key,
                                                               turns_to_complete, ignore_costs)
     if turns_to_complete == nil then
          turns_to_complete = -1
     end

     if ignore_costs == nil then
          ignore_costs = false
     end

     if not is_number(force_cqi) then
          script_error("ERROR: queue_building_construction_in_force() called but supplied military force cqi [" ..
          tostring(force_cqi) .. "] is not a number")
          return false
     end

     if not is_number(slot_index) then
          script_error("ERROR: queue_building_construction_in_force() called but supplied slot number [" ..
          tostring(slot_index) .. "] is not a number")
          return false
     end

     if not is_string(target_building_key) then
          script_error("ERROR: queue_building_construction_in_force() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string")
          return false
     end

     if not is_number(turns_to_complete) then
          script_error("ERROR: queue_building_construction_in_force() called but supplied turns_to_complete [" ..
          tostring(turns_to_complete) .. "] is not a number")
          return false
     end

     if not is_boolean(ignore_costs) then
          script_error("ERROR: queue_building_construction_in_force() called but supplied ignore_costs [" ..
          tostring(ignore_costs) .. "] is not a boolean")
          return false
     end

     local force = cm:get_military_force_by_cqi(force_cqi)
     if not force then
          script_error("ERROR: queue_building_construction_in_force() called but supplied military force cqi [" ..
          tostring(force_cqi) .. "] does not correspond to a military force")
          return false
     end

     local force_slots = force:buildings()
     if slot_index > force_slots:num_items() then
          script_error("ERROR: queue_building_construction_in_force() called but supplied slot index [" ..
          tostring(slot_index) .. "] is larger than the amount of slots the force has.")
          return false
     end

     self.game_interface:queue_military_force_building_construction(force_cqi, slot_index - 1, target_building_key,
          turns_to_complete, ignore_costs)
end;

--- @function queue_building_dismantle
--- @desc Queues the building in the supplied slot number of the supplied region for dismantling.
--- @p string region key
--- @p number slot number
function campaign_manager:queue_building_dismantle(region_key, slot_num)
     if not is_string(region_key) then
          script_error("ERROR: queue_building_dismantle() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(slot_num) then
          script_error("ERROR: queue_building_dismantle() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number");
          return false;
     end;

     local region = cm:get_region(region_key)

     if not region then
          script_error("ERROR: queue_building_dismantle() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region")
          return false;
     end

     local slot_list = region:slot_list()

     if slot_num > slot_list:num_items() then
          script_error("ERROR: queue_building_dismantle() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has")
          return false;
     end

     local slot = slot_list:item_at(slot_num - 1)

     self.game_interface:queue_building_dismantle(region:name() .. ":" .. tostring(slot_num - 1))
end

--- @function queue_building_repair
--- @desc Queues the building in the supplied slot number of the supplied region for repair.
--- @p string region key
--- @p number slot number
--- @p [opt=false] boolean ignore_cost, whether to ignore the cost and repair for free, or expend the resources and dev points
function campaign_manager:queue_building_repair(region_key, slot_num, ignore_cost)
     if ignore_cost == nil then
          ignore_cost = false
     end

     if not is_string(region_key) then
          script_error("ERROR: queue_building_repair() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     if not is_number(slot_num) then
          script_error("ERROR: queue_building_repair() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number")
          return false
     end

     if not is_boolean(ignore_cost) then
          script_error("ERROR: queue_building_repair() called but supplied ignore_cost [" ..
          tostring(ignore_cost) .. "] is not a boolean")
          return false
     end

     local region = cm:get_region(region_key)

     if not region then
          script_error("ERROR: queue_building_repair() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region")
          return false
     end

     local slot_list = region:slot_list()

     if slot_num > slot_list:num_items() then
          script_error("ERROR: queue_building_repair() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has")
          return false
     end

     local slot = slot_list:item_at(slot_num - 1)

     self.game_interface:queue_building_repair(region:name() .. ":" .. tostring(slot_num - 1), ignore_cost)
end

--- @function get_building_create_time
--- @desc Get the creation time for a building by a building level record key.
--- @p @string building level key, Building level record key, from the <code>building_levels</code> database table.
--- @r @number creation time in turns
function campaign_manager:get_building_create_time(building_level_record_key)
     if not is_string(building_level_record_key) then
          script_error("ERROR: get_building_create_time() called but supplied building level record key [" ..
          tostring(building_level_record_key) .. "] is not a string")
          return false
     end

     return self.game_interface:get_building_create_time(building_level_record_key)
end

--- @function instantly_dismantle_building_in_region_slot
--- @desc Instantly dismantles the building in the supplied region slot
--- @p @slot slot
function campaign_manager:instantly_dismantle_building_in_region_slot(slot)
     self.game_interface:region_slot_instantly_dismantle_building(slot);
end;

--- @function instantly_dismantle_building_in_region
--- @desc Instantly dismantles the building in the supplied slot number of the supplied region.
--- @p string region key
--- @p number slot number
--- @p [opt=true] boolean recoup_resources, whether to recoup the resources for the dismantled building
--- @p [opt=false] boolean silent, whether to suppress the firing of an event feed event for the dismantled building
function campaign_manager:instantly_dismantle_building_in_region(region_key, slot_num, recoup_resources, silent)
     if recoup_resources == nil then
          recoup_resources = true
     end

     silent = not not silent

     if not is_string(region_key) then
          script_error("ERROR: instantly_dismantle_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(slot_num) then
          script_error("ERROR: instantly_dismantle_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number");
          return false;
     end;

     local region = cm:get_region(region_key)

     if not region then
          script_error("ERROR: instantly_dismantle_building_in_region() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region");
          return false;
     end

     local slot_list = region:slot_list()

     if slot_num > slot_list:num_items() then
          script_error("ERROR: instantly_dismantle_building_in_region() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has");
          return false;
     end

     local slot = slot_list:item_at(slot_num - 1)

     self.game_interface:region_slot_instantly_dismantle_building(slot, recoup_resources, silent);
end;

--- @function get_most_pious_region_for_faction_for_religion
--- @desc Returns the region held by a specified faction that has the highest proportion of a specified religion. The numeric religion proportion is also returned.
--- @p faction subject faction
--- @p string religion key
--- @return region most pious region
--- @return number religion proportion
function campaign_manager:get_most_pious_region_for_faction_for_religion(faction, religion_key)
     local region_list = faction:region_list();

     local highest_religion_region = false;
     local highest_religion_amount = 0;

     for i = 0, region_list:num_items() - 1 do
          local current_region = region_list:item_at(i);
          local current_region_religion_amount = current_region:religion_proportion(religion_key);

          if current_region_religion_amount > highest_religion_amount then
               highest_religion_region = current_region;
               highest_religion_amount = current_region_religion_amount;
          end;
     end;

     return highest_religion_region, highest_religion_amount;
end;

--- @function create_storm_for_region
--- @desc Creates a storm of a given type in a given region. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output.
--- @p string region key
--- @p number storm strength
--- @p number duration
--- @p string storm type
function campaign_manager:create_storm_for_region(region_key, strength, duration, storm_type)
     if not is_string(region_key) then
          script_error("ERROR: create_storm_for_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(strength) or strength < 1 then
          script_error("ERROR: create_storm_for_region() called but supplied strength value [" ..
          tostring(strength) .. "] is not a number greater than zero");
          return false;
     end;

     if not is_number(duration) or duration < 0 then
          script_error("ERROR: create_storm_for_region() called but supplied duration value [" ..
          tostring(duration) .. "] is not a positive number");
          return false;
     end;

     if not is_string(storm_type) then
          script_error("ERROR: create_storm_for_region() called but supplied storm_type string [" ..
          tostring(storm_type) .. "] is not a string");
          return false;
     end;

     out("* create_storm_for_region() called, creating storm type [" ..
     storm_type .. "] in region [" .. region_key .. "]");

     self.game_interface:create_storm_for_region(region_key, strength, duration, storm_type);
end;

--- @function get_province_capital_for_region
--- @desc Returns the region designated as the province capital, for the supplied region's province.
--- @p region region
--- @return region province capital region
function campaign_manager:get_province_capital_for_region(region)
     if region:is_province_capital() then
          return region;
     end;

     local region_list = region:province():regions();

     for i = 0, region_list:num_items() - 1 do
          if region_list:item_at(i):is_province_capital() then
               return region_list:item_at(i);
          end;
     end;
end;

--- @function region_contains_building
--- @desc Returns <code>true</code> if the supplied region contains a building with the supplied key, <code>false</code> otherwise.
--- @p region region
--- @p string building key
--- @return boolean region contains building
function campaign_manager:region_contains_building(region, building_key)
     if not is_region(region) then
          script_error("ERROR: region_contains_building() called but supplied region [" ..
          tostring(region) .. "] is not a region object")
          return false
     end

     if not is_string(building_key) then
          script_error("ERROR: region_contains_building() called but supplied building key [" ..
          tostring(building_key) .. "] is not a string")
          return false
     end

     for i = 0, region:slot_list():num_items() - 1 do
          local slot = region:slot_list():item_at(i)

          if slot:has_building() and slot:building():name() == building_key then
               return true
          end
     end

     return false
end

-----------------------------------------------------------------------------
--- @section Settlement Queries
-----------------------------------------------------------------------------


--	returns display or logical position of a settlement - for internal use, call
--	settlement_display_pos() or settlement_logical_pos() externally
function campaign_manager:settlement_pos(settlement_name, display)
     if not is_string(settlement_name) then
          script_error("ERROR: settlement_pos() called but supplied name [" ..
          tostring(settlement_name) .. "] is not a string");
          return false;
     end;

     local settlement = self:model():world():region_manager():settlement_by_key(settlement_name);

     if not settlement then
          script_error("ERROR: settlement_pos() called but no settlement found with supplied name [" ..
          settlement_name .. "]");
          return false;
     end;

     if display then
          return settlement:display_position_x(), settlement:display_position_y();
     else
          return settlement:logical_position_x(), settlement:logical_position_y();
     end;
end;

--- @function settlement_display_pos
--- @desc Returns the display position of a supplied settlement by string name.
--- @p string settlement name
--- @return number x display position
--- @return number y display position
function campaign_manager:settlement_display_pos(settlement_name)
     return self:settlement_pos(settlement_name, true);
end;

--- @function settlement_logical_pos
--- @desc Returns the logical position of a supplied settlement by string name.
--- @p string settlement name
--- @return number x logical position
--- @return number y logical position
function campaign_manager:settlement_logical_pos(settlement_name)
     return self:settlement_pos(settlement_name, false);
end;

-----------------------------------------------------------------------------
--- @section Pending Battle Cache
--- @desc Using the standard <a href="../../scripting_doc.html">game interface</a> it can be difficult to get information about a battle after it has been fought. The only method of querying the forces that fought in a battle is through the character interface (of the respective army commanders), and if they died in battle this will no longer be available.
--- @desc The pending battle cache system stores information about a battle prior to it being fought, which can be queried after the battle. This allows the factions, characters, and military forces involved to be queried even if they died in the battle. The information will remain available for querying until the next battle occurs.
--- @desc The data in the cache may also be queried prior to battle. The script triggers a <code>ScriptEventPendingBattle</code> event after a <code>PendingBattle</code> event is received and the pending battle cache has been populated. Scripts that want to query the pending battle cache prior to battle can listen for this.
-----------------------------------------------------------------------------


-- called internally
function campaign_manager:start_pending_battle_cache()
     -- campaign_manager:start_processing_battle_listeners() now calls self:cache_pending_battle() directly
     --[[
	core:add_listener(
		"pending_battle_cache",
		"ScriptEventCachePendingBattle",
		true,
		function() self:cache_pending_battle() end,
		true
	);
	]]

     -- In multiplayer we rebuild the pending battle cache immediately prior to the battle being fought, as human players can decline to enter as reinforcements.
     -- We do this on the first tick as the call to self:is_multiplayer() will fail before then, as the model is not ready.
     self:add_first_tick_callback(
          function()
               if self:is_multiplayer() then
                    core:add_listener(
                         "pending_battle_cache",
                         "BattleBeingFought",
                         true,
                         function() self:cache_pending_battle() end,
                         true
                    );
               end;
          end
     );

     -- Need to test for a pending battle on loading, as the above event "PendingBattle" isn't fired when loading into pre-battle screen.
     -- If player has closed and opened game, svr values won't be saved.
     core:add_listener(
          "LoadingScreenDismissedTestForPendingBattle",
          "LoadingScreenDismissed",
          true,
          function()
               local battle_active, battle_already_fought = self:is_pending_battle_active()

               if battle_active and not battle_already_fought then
                    self:cache_pending_battle()
               end
          end,
          false
     )
end;

-- caches a pending battle character within a pending battle
function campaign_manager:cache_pending_battle_character(list, character)
     local record = {};

     record.cqi = character:command_queue_index();
     record.fm_cqi = character:family_member():command_queue_index();
     record.faction_name = character:faction():name();
     record.units = {};

     if character:has_military_force() then
          local mf = character:military_force();
          local unit_list = mf:unit_list();

          record.mf_cqi = mf:command_queue_index();

          for i = 0, unit_list:num_items() - 1 do
               local unit = unit_list:item_at(i);
               local unit_record = {};
               unit_record.unit_cqi = unit:command_queue_index();
               unit_record.unit_key = unit:unit_key();
               table.insert(record.units, unit_record);
          end;
     else
          script_error("WARNING: cache_pending_battle_character() called but supplied character (cqi: [" ..
          character:command_queue_index() ..
          "], faction name: [" ..
          character:faction():name() .. "]) has no military force, how can this be? Not going to add CQI.");
          return;
     end;

     table.insert(list, record);
end;

-- caches a pending battle
function campaign_manager:cache_pending_battle(context)
     local pb = cm:model():pending_battle();

     local attackers = {};
     local defenders = {};

     -- Monetary value
     local attacker_value = 0;
     local defender_value = 0;

     -- Metric of combat strength
     local attacker_strength = 0;
     local defender_strength = 0;

     local attacker_num_units = 0;
     local defender_num_units = 0;

     local is_quest_battle = false;

     local any_attacker_is_human = false;
     local any_defender_is_human = false;


     -- Cache attackers

     -- primary
     if pb:has_attacker() then
          local attacker = pb:attacker();
          self:cache_pending_battle_character(attackers, attacker);
          if attacker:has_military_force() then
               local mf = attacker:military_force();
               attacker_value = attacker_value + self:military_force_monetary_value(mf:command_queue_index());
               attacker_strength = attacker_strength + mf:strength();
               attacker_num_units = attacker_num_units + mf:unit_list():num_items();
          end;

          local faction = attacker:faction();

          if not is_quest_battle and faction:is_quest_battle_faction() then
               is_quest_battle = true;
          end;

          if faction:is_human() then
               any_attacker_is_human = true;
          end;
     end;

     -- secondary
     local secondary_attacker_list = pb:secondary_attackers();
     for i = 0, secondary_attacker_list:num_items() - 1 do
          local attacker = secondary_attacker_list:item_at(i);
          self:cache_pending_battle_character(attackers, attacker);

          -- Night battles prevent reinforcements so don't add secondary forces to cumulative totals
          if pb:attacker():has_military_force() and pb:night_battle() == false then
               attacker_value = attacker_value +
               self:military_force_monetary_value(attacker:military_force():command_queue_index());
               attacker_strength = attacker_strength + attacker:military_force():strength();
               attacker_num_units = attacker_num_units + attacker:military_force():unit_list():num_items();
          end;

          local faction = attacker:faction();

          if not is_quest_battle and faction:is_quest_battle_faction() then
               is_quest_battle = true;
          end;

          if not any_attacker_is_human and faction:is_human() then
               any_attacker_is_human = true;
          end;
     end;

     -- Cache defenders

     -- primary
     if pb:has_defender() then
          local defender = pb:defender();
          self:cache_pending_battle_character(defenders, defender);
          defender_value = defender_value +
          self:military_force_monetary_value(defender:military_force():command_queue_index());
          defender_strength = defender_strength + defender:military_force():strength()
          defender_num_units = defender_num_units + defender:military_force():unit_list():num_items();

          local faction = defender:faction();

          if not is_quest_battle and faction:is_quest_battle_faction() then
               is_quest_battle = true;
          end;

          if faction:is_human() then
               any_defender_is_human = true;
          end;
     end;

     -- secondary
     local secondary_defenders_list = pb:secondary_defenders();
     for i = 0, secondary_defenders_list:num_items() - 1 do
          local defender = secondary_defenders_list:item_at(i);
          self:cache_pending_battle_character(defenders, secondary_defenders_list:item_at(i));

          -- Night battles prevent reinforcements so don't add secondary forces to cumulative totals
          if pb:night_battle() == false then
               defender_value = defender_value +
               self:military_force_monetary_value(defender:military_force():command_queue_index());
               defender_strength = defender_strength + defender:military_force():strength();
               defender_num_units = defender_num_units + defender:military_force():unit_list():num_items();
          end

          local faction = defender:faction();

          if not is_quest_battle and faction:is_quest_battle_faction() then
               is_quest_battle = true;
          end;

          if not any_defender_is_human and faction:is_human() then
               any_defender_is_human = true;
          end;
     end;

     if attacker_value < 1 then
          attacker_value = 1;
     end
     if defender_value < 1 then
          defender_value = 1;
     end

     -- Write the data cached in to this function in to the pbc_data table, which will be saved/loaded
     local pbc_data = self.pbc_data;

     local attacker_data = pbc_data.attacker_data;
     attacker_data.armies = attackers;
     attacker_data.value = attacker_value;
     attacker_data.strength = attacker_strength;
     attacker_data.num_units = attacker_num_units;
     attacker_data.any_human = any_attacker_is_human;

     local defender_data = pbc_data.defender_data;
     defender_data.armies = defenders;
     defender_data.value = defender_value;
     defender_data.strength = defender_strength;
     defender_data.num_units = defender_num_units;
     defender_data.any_human = any_defender_is_human;

     pbc_data.is_quest_battle = is_quest_battle;

     self:set_pending_battle_svr_state(pb);

     if not self:is_multiplayer() and self:is_local_players_turn() then
          self:print_pending_battle_cache(true);
     end;

     core:trigger_event("ScriptEventPendingBattle", pb);
end;

-- output for pending battle cache system - can be used for debugging, and it happens automatically when a PendingBattle event occurs on the player's turn
function campaign_manager:print_pending_battle_cache(from_pending_battle_event)
     local attackers = self.pbc_data.attacker_data.armies;
     local defenders = self.pbc_data.defender_data.armies;

     if not from_pending_battle_event then
          out("****");
     end;

     out("Printing pending battle cache...");
     out("Attackers:");
     for i = 1, #attackers do
          local current_record = attackers[i];
          out("\t" ..
          i ..
          " faction: [" ..
          current_record.faction_name ..
          "], char cqi: [" ..
          current_record.cqi .. "], fm cqi: [" .. current_record.fm_cqi .. "], mf cqi: [" .. current_record.mf_cqi .. "]");

          for j = 1, #current_record.units do
               local unit_record = current_record.units[j];
               out("\t\tunit " ..
               j .. " cqi: [" .. unit_record.unit_cqi .. "], type key: [" .. unit_record.unit_key .. "]");
          end;
     end;
     out("Defenders:");
     for i = 1, #defenders do
          local current_record = defenders[i];
          out("\t" ..
          i ..
          " faction: [" ..
          current_record.faction_name ..
          "], char cqi: [" .. current_record.cqi .. "], mf cqi: [" .. current_record.mf_cqi .. "]");

          for j = 1, #current_record.units do
               local unit_record = current_record.units[j];
               out("\t\tunit " ..
               j .. " cqi: [" .. unit_record.unit_cqi .. "], type key: [" .. unit_record.unit_key .. "]");
          end;
     end;
     out("****");
end;

function campaign_manager:pending_battle_cache_table_from_string(str)
     local list = {};

     local pointer = 1;
     while true do
          -- see if we have another record to read in
          local next_separator = string.find(str, ",", pointer);
          if not next_separator then
               -- no more records, exit
               break;
          end;

          -- construct the record we're about to read in
          local record = {};

          -- first read in the character cqi
          local cqi_str = string.sub(str, pointer, next_separator - 1);
          local cqi = tonumber(cqi_str);

          if not cqi then
               script_error("ERROR: pending_battle_cache_table_from_string() could not convert character cqi string [" ..
               tostring(cqi_str) .. "] into a number, inserting -1");
               cqi = -1;
          end;

          record.cqi = cqi;

          -- next, read in the military force cqi
          pointer = next_separator + 1;
          next_separator = string.find(str, ",", pointer);

          local mf_cqi_str = string.sub(str, pointer, next_separator - 1);
          local mf_cqi = tonumber(mf_cqi_str);

          if not mf_cqi then
               script_error(
               "ERROR: pending_battle_cache_table_from_string() could not convert military force cqi string [" ..
               tostring(mf_cqi_str) .. "] into a number, inserting -1");
               cqi = -1;
          end;

          -- string pending battle cache records won't contain family_member cqis, so just inject a dummy value
          record.fm_cqi = -1;

          record.mf_cqi = mf_cqi;

          -- next, read in the faction name
          pointer = next_separator + 1;
          next_separator = string.find(str, ",", pointer);

          if not next_separator then
               script_error(
               "ERROR: pending_battle_cache_table_from_string() could not find faction name, presuming this is an old savegame - not doing anything");
               return false;
          end;

          record.faction_name = string.sub(str, pointer, next_separator - 1);

          -- next, read in units
          pointer = next_separator + 1;
          next_separator = string.find(str, ";", pointer);

          local unit_list_str = string.sub(str, pointer, next_separator - 1);
          local unit_list_pointer = 1;
          local unit_list_next_separator = 1;
          local unit_records = {};

          while true do
               -- see if we have another unit to process
               unit_list_next_separator = string.find(unit_list_str, ",", unit_list_pointer);
               if not unit_list_next_separator then
                    break;
               end;

               -- create a unit record for this unit
               local current_unit_record = {};

               -- read in the unit cqi first
               current_unit_record.unit_cqi = tonumber(string.sub(unit_list_str, unit_list_pointer,
                    unit_list_next_separator - 1));
               if not is_number(current_unit_record.unit_cqi) then
                    script_error("ERROR: pending_battle_cache_table_from_string() could not convert unit cqi string [" ..
                    tostring(string.sub(unit_list_str, unit_list_pointer, unit_list_next_separator - 1)) ..
                    "] into a number, inserting -1");
                    current_unit_record.unit_cqi = -1;
               end;

               -- read in the unit key next
               unit_list_pointer = unit_list_next_separator + 1;
               unit_list_next_separator = string.find(unit_list_str, "$", unit_list_pointer);
               current_unit_record.unit_key = string.sub(unit_list_str, unit_list_pointer, unit_list_next_separator - 1);

               table.insert(unit_records, current_unit_record);

               unit_list_pointer = unit_list_next_separator + 1;
          end;

          record.units = unit_records;

          pointer = next_separator + 1;

          table.insert(list, record);
     end;

     return list;
end;

--- @function pending_battle_cache_num_attackers
--- @desc Returns the number of attacking armies in the cached pending battle.
--- @r @number number of attacking armies
function campaign_manager:pending_battle_cache_num_attackers()
     return #self.pbc_data.attacker_data.armies;
end;

--- @function pending_battle_cache_get_attacker
--- @desc Returns records relating to a particular attacker in the cached pending battle. The attacker is specified by numerical index, with the first being accessible at record 1. This function returns the cqi of the commanding character, the cqi of the related family member interface, the cqi of the military force, and the faction name.
--- @desc To get records of the units related to an attacker, use @campaign_manager:pending_battle_cache_num_attacker_units and @campaign_manager:pending_battle_cache_get_attacker_unit.
--- @p number index of attacker
--- @r @number character cqi
--- @r @number family member cqi
--- @r @number military force cqi
--- @r @string faction name
--- @new_example print attacker details
--- @example for i = 1, cm:pending_battle_cache_num_attackers() do
--- @example 	local char_cqi, fm_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_attacker(i);
--- @example 	out("Attacker " .. i .. " of faction " .. faction_name .. ":");
--- @example 	out("\tcharacter cqi: " .. char_cqi);
--- @example 	out("\tfamily_member cqi: " .. fm_cqi);
--- @example	out("\tmilitary force cqi: " .. mf_cqi);
--- @example end
function campaign_manager:pending_battle_cache_get_attacker(index)
     local pbc_attackers = self.pbc_data.attacker_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_attackers then
          script_error("ERROR: pending_battle_cache_get_attacker() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return pbc_attackers[index].cqi, pbc_attackers[index].fm_cqi, pbc_attackers[index].mf_cqi,
         pbc_attackers[index].faction_name;
end;

--- @function pending_battle_cache_get_attacker_faction_name
--- @desc Returns just the faction name of a particular attacker in the cached pending battle. The attacker is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of attacker
--- @r @string faction name
function campaign_manager:pending_battle_cache_get_attacker_faction_name(index)
     local pbc_attackers = self.pbc_data.attacker_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_attackers then
          script_error("ERROR: pending_battle_cache_get_attacker_faction_name() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return pbc_attackers[index].faction_name;
end;

--- @function pending_battle_cache_num_attacker_units
--- @desc Returns the number of units that a specified attacker in the cached pending battle took into battle, or will take into battle. If no army index is specified, then the total number of units across all attacking armies is returned.
--- @p [opt=nil] @number index of attacker
--- @r @number number of attacking units
function campaign_manager:pending_battle_cache_num_attacker_units(index)
     if not index then
          return self.pbc_data.attacker_data.num_units;
     end;

     local pbc_attackers = self.pbc_data.attacker_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_attackers then
          script_error("ERROR: pending_battle_cache_num_attacker_units() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return #pbc_attackers[index].units;
end;

--- @function pending_battle_cache_get_attacker_unit
--- @desc Returns the cqi and unit key of a specified unit on the specified attacker in the pending battle cache, by 1-based index.
--- @p @number attacker index, Index of attacking character within the pending battle cache.
--- @p @number unit index, Index of unit belonging to the attacking character.
--- @r @number cqi of unit
--- @r @string key of unit
function campaign_manager:pending_battle_cache_get_attacker_unit(index, unit_index)
     local pbc_attackers = self.pbc_data.attacker_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_attackers then
          script_error("ERROR: pending_battle_cache_get_attacker_unit() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     local character_record = pbc_attackers[index];

     if not is_number(unit_index) or unit_index < 1 or unit_index > #character_record.units then
          script_error("ERROR: pending_battle_cache_get_attacker_unit() called but supplied unit index [" ..
          tostring(unit_index) .. "] is out of range");
          return false;
     end;

     local unit_record = character_record.units[unit_index];

     return unit_record.unit_cqi, unit_record.unit_key;
end;

--- @function pending_battle_cache_num_defenders
--- @desc Returns the number of defending armies in the cached pending battle.
--- @r @number number of defending armies
function campaign_manager:pending_battle_cache_num_defenders()
     return #self.pbc_data.defender_data.armies;
end;

--- @function pending_battle_cache_get_defender
--- @desc Returns records relating to a particular defender in the cached pending battle. The defender is specified by numerical index, with the first being accessible at record 1. This function returns the cqi of the commanding character, the cqi of the related family member interface, the cqi of the military force, and the faction name.
--- @p @number index of defender
--- @r @number character cqi
--- @r @number family member cqi
--- @r @number military force cqi
--- @r @string faction name
--- @new_example print defender details
--- @example for i = 1, cm:pending_battle_cache_num_defenders() do
--- @example 	local char_cqi, fm_cqi, mf_cqi, faction_name = cm:pending_battle_cache_get_defender(i);
--- @example 	out("Defender " .. i .. " of faction " .. faction_name .. ":");
--- @example 	out("\tcharacter cqi: " .. char_cqi);
--- @example 	out("\tfamily_member cqi: " .. fm_cqi);
--- @example	out("\tmilitary force cqi: " .. mf_cqi);
--- @example end
function campaign_manager:pending_battle_cache_get_defender(index)
     local pbc_defenders = self.pbc_data.defender_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_defenders then
          script_error("ERROR: pending_battle_cache_get_defender() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return pbc_defenders[index].cqi, pbc_defenders[index].fm_cqi, pbc_defenders[index].mf_cqi,
         pbc_defenders[index].faction_name;
end;

--- @function pending_battle_cache_get_defender_faction_name
--- @desc Returns just the faction name of a particular defender in the cached pending battle. The defender is specified by numerical index, with the first being accessible at record 1.
--- @p @number index of defender
--- @r @string faction name
function campaign_manager:pending_battle_cache_get_defender_faction_name(index)
     local pbc_defenders = self.pbc_data.defender_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_defenders then
          script_error("ERROR: pending_battle_cache_get_defender_faction_name() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return pbc_defenders[index].faction_name;
end;

--- @function pending_battle_cache_num_defender_units
--- @desc Returns the number of units that a specified defender in the cached pending battle took into battle, or will take into battle. If no army index is specified, then the total number of units across all defending armies is returned.
--- @p [opt=nil] @number index of defender
--- @r @number number of defender units
function campaign_manager:pending_battle_cache_num_defender_units(index)
     if not index then
          return self.pbc_data.defender_data.num_units;
     end;

     local pbc_defenders = self.pbc_data.defender_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_defenders then
          script_error("ERROR: pending_battle_cache_num_defender_units() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     return #pbc_defenders[index].units;
end;

--- @function pending_battle_cache_get_defender_unit
--- @desc Returns the cqi and unit key of a specified unit on the specified defender in the pending battle cache, by 1-based index.
--- @p @number defender index, Index of attacking character within the pending battle cache.
--- @p @number unit index, Index of unit belonging to the attacking character.
--- @r @number cqi of unit
--- @r @string key of unit
function campaign_manager:pending_battle_cache_get_defender_unit(index, unit_index)
     local pbc_defenders = self.pbc_data.defender_data.armies;

     if not is_number(index) or index < 0 or index > #pbc_defenders then
          script_error("ERROR: pending_battle_cache_get_defender_unit() called but supplied index [" ..
          tostring(index) .. "] is out of range");
          return false;
     end;

     local character_record = pbc_defenders[index];

     if not is_number(unit_index) or unit_index < 1 or unit_index > #character_record.units then
          script_error("ERROR: pending_battle_cache_get_defender_unit() called but supplied unit index [" ..
          tostring(unit_index) .. "] is out of range");
          return false;
     end;

     local unit_record = character_record.units[unit_index];

     return unit_record.unit_cqi, unit_record.unit_key;
end;

--- @function pending_battle_cache_faction_is_attacker
--- @desc Returns <code>true</code> if the faction was an attacker (primary or reinforcing) in the cached pending battle.
--- @p @string faction key
--- @r @boolean faction was attacker
function campaign_manager:pending_battle_cache_faction_is_attacker(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: pending_battle_cache_faction_is_attacker() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     local pbc_attackers = self.pbc_data.attacker_data.armies;

     for i = 1, #pbc_attackers do
          if pbc_attackers[i].faction_name == faction_name then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_faction_is_defender
--- @desc Returns <code>true</code> if the faction was a defender (primary or reinforcing) in the cached pending battle.
--- @p @string faction key
--- @r @boolean faction was defender
function campaign_manager:pending_battle_cache_faction_is_defender(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: pending_battle_cache_faction_is_defender() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     local pbc_defenders = self.pbc_data.defender_data.armies;

     for i = 1, #pbc_defenders do
          if pbc_defenders[i].faction_name == faction_name then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_faction_is_involved
--- @desc Returns <code>true</code> if the faction was involved in the cached pending battle as either attacker or defender.
--- @p @string faction key
--- @r @boolean faction was involved
function campaign_manager:pending_battle_cache_faction_is_involved(faction_name)
     return self:pending_battle_cache_faction_is_attacker(faction_name) or
     self:pending_battle_cache_faction_is_defender(faction_name);
end;

--- @function pending_battle_cache_human_is_attacker
--- @desc Returns <code>true</code> if any of the attacking factions involved in the cached pending battle were human controlled (whether local or not).
--- @r @boolean human was attacking
function campaign_manager:pending_battle_cache_human_is_attacker(human_factions)
     -- If the pbc data contains the any_human flag then just return that - old savegames will not, however
     local any_human = self.pbc_data.attacker_data.any_human;
     if is_boolean(any_human) then
          return any_human;
     end;

     human_factions = human_factions or self:get_human_factions();

     for i = 1, #human_factions do
          if self:pending_battle_cache_faction_is_attacker(human_factions[i]) then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_human_is_defender
--- @desc Returns <code>true</code> if any of the defending factions involved in the cached pending battle were human controlled (whether local or not).
--- @r @boolean human was defending
function campaign_manager:pending_battle_cache_human_is_defender(human_factions)
     -- If the pbc data contains the any_human flag then just return that - old savegames will not, however
     local any_human = self.pbc_data.defender_data.any_human;
     if is_boolean(any_human) then
          return any_human;
     end;

     human_factions = human_factions or self:get_human_factions();

     for i = 1, #human_factions do
          if self:pending_battle_cache_faction_is_defender(human_factions[i]) then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_human_is_involved
--- @desc Returns <code>true</code> if any of the factions involved in the cached pending battle on either side were human controlled (whether local or not).
--- @r @boolean human was involved
function campaign_manager:pending_battle_cache_human_is_involved()
     -- If the pbc data contains the any_human flag then just return that - old savegames will not, however
     local any_attacker_human = self.pbc_data.attacker_data.any_human;
     if is_boolean(any_attacker_human) then
          return any_attacker_human or self.pbc_data.defender_data.any_human;
     end;

     local human_factions = self:get_human_factions();
     return self:pending_battle_cache_human_is_attacker(human_factions) or
     self:pending_battle_cache_human_is_defender(human_factions);
end;

--- @function pending_battle_cache_char_is_attacker
--- @desc Returns <code>true</code> if the supplied character was an attacker in the cached pending battle.
--- @p object character, Character to query. This may be supplied as a character object or as a character cqi number.
--- @r @boolean character was attacker
function campaign_manager:pending_battle_cache_char_is_attacker(obj)
     local char_cqi;

     -- support passing in the actual character
     if is_character(obj) then
          char_cqi = obj:command_queue_index();
     else
          char_cqi = obj;
     end;

     for i = 1, self:pending_battle_cache_num_attackers() do
          local current_char_cqi = self:pending_battle_cache_get_attacker(i);

          if current_char_cqi == char_cqi then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_char_is_defender
--- @desc Returns <code>true</code> if the supplied character was a defender in the cached pending battle.
--- @p object character, Character to query. This may be supplied as a character object or as a character cqi number.
--- @r @boolean character was defender
function campaign_manager:pending_battle_cache_char_is_defender(obj)
     local char_cqi;

     -- support passing in the actual character
     if is_character(obj) then
          char_cqi = obj:command_queue_index();
     else
          char_cqi = obj;
     end;

     for i = 1, self:pending_battle_cache_num_defenders() do
          local current_char_cqi = self:pending_battle_cache_get_defender(i);

          if current_char_cqi == char_cqi then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_char_is_involved
--- @desc Returns <code>true</code> if the supplied character was an attacker or defender in the cached pending battle.
--- @p object character, Character to query. May be supplied as a character object or as a cqi number.
--- @r @boolean character was involved
function campaign_manager:pending_battle_cache_char_is_involved(obj)
     local char_cqi;

     -- support passing in the actual character
     if is_character(obj) then
          char_cqi = obj:command_queue_index();
     else
          char_cqi = obj;
     end;

     return self:pending_battle_cache_char_is_attacker(char_cqi) or self:pending_battle_cache_char_is_defender(char_cqi);
end;

--- @function pending_battle_cache_mf_is_attacker
--- @desc Returns <code>true</code> if the supplied military force was an attacker in the cached pending battle.
--- @p @number cqi, Command-queue-index of the military force to query.
--- @r @boolean force was attacker
function campaign_manager:pending_battle_cache_mf_is_attacker(obj)
     local mf_cqi;

     if is_militaryforce(obj) then
          mf_cqi = obj:command_queue_index();
     else
          mf_cqi = obj;
     end;

     for i = 1, self:pending_battle_cache_num_attackers() do
          local current_char_cqi, current_fm_cqi, current_mf_cqi, current_faction_name = self
          :pending_battle_cache_get_attacker(i);

          if current_mf_cqi == mf_cqi then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_mf_is_defender
--- @desc Returns <code>true</code> if the supplied military force was a defender in the cached pending battle.
--- @p @number cqi, Command-queue-index of the military force to query.
--- @r @boolean force was defender
function campaign_manager:pending_battle_cache_mf_is_defender(obj)
     local mf_cqi;

     if is_militaryforce(obj) then
          mf_cqi = obj:command_queue_index();
     else
          mf_cqi = obj;
     end;

     for i = 1, self:pending_battle_cache_num_defenders() do
          local current_char_cqi, current_fm_cqi, current_mf_cqi, current_faction_name = self
          :pending_battle_cache_get_defender(i);

          if current_mf_cqi == mf_cqi then
               return true;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_mf_is_involved
--- @desc Returns <code>true</code> if the supplied military force was an attacker or defender in the cached pending battle.
--- @p @number cqi, Command-queue-index of the military force to query.
--- @r @boolean force was involved
function campaign_manager:pending_battle_cache_mf_is_involved(obj)
     local mf_cqi;

     -- support passing in the actual character
     if is_militaryforce(obj) then
          mf_cqi = obj:command_queue_index();
     else
          mf_cqi = obj;
     end;

     return self:pending_battle_cache_mf_is_attacker(mf_cqi) or self:pending_battle_cache_mf_is_defender(mf_cqi);
end;

--- @function pending_battle_cache_get_enemies_of_char
--- @desc Returns a numerically indexed table of family member cqis, each representing an enemy character of the supplied character in the cached pending battle. Note that if the battle has already been fought, the character associated with the family member interface may be dead.
--- @desc If the supplied character was not present in the pending battle then the returned table will be empty.
--- @p @character character, Character to query. This may be supplied as either a @character interface or a character cqi number.
--- @r @table table of enemy family member cqis
function campaign_manager:pending_battle_cache_get_enemies_of_char(obj)
     if not is_number(obj) and not is_character(obj) then
          script_error(
          "ERROR: pending_battle_cache_get_enemies_of_character() called but supplied character identifier [" ..
          tostring(obj) .. "] is not a number cqi or a character interface");
          return false;
     end;

     local retval = {};

     if self:pending_battle_cache_char_is_attacker(obj) then
          for i = 1, self:pending_battle_cache_num_defenders() do
               local char_cqi, fm_cqi = self:pending_battle_cache_get_defender(i);
               table.insert(retval, fm_cqi);
          end;
     elseif self:pending_battle_cache_char_is_defender(obj) then
          for i = 1, self:pending_battle_cache_num_attackers() do
               local char_cqi, fm_cqi = self:pending_battle_cache_get_attacker(i);
               table.insert(retval, fm_cqi);
          end;
     end;

     return retval;
end;

--- @function pending_battle_cache_is_quest_battle
--- @desc Returns <code>true</code> if any of the participating factions in the pending battle are quest battle factions, <code>false</code> otherwise.
--- @r @boolean is quest battle
function campaign_manager:pending_battle_cache_is_quest_battle()
     return self.pbc_data.is_quest_battle;
end;

--- @function pending_battle_cache_attacker_victory
--- @desc Returns <code>true</code> if the pending battle has been won by the attacker, <code>false</code> otherwise.
--- @r @boolean attacker has won
function campaign_manager:pending_battle_cache_attacker_victory()
     return not not string.find(self:model():pending_battle():attacker_battle_result(), "victory");
end;

--- @function pending_battle_cache_defender_victory
--- @desc Returns <code>true</code> if the pending battle has been won by the defender, <code>false</code> otherwise.
--- @r @boolean defender has won
function campaign_manager:pending_battle_cache_defender_victory()
     return not not string.find(self:model():pending_battle():defender_battle_result(), "victory");
end;

--- @function pending_battle_cache_attacker_value
--- @desc Returns the gold value of attacking forces in the cached pending battle.
--- @r @number gold value
function campaign_manager:pending_battle_cache_attacker_value()
     return self.pbc_data.attacker_data.value;
end;

--- @function pending_battle_cache_defender_value
--- @desc Returns the gold value of defending forces in the cached pending battle.
--- @r @number gold value
function campaign_manager:pending_battle_cache_defender_value()
     return self.pbc_data.defender_data.value;
end;

--- @function pending_battle_cache_attacker_strength
--- @desc Returns the total summed strength of all attacking armies in the pending battle cache. This strength is an arbitrary numeric value indicating the fighting strength of the armies present.
--- @r @number strength
function campaign_manager:pending_battle_cache_attacker_strength()
     return self.pbc_data.attacker_data.strength;
end;

--- @function pending_battle_cache_defender_strength
--- @desc Returns the total summed strength of all defending armies in the pending battle cache. This strength is an arbitrary numeric value indicating the fighting strength of the armies present.
--- @r @number strength
function campaign_manager:pending_battle_cache_defender_strength()
     return self.pbc_data.defender_data.strength;
end;

--- @function pending_battle_cache_attackers_contained_unit
--- @desc Returns <code>true</code> if any of the attacking armies in the pending battle cache contained a unit with the supplied key, or <code>false</code> otherwise.
--- @p @string unit key, Unit key, from the <code>land_units</code> database table.
--- @r @boolean unit was involved as attacker
function campaign_manager:pending_battle_cache_attackers_contained_unit(unit_key)
     if not is_string(unit_key) then
          script_error("ERROR: pending_battle_cache_attackers_contained_unit() called but supplied unit key [" ..
          tostring(unit_key) .. "] is not a string");
          return false;
     end;

     local pbc_attackers = self.pbc_data.attacker_data.armies;

     for i = 1, #pbc_attackers do
          local units = pbc_attackers[i].units;

          for j = 1, #units do
               if units[j].unit_key == unit_key then
                    return true;
               end;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_defenders_contained_unit
--- @desc Returns <code>true</code> if any of the defending armies in the pending battle cache contained a unit with the supplied key, or <code>false</code> otherwise.
--- @p @string unit key, Unit key, from the <code>land_units</code> database table.
--- @r @boolean unit was involved as defender
function campaign_manager:pending_battle_cache_defenders_contained_unit(unit_key)
     if not is_string(unit_key) then
          script_error("ERROR: pending_battle_cache_defenders_contained_unit() called but supplied unit key [" ..
          tostring(unit_key) .. "] is not a string");
          return false;
     end;

     local pbc_defenders = self.pbc_data.defender_data.armies;

     for i = 1, #pbc_defenders do
          local units = pbc_defenders[i].units;

          for j = 1, #units do
               if units[j].unit_key == unit_key then
                    return true;
               end;
          end;
     end;

     return false;
end;

--- @function pending_battle_cache_unit_is_involved
--- @desc Returns <code>true</code> if any of the attacking armies in the pending battle cache contained a unit with the supplied key.
--- @p @string unit key, Unit key, from the <code>land_units</code> database table.
--- @r @boolean unit was involved
function campaign_manager:pending_battle_cache_unit_is_involved(unit_key)
     if not is_string(unit_key) then
          script_error("ERROR: pending_battle_cache_unit_is_involved() called but supplied unit key [" ..
          tostring(unit_key) .. "] is not a string");
          return false;
     end;

     return self:pending_battle_cache_attackers_contained_unit(unit_key) or
     self:pending_battle_cache_defenders_contained_unit(unit_key);
end;

-----------------------------------------------------------------------------
--- @section Pre and Post-Battle Events
--- @desc The campaign manager automatically monitors battles starting and finishing, and fires events at certain key times during a battle sequence that client scripts can listen for.
--- @desc The campaign manager fires the following pre-battle events <b>in singleplayer mode only</b>. The pending battle may be accessed on the context of each with <code>context:pending_battle()</code>:
--- @desc <table class="simple"><tr><td><strong>Event</strong></td><td><strong>Trigger Condition</strong></td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpened</code></td><td>The pre-battle panel has opened on the local machine.</td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpenedAmbushPlayerDefender</code></td><td>The pre-battle panel has opened on the local machine and the player is the defender in an ambush.</td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpenedAmbushPlayerAttacker</code></td><td>The pre-battle panel has opened on the local machine and the player is the attacker in an ambush.</td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpenedMinorSettlement</code></td><td>The pre-battle panel has opened on the local machine and the battle is at a minor settlement.</td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpenedProvinceCapital</code></td><td>The pre-battle panel has opened on the local machine and the battle is at a province capital.</td></tr>
--- @desc <tr><td><code>ScriptEventPreBattlePanelOpenedField</code></td><td>The pre-battle panel has opened on the local machine and the battle is a field battle.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerBattleStarted</code></td><td>Triggered when the local player initiates a battle from the pre-battle screen, either by clicking the attack or autoresolve button.</td></tr></table>
--- @desc
--- @desc The campaign manager fires the following events post-battle events in singleplayer and multiplayer modes.
--- @desc <table class="simple"><tr><td><strong>Event</strong></td><td><strong>Trigger Condition</strong></td></tr>
--- @desc <tr><td><code>ScriptEventBattleSequenceCompleted</code></td><td>This event is triggered when any battle sequence is completed, whether a battle was fought or not.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerBattleSequenceCompleted</code></td><td>This event is triggered after a battle sequence involving a human player has been completed and the camera has returned to its normal completion, whether a battle was fought or not.</td></tr></table>
--- @desc
--- @desc It also fires the following events post-battle in singleplayer and multiplayer modes, for battle victories/defeats involving a human player. If multiple human players are involved in a single battle, then an event is generated for each. The pending battle and the involved human faction can be accessed on the context of each with <code>context:pending_battle()</code> and <code>context:faction()</code> respectively:
--- @desc <table class="simple"><tr><td><strong>Event</strong></td><td><strong>Trigger Condition</strong></td></tr>
--- @desc <tr><td><code>ScriptEventPlayerWinsBattle</code></td><td>A human player has won a battle.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerWinsFieldBattle</code></td><td>A human player has won a field battle. A "field" battle is a non-settlement battle, although it would include a battle where a settlement defender sallied against the besieging player.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerWinsSettlementDefenceBattle</code></td><td>A human player has won a settlement defence battle as the defender (including a battle where the player sallied).</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerWinsSettlementAttackBattle</code></td><td>A human player has won a settlement defence battle as the attacker. They should have captured the settlement if this event has been received.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerLosesSettlementDefenceBattle</code></td><td>A human player has lost a settlement defence battle as the defender.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerLosesSettlementAttackBattle</code></td><td>A human player has lost a settlement defence battle as the attacker.</td></tr>
--- @desc <tr><td><code>ScriptEventPlayerLosesFieldBattle</code></td><td>A human player has lost a field (non-settlement) battle.</td></tr></table>
-----------------------------------------------------------------------------

function campaign_manager:start_processing_battle_listeners(is_multiplayer)
     --
     -- Singleplayer-only listeners
     -- Work towards removing these and replacing them with equivalents that work in multiplayer.
     if not is_multiplayer then
          -- Trigger ScriptEventPlayerBattleStarted in singleplayer mode if attack or autoresolve buttons are clicked
          core:add_listener(
               "processing_battle_listener",
               "ComponentLClickUp",
               function(context) return context.string == "button_attack" or context.string == "button_autoresolve" end,
               function()
                    core:trigger_event("ScriptEventPlayerBattleStarted");
               end,
               true
          );

          -- Trigger pre-battle panel events in singleplayer
          core:add_listener(
               "processing_battle_listener",
               "PanelOpenedCampaign",
               function(context) return context.string == "popup_pre_battle" end,
               function(context)
                    local pb = self:model():pending_battle();
                    local battle_type = pb:battle_type();

                    core:trigger_event("ScriptEventPreBattlePanelOpened", pb);

                    -- check if this is an ambush
                    out("popup_pre_battle panel has opened, battle type is " .. battle_type);

                    if battle_type == "land_ambush" then
                         local local_faction_name = self:get_local_faction_name(true);
                         if local_faction_name then
                              if self:pending_battle_cache_faction_is_defender(local_faction_name) then
                                   -- this is an ambush battle in which the player is the defender
                                   core:trigger_event("ScriptEventPreBattlePanelOpenedAmbushPlayerDefender", pb);
                              else
                                   -- this is an ambush
                                   core:trigger_event("ScriptEventPreBattlePanelOpenedAmbushPlayerAttacker", pb);
                              end;
                         end;

                         return;
                    end;

                    -- if siege buttons are visible then this must be a siege battle
                    local uic_button_set_siege = find_uicomponent(core:get_ui_root(), "popup_pre_battle",
                         "button_set_siege");

                    if uic_button_set_siege and uic_button_set_siege:Visible() then
                         -- this is a battle at a settlement, if the encircle button is visible then it's a minor settlement
                         local uic_encircle_button = find_uicomponent(core:get_ui_root(), "popup_pre_battle",
                              "button_surround");

                         if uic_encircle_button and uic_encircle_button:Visible() then
                              -- this is a battle at a minor settlement
                              core:trigger_event("ScriptEventPreBattlePanelOpenedMinorSettlement", pb);
                         else
                              -- this is a battle at a province capital
                              core:trigger_event("ScriptEventPreBattlePanelOpenedProvinceCapital", pb);
                         end;
                    else
                         -- this is a regular field battle
                         core:trigger_event("ScriptEventPreBattlePanelOpenedField", pb);
                    end;
               end,
               true
          );
     end;

     core:add_listener(
          "processing_battle_listener",
          "PendingBattle",
          true,
          function(context)
               local pb = context:pending_battle();
               local attacker = pb:attacker();
               local defender = pb:defender();
               out("");
               out("**** PendingBattle event received, starting battle sequence - attacking character is " ..
                    (pb:has_attacker() and ("[" .. self:char_name_to_string(attacker) .. "] with cqi [" .. attacker:command_queue_index() .. "] of faction [" .. attacker:faction():name() .. "]") or "<no attacker?>") ..
                    ", defending character is " ..
                    (pb:has_defender() and ("[" .. self:char_name_to_string(defender) .. "] with cqi [" .. defender:command_queue_index() .. "] of faction [" .. defender:faction():name() .. "] at position [" .. defender:logical_position_x() .. ", " .. defender:logical_position_y() .. "]") or "<no defender?>"));

               if pb:has_contested_garrison() then
                    local gr = pb:contested_garrison();

                    if gr:is_settlement() then
                         local settlement = gr:settlement_interface();
                         out("\tThe battle is being fought over a settlement [" .. settlement:key() .. "]");
                    elseif gr:is_slot() then
                         local slot = gr:slot_interface();
                         out("\tThe battle is being fought over an ERS/outpost [" .. slot:slot_key() .. "]");
                    end;
               end;

               if self.processing_battle then
                    script_error(
                    "WARNING: PendingBattle event has been received but processing_battle flag is already true - how can this be?");
               end;

               self.processing_battle = true;

               self:cache_pending_battle();
          end,
          true
     );

     local battle_completion_event_received_for_current_battle = false;
     local battle_completed_camera_move_event_received_for_current_battle = false;

     -- List of human factions. At the time this function is called it's too early to populate, so we do it when the first BattleCompleted event is received.
     local human_factions = false;

     -- Forward-declare these functions, just because they look nicer at the bottom
     local battle_completion_event_received = false;
     local battle_sequence_completed = false;
     local trigger_events_for_player_involvement_in_battle = false;

     --
     -- BattleCompletedCameraMove listener
     -- This is received when the player is a participant in a battle and the camera has started to pull back up to gameplay altitude after
     -- the battle. It is received in multiplayer as well as singleplayer. When it's received, we set a flag which makes the battle sequence last
     -- a couple of seconds longer, allowing the camera movement to finish (otherwise we'd start getting missions and events popping off as the
     -- camera is underway)
     core:add_listener(
          "processing_battle_listener",
          "BattleCompletedCameraMove",
          true,
          function(context)
               battle_completed_camera_move_event_received_for_current_battle = true;
          end,
          true
     );


     --
     -- Battle completion listeners
     -- Here we establish listeners for a series of events that each signify that the battle sequence has ended, whether the battle was fought or
     -- not (participants withdrew, siege maintained, ambush declined etc).
     -- If the BattleCompletedCameraMove event has already been received then this menas a player is participating in the battle - in this case,
     -- if it's a player's turn, we wait for a couple of seconds for the camera to pull back up to gameplay altitude before sending notifications
     -- that the battle sequence is over.
     --
     -- If the battle has been fought, we also try and trigger events for any player involvement.
     core:add_listener(
          "processing_battle_listener",
          "BattleCompleted",
          true,
          function()
               battle_completion_event_received("BattleCompleted", "the battle was not fought");
          end,
          true
     );
     core:add_listener(
          "processing_battle_listener",
          "CharacterMaintainsSiege",
          true,
          function(context)
               local character = context:character();
               battle_completion_event_received("CharacterMaintainsSiege",
                    "character with cqi [" ..
                    character:command_queue_index() ..
                    "] of faction [" ..
                    character:faction():name() ..
                    "] is maintaining a siege in region [" .. context:region():name() .. "]");
          end,
          true
     );
     core:add_listener(
          "processing_battle_listener",
          "CharacterDeclinesAttackOfOpportunity",
          true,
          function(context)
               local character = context:character();
               local target_character = context:target_character();
               battle_completion_event_received("CharacterDeclinesAttackOfOpportunity",
                    "character with cqi [" ..
                    character:command_queue_index() ..
                    "] of faction [" ..
                    character:faction():name() ..
                    "] has declined an attack of opportunity against target character with cqi [" ..
                    target_character:command_queue_index() ..
                    "] of faction [" .. target_character:faction():name() .. "]");
          end,
          true
     );


     --
     -- local function, called when one of the events above is received, signifying that the battle sequence has been resolved
     function battle_completion_event_received(event_name, battle_not_fought_str)
          if battle_completion_event_received_for_current_battle then
               return;
          end;

          battle_completion_event_received_for_current_battle = true;

          if not self.processing_battle then
               script_error(
               "WARNING: PendingBattle event has been received but processing_battle flag is false - how can we be completing a battle if one isn't happening?");
          end;

          local pb = self:model():pending_battle();
          local battle_fought = self:model():pending_battle():has_been_fought();

          -- Output
          out("**** Battle sequence is ending as " .. event_name .. " was received, " ..
               (
                    battle_fought and
                    (
                         pb:attacker_won() and "the attacker won" or
                         (
                              pb:defender_won() and "the defender won" or
                              (
                                   pb:is_draw() and "the battle was drawn" or "could not determine result of battle"
                              )
                         )
                    ) or battle_not_fought_str
               ));

          local is_human_factions_turn = self:is_human_factions_turn();

          --
          -- Complete the battle sequence (or wait two seconds to do it, if it's a player's turn)
          if battle_completed_camera_move_event_received_for_current_battle then
               battle_completed_camera_move_event_received_for_current_battle = false;

               if is_human_factions_turn then
                    -- The BattleCompletedCameraMove event has already been received and it's a player's turn, which means we're pulling back up to gameplay altitude. Wait a couple of seconds before completing.
                    self:callback(
                         function()
                              battle_sequence_completed(battle_fought, is_human_factions_turn);
                         end,
                         2
                    );
                    out("\twaiting for the camera movement to complete before completing battle sequence");
               else
                    battle_sequence_completed(battle_fought, is_human_factions_turn);
               end;
          else
               battle_sequence_completed(battle_fought, is_human_factions_turn);
          end;

          --
          -- If the battle has been fought then send custom events for each human faction
          if battle_fought and self:pending_battle_cache_human_is_involved() then
               trigger_events_for_player_involvement_in_battle(pb)
          end;
     end;

     --
     -- local function to complete the battle sequence
     function battle_sequence_completed(battle_fought, is_human_factions_turn)
          self.processing_battle = false;

          battle_completion_event_received_for_current_battle = false;

          if is_human_factions_turn then
               if battle_fought then
                    out(
                    "**** Battle sequence involving a fought battle and the player has fully completed, triggering ScriptEventPlayerFoughtBattleSequenceCompleted, ScriptEventPlayerBattleSequenceCompleted and ScriptEventBattleSequenceCompleted");
                    core:trigger_event("ScriptEventPlayerFoughtBattleSequenceCompleted");
               else
                    out(
                    "**** Battle sequence involving the player has fully completed, no battle was fought - triggering ScriptEventPlayerBattleSequenceCompleted and ScriptEventBattleSequenceCompleted");
               end;

               core:trigger_custom_event("ScriptEventPlayerBattleSequenceCompleted", { battle_fought = battle_fought });
          else
               out("**** Battle sequence completed, triggering ScriptEventBattleSequenceCompleted.");
          end;
          out("");

          core:trigger_event("ScriptEventBattleSequenceCompleted", { battle_fought = battle_fought });
     end;

     --
     -- local function to trigger events for player involvement in a battle that has been fought
     function trigger_events_for_player_involvement_in_battle(pb)
          local attacker_victory = self:pending_battle_cache_attacker_victory();
          local defender_victory = self:pending_battle_cache_defender_victory();

          local is_settlement_battle = pb:has_contested_garrison();
          local battle_type = pb:battle_type();

          -- Populate this local value the first time we get here
          if not human_factions then
               human_factions = self:get_human_factions();
          end;

          local any_attacker_is_human = self:pending_battle_cache_human_is_attacker();
          local any_defender_is_human = self:pending_battle_cache_human_is_defender();

          for i = 1, #human_factions do
               local human_faction_name = human_factions[i];
               if any_attacker_is_human and self:pending_battle_cache_faction_is_attacker(human_faction_name) then
                    local human_faction = cm:get_faction(human_faction_name);
                    if attacker_victory then
                         -- Player is attacker and the attacker won the battle
                         if is_settlement_battle then
                              if battle_type == "settlement_sally" then
                                   -- the player has won a sally battle as the attacker - i.e. the player attacked out of the settlement
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they won a sally battle as the attacker, triggering events ScriptEventPlayerWinsSettlementDefenceBattle and ScriptEventPlayerWinsBattle");
                                   core:trigger_event("ScriptEventPlayerWinsSettlementDefenceBattle", pb, human_faction);
                              else
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they won a settlement battle as the attacker, triggering events ScriptEventPlayerWinsSettlementAttackBattle and ScriptEventPlayerWinsBattle");
                                   core:trigger_event("ScriptEventPlayerWinsSettlementAttackBattle", pb, human_faction);
                              end;
                         else
                              out("**** Battle involving player faction [" ..
                              human_faction_name ..
                              "] has been fought - they won a non-settlement battle as the attacker, triggering events ScriptEventPlayerWinsFieldBattle and ScriptEventPlayerWinsBattle");
                              core:trigger_event("ScriptEventPlayerWinsFieldBattle", pb, human_faction);
                         end;
                         core:trigger_event("ScriptEventPlayerWinsBattle", pb, human_faction);
                    else
                         -- Player is attacker and the defender won the battle
                         if is_settlement_battle then
                              if battle_type == "settlement_sally" then
                                   -- the player has lost a sally battle as the attacker - i.e. the player attacked out of the settlement
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they lost a sally battle as the attacker, triggering events ScriptEventPlayerLosesSettlementDefenceBattle and ScriptEventPlayerLosesBattle");
                                   core:trigger_event("ScriptEventPlayerLosesSettlementDefenceBattle", pb, human_faction);
                              else
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they lost a settlement battle as the attacker, triggering events ScriptEventPlayerLosesSettlementAttackBattle and ScriptEventPlayerLosesBattle");
                                   core:trigger_event("ScriptEventPlayerLosesSettlementAttackBattle", pb, human_faction);
                              end;
                         else
                              out("**** Battle involving player faction [" ..
                              human_faction_name ..
                              "] has been fought - they lost a non-settlement battle as the attacker, triggering events ScriptEventPlayerLosesFieldBattle and ScriptEventPlayerLosesBattle");
                              core:trigger_event("ScriptEventPlayerLosesFieldBattle", pb, human_faction);
                         end;
                         core:trigger_event("ScriptEventPlayerLosesBattle", pb, human_faction);
                    end;
               elseif any_defender_is_human and self:pending_battle_cache_faction_is_defender(human_faction_name) then
                    local human_faction = cm:get_faction(human_faction_name);
                    if attacker_victory then
                         -- Player is defender and the attacker won the battle
                         if is_settlement_battle then
                              if battle_type == "settlement_sally" then
                                   -- the player has lost a sally battle as the defender - i.e. the player was sieging, and their opponent attacked out of the settlement
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they lost a sally battle as the defender, triggering events ScriptEventPlayerLosesFieldBattle and ScriptEventPlayerLosesBattle");
                                   core:trigger_event("ScriptEventPlayerLosesFieldBattle", pb, human_faction);
                              else
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they lost a settlement battle as the defender, triggering events ScriptEventPlayerLosesSettlementDefenceBattle and ScriptEventPlayerLosesBattle");
                                   core:trigger_event("ScriptEventPlayerLosesSettlementDefenceBattle", pb, human_faction);
                              end;
                         else
                              out("**** Battle involving player faction [" ..
                              human_faction_name ..
                              "] has been fought - they lost a non-settlement battle as the defender, triggering events ScriptEventPlayerLosesFieldBattle and ScriptEventPlayerLosesBattle");
                              core:trigger_event("ScriptEventPlayerLosesFieldBattle", pb, human_faction);
                         end;
                         core:trigger_event("ScriptEventPlayerLosesBattle", pb, human_faction);
                    else
                         -- Player is defender and the defender won the battle
                         if is_settlement_battle then
                              if battle_type == "settlement_sally" then
                                   -- the player has won a sally battle as the defender - i.e. the player was sieging, and their opponent attacked out of the settlement but was defeated
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they won a sally battle as the defender, triggering events ScriptEventPlayerWinsSettlementAttackBattle and ScriptEventPlayerWinsBattle");
                                   core:trigger_event("ScriptEventPlayerWinsSettlementAttackBattle", pb, human_faction);
                              else
                                   out("**** Battle involving player faction [" ..
                                   human_faction_name ..
                                   "] has been fought - they won a settlement battle as the defender, triggering events ScriptEventPlayerWinsSettlementDefenceBattle and ScriptEventPlayerWinsBattle");
                                   core:trigger_event("ScriptEventPlayerWinsSettlementDefenceBattle", pb, human_faction);
                              end;
                         else
                              out("**** Battle involving player faction [" ..
                              human_faction_name ..
                              "] has been fought - they won a non-settlement battle as the defender, triggering events ScriptEventPlayerWinsFieldBattle and ScriptEventPlayerWinsBattle");
                              core:trigger_event("ScriptEventPlayerWinsFieldBattle", pb, human_faction);
                         end;
                         core:trigger_event("ScriptEventPlayerWinsBattle", pb, human_faction);
                    end;
               end;
          end;
     end;
end;

-----------------------------------------------------------------------------
--- @section Values Passed to Battle
--- @desc Prior to battle, the campaign manager saves certain data into the @"core:Scripted Value Registry" which can be accessed by battle scripts:
--- @desc <table class="simple"><tr><td><strong>Variable Name</strong></td><td><strong>Data Type</strong></td><td><strong>Description</strong></td></tr><tr><td><code>battle_type</code></td><td><code>string</code></td><td>The string battle type.</td></tr><tr><td><code>primary_attacker_faction_name</code></td><td><code>string</code></td><td>The faction key of the primary attacking army.</td></tr><tr><td><code>primary_attacker_subculture</code></td><td><code>string</code></td><td>The subculture key of the primary attacking army.</td></tr><tr><td><code>primary_defender_faction_name</code></td><td><code>string</code></td><td>The faction key of the primary defending army.</td></tr><tr><td><code>primary_defender_subculture</code></td><td><code>string</code></td><td>The subculture key of the primary defending army.</td></tr><tr><td><code>primary_attacker_is_player</code></td><td><code>boolean</code></td><td>Whether the local player is the primary attacker.</td></tr><tr><td><code>primary_defender_is_player</code></td><td><code>boolean</code></td><td>Whether the local player is the primary defender.</td></tr></table>
--- @desc These values can be accessed in battle scripts using @core:svr_load_string and @core:svr_load_bool.
-----------------------------------------------------------------------------


-- called by the pending battle cache system when the pending battle event occurs
function campaign_manager:set_pending_battle_svr_state(pb)
     local primary_attacker_faction_name = "";
     local primary_attacker_subculture = "";
     local primary_defender_faction_name = "";
     local primary_defender_subculture = "";

     if pb:has_attacker() then
          primary_attacker_faction_name = pb:attacker():faction():name();
          primary_attacker_subculture = pb:attacker():faction():subculture();
     end;

     if pb:has_defender() then
          primary_defender_faction_name = pb:defender():faction():name();
          primary_defender_subculture = pb:defender():faction():subculture();
     end;

     core:svr_save_string("campaign_key_for_battle", self:get_campaign_name());
     core:svr_save_string("battle_type", pb:battle_type());
     core:svr_save_string("primary_attacker_faction_name", primary_attacker_faction_name);
     core:svr_save_string("primary_attacker_subculture", primary_attacker_subculture);
     core:svr_save_string("primary_defender_faction_name", primary_defender_faction_name);
     core:svr_save_string("primary_defender_subculture", primary_defender_subculture);

     -- only in sp
     if not self:is_multiplayer() then
          local local_faction_name = cm:get_local_faction_name();

          if primary_attacker_faction_name == local_faction_name then
               core:svr_save_bool("primary_attacker_is_player", true);
               core:svr_save_bool("primary_defender_is_player", false);
          elseif primary_defender_faction_name == local_faction_name then
               core:svr_save_bool("primary_attacker_is_player", false);
               core:svr_save_bool("primary_defender_is_player", true);
          else
               core:svr_save_bool("primary_attacker_is_player", false);
               core:svr_save_bool("primary_defender_is_player", false);
          end;
     end;
end;

-----------------------------------------------------------------------------
--- @section Random Numbers
-----------------------------------------------------------------------------


--- Commented out on the 11th of April 2019 - Feature is now obsolute due to model():random_int()

--[[ function campaign_manager:random_number(max_num, min_num)
	if is_nil(max_num) then
		max_num = 100;
	end;

	if is_nil(min_num) then
		min_num = 1;
	end;

	if not is_number(max_num) or math.floor(max_num) < max_num then
		script_error("random_number ERROR: supplied max number [" .. tostring(max_num) .. "] is not a valid integer");
		return 0;
	end;

	if max_num == min_num then
		return max_num;
	end;

	if min_num == 1 and max_num < min_num then
		script_error("random_number ERROR: supplied max number [" .. tostring(max_num) .. "] can only be negative if a min number is also supplied");
		return 0;
	end;

	if not is_number(min_num) or min_num >= max_num or math.floor(min_num) < min_num then
		script_error("random_number ERROR: supplied min number [" .. tostring(min_num) .. "] is not an integer less than the max num");
		return 0;
	end;

	-- internal_max_num is the number we'll be proceeding with internally, it's the max_num if min_num was 1.
	-- So if the user wants a random number between 11 and 20, we'll proceed as if they want a random number between 1 and
	-- 10 and then adjust the result afterwards.
	local internal_max_num = max_num + 1 - min_num;

	-- work out the bit depth of internal_max_num
	local count = 2;
	local depth = 1;

	while count < internal_max_num do
		count = count * 2;
		depth = depth + 1;
	end;

	-- assemble a random number of the specified bit-depth
	local random_number = 0;

	for i = 0, depth - 1 do
		if self:model():random_percent(50) then
			random_number = random_number + (2 ^ i);
		end;
	end;

	-- if the number we've got is bigger than the maximum, try again
	if random_number >= internal_max_num then
		return self:random_number(max_num, min_num);
	end;

	local retval = random_number + min_num;

	if self:is_multiplayer() then
		--out("random_number() called, max_num [" .. tostring(max_num) .. "], min_num [" .. tostring(min_num) .. "], returning value [" .. tostring(retval) .. "]");
	end;

	return retval;
end;
 ]]


--- @function random_sort
--- @desc Randomly sorts a numerically-indexed table. This is safe to use in multiplayer, but will destroy the supplied table. It is faster than @campaign_manager:random_sort_copy.
--- @desc Note that records in this table that are not arranged in an ascending numerical index will be lost.
--- @desc Note also that the supplied table is overwritten with the randomly-sorted table, which is also returned as a return value.
--- @p @table numerically-indexed table, Numerically-indexed table. This will be overwritten by the returned, randomly-sorted table.
--- @return @table randomly-sorted table
function campaign_manager:random_sort(t)
     if not is_table(t) then
          script_error("ERROR: random_sort() called but supplied object [" .. tostring(t) .. "] is not a table");
          return false;
     end;

     local model = self:model();
     if not model then
          script_error("ERROR: random_sort() called but model is not yet created - returning unsorted table");
          return t;
     end;

     local new_t = {};
     local table_size = #t;
     local n = 0;

     for i = 1, table_size do
          -- pick an entry from t, add it to new_t, then remove it from t
          n = model:random_int(1, #t);

          table.insert(new_t, t[n]);
          table.remove(t, n);
     end;

     return new_t;
end;

--- @function random_sort_copy
--- @desc Randomly sorts a numerically-indexed table. This is safe to use in multiplayer, and will preserve the original table, but it is slower than @campaign_manager:random_sort as it copies the table first.
--- @desc Note that records in the source table that are not arranged in an ascending numerical index will not be copied (they will not be deleted, however).
--- @p @table numerically-indexed table, Numerically-indexed table.
--- @return @table randomly-sorted table
function campaign_manager:random_sort_copy(t)
     if not is_table(t) then
          script_error("ERROR: random_sort_copy() called but supplied object [" .. tostring(t) .. "] is not a table");
          return false;
     end;

     local table_size = #t;
     local new_t = {};

     -- copy this table
     for i = 1, table_size do
          new_t[i] = t[i];
     end;

     return self:random_sort(new_t);
end;

----------------------------------------------------------------------------
--- @section Campaign UI
----------------------------------------------------------------------------


--- @function get_campaign_ui_manager
--- @desc Gets a handle to the @campaign_ui_manager (or creates it).
--- @return campaign_ui_manager
function campaign_manager:get_campaign_ui_manager()
     if self.campaign_ui_manager then
          return self.campaign_ui_manager;
     end;
     return campaign_ui_manager:new();
end;

--- @function highlight_event_dismiss_button
--- @desc Activates or deactivates a highlight on the event panel dismiss button. This may not work in all circumstances.
--- @p [opt=true] boolean should highlight
function campaign_manager:highlight_event_dismiss_button(should_highlight)
     if should_highlight ~= false then
          should_highlight = true;
     end;

     local uic_button = find_uicomponent(core:get_ui_root(), "panel_manager", "events", "button_set", "accept_decline",
          "button_accept");
     local button_highlighted = false;

     -- if should_highlight is false, then both potential buttons get unhighlighted
     -- if it's true, then only the first that is found to be visible is highlighted

     if uic_button and (uic_button:Visible(true) or not should_highlight) then
          uic_button:Highlight(should_highlight, false, 0);
          button_highlighted = true;
     end;

     if button_highlighted and should_highlight then
          return;
     end;

     uic_button = find_uicomponent(core:get_ui_root(), "panel_manager", "events", "button_set", "accept_holder",
          "button_accept");

     if uic_button and (uic_button:Visible(true) or not should_highlight) then
          uic_button:Highlight(should_highlight, false, 0);
     end;
end;

--- @function quit
--- @desc Immediately exits to the frontend. Mainly used in benchmark scripts.
function campaign_manager:quit()
     out("campaign_manager:quit() called");

     self:dismiss_advice();

     self:callback(
          function()
               self:steal_user_input(true);
               core:get_ui_root():InterfaceFunction("QuitForScript");
          end,
          1
     );
end;

--- @function enable_ui_hiding
--- @desc Enables or disables the ability of the player to hide the UI.
--- @p [opt=true] boolean enable hiding
function campaign_manager:enable_ui_hiding(value)
     if value ~= false then
          value = true;
     end;

     self.ui_hiding_enabled = value;

     self.game_interface:disable_shortcut("root", "toggle_ui", not value);
     self.game_interface:disable_shortcut("root", "toggle_ui_with_borders", not value);
end;

--- @function disable_shortcut
--- @desc Disables/Enables a shortcut in the underlaying SHORTCUT_HANDLER. This is a wrapper of a c++ function with the same name.
--- @p string object_id, ui_component id matching the function from the default_keys.xml.
--- @p string function_id, function id matching the function shortcut from the default_keys.xml.
--- @p bool disabled, true for disable, false for enable.
--- @example cm:disable_shortcut("object_id", "function_id", true)
function campaign_manager:disable_shortcut(object_id, function_id, disabled)
     if not is_string(object_id) then
          script_error("ERROR: disable_shortcut() called but supplied object_id [" ..
          tostring(object_id) .. "] is not a string");
          return false;
     end

     if not is_string(function_id) then
          script_error("ERROR: disable_shortcut() called but supplied function_id [" ..
          tostring(function_id) .. "] is not a string");
          return false;
     end

     if disabled == true then
          self.game_interface:disable_shortcut(object_id, function_id, true);
     else
          self.game_interface:disable_shortcut(object_id, function_id, false);
     end
end

--- @function is_ui_hiding_enabled
--- @desc Returns <code>false</code> if ui hiding has been disabled with @campaign_manager:enable_ui_hiding, <code>true</code> otherwise.
--- @return boolean is ui hiding enabled
function campaign_manager:is_ui_hiding_enabled()
     return self.ui_hiding_enabled;
end;

-----------------------------------------------------------------------------
--- @section Camera Movement
--- @desc The functions in this section allow or automate camera scrolling to some degree. Where camera positions are supplied as arguments, these are given as a table of numbers. The numbers in a camera position table are given in the following order:
--- @desc <ol><li>x co-ordinate of camera target.</li>
--- @desc <li>y co-ordinate of camera target.</li>
--- @desc <li>horizontal distance from camera to target.</li>
--- @desc <li>bearing from camera to target, in radians.</li>
--- @desc <li>vertical distance from camera to target.</li></ol>
--- @desc In campaign, the game will print the current camera co-ordinates if the <code>camera_position</code> command is entered on the console. The position is printed on the Command tab of the console.
-----------------------------------------------------------------------------


-- called internally by various camera functions
function campaign_manager:check_valid_camera_waypoint(waypoint)
     if not is_table(waypoint) then
          script_error("ERROR: check_valid_camera_waypoint() called but supplied waypoint [" ..
          tostring(waypoint) .. "] is not a table");
          return false;
     end;

     for i = 1, 5 do
          if not is_number(waypoint[i]) then
               script_error("ERROR: check_valid_camera_waypoint() called but index [" ..
               i .. "] of supplied waypoint is not a number but is [" .. tostring(waypoint[i]) .. "]");
               return false;
          end;
     end;

     -- for waypoints that include a timestamp
     if #waypoint == 6 then
          if not is_number(waypoint[6]) then
               script_error("ERROR: check_valid_camera_waypoint() called but index [" ..
               6 .. "] of supplied waypoint is not a number but is [" .. tostring(waypoint[6]) .. "]");
               return false;
          end;
     end;

     return true;
end;

-- returns true if the supplied positions are the same
function campaign_manager:scroll_camera_position_check(source, dest)
     return source[1] == dest[1] and source[2] == dest[2] and source[3] == dest[3] and source[4] == dest[4] and
     source[5] == dest[5];
end;

-- internal function to convert a camera position to a string
function campaign_manager:camera_position_to_string(x, y, d, b, h)
     if is_table(x) then
          y = x[2];
          d = x[3];
          b = x[4];
          h = x[5];
          x = x[1];
     end;

     return "[x: " ..
     tostring(x) ..
     ", y: " .. tostring(y) .. ", d: " .. tostring(d) .. ", b: " .. tostring(b) .. ", h: " .. tostring(h) .. "]";
end;

--- @function scroll_camera_with_direction
--- @desc Override function for scroll_camera_wiht_direction that provides output.
--- @p boolean correct endpoint, Correct endpoint. If true, the game will adjust the final position of the camera so that it's a valid camera position for the game. Set to true if control is being released back to the player after this camera movement finishes.
--- @p number time, Time in seconds over which to scroll.
--- @p ... positions, Two or more camera positions must be supplied. Each position should be a table with five number components, as described in the description of the @"campaign_manager:Camera Movement" section.
--- @new_example
--- @desc Pull the camera out from a close-up to a wider view.
--- @example cm:scroll_camera_with_direction(
--- @example 	true,
--- @example 	5,
--- @example 	{132.9, 504.8, 8, 0, 6},
--- @example 	{132.9, 504.8, 16, 0, 12}
--- @example )
function campaign_manager:scroll_camera_with_direction(correct_endpoint, t, ...)
     local x, y, d, b, h = self:get_camera_position();

     if correct_endpoint then
          out("scroll_camera_with_direction() called, correct endpoint was set to true but forcing it false - time is " ..
          tostring(t) .. "s, current camera position is " .. self:camera_position_to_string(x, y, d, b, h));
          correct_endpoint = false;
     else
          out("scroll_camera_with_direction() called, correct endpoint is " ..
          tostring(correct_endpoint) ..
          ", time is " ..
          tostring(t) .. "s, current camera position is " .. self:camera_position_to_string(x, y, d, b, h));
     end;

     out.inc_tab();
     for i = 1, arg.n do
          local current_pos = arg[i];
          out("position " ..
          i ..
          ": " ..
          self:camera_position_to_string(current_pos[1], current_pos[2], current_pos[3], current_pos[4], current_pos[5]));
     end;
     out.dec_tab();

     self.game_interface:scroll_camera_with_direction(correct_endpoint, t, unpack(arg));
end;

--- @function scroll_camera_from_current
--- @desc Scrolls the camera from the current camera position. This is the same as callling @campaign_manager:scroll_camera_with_direction with the current camera position as the first set of co-ordinates.
--- @p boolean correct endpoint, Correct endpoint. If true, the game will adjust the final position of the camera so that it's a valid camera position for the game. Set to true if control is being released back to the player after this camera movement finishes.
--- @p number time, Time in seconds over which to scroll.
--- @p ... positions, One or more camera positions must be supplied. Each position should be a table with five number components, as described in the description of the @"campaign_manager:Camera Movement" section.
--- @example cm:scroll_camera_from_current(
--- @example 	true,
--- @example 	5,
--- @example 	{251.3, 312.0, 12, 0, 8}
--- @example )
function campaign_manager:scroll_camera_from_current(correct_endpoint, t, ...)
     -- check our parameters
     if not is_number(t) or t <= 0 then
          script_error("ERROR: scroll_camera_from_current() called but supplied duration [" ..
          tostring(t) .. "] is not a number");
          return false;
     end;

     for i = 1, arg.n do
          if not self:check_valid_camera_waypoint(arg[i]) then
               -- error will be returned by the function above
               return false;
          end;
     end;

     -- insert the current camera position as the first position in the sequence
     local x, y, d, b, h = self:get_camera_position();

     table.insert(arg, 1, { x, y, d, b, h });

     -- output
     out("scroll_camera_from_current() called");
     out.inc_tab();
     self:scroll_camera_with_direction(correct_endpoint, t, unpack(arg))
     out.dec_tab();
end;

--- @function scroll_camera_with_cutscene
--- @desc Scrolls the camera from the current camera position in a cutscene. Cinematic borders will be shown (unless disabled with @campaign_manager:set_use_cinematic_borders_for_automated_cutscenes), the UI hidden, and interaction with the game disabled while the camera is scrolling. The player will be able to skip the cutscene with the ESC key, in which case the camera will jump to the end position.
--- @p number time, Time in seconds over which to scroll.
--- @p [opt=nil] function callback, Optional callback to call when the cutscene ends.
--- @p ... positions, One or more camera positions must be supplied. Each position should be a table with five number components, as described in the description of the @"campaign_manager:Camera Movement" section.
function campaign_manager:scroll_camera_with_cutscene(t, end_callback, ...)
     -- check our parameters
     if not is_number(t) or t <= 0 then
          script_error("ERROR: scroll_camera_with_cutscene() called but supplied duration [" ..
          tostring(t) .. "] is not a number");
          return false;
     end;

     if not is_function(end_callback) and not is_nil(end_callback) then
          script_error("ERROR: scroll_camera_with_cutscene() called but supplied end_callback [" ..
          tostring(end_callback) .. "] is not a function or nil");
          return false;
     end;

     for i = 1, arg.n do
          if not self:check_valid_camera_waypoint(arg[i]) then
               -- error will be returned by the function above
               return false;
          end;
     end;

     -- get the last position now before we start mucking around with the argument list
     local last_pos = arg[arg.n];

     -- insert the current camera position as the first position in the sequence
     local x, y, d, b, h = self:get_camera_position();

     table.insert(arg, 1, { x, y, d, b, h });

     self:cut_and_scroll_camera_with_cutscene(t, end_callback, unpack(arg));
end;

--- @function cut_and_scroll_camera_with_cutscene
--- @desc Scrolls the camera through the supplied list of camera points in a cutscene. Cinematic borders will be shown (unless disabled with @campaign_manager:set_use_cinematic_borders_for_automated_cutscenes), the UI hidden, and interaction with the game disabled while the camera is scrolling. The player will be able to skip the cutscene with the ESC key, in which case the camera will jump to the end position.
--- @p number time, Time in seconds over which to scroll.
--- @p [opt=nil] function callback, Optional callback to call when the cutscene ends.
--- @p ... positions. One or more camera positions must be supplied. Each position should be a table with five number components, as described in the description of the @"campaign_manager:Camera Movement" section.
function campaign_manager:cut_and_scroll_camera_with_cutscene(t, end_callback, ...)
     -- check our parameters
     if not is_number(t) or t <= 0 then
          script_error("ERROR: cut_and_scroll_camera_with_cutscene() called but supplied duration [" ..
          tostring(t) .. "] is not a number");
          return false;
     end;

     if not is_function(end_callback) and not is_nil(end_callback) then
          script_error("ERROR: cut_and_scroll_camera_with_cutscene() called but supplied end_callback [" ..
          tostring(end_callback) .. "] is not a function or nil");
          return false;
     end;

     if arg.n < 2 then
          script_error("ERROR: cut_and_scroll_camera_with_cutscene() called but less than two camera positions given");
          return false;
     end;

     for i = 1, arg.n do
          if not self:check_valid_camera_waypoint(arg[i]) then
               -- error will be returned by the function above
               return false;
          end;
     end;

     -- make a cutscene, add the camera pan as the action and play it
     local cutscene = campaign_cutscene:new(
          "scroll_camera_with_cutscene",
          t,
          function()
               out.dec_tab();
               if end_callback then
                    end_callback();
               end;
          end
     );

     cutscene:set_skippable(true, arg[arg.n]); -- set the last position in the supplied list to be the skip position
     cutscene:set_dismiss_advice_on_end(false);

     cutscene:set_use_cinematic_borders(self.use_cinematic_borders_for_automated_cutscenes);

     if not uim:override("settlement_labels"):is_locked() then
          cutscene:set_disable_settlement_labels(false);
     end;

     local start_position = arg[1];

     cutscene:action(function() self:set_camera_position(unpack(start_position)) end, 0);
     cutscene:action(
          function()
               out.inc_tab();
               self:scroll_camera_with_direction(true, t, unpack(arg));
               out.dec_tab();
          end,
          0
     );
     cutscene:start();
end;

--- @function scroll_camera_to_settlement
--- @desc Scrolls the camera to a settlement, specified by region key.
--- @p string region key, Key of region containing target settlement.
--- @p [opt=1] number time, Time in seconds over which to scroll.
function campaign_manager:scroll_camera_to_settlement(region_key, time)
     time = time or 1

     local settlement = cm:get_region(region_key):settlement()
     local targ_x = settlement:display_position_x();
     local targ_y = settlement:display_position_y();

     local x, y, d, b, h = self:get_camera_position();

     self:scroll_camera_from_current(
          true,
          time,
          { targ_x, targ_y, 7.6, b, 4.0 }
     )
end

--- @function scroll_camera_to_region_slot
--- @desc Scrolls the camera to the specified region slot. The region slot is specified by its slot key.
--- @p string slot key, Key of target slot.
--- @p [opt=1] number time, Time in seconds over which to scroll.
function campaign_manager:scroll_camera_to_region_slot(slot_key, time)
     time = time or 1

     local slot = cm:model():world():region_manager():slot_by_key(slot_key)
     local targ_x = slot:display_position_x();
     local targ_y = slot:display_position_y();

     local x, y, d, b, h = self:get_camera_position();

     self:scroll_camera_from_current(
          true,
          time,
          { targ_x, targ_y, 7.6, b, 4.0 }
     )
end

--- @function scroll_camera_with_cutscene_to_character
--- @desc Scrolls the camera in a cutscene to the specified character in a cutscene. The character is specified by its command queue index (cqi). Cinematic borders will be shown (unless disabled with @campaign_manager:set_use_cinematic_borders_for_automated_cutscenes), the UI hidden, and interaction with the game disabled while the camera is scrolling. The player will be able to skip the cutscene with the ESC key, in which case the camera will jump to the target.
--- @p number time, Time in seconds over which to scroll.
--- @p [opt=nil] function callback, Optional callback to call when the cutscene ends.
--- @p number cqi, CQI of target character.
function campaign_manager:scroll_camera_with_cutscene_to_character(t, end_callback, char_cqi)
     if not is_number(char_cqi) then
          script_error("ERROR: scroll_camera_with_cutscene_to_character() called but supplied character cqi [" ..
          tostring(char_cqi) .. "] is not a number");
          return false;
     end;

     local character = self:get_character_by_cqi(char_cqi);

     if not character then
          script_error("ERROR: scroll_camera_with_cutscene_to_character() called but no character with cqi [" ..
          char_cqi .. "] could be found");
          return false;
     end;

     local targ_x = character:display_position_x();
     local targ_y = character:display_position_y();

     local x, y, d, b, h = self:get_camera_position();

     -- pan camera to calculated target
     self:scroll_camera_with_cutscene(
          t,
          end_callback,
          { targ_x, targ_y, 7.6, b, 4.0 }
     );
end;

--- @function scroll_camera_to_character
--- @desc Scrolls the camera to the specified character. The character is specified by its command queue index (cqi).
--- @p number cqi, CQI of target character.
--- @p [opt=1] number time, Time in seconds over which to scroll.
function campaign_manager:scroll_camera_to_character(char_cqi, time, face_character)
     if not is_number(char_cqi) then
          script_error("ERROR: scroll_camera_to_character() called but supplied character cqi [" ..
          tostring(char_cqi) .. "] is not a number")
          return false
     end

     local character = self:get_character_by_cqi(char_cqi)

     if not character then
          script_error("ERROR: scroll_camera_to_character() called but no character with cqi [" ..
          char_cqi .. "] could be found")
          return false
     end

     local targ_x = character:display_position_x()
     local targ_y = character:display_position_y()

     local x, y, d, current_camera_bearing, h = self:get_camera_position()

     if face_character then
          local targ_bearing = character:bearing()
          local new_camera_bearing = (-math.abs(targ_bearing) + math.pi) * (targ_bearing < 0 and 1 or -1)

          if math.abs(current_camera_bearing) == math.pi and math.abs(current_camera_bearing) == math.abs(new_camera_bearing) then
               new_camera_bearing = current_camera_bearing
          end

          out("curr bearing: " .. current_camera_bearing .. " new bearing: " .. new_camera_bearing)
          current_camera_bearing = new_camera_bearing
     end

     time = time or 1

     -- pan camera to calculated target
     self:scroll_camera_from_current(
          true,
          time,
          { targ_x, targ_y, 7.6, current_camera_bearing, 4.0 }
     )
end

--- @function scroll_camera_to_force
--- @desc Scrolls the camera to the specified military force. The military force is specified by its command queue index (cqi).
--- @p number cqi, CQI of target military force.
--- @p [opt=1] number time, Time in seconds over which to scroll.
function campaign_manager:scroll_camera_to_force(force_cqi, time, face_character)
     if not is_number(force_cqi) then
          script_error("ERROR: scroll_camera_to_force() called but supplied force cqi [" ..
          tostring(force_cqi) .. "] is not a number")
          return false
     end

     local force = self:get_military_force_by_cqi(force_cqi)

     if not force then
          script_error("ERROR: scroll_camera_to_force() called but no force with cqi [" ..
          force_cqi .. "] could be found")
          return false
     end

     cm:scroll_camera_to_character(force:general_character():command_queue_index(), time, face_character)
end

--- @function set_use_cinematic_borders_for_automated_cutscenes
--- @desc Sets whether or not to show cinematic borders when scrolling the camera in an automated cutscene (for example with @campaign_manager:scroll_camera_with_cutscene). By default, cinematic borders are displayed.
--- @p [opt=true] boolean show borders
function campaign_manager:set_use_cinematic_borders_for_automated_cutscenes(value)
     if value == false then
          self.use_cinematic_borders_for_automated_cutscenes = false;
     else
          self.use_cinematic_borders_for_automated_cutscenes = true;
     end;
end;

-- use with care
function campaign_manager:scroll_camera_from_current_with_smoothing(correct_endpoint, ...)
     if not is_boolean(correct_endpoint) then
          script_error("ERROR: scroll_camera_from_current_with_smoothing() called but supplied correct_endpoint flag [" ..
          tostring(correct_endpoint) .. "] is not a boolean value");
          return false;
     end;

     if arg.n == 0 then
          script_error("ERROR: scroll_camera_from_current_with_smoothing() called but no waypoints supplied");
          return false;
     end;

     local max_time = 0;
     local camera_waypoints = {}; -- internal list of waypoints

     local processed_waypoints = {}; -- internal list of processed waypoints i.e. one per second

     -- insert current camera position at start
     local x, y, d, b, h = self:get_camera_position();
     table.insert(camera_waypoints, 1, { x, y, d, b, h, 0 });
     table.insert(processed_waypoints, { x, y, d, b, h });

     -- check supplied waypoints are valid
     for i = 1, arg.n do
          local current_waypoint = arg[i];

          if not self:check_valid_camera_waypoint(current_waypoint) then
               -- error will be returned by the function above
               return false;
          end;

          local current_time = current_waypoint[6];

          if math.floor(current_time) < current_time then
               script_error("WARNING: scroll_camera_from_current_with_smoothing() called but supplied camera waypoint [" ..
               i ..
               "] has a specified time of [" ..
               tostring(current_time) .. "] - only integer values are supported, rounding it down");
               current_time = math.floor(current_time);
          end;

          out("attempting to insert waypoint with time " .. current_time);

          -- insert supplied waypoint into internal list
          local waypoint_inserted = false;
          for j = 1, #camera_waypoints do
               out("\tcomparing against pre-inserted waypoint with time " .. camera_waypoints[j][6]);
               if camera_waypoints[j][6] > current_time then
                    out("\tinserting waypoint");
                    waypoint_inserted = true;
                    table.insert(camera_waypoints, j,
                         { current_waypoint[1], current_waypoint[2], current_waypoint[3], current_waypoint[4],
                              current_waypoint[5], current_time });
               end;
          end;

          if not waypoint_inserted then
               out("inserting waypoint at end");
               table.insert(camera_waypoints,
                    { current_waypoint[1], current_waypoint[2], current_waypoint[3], current_waypoint[4],
                         current_waypoint[5], current_time });
          end;

          if current_time > max_time then
               max_time = current_time;
          end;
     end;

     local current_camera_waypoint_pointer = 1;

     for i = 1, max_time do
          -- check we're not going to overrun the end of our camera_waypoints list
          if current_camera_waypoint_pointer >= #camera_waypoints then
               script_error(
               "ERROR: scroll_camera_from_current_with_smoothing() is going to overrun the end of its camera_waypoints list, how can this be? current camera waypoint pointer is [" ..
               tostring(current_camera_waypoint_pointer) ..
               "], number of unprocessed waypoints is [" ..
               #camera_waypoints ..
               "], current time is [" .. tostring(i) .. "], and max time is [" .. tostring(max_time) .. "]");
               return false;
          end;

          local current_camera_waypoint = camera_waypoints[current_camera_waypoint_pointer];
          local next_camera_waypoint = camera_waypoints[current_camera_waypoint_pointer + 1];

          local current_camera_waypoint_time = current_camera_waypoint[6];
          local next_camera_waypoint_time = next_camera_waypoint[6];

          -- if we're reached the next waypoint, add it directly
          if i == next_camera_waypoint_time then
               table.insert(processed_waypoints,
                    { next_camera_waypoint[1], next_camera_waypoint[2], next_camera_waypoint[3], next_camera_waypoint[4],
                         next_camera_waypoint[5] });
               current_camera_waypoint_pointer = current_camera_waypoint_pointer + 1;
          else
               -- we're midway between two waypoints - calculate the position
               local waypoint_to_add = {};

               for j = 1, 5 do
                    waypoint_to_add[j] = current_camera_waypoint[j] +
                    ((next_camera_waypoint[j] - current_camera_waypoint[j]) * (i - current_camera_waypoint_time)) /
                    (next_camera_waypoint_time - current_camera_waypoint_time)
               end;

               table.insert(processed_waypoints, waypoint_to_add);
          end;
     end;

     out("scroll_camera_from_current_with_smoothing() called");
     out.inc_tab();
     self:scroll_camera_with_direction(correct_endpoint, max_time, unpack(processed_waypoints))
     out.dec_tab();
end;

--- @function position_camera_at_primary_military_force
--- @desc Immediately positions the camera at a position looking at the primary military force for the supplied faction. The faction is specified by key.
--- @p string faction key
function campaign_manager:position_camera_at_primary_military_force(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: position_camera_at_primary_military_force() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     local faction = cm:get_faction(faction_name);

     if not faction then
          script_error("ERROR: position_camera_at_primary_military_force() called but no faction with name [" ..
          faction_name .. "] could be found");
          return false;
     end;

     if not faction:has_faction_leader() then
          script_error(
          "ERROR: position_camera_at_primary_military_force() called but no faction leader could be found for faction [" ..
          faction_name .. "]");
          return false;
     end;

     local faction_leader = faction:faction_leader();
     local x = nil;
     local y = nil;

     if faction_leader:has_military_force() then
          x = faction_leader:display_position_x();
          y = faction_leader:display_position_y();
     else
          local mf_list_item_0 = faction:military_force_list():item_at(0);

          if mf_list_item_0:has_general() then
               local general = mf_list_item_0:general_character();

               x = general:display_position_x();
               y = general:display_position_y();
          else
               script_error(
               "ERROR: position_camera_at_primary_military_force() called but no military force for faction [" ..
               faction_name .. "] could be found on the map");
          end;
     end

     cm:set_camera_position(x, y, 7.6, 0.0, 4.0);
end;

--- @function cindy_playback
--- @desc Starts playback of a cindy scene. This is a wrapper for the @cinematics:cindy_playback function, adding debug output.
--- @p @string filepath, File path to cindy scene, from the working data folder.
--- @p [opt=nil] @number blend in duration, Time in seconds over which the camera will blend into the cindy scene when started.
--- @p [opt=nil] @number blend out duration, Time in seconds over which the camera will blend out of the cindy scene when it ends.
function campaign_manager:cindy_playback(filepath, blend_in_duration, blend_out_duration)
     if not is_string(filepath) then
          script_error("ERROR: cindy_playback() called but supplied file path [" ..
          tostring(filepath) .. "] is not a string");
          return false;
     end;

     if blend_in_duration and not is_number(blend_in_duration) then
          script_error("ERROR: cindy_playback() called but supplied blend in duration [" ..
          tostring(blend_in_duration) .. "] is not a number or nil");
          return false;
     end;

     if blend_out_duration and not is_number(blend_out_duration) then
          script_error("ERROR: cindy_playback() called but supplied blend out duration [" ..
          tostring(blend_out_duration) .. "] is not a number or nil");
          return false;
     end;

     if (blend_in_duration and not blend_out_duration) or (blend_out_duration and not blend_in_duration) then
          script_error("WARNING: cindy_playback() called with blend in duration [" ..
          tostring(blend_in_duration) ..
          "] and blend out duration [" ..
          tostring(blend_out_duration) .. "] specified - both need to be supplied for either to work");
          return false;
     end;

     out("Starting cinematic playback of file: " .. filepath .. ".");
     self.cinematic:cindy_playback(filepath, blend_in_duration, blend_out_duration);
end;

--- @function stop_cindy_playback
--- @desc Stops playback of any currently-playing cindy scene. This is a wrapper for the function of the same name on the <code>cinematic</code> interface, but adds console output.
--- @p boolean clear animation scenes
function campaign_manager:stop_cindy_playback(clear_anim_scenes)
     out("Stopping cinematic playback");
     self.cinematic:stop_cindy_playback(clear_anim_scenes);
end;

--- @function scroll_camera_with_cutscene_to_settlement
--- @desc Scrolls the camera in a cutscene to the specified settlement in a cutscene. The settlement is specified by region key. Cinematic borders will be shown (unless disabled with @campaign_manager:set_use_cinematic_borders_for_automated_cutscenes), the UI hidden, and interaction with the game disabled while the camera is scrolling. The player will be able to skip the cutscene with the ESC key, in which case the camera will jump to the target.
--- @p number time, Time in seconds over which to scroll.
--- @p [opt=nil] function callback, Optional callback to call when the cutscene ends.
--- @p string region key, Key of region containing target settlement.
function campaign_manager:scroll_camera_with_cutscene_to_settlement(t, end_callback, region_key)
     if not is_string(region_key) then
          script_error("ERROR: scroll_camera_with_cutscene_to_settlement() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     local region = cm:get_region(region_key);

     if not region then
          script_error("ERROR: scroll_camera_with_cutscene_to_settlement() called but region with supplied key [" ..
          region_key .. "] could not be found");
          return false;
     end;

     local settlement = region:settlement();

     local targ_x = settlement:display_position_x();
     local targ_y = settlement:display_position_y();

     local x, y, d, b, h = self:get_camera_position();

     -- pan camera to calculated target
     self:scroll_camera_with_cutscene(
          t,
          end_callback,
          { targ_x, targ_y, 7.6, b, 4.0 }
     );
end;

-----------------------------------------------------------------------------
--- @section Camera Position Caching
--- @desc The functions in this section allow the current position of the camera to be cached, and then for a test to be performed later to determine if the camera has moved. This is useful for determining if the player has moved the camera, which would indicate whether it's appropriate or not to scroll the camera via script in certain circumstances.
-----------------------------------------------------------------------------



--- @function get_camera_position_cindy_format
--- @desc Returns camera position and target as it would in battle. Useful for setting cindy cameras.
--- @return @number posx
--- @return @number posy
--- @return @number posz
--- @return @number tarx
--- @return @number tary
--- @return @number tarz
function campaign_manager:get_camera_position_cindy_format()
     return self.game_interface:get_camera_position_cindy_format()
end

--- @function cache_camera_position
--- @desc Caches the current camera position, so that the camera position may be compared to it later to determine if it has moved. An optional name may be specified for this cache entry so that multiple cache entries may be created. If the camera position was previously cached with the supplied cache name then that cache will be overwritten.
--- @p [opt="default"] string cache name
function campaign_manager:cache_camera_position(cache_name)
     if cache_name then
          if not is_string(cache_name) then
               script_error("ERROR: cache_camera_position() called but supplied cache name [" ..
               tostring(cache_name) .. "] is not a string or nil");
               return false;
          end;
     else
          cache_name = "default";
     end;

     local cached_camera_record = {};
     cached_camera_record.x, cached_camera_record.y, cached_camera_record.d, cached_camera_record.b, cached_camera_record.h =
     self:get_camera_position();

     self.cached_camera_records[cache_name] = cached_camera_record;
end;

--- @function cached_camera_position_exists
--- @desc Returns whether a camera position is currently cached for the (optional) supplied cache name.
--- @p [opt="default"] string cache name
--- @return @boolean camera position is cached
function campaign_manager:cached_camera_position_exists(cache_name)
     if cache_name then
          if not is_string(cache_name) then
               script_error("ERROR: cached_camera_position_exists() called but supplied cache name [" ..
               tostring(cache_name) .. "] is not a string or nil");
               return false;
          end;
     else
          cache_name = "default";
     end;

     return not not self.cached_camera_records[cache_name];
end;

--- @function get_cached_camera_position
--- @desc Returns the camera position which was last cached with the optional cache name (the default cache name is <code>"default"</code>). If no camera cache has been set with the specified name then a script error is generated.
--- @p [opt="default"] string cache name
--- @return @number x
--- @return @number y
--- @return @number d
--- @return @number b
--- @return @number h
function campaign_manager:get_cached_camera_position(cache_name)
     if cache_name then
          if not is_string(cache_name) then
               script_error("ERROR: get_cached_camera_position() called but supplied cache name [" ..
               tostring(cache_name) .. "] is not a string or nil");
               return false;
          end;
     else
          cache_name = "default";
     end;

     local cached_camera_record = self.cached_camera_records[cache_name];

     if cached_camera_record then
          return cached_camera_record.x, cached_camera_record.y, cached_camera_record.d, cached_camera_record.b,
              cached_camera_record.h;
     end;
end;

--- @function camera_has_moved_from_cached
--- @desc Compares the current position of the camera to that last cached with the (optional) specified cache name, and returns <code>true</code> if any of the camera co-ordinates have changed by the (optional) supplied distance, or <code>false</code> otherwise. If no camera cache has been set with the specified name then a script error is generated.
--- @p [opt="default"] string cache name
function campaign_manager:camera_has_moved_from_cached(cache_name, distance)
     if cache_name then
          if not is_string(cache_name) then
               script_error("ERROR: camera_has_moved_from_cached() called but supplied cache name [" ..
               tostring(cache_name) .. "] is not a string or nil");
               return false;
          end;
     else
          cache_name = "default";
     end;

     if not distance then
          distance = 1;
     else
          if not is_number(distance) then
               script_error("ERROR: camera_has_moved_from_cached() called but supplied distance [" ..
               distance .. "] is not a positive number or nil");
               return false;
          end;
     end;

     local cached_camera_record = self.cached_camera_records[cache_name];

     if not cached_camera_record then
          script_error("ERROR: camera_has_moved_from_cached() called but no cache with supplied name [" ..
          cache_name .. "] is currently set");
          return false;
     end;

     local x, y, d, b, h = cm:get_camera_position();

     return math.abs(cached_camera_record.x - x) > 1 or
         math.abs(cached_camera_record.y - y) > 1 or
         math.abs(cached_camera_record.d - d) > 1 or
         math.abs(cached_camera_record.b - b) > 1 or
         math.abs(cached_camera_record.h - h) > 1;
end;

--- @function delete_cached_camera_position
--- @desc Removes the cache for the supplied cache name. If no cache name is specified the default cache (cache name <code>"default"</code>) is deleted.
--- @p [opt="default"] string cache name
function campaign_manager:delete_cached_camera_position(cache_name)
     if cache_name then
          if not is_string(cache_name) then
               script_error("ERROR: reset_cached_camera_position() called but supplied cache name [" ..
               tostring(cache_name) .. "] is not a string or nil");
               return false;
          end;
     else
          cache_name = "default";
     end;

     self.cached_camera_records[cache_name] = nil;
end;

----------------------------------------------------------------------------
---	@section Cutscenes and Key Stealing
----------------------------------------------------------------------------


--- @function show_subtitle
--- @desc Shows subtitled text during a cutscene. The text is displayed until @campaign_manager:hide_subtitles is called.
--- @p string text key, Text key. By default, this is supplied as a record key from the <code>scripted_subtitles</code> table. Text from anywhere in the database may be shown, however, by supplying the full localisation key and <code>true</code> for the second argument.
--- @p [opt=false] boolean full text key supplied, Set to true if the fll localised text key was supplied for the first argument in the form [table]_[field]_[key].
--- @p [opt=false] boolean force diplay, Forces subtitle display. Setting this to <code>true</code> overrides the player's preferences on subtitle display.
function campaign_manager:show_subtitle(key, full_key_supplied, should_force)
     if not is_string(key) then
          script_error("ERROR: show_subtitle() called but supplied key [" .. tostring(key) .. "] is not a string");
          return false;
     end;

     -- only proceed if we're forcing the subtitle to play, or if the subtitle preferences setting is on
     if not should_force and not common.subtitles_enabled() then
          return;
     end;

     local full_key;

     if not full_key_supplied then
          full_key = "scripted_subtitles_localised_text_" .. key;
     else
          full_key = key;
     end;

     local localised_text = common.get_localised_string(full_key);

     if not is_string(localised_text) then
          script_error(
          "ERROR: show_subtitle() called but could not find any localised text corresponding with supplied key [" ..
          tostring(key) .. "] in scripted_subtitles table");
          return false;
     end;

     local ui_root = core:get_ui_root();

     out("show_subtitle() called, supplied key is [" .. key .. "] and localised text is [" .. localised_text .. "]");

     -- create the subtitles component if it doesn't already exist
     if not self.subtitles_component_created then
          ui_root:CreateComponent("scripted_subtitles", "UI/Campaign UI/scripted_subtitles");
          self.subtitles_component_created = true;
     end;

     -- find the subtitles component
     local uic_subtitles = find_uicomponent(ui_root, "scripted_subtitles", "text_child");

     if not uic_subtitles then
          script_error("ERROR: show_subtitles() could not find the scripted_subtitles uicomponent");
          return false;
     end;

     -- set the text on it
     uic_subtitles:SetStateText(localised_text, full_key);

     -- make the subtitles component visible if it's not already
     if not self.subtitles_visible then
          uic_subtitles:SetVisible(true);
          uic_subtitles:RegisterTopMost();
          self.subtitles_visible = true;
     end;

     output_uicomponent(uic_subtitles);
end;

--- @function hide_subtitles
--- @desc Hides any subtitles currently displayed with @campaign_manager:show_subtitle.
function campaign_manager:hide_subtitles()
     if self.subtitles_visible then
          -- find the subtitles component
          local uic_subtitles = find_uicomponent(core:get_ui_root(), "scripted_subtitles", "text_child");

          uic_subtitles:RemoveTopMost();
          uic_subtitles:SetVisible(false);
          self.subtitles_visible = false;
     end;
end;

-- internal function that campaign cutscenes call to set global cutscene debug mode
function campaign_manager:set_campaign_cutscene_debug(value)
     if value == false then
          self.is_campaign_cutscene_debug = false;
     else
          self.is_campaign_cutscene_debug = true;
     end;
end;

-- internal function that campaign cutscenes call to query global cutscene debug mode
function campaign_manager:get_campaign_cutscene_debug()
     return self.is_campaign_cutscene_debug;
end;

--- @function set_active_cutscene
--- @desc Sets the active cutscene on the campaign manager, so the campaign manager knows which cutscene (if any) is currently playing. If no campaign cutscene is supplied, then the active cutscene is cleared. This should only be called by the campaign cutscene library and should not be called by client scripts.
--- @p [opt=nil] @campaign_cutscene active cutscene
function campaign_manager:set_active_cutscene(ct)
     if ct then
          if not validate.is_campaigncutscene(ct) then
               return false;
          end;

          if self.active_cutscene then
               script_error("WARNING: set_active_cutscene() called with cutscene [" ..
               ct.name ..
               "] but we already have an active cutscene with name [" ..
               self.active_cutscene.name .. "], how can this be? The active cutscene will be overwritten");
          end;

          self.active_cutscene = ct;
     else
          if not self.active_cutscene then
               script_error(
               "WARNING: set_active_cutscene() called with no cutscene specified to clear the active cutscene, but we don't have an active cutscene? This shouldn't happen.");
          end;

          self.active_cutscene = nil;
     end;
end;

--- @function get_active_cutscene
--- @desc Returns the campaign cutscene currently playing. If no cutscene is currently playing then @nil is returned.
--- @r @campaign_cutscene active cutscene, or @nil if no cutscene is active
function campaign_manager:get_active_cutscene()
     return self.active_cutscene;
end;

--- @function skip_active_cutscene
--- @desc Skips any campaign cutscene currently active.
function campaign_manager:skip_active_cutscene()
     if self.active_cutscene then
          self.active_cutscene:skip();
     end;
end;

--- @function steal_escape_key
--- @desc Steals or releases the escape key. This wraps a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>. While the ESC key is stolen by script, presses of the key will cause <code>OnKeyPressed()</code> to be called which goes on to call @campaign_manager:on_key_press_up.
--- @desc To register a function to call when the escape key is pressed use @campaign_manager:steal_escape_key_with_callback or @campaign_manager:steal_escape_key_and_space_bar_with_callback instead of this function.
--- @p boolean steal
function campaign_manager:steal_escape_key(value)
     if value and not self.escape_key_stolen then
          -- out(" * Stealing ESC key");
          self.escape_key_stolen = true;
          self.game_interface:steal_escape_key(true);
     elseif not value then
          -- out(" * Releasing ESC key");
          self.escape_key_stolen = false;
          self.game_interface:steal_escape_key(false);
     end;
end;

--- @function steal_user_input
--- @desc Steals or releases user input. This wraps a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>. Stealing user input prevents any player interaction with the game (asides from pressing the ESC key).
--- @p boolean steal
function campaign_manager:steal_user_input(value)
     if value and not self.user_input_stolen then
          out(" * Stealing user input");
          self.user_input_stolen = true;
          self.game_interface:steal_user_input(true);
     elseif not value and self.user_input_stolen then
          out(" * Releasing user input");
          self.user_input_stolen = false;
          self.game_interface:steal_user_input(false);
     end;
end;

-- called by the code whenever a key is pressed when input has been stolen
-- input is stolen when steal_user_input() (all keys) or steal_escape_key() (just esc key) are called
function OnKeyPressed(key, is_key_up)
     if is_key_up == true then
          cm:on_key_press_up(key);
     end;
end;

--- @function on_key_press_up
--- @desc Called by the campaign model when a key stolen by steal_user_input or steal_escape_key is pressed. Client scripts should not call this!
--- @p string key pressed
function campaign_manager:on_key_press_up(key)
     -- if anything has stolen this key, then execute the callback on the top of the relevant stack, then remove it
     local key_table = self.stolen_keys[key];
     if is_table(key_table) and #key_table > 0 then
          local entry = key_table[#key_table];
          local callback = entry.callback;
          if not entry.is_persistent then
               table.remove(key_table, #key_table);
          end;
          callback();
     end;
end;

--- @function print_key_steal_entries
--- @desc Debug output of all current stolen key records.
function campaign_manager:print_key_steal_entries()
     out.inc_tab();
     out("*****");
     out("printing key_steal_entries");
     for key, entries in pairs(self.stolen_keys) do
          out("\tkey " .. key);
          for i = 1, #entries do
               local entry = entries[i];
               out("\t\tentry " ..
               i ..
               " name is " ..
               entry.name ..
               ", callback is " .. tostring(entry.callback) .. ", persistent flag is " .. tostring(entry.is_persistent));
          end;
     end;
     out("*****");
     out.dec_tab();
end;

--- @function steal_key_with_callback
--- @desc Steal a key, and register a callback to be called when it's pressed. It will be un-stolen when this occurs. @campaign_manager:steal_user_input will need to be called separately for this mechanism to work, unless it's the escape key that being stolen, where @campaign_manager:steal_escape_key should be used instead. In this latter case @campaign_manager:steal_escape_key_with_callback can be used instead.
--- @p string name, Unique name for this key-steal entry. This can be used later to release the key with @campaign_manager:release_key_with_callback.
--- @p string key, Key name.
--- @p function callback, Function to call when the key is pressed.
--- @p [opt=false] @boolean is persistent, Key should remain stolen after callback is first called.
function campaign_manager:steal_key_with_callback(name, key, callback, is_persistent)
     if not is_string(name) then
          script_error("ERROR: steal_key_with_callback() called but supplied name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_string(key) then
          script_error("ERROR: steal_key_with_callback() called but supplied key [" ..
          tostring(key) .. "] is not a string");
          return false;
     end;

     -- create a table for this key if one doesn't already exist
     if not is_table(self.stolen_keys[key]) then
          self.stolen_keys[key] = {};
     end;

     local key_steal_entries_for_key = self.stolen_keys[key];

     -- don't proceed if a keysteal entry with this name already exists
     for i = 1, #key_steal_entries_for_key do
          if key_steal_entries_for_key[i].name == name then
               script_error("ERROR: steal_key_with_callback() called but a steal entry with supplied name [" ..
               name .. "] already exists for supplied key [" .. tostring(key) .. "]");
               return false;
          end;
     end;

     -- create a key steal entry
     local key_steal_entry = {
          ["name"] = name,
          ["callback"] = callback,
          ["is_persistent"] = not not is_persistent
     };

     -- add this key steal entry at the end of the list
     table.insert(key_steal_entries_for_key, key_steal_entry);

     return true;
end;

--- @function release_key_with_callback
--- @desc Releases a key stolen with @campaign_manager:steal_key_with_callback.
--- @p string name, Unique name for this key-steal entry.
--- @p string key, Key name.
function campaign_manager:release_key_with_callback(name, key)
     if not is_string(name) then
          script_error("ERROR: release_key_with_callback() called but supplied name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_string(key) then
          script_error("ERROR: release_key_with_callback() called but supplied key [" ..
          tostring(key) .. "] is not a string");
          return false;
     end;

     local key_steal_entries_for_key = self.stolen_keys[key];

     if key_steal_entries_for_key then
          for i = 1, #key_steal_entries_for_key do
               if key_steal_entries_for_key[i].name == name then
                    table.remove(key_steal_entries_for_key, i);
                    break;
               end;
          end;
     end;

     return true;
end;

--- @function steal_escape_key_with_callback
--- @desc Steals the escape key and registers a function to call when it is pressed. Unlike @campaign_manager:steal_key_with_callback this automatically calls @campaign_manager:steal_escape_key if the key is not already stolen.
--- @p string name, Unique name for this key-steal entry.
--- @p function callback, Function to call when the key is pressed.
--- @p [opt=false] @boolean is persistent, Key should remain stolen after callback is first called.
function campaign_manager:steal_escape_key_with_callback(name, callback, is_persistent)
     -- attempt to steal the escape key if our attempt to register a callback succeeds
     if self:steal_key_with_callback(name, "ESCAPE", callback, is_persistent) then
          self:steal_escape_key(true);
     end;
end;

--- @function release_escape_key_with_callback
--- @desc Releases the escape key after it's been stolen with @campaign_manager:steal_escape_key_with_callback.
--- @p string name, Unique name for this key-steal entry.
function campaign_manager:release_escape_key_with_callback(name)
     -- attempt to release the escape key if our attempt to unregister a callback succeeds, and if the list of things now listening for the escape key is empty
     if self:release_key_with_callback(name, "ESCAPE") then
          local esc_key_stealers = self.stolen_keys["ESCAPE"];
          if is_table(esc_key_stealers) and #esc_key_stealers == 0 then
               self:steal_escape_key(false);
          end;
     end;
end;

--- @function steal_escape_key_and_space_bar_with_callback
--- @desc Steals the escape key and spacebar and registers a function to call when they are pressed.
--- @p string name, Unique name for this key-steal entry.
--- @p function callback, Function to call when one of the keys are pressed.
--- @p [opt=false] @boolean is persistent, Keys should remain stolen after callback is first called.
function campaign_manager:steal_escape_key_and_space_bar_with_callback(name, callback, is_persistent)
     if self:steal_key_with_callback(name, "SPACE", callback, is_persistent) then
          self:steal_escape_key_with_callback(name, callback, is_persistent);
     end;
end;

--- @function release_escape_key_and_space_bar_with_callback
--- @desc Releases the escape key and spacebar after they've been stolen with @campaign_manager:steal_escape_key_and_space_bar_with_callback.
--- @p string name, Unique name for this key-steal entry
--- @p function callback, Function to call when one of the keys are pressed.
function campaign_manager:release_escape_key_and_space_bar_with_callback(name)
     if self:release_key_with_callback(name, "SPACE", callback) then
          self:release_escape_key_with_callback(name, callback);
     end;
end;

-----------------------------------------------------------------------------
--- @section Advice
-----------------------------------------------------------------------------


--- @function show_advice
--- @desc Displays some advice. The advice to display is specified by <code>advice_thread</code> key.
--- @p string advice key, Advice thread key.
--- @p [opt=false] boolean show progress button, Show progress/close button on the advisor panel.
--- @p [opt=false] boolean highlight progress button, Highlight the progress/close button on the advisor panel.
--- @p [opt=nil] function callback, End callback to call once the advice VO has finished playing.
--- @p [opt=1] number playtime, Minimum playtime for the advice VO in seconds. This must be a positive number. If this is longer than the length of the VO audio, the end callback is not called until after this duration has elapsed. If no end callback is set this has no effect. This is useful during development before recorded VO is ready for simulating the advice being played for a certain duration - with no audio, the advice would complete immediately, or not complete at all.
--- @p [opt=0] number delay, Delay in seconds to wait after the advice has finished before calling the supplied end callback. If no end callback is supplied this has no effect.
function campaign_manager:show_advice(key, progress_button, highlight, callback, playtime, delay)
     if not self.advice_enabled then
          return;
     end;

     if not is_string(key) then
          script_error("ERROR: show_advice() called but supplied key [" .. tostring(key) .. "] is not a string");
          return false;
     end;

     if callback then
          if not is_function(callback) then
               script_error("ERROR: show_advice() called but supplied callback [" ..
               tostring(callback) .. "] is not a function or nil");
               return false;
          end;

          if playtime then
               if not is_number(playtime) then
                    script_error("ERROR: show_advice() called with a callback specified but supplied playtime [" ..
                    tostring(playtime) .. "] is not a number or nil");
                    return false;
               end;

               if playtime <= 0 then
                    script_error(
                    "WARNING: show_advice() called with a callback specified but supplied minimum playtime [" ..
                    playtime .. "] is not a number > 0 - setting it to be one second");
                    playtime = 1;
               end;
          else
               playtime = 1;
          end;

          if delay then
               if (not is_number(delay) or delay < 0) then
                    script_error("ERROR: show_advice() called with a callback specified but supplied delay [" ..
                    tostring(delay) .. "] is not a positive number or nil");
                    return false;
               end;
          else
               delay = 0;
          end;
     end;

     local show_advice_progress_str = "show_advice_progress_on_advice_finished";

     -- If this callback exists at this point then a callback to be called after the previous advice has finished has not yet been called - probably the advice is still playing, but now
     -- we've been told to play another. In this case, call the callback now.
     if self.show_advice_finished_callback then
          local show_advice_finished_callback = self.show_advice_finished_callback;
          self.show_advice_finished_callback = false;
          self:cancel_progress_on_advice_finished("show_advice") -- cancel the end callback, otherwise it will be called twice.
          show_advice_finished_callback();
     end;

     self:remove_callback(show_advice_progress_str);
     self:remove_callback(self.modify_advice_str);
     self:cancel_progress_on_advice_finished("show_advice")

     -- actually show the advice
     if self.next_advice_location then
          local x = self.next_advice_location.x;
          local y = self.next_advice_location.y;
          out("show_advice() called, key is " .. tostring(key) .. ", location is [" .. x .. ", " .. y .. "]");
          common.advance_scripted_advice_thread_located(key, 1, x, y);
          self.next_advice_location = nil;
     else
          out("show_advice() called, key is " .. tostring(key));
          common.advance_scripted_advice_thread(key, 1);
     end;

     get_infotext_manager():notify_of_advice(key);

     -- modify the state of the progress button to what has been specified
     self:modify_advice(progress_button, highlight);

     -- set up a progress_on_advice_finished callback if we should
     if callback then
          -- store this callback, for if show_advice() is called again we should call it then
          self.show_advice_finished_callback = callback;

          -- delay this by a second in case it returns back straight away
          self:callback(
               function()
                    if self.advice_debug then
                         out("show_advice() for key [" ..
                         key ..
                         "] is starting progress_on_advice_finished() monitor as an on-finished callback was specified");
                    end;

                    self:progress_on_advice_finished(
                         "show_advice",
                         function()
                              self.show_advice_finished_callback = false;
                              callback();
                         end,
                         delay,
                         playtime,
                         true
                    );
               end,
               1,
               show_advice_progress_str
          );
     end;
end;

--- @function set_next_advice_location
--- @desc Sets an x/y display location for the next triggered advice. Once that advice has triggered this position will be cleared, meaning further advice will trigger without a location unless this function is called again.
--- @p @number x position, X display position.
--- @p @number y position, Y display position.
function campaign_manager:set_next_advice_location(x, y)
     if not is_number(x) or x <= 0 then
          script_error("ERROR: set_next_advice_location() called but supplied x position [" ..
          tostring(x) .. "] is not a positive number");
          return false;
     end;

     if not is_number(y) or y <= 0 then
          script_error("ERROR: set_next_advice_location() called but supplied y position [" ..
          tostring(y) .. "] is not a positive number");
          return false;
     end;

     self.next_advice_location = { x = x, y = y };
end;

--- @function set_exclusive_visible_labels
--- @desc Sets which factions labels should only be visible.
--- @p faction_keys array of strings, each string represents faction key from the <code>factions</code> table
function campaign_manager:set_exclusive_visible_labels(faction_keys)
     if not is_table(faction_keys) then
          script_error("ERROR: set_exclusive_visible_labels() called but supplied faction_keys [" ..
          tostring(faction_keys) .. "] is not a table");
          return;
     end;
     self.game_interface:set_exclusive_visible_labels(faction_keys);
end;

--- @function set_advice_enabled
--- @desc Enables or disables the advice system.
--- @p [opt=true] boolean enable advice
function campaign_manager:set_advice_enabled(value)
     if value == false then
          --
          -- delaying this call as a workaround for a floating-point error that seems to occur when it's made in the same tick as the LoadingScreenDismissed event
          self:callback(function() self.game_interface:override_ui("disable_advisor_button", true) end, 0.2);
          -- self.game_interface:override_ui("disable_advisor_button", true);

          set_component_active(false, "menu_bar", "button_show_advice");
          self.advice_enabled = false;
     else
          self.game_interface:override_ui("disable_advisor_button", false);
          set_component_active(true, "menu_bar", "button_show_advice");
          self.advice_enabled = true;
     end;
end;

--- @function is_advice_enabled
--- @desc Returns <code>true</code> if the advice system is enabled, or <code>false</code> if it's been disabled with @campaign_manager:set_advice_enabled.
--- @return boolean advice is enabled
function campaign_manager:is_advice_enabled()
     return self.advice_enabled;
end;

--- @function modify_advice
--- @desc Immediately enables or disables the close button that appears on the advisor panel, or causes it to be highlighted.
--- @p [opt=false] boolean show progress button
--- @p [opt=false] boolean highlight progress button
function campaign_manager:modify_advice(show_progress_button, highlight)
     -- if the component doesn't exist yet, wait a little bit as it's probably in the process of being created
     if not find_uicomponent(core:get_ui_root(), "advice_interface") then
          self:callback(function() self:modify_advice(show_progress_button, highlight) end, 0.2, self.modify_advice_str);
          return;
     end;

     self:remove_callback(self.modify_advice_str);

     local progress_buttons_list = get_advisor_progress_buttons();

     show_advisor_progress_buttons(show_progress_button, progress_buttons_list);
     highlight_advisor_progress_button(not not highlight, progress_buttons_list);
end;

--- @function add_pre_dismiss_advice_callback
--- @desc Registers a callback to be called when/immediately before the advice gets dismissed.
--- @p function callback
function campaign_manager:add_pre_dismiss_advice_callback(callback)
     if not is_function(callback) then
          script_error("ERROR: add_pre_dismiss_advice_callback() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     table.insert(self.pre_dismiss_advice_callbacks, callback);
end;

--- @function dismiss_advice
--- @desc Dismisses the advice. Prior to performing the dismissal, this function calls any pre-dismiss callbacks registered with @campaign_manager:add_pre_dismiss_advice_callback. This function gets called internally when the player clicks the script-controlled advice progression button that appears on the advisor panel.
function campaign_manager:dismiss_advice()
     if not core:is_ui_created() then
          script_error("ERROR: dismiss_advice() called but ui not created");
          return false;
     end;

     -- call all pre_dismiss_advice_callbacks
     for i = 1, #self.pre_dismiss_advice_callbacks do
          self.pre_dismiss_advice_callbacks[i]();
     end;

     self.pre_dismiss_advice_callbacks = {};

     -- perform the advice dismissal
     self.game_interface:dismiss_advice();
     self.infotext:clear_infotext();

     -- unhighlight advisor progress button
     highlight_advisor_progress_button(false);
end;

--- @function progress_on_advice_dismissed
--- @desc Registers a function to be called when the advisor is dismissed. Only one such function can be registered at a time.
--- @p @string name, Process name, by which this progress listener may be later cancelled if necessary.
--- @p @function callback, Callback to call.
--- @p [opt=0] @number delay, Delay in seconds after the advisor is dismissed before calling the callback.
--- @p [opt=false] @boolean highlight on finish, Highlight on advice finish. If set to <code>true</code>, this also establishes a listener for the advice VO finishing. When it does finish, this function then highlights the advisor close button.
function campaign_manager:progress_on_advice_dismissed(name, callback, delay, highlight_on_finish)
     if not is_string(name) then
          script_error("ERROR: progress_on_advice_dismissed() called but supplied process name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_function(callback) then
          script_error("ERROR: progress_on_advice_dismissed() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     if not is_number(delay) or delay < 0 then
          delay = 0;
     end;

     local process_name = name .. "_advice_dismissed";

     -- a test to see if the advisor is visible on-screen at this moment
     local advisor_open_test = function()
          local uic_advisor = find_uicomponent(core:get_ui_root(), "advice_interface");
          return self.advice_enabled and uic_advisor and uic_advisor:Visible(true) and
          uic_advisor:CurrentAnimationId() == "";
     end;

     -- a function to set up listeners for the advisor closing
     local progress_func = function()
          local is_dismissed = false;
          local is_highlighted = false;

          core:add_listener(
               process_name,
               "AdviceDismissed",
               true,
               function()
                    is_dismissed = true;

                    if highlight_on_finish then
                         self:cancel_progress_on_advice_finished(process_name);
                    end;

                    -- remove the highlight if it's applied
                    if is_highlighted then
                         self:modify_advice(true, false);
                    end;

                    if delay > 0 then
                         self:callback(callback, delay);
                    else
                         callback();
                    end;
               end,
               false
          );

          -- if the highlight_on_finish flag is set, we highlight the advisor close button when the advice audio finishes playing
          if highlight_on_finish then
               self:progress_on_advice_finished(
                    process_name,
                    function()
                         if not is_dismissed then
                              is_highlighted = true;
                              self:modify_advice(true, true)
                         end;
                    end
               );
          end;
     end;

     -- If the advisor open test passes then set up the progress listener, otherwise wait 0.5 seconds and try it again.
     -- If the advisor fails this test three times (i.e over the course of a second) then automatically progress
     if advisor_open_test() then
          progress_func();
     else
          self:callback(
               function()
                    if advisor_open_test() then
                         progress_func();
                    else
                         self:callback(
                              function()
                                   if advisor_open_test() then
                                        progress_func();
                                   else
                                        if delay > 0 then
                                             self:callback(callback, delay, process_name);
                                        else
                                             callback();
                                        end;
                                   end;
                              end,
                              0.5,
                              process_name
                         );
                    end;
               end,
               0.5,
               process_name
          );
     end;
end;

--- @function cancel_progress_on_advice_dismissed
--- @desc Cancels any running @campaign_manager:progress_on_advice_dismissed process.
--- @p @string name, Name of the progress on advice dismissed process to cancel.
function campaign_manager:cancel_progress_on_advice_dismissed(name)
     if not is_string(name) then
          script_error("ERROR: progress_on_advice_dismissed() called but supplied process name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     local process_name = name .. "_advice_dismissed";

     core:remove_listener(process_name);
     self:remove_callback(process_name);
     self:cancel_progress_on_advice_finished(process_name);
end;

local function progress_on_advice_finished_process_name(name)
     return name .. "_advice_finished";
end;


--- @function progress_on_advice_finished
--- @desc Registers a function to be called when the advisor VO has finished playing and the <code>AdviceFinishedTrigger</code> event is sent from the game to script. If this event is not received after a duration (default 5 seconds) the function starts actively polling whether the advice audio is still playing, and calls the callback when it finds that it isn't.
--- @desc Only one process invoked by this function may be active at a time.
--- @p @string name, Name for this progress on advice finished process, by which it may be later cancelled if necessary.
--- @p @function callback, Callback to call.
--- @p [opt=0] @number delay, Delay in seconds after the advisor finishes to wait before calling the callback.
--- @p [opt=5] @number playtime, Time in seconds to wait before actively polling whether the advice is still playing. The default value is 5 seconds unless overridden with this parameter. This is useful during development as if no audio has yet been recorded, or if no advice is playing for whatever reason, the function would otherwise continue to monitor until the next time advice is triggered, which is probably not desired. The value must be positive.
function campaign_manager:progress_on_advice_finished(name, callback, delay, playtime)
     if not is_string(name) then
          script_error("ERROR: progress_on_advice_finished() called but supplied process name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_function(callback) then
          script_error("ERROR: progress_on_advice_finished() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     if delay and not is_number(delay) then
          script_error("ERROR: progress_on_advice_finished() called but supplied delay [" ..
          tostring(delay) .. "] is not a number or nil");
          return false;
     end;

     if playtime then
          if not is_number(playtime) then
               script_error("ERROR: progress_on_advice_finished() called but supplied playtime [" ..
               tostring(playtime) .. "] is not a number or nil");
               return false;
          end;

          if playtime <= 0 then
               script_error("WARNING: progress_on_advice_finished() called with a playtime [" ..
               tostring(playtime) ..
               "] of 0 or less. The advice playtime must be positive, setting this to the default value of five seconds.")
               playtime = 5;
          end;
     else
          playtime = 5;
     end;

     local process_name = progress_on_advice_finished_process_name(name);

     local call_callback_with_delay = function()
          self:cancel_progress_on_advice_finished(name); -- name rather than process_name, as cancel_progress_on_advice_finished() performs its own conversion

          -- do the given callback
          if is_number(delay) and delay > 0 then
               if self.advice_debug then
                    out("progress_on_advice_finished() - advice audio has finished playing, calling callback after " ..
                    tostring(delay) .. "s");
               end;
               self:callback(
                    function()
                         callback()
                    end,
                    delay,
                    process_name
               );
          else
               if self.advice_debug then
                    out(
                    "progress_on_advice_finished() - advice audio has finished playing, calling callback without delay");
               end;
               callback();
          end;
     end;

     -- if advice is disabled then just finish
     if not self.advice_enabled then
          call_callback_with_delay();
          return;
     end;

     -- Also listen for the advice being dismissed and immediately proceed
     core:add_listener(
          process_name,
          "AdviceDismissed",
          true,
          function()
               call_callback_with_delay();
          end,
          false
     );

     if common.is_advice_audio_playing() then
          if self.advice_debug then
               out(
               "progress_on_advice_finished() called - advice audio is playing, so establishing an AdviceFinishedTrigger event listener to listen for it finishing");
          end;

          -- advice is currently playing
          core:add_listener(
               process_name,
               "AdviceFinishedTrigger",
               true,
               function()
                    call_callback_with_delay();
               end,
               false
          );
     else
          if self.advice_debug then
               out(
               "progress_on_advice_finished() called - no advice audio is currently playing, so will begin to poll advice status after " ..
               playtime .. "s");
          end;
     end;

     -- Begin to poll whether the advice has finished after the minimum playtime has elapsed.
     self:callback(
          function()
               self:progress_on_advice_finished_poll(name, call_callback_with_delay, playtime, 0)
          end,
          playtime,
          process_name
     );
end;

-- used internally by progress_on_advice_finished
function campaign_manager:progress_on_advice_finished_poll(name, callback, playtime, count)
     count = count or 0;

     if common.is_advice_audio_playing() then
          if self.advice_debug then
               out("progress_on_advice_finished() is polling advice - advice audio is currently playing");
          end;
     else
          self:cancel_progress_on_advice_finished(name);

          if self.advice_debug then
               out("progress_on_advice_finished() is progressing as no advice sound is playing after playtime of " ..
               playtime + (count * self.PROGRESS_ON_ADVICE_FINISHED_REPOLL_TIME) .. "s");
          end;

          -- do the given callback - this will be call_callback_with_delay that was set up in progress_on_advice_finished, so no need to wait
          callback();
          return;
     end;

     count = count + 1;

     local process_name = progress_on_advice_finished_process_name(name);

     -- sound is still playing, check again in a bit
     self:callback(
          function()
               self:progress_on_advice_finished_poll(name, callback, playtime, count)
          end,
          self.PROGRESS_ON_ADVICE_FINISHED_REPOLL_TIME,
          process_name
     );
end;

--- @function cancel_progress_on_advice_finished
--- @desc Cancels any running @campaign_manager:progress_on_advice_finished process.
--- @p @string name, Name of the progress on advice finished process to cancel.
function campaign_manager:cancel_progress_on_advice_finished(name)
     if not is_string(name) then
          script_error("ERROR: cancel_progress_on_advice_finished() called but supplied process name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     local process_name = progress_on_advice_finished_process_name(name);

     core:remove_listener(process_name);
     self:remove_callback(process_name);
end;

-----------------------------------------------------------------------------
--- @section Progress on UI Event
-----------------------------------------------------------------------------


--- @function progress_on_panel_dismissed
--- @desc Calls a supplied callback when a panel with the supplied name is closed.
--- @p string unique name, Unique descriptive string name for this process. Multiple <code>progress_on_panel_dismissed</code> monitors may be active at any one time.
--- @p string panel name, Name of the panel.
--- @p function callback, Callback to call.
--- @p [opt=0] number callback delay, Time in seconds to wait after the panel dismissal before calling the supplied callback.
function campaign_manager:progress_on_panel_dismissed(name, panel_name, callback, delay)
     if not is_string(name) then
          script_error("ERROR: progress_on_panel_dismissed() called but supplied name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_string(panel_name) then
          script_error("ERROR: progress_on_panel_dismissed() called but supplied panel name [" ..
          tostring(panel_name) .. "] is not a string");
          return false;
     end;

     if not is_function(callback) then
          script_error("ERROR: progress_on_panel_dismissed() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     delay = delay or 0;

     if not is_number(delay) or delay < 0 then
          script_error("ERROR: progress_on_panel_dismissed() called but supplied delay [" ..
          tostring(delay) .. "] is not a positive number or nil");
          return false;
     end;

     local listener_name = name .. "_progress_on_panel_dismissed";

     if self:get_campaign_ui_manager():is_panel_open(panel_name) then
          core:add_listener(
               listener_name,
               "PanelClosedCampaign",
               function(context)
                    return context.string == panel_name
               end,
               function()
                    if delay == 0 then
                         callback();
                    else
                         self:callback(callback, delay);
                    end;
               end,
               false
          );
     else
          if delay == 0 then
               callback();
          else
               self:callback(callback, delay, listener_name);
          end;
     end;
end;

--- @function cancel_progress_on_panel_dismissed
--- @desc Cancels a monitor started with @campaign_manager:progress_on_panel_dismissed by name.
--- @p string unique name, Unique descriptive string name for this process.
function campaign_manager:cancel_progress_on_panel_dismissed(name)
     local listener_name = name .. "_progress_on_panel_dismissed";

     core:remove_listener(listener_name);
     self:remove_callback(listener_name);
end;

--- @function progress_on_events_dismissed
--- @desc Calls a supplied callback when all events panels are closed. Analagous to calling @campaign_manager:progress_on_panel_dismissed with the panel name "events".
--- @p string unique name, Unique descriptive string name for this process. Multiple <code>progress_on_panel_dismissed</code> monitors may be active at any one time.
--- @p function callback, Callback to call.
--- @p [opt=0] number callback delay, Time in seconds to wait after the panel dismissal before calling the supplied callback.
function campaign_manager:progress_on_events_dismissed(name, callback, delay)
     return self:progress_on_panel_dismissed(name, "events", callback, delay);
end;

--- @function cancel_progress_on_events_dismissed
--- @desc Cancels a monitor started with @campaign_manager:progress_on_events_dismissed (or @campaign_manager:progress_on_panel_dismissed) by name.
--- @p string unique name, Unique descriptive string name for this process.
function campaign_manager:cancel_progress_on_events_dismissed(name)
     return self:cancel_progress_on_panel_dismissed(name);
end;

--- @function progress_on_fullscreen_panel_dismissed
--- @desc Calls the supplied callback when all fullscreen campaign panels are dismissed. Only one such monitor may be active at once - starting a second will cancel the first.
--- @p function callback, Callback to call.
--- @p [opt=0] number callback delay, Time in seconds to wait after the panel dismissal before calling the supplied callback.
function campaign_manager:progress_on_fullscreen_panel_dismissed(callback, delay)
     delay = delay or 0;

     self:cancel_progress_on_fullscreen_panel_dismissed();

     local open_fullscreen_panel = self:get_campaign_ui_manager():get_open_fullscreen_panel();

     if open_fullscreen_panel then
          core:add_listener(
               "progress_on_fullscreen_panel_dismissed",
               "ScriptEventPanelClosedCampaign",
               function(context) return context.string == open_fullscreen_panel end,
               function() self:progress_on_fullscreen_panel_dismissed(callback, delay) end,
               false
          );
     else
          self:callback(callback, delay, "progress_on_fullscreen_panel_dismissed");
     end;
end;

--- @function cancel_progress_on_fullscreen_panel_dismissed
--- @desc Cancels any running monitor started with @campaign_manager:progress_on_fullscreen_panel_dismissed.
--- @p function callback, Callback to call.
--- @p [opt=0] number callback delay, Time in seconds to wait after the panel dismissal before calling the supplied callback.
function campaign_manager:cancel_progress_on_fullscreen_panel_dismissed()
     self:remove_callback("progress_on_fullscreen_panel_dismissed");
     core:remove_listener("progress_on_fullscreen_panel_dismissed");
end;

--- @function start_intro_cutscene_on_loading_screen_dismissed
--- @desc This function provides an easy one-shot method of starting an intro flyby cutscene from a loading screen with a fade effect. Call this function on the first tick (or before), and pass to it a function which starts an intro cutscene.
--- @p function callback, Callback to call.
--- @p [opt=0] number fade in time, Time in seconds over which to fade in the camera from black.
function campaign_manager:start_intro_cutscene_on_loading_screen_dismissed(callback, fade_in_duration)
     if not is_function(callback) then
          script_error("ERROR: start_intro_cutscene_on_loading_screen_dismissed() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     fade_in_duration = fade_in_duration or 1;

     if not is_number(fade_in_duration) or fade_in_duration < 0 then
          script_error(
          "ERROR: start_intro_cutscene_on_loading_screen_dismissed() called but supplied fade in duration [" ..
          tostring(fade_in_duration) .. "] is not a positive number or nil");
          return false;
     end;

     CampaignUI.EnableCinematicMode(true);
     self:fade_scene(0, 0);

     core:progress_on_loading_screen_dismissed(
          function()
               self:fade_scene(1, fade_in_duration);
               callback();
          end
     );
end;

-- progress on mission accepted
-- Old-style mission progression listener, with ui locking. Ideally use progress_on_events_dismissed instead.
function campaign_manager:progress_on_mission_accepted(callback, delay, should_lock)
     if not is_function(callback) then
          script_error("ERROR: progress_on_mission_accepted() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     local uim = self:get_campaign_ui_manager();

     should_lock = not not should_lock;
     self.ui_locked_for_mission = should_lock;

     -- we should lock out elements of the ui so that the player is compelled to accept the mission
     if should_lock then
          uim:lock_ui();
     end;

     local callback_func = function()
          if should_lock then
               uim:unlock_ui();
          end;
          callback();
     end;

     core:add_listener(
          "progress_on_mission_accepted",
          "ScriptEventPanelClosedCampaign",
          function(context) return context.string == "events" or context.string == "quest_details" end,
          function()
               core:remove_listener("progress_on_mission_accepted");

               self.ui_locked_for_mission = false;

               if is_number(delay) and delay > 0 then
                    self:callback(callback_func, delay);
               else
                    callback_func();
               end;
          end,
          false
     );
end;

function campaign_manager:cancel_progress_on_mission_accepted()
     if self.ui_locked_for_mission then
          self:get_campaign_ui_manager():unlock_ui();
     end;

     core:remove_listener("progress_on_mission_accepted");
end;

--- @function progress_on_battle_completed
--- @desc Calls the supplied callback when a battle sequence is fully completed. A battle sequence is completed once the pre or post-battle panel has been dismissed and any subsequent camera animations have finished.
--- @p string name, Unique name for this monitor. Multiple such monitors may be active at once.
--- @p function callback, Callback to call.
--- @p [opt=0] number delay, Delay in ms after the battle sequence is completed before calling the callback.
function campaign_manager:progress_on_battle_completed(name, callback, delay)
     delay = delay or 0;

     if not is_string(name) then
          script_error("ERROR: progress_on_battle_completed() called but supplied name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     if not is_function(callback) then
          script_error("ERROR: progress_on_battle_completed() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     if self:is_processing_battle() then
          core:add_listener(
               "progress_on_battle_completed_" .. name,
               "ScriptEventBattleSequenceCompleted",
               true,
               function(context)
                    self:callback(function() callback() end, delay, "progress_on_battle_completed_" .. name);
               end,
               false
          );
     else
          if delay > 0 then
               self:callback(function() callback() end, delay, "progress_on_battle_completed_" .. name);
          else
               callback();
          end;
     end;
end;

--- @function cancel_progress_on_battle_completed
--- @desc Cancels a running monitor started with @campaign_manager:progress_on_battle_completed by name.
--- @p string name, Name of monitor to cancel.
function campaign_manager:cancel_progress_on_battle_completed(name)
     if not is_string(name) then
          script_error("ERROR: cancel_progress_on_battle_completed() called but supplied name [" ..
          tostring(name) .. "] is not a string");
          return false;
     end;

     core:remove_listener("progress_on_battle_completed_" .. name);
     self:remove_callback("progress_on_battle_completed_" .. name);
end;

--- @function progress_on_camera_movement_finished
--- @desc Calls the supplied callback when the campaign camera is seen to have finished moving. The function has to poll the camera position repeatedly, so the supplied callback will not be called the moment the camera comes to rest due to the model tick resolution.
--- @desc Only one such monitor may be active at once.
--- @p function callback, Callback to call.
--- @p [opt=0] number delay, Delay in ms after the camera finishes moving before calling the callback.
function campaign_manager:progress_on_camera_movement_finished(callback, delay)
     delay = delay or 0;

     if not is_function(callback) then
          script_error("ERROR: progress_on_camera_movement_finished() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     out("progress_on_camera_movement_finished() called");

     local x, y, b, d, h = self:get_camera_position();

     self:repeat_callback(
          function()
               local new_x, new_y, new_b, new_d, new_h = self:get_camera_position();

               -- out("\tcurrent camera pos is [" .. new_x .. ", " .. new_y .. ", " .. new_b .. ", " .. new_d .. ", " .. new_h .. "], cached is [" .. x .. ", " .. y .. ", " .. b .. ", " .. d .. ", " .. h .."]");

               if math.abs(x - new_x) < 0.1 and
                   math.abs(y - new_y) < 0.1 and
                   math.abs(b - new_b) < 0.1 and
                   math.abs(d - new_d) < 0.1 and
                   math.abs(h - new_h) < 0.1 then
                    -- camera pos matches, the camera movement is finished
                    if delay then
                         self:remove_callback("progress_on_camera_movement_finished");
                         self:callback(function() callback() end, delay, "progress_on_camera_movement_finished");
                    else
                         self:remove_callback("progress_on_camera_movement_finished");
                         callback();
                    end;
               else
                    -- camera pos doesn't match
                    x = new_x;
                    y = new_y;
                    b = new_b;
                    d = new_d;
                    h = new_h;
               end
          end,
          0.2,
          "progress_on_camera_movement_finished"
     );
end;

--- @function cancel_progress_on_camera_movement_finished
--- @desc Cancels a running monitor started with @campaign_manager:progress_on_camera_movement_finished.
function campaign_manager:cancel_progress_on_camera_movement_finished()
     self:remove_callback("progress_on_camera_movement_finished");
end;

--- @function progress_on_post_battle_panel_visible
--- @desc Calls the supplied callback when the post-battle panel has finished animating on-screen. The function has to poll the panel state repeatedly, so the supplied callback will not be called the exact moment the panel comes to rest. Don't call this unless you know that the panel is about to animate on, otherwise it will be repeatedly polling in the background!
--- @desc Only one such monitor may be active at once.
--- @p function callback, Callback to call.
--- @p [opt=0] number delay, Delay in ms after the panel finishes moving before calling the callback.
function campaign_manager:progress_on_post_battle_panel_visible(callback, delay)
     local uic_panel = find_uicomponent(core:get_ui_root(), "popup_battle_results", "mid");

     if uic_panel and uic_panel:Visible(true) and is_fully_onscreen(uic_panel) and uic_panel:CurrentAnimationId() == "" then
          if delay and is_number(delay) and delay > 0 then
               self:callback(callback, delay, "progress_on_post_battle_panel_visible");
          else
               callback();
          end;
     else
          self:callback(
               function()
                    self:progress_on_post_battle_panel_visible(callback, delay)
               end,
               0.2,
               "progress_on_post_battle_panel_visible"
          );
     end;
end;

--- @function cancel_progress_on_post_battle_panel_visible
--- @desc Cancels a running monitor started with @campaign_manager:progress_on_post_battle_panel_visible.
function campaign_manager:cancel_progress_on_post_battle_panel_visible()
     self:remove_callback("progress_on_post_battle_panel_visible");
end;

-----------------------------------------------------------------------------
--- @section Progress on UI Trigger
-----------------------------------------------------------------------------


-- Start the listening process associated with progress_on_all_clients_ui_triggered. We start this from script start so that each machine picks up UITrigger events even before progress_on_all_clients_ui_triggered() is called.
function campaign_manager:start_progress_on_all_clients_ui_triggered_monitor()
     local progress_on_all_clients_ui_triggers = self.progress_on_all_clients_ui_triggers;
     local prefix_str = "progress_on_all_clients_";
     local prefix_str_length = string.len(prefix_str);

     core:add_listener(
          "progress_on_all_clients_ui_trigger",
          "UITrigger",
          function(context)
               return string.find(context:trigger(), prefix_str);
          end,
          function(context)
               -- Clip the prefix from the start of the trigger name
               local trigger_name = string.sub(context:trigger(), prefix_str_length + 1);

               -- If we have no record of this trigger then create one - this will happen if the UITrigger on a remote machine happens before the listener is established on the local machine
               if not progress_on_all_clients_ui_triggers[trigger_name] then
                    progress_on_all_clients_ui_triggers[trigger_name] = {};
               end;

               -- Lookup the faction that triggered the event
               local faction = cm:model():faction_for_command_queue_index(context:faction_cqi());
               if not faction:is_null_interface() then
                    local faction_name = faction:name();

                    local trigger_record = progress_on_all_clients_ui_triggers[trigger_name];

                    if not trigger_record[faction_name] then
                         -- Record this faction as having sent its event
                         trigger_record[faction_name] = true;

                         -- Increase the count
                         local count = trigger_record.count or 0;
                         count = count + 1;
                         trigger_record.count = count;

                         local human_factions = cm:get_human_factions();

                         local total = #human_factions;
                         if count >= total then
                              -- Take a local copy of the callback, clear this UITrigger record, produce some output and call the callback
                              local callback = trigger_record.callback;

                              if not callback then
                                   script_error(
                                   "ERROR: progress_on_all_clients_ui_triggered() has received ui trigger [" ..
                                   count ..
                                   "/" ..
                                   total ..
                                   "] for trigger [" ..
                                   trigger_name ..
                                   "] from faction [" ..
                                   faction_name ..
                                   "] but no progression callback is set up - how can this be? Expect a desync");
                                   return;
                              end;

                              self.progress_on_all_clients_ui_triggers[trigger_name] = nil;
                              out("# progress_on_all_clients_ui_triggered() has received ui trigger [" ..
                              count ..
                              "/" ..
                              total ..
                              "] for trigger [" ..
                              trigger_name .. "] from faction [" .. faction_name .. "], calling progression callback");
                              callback();
                         else
                              out("# progress_on_all_clients_ui_triggered() has received ui trigger [" ..
                              count ..
                              "/" ..
                              total .. "] for trigger [" .. trigger_name .. "] from faction [" .. faction_name .. "]");
                         end;
                    end;
               end;
          end,
          true
     );
end;

--- @function progress_on_all_clients_ui_triggered
--- @desc This function uses @CampaignUI:TriggerCampaignScriptEvent to trigger a UI event over the network which all clients receive. Once the event has been received from all clients then the progress callback is called. This can be used to progress the script in a synchronous manner in a multiplayer game only once an inherently-asynchronous event has been received. For example, a cutscene shown on multiple machines at once could be skipped on one machine and not another - progress_on_all_clients_ui_triggered can be used in this situation to only progress on all machines onces the cutscene has finished on all machines.
--- @desc The listening process associated with this function begins when the script is started, so it will pick up relevant events generated by <code>progress_on_all_clients_ui_triggered()</code> calls on remote machines even before <code>progress_on_all_clients_ui_triggered()</code> is called on this machine.
--- @p @string name, Name for this process by which it may optionally be cancelled.
--- @p @function callback, Progression callback.
--- @example -- play a cutscene in multiplayer and proceed when it's finished on all clients
--- @example
--- @example local cutscene_name = "example_cutscene"
--- @example local c = campaign_cutscene:new_from_cindyscene(
--- @example 	cutscene_name,									-- name for cutscene
--- @example	"path/to/cindy_scene.CindySceneManager,			-- cindyscene
---	@example	function()										-- end callback
--- @example		cm:progress_on_ui_trigger(
--- @example			cutscene_name,
--- @example			function()
--- @example				out("Cutscene has finished on all clients, progressing...")
--- @example			end
--- @example		)
--- @example	end
--- @example )
function campaign_manager:progress_on_all_clients_ui_triggered(trigger_name, callback)
     if not validate.is_string(trigger_name) then
          return false;
     end;

     if not validate.is_function(callback) then
          return false;
     end;

     -- Immediately call the callback if this is a singleplayer game
     if not self:is_multiplayer() then
          callback();
          return;
     end;

     -- Get the local faction, grabbing the main parent faction if the local faction is auxiliary
     local local_faction = cm:get_local_faction(true);

     if not local_faction then
          script_error(
          "WARNING: progress_on_all_clients_ui_triggered() called but no local faction found, is this an autorun? Immediately calling the callback");
          callback();
          return;
     end;

     -- Set up a record for this trigger name if one does not already exist
     if not self.progress_on_all_clients_ui_triggers[trigger_name] then
          self.progress_on_all_clients_ui_triggers[trigger_name] = {};
     end;

     -- Register a callback for this trigger name
     self.progress_on_all_clients_ui_triggers[trigger_name].callback = callback;

     local local_faction_cqi = local_faction:command_queue_index();

     out("");
     out("# progress_on_all_clients_ui_triggered() called with trigger name [" ..
     trigger_name ..
     "] on machine with local faction [" .. local_faction:name() .. "] (cqi: " .. local_faction_cqi .. ")");
     out("");

     -- Trigger a UITrigger event over the network, which the monitor in start_progress_on_all_clients_ui_triggered_monitor() will receive
     CampaignUI.TriggerCampaignScriptEvent(local_faction_cqi, "progress_on_all_clients_" .. trigger_name);
end;

-----------------------------------------------------------------------------
--- @section Multiplayer Queries
--- @desc The function @campaign_manager:progress_on_mp_query can be used to query information that is only available to the script on one machine, and have the result of that sent across the network to all machines.
-----------------------------------------------------------------------------


local valid_mp_query_cmds_indexed = {
     "all_advice_strings_seen",
     "any_advice_strings_seen",
}
local valid_mp_query_cmds_lookup = table.indexed_to_lookup(valid_mp_query_cmds_indexed);


function campaign_manager:start_mp_query_listener()
     core:add_listener(
          "mp_query_listener",
          "UITrigger",
          function(context)
               return string.sub(context:trigger(), 1, 4) == "mpq:";
          end,
          function(context)
               local query_str_with_result = context:trigger();

               local result_separator = string.find(query_str_with_result, "::");
               if not result_separator then
                    script_error(
                    "WARNING: mp query event received but could not find result separator? Query string is " ..
                    tostring(query_str_with_result));
                    return false;
               end;

               local result = string.sub(query_str_with_result, result_separator + 2);
               local query_str = string.sub(query_str_with_result, 1, result_separator - 1);

               local callback = self.mp_queries[query_str];
               if not callback then
                    script_error(
                    "WARNING: mp query event received but no record for it could be found. How can this be? Query string is " ..
                    tostring(query_str_with_result));
                    return false;
               end;

               self.mp_queries[query_str] = nil;

               if result == "true" then
                    callback(true);
               elseif result == "false" then
                    callback(false);
               else
                    local result_as_number = tonumber(result);
                    if result_as_number then
                         callback(result_as_number);
                    else
                         callback(result);
                    end;
               end;
          end,
          true
     )
end;

--- @function progress_on_mp_query
--- @desc Calls the supplied callback when the result of a multiplayer query is received from the network. Multiplayer queries allow the scripts on all machines in a multiplayer game to query information that normally on the script on one machine would have access to, such as advice history or the state of the UI.
--- @desc With each multiplayer query a faction key and some optional query data is specified. The query is run on the machine where the local player's faction matches the faction specified with the query. The results of the query are then broadcast with @CampaignUI:TriggerCampaignScriptEvent for all machines in the multiplayer game to receive.
--- @desc A number of multiplayer queries are supported:
--- @desc <table class="simple"><tr><th>Command</th><th>Description</th></tr>
--- @desc <td><code>all_advice_strings_seen</code></td><td>Returns true if all the specified advice strings have been seen on the machine where the local player's faction matches the faction specified with the query. The query data should be a table containing a list of advice strings. The result of the query will be a boolean value.</td></tr>
--- @desc <tr><td><code>any_advice_strings_seen</code></td><td>Returns true if any of the specified advice strings have been seen on the machine where the local player's faction matches the faction specified with the query. The query data should be a table containing a list of advice strings. The result of the query will be a boolean value.</td></tr>
--- @desc <tr><td><code>get_open_blocking_panel</code></td><td>Returns the result of calling @campaign_ui_manager:get_open_fullscreen_panel on the machine where the local player's faction matches the faction specified with the query. No query data is specified with this query. The result of the query will be a string panel name, or <code>false</code> if no panel is open.</td></tr></table>
--- @desc When the query is completed, the function will be called on all machines with the result of the query supplied as a single argument.
--- @p @string query command, Query command to run. See documentation above for a supported list of query commands.
--- @p @string faction key, Faction key, from the <code>factions</code> database table. The query is run on the machine where the local player's faction matches this key.
--- @p [opt=nil] @table query data, Data required to perform the query. This can be in different forms for different queries, but is often a @table.
--- @p @function callback, Callback that is called when the query is completed. The result of the query will be passed to the callback as a single argument.
function campaign_manager:progress_on_mp_query(query_cmd, faction_key, query_data, callback)
     if not validate.is_string(query_cmd) then
          return false;
     end;

     if not valid_mp_query_cmds_lookup[query_cmd] then
          script_error("ERROR: progress_on_mp_query() called but supplied query id [" ..
          tostring(query_cmd) ..
          "] is not recognised. Valid query ids are [" .. table.concat(valid_mp_query_cmds_indexed, ", ") .. "]");
          return false;
     end;

     if not validate.is_string(faction_key) then
          return false;
     end;

     local faction = self:get_faction(faction_key);
     if not faction then
          script_error("ERROR: progress_on_mp_query() called but no faction with supplied faction key [" ..
          faction_key .. "] could be found");
          return false;
     end;

     if not faction:is_human() then
          script_error("ERROR: progress_on_mp_query() called but faction with supplied faction key [" ..
          faction_key .. "] is not human-controlled");
          return false;
     end;

     local query_id = self.mp_query_count;
     self.mp_query_count = self.mp_query_count + 1;

     if query_cmd == "all_advice_strings_seen" then
          if query_data and not validate.is_table(query_data) then
               return false;
          end;

          local query_str = "mpq:" ..
          query_cmd .. ":" .. faction_key .. ":" .. query_id .. ":" .. table.concat(query_data, ",");
          self.mp_queries[query_str] = callback;

          if faction_key == cm:get_local_faction_name(true) then
               local result = true;
               for i = 1, #query_data do
                    if not common.get_advice_history_string_seen(query_data[i]) then
                         result = false;
                         break;
                    end;
               end;

               CampaignUI.TriggerCampaignScriptEvent(0, query_str .. "::" .. tostring(result));
          end;
     elseif query_cmd == "any_advice_strings_seen" then
          if query_data and not validate.is_table(query_data) then
               return false;
          end;

          local query_str = "mpq:" ..
          query_cmd .. ":" .. faction_key .. ":" .. query_id .. ":" .. table.concat(query_data, ",");
          self.mp_queries[query_str] = callback;

          if faction_key == cm:get_local_faction_name(true) then
               local result = false;
               for i = 1, #query_data do
                    if common.get_advice_history_string_seen(query_data[i]) then
                         result = true;
                         break;
                    end;
               end;

               CampaignUI.TriggerCampaignScriptEvent(0, query_str .. "::" .. tostring(result));
          end;
     elseif query_cmd == "get_open_blocking_panel" then
          local query_str = "mpq:" .. query_cmd .. ":" .. faction_key .. ":" .. query_id;
          self.mp_queries[query_str] = callback;

          if faction_key == cm:get_local_faction_name(true) then
               local result = cuim:get_open_fullscreen_panel();

               CampaignUI.TriggerCampaignScriptEvent(0, query_str .. "::" .. tostring(result));
          end;
     end;
end;

-----------------------------------------------------------------------------
--- @section Character Locomotion Wrappers
--- @desc It can traditionally be tricky to get characters locomotion orders such as @episodic_scripting:move_to and @episodic_scripting:attack to work reliably. Locomotion orders require several conditions to be true before they will work successfully, such as it being the locomoting character's faction's turn and for the turn to be in the correct (normal) phase.
--- @desc The locomotion orders listed in this section all run through some central functionality that performs pre and post-locomotion checks to catch and either bypass or report any possible errors. If a movement order is issued before the normal turn phase (as is the case at the moment when the <code>FactionTurnStarts</code> event is triggered), the order will be delayed until the normal turn phase starts, for example.
-----------------------------------------------------------------------------


--- @function enable_locomotion_failed_warning
--- @desc Enables or disables the script error that appears by default when a character locomotion order such as @campaign_manager:move_to or @campaign_manager:attack fails for some reason. This script error can be suppressed globally for all locomotion orders by calling this function with <code>false</code> as an argument.
--- @p [opt=true] @boolean enable warning
function campaign_manager:enable_locomotion_failed_warning(enable)
     if enable == false then
          self.locomotion_failed_warning_enabled = false;
     else
          self.locomotion_failed_warning_enabled = true;
     end;
end;

-- Final step to perform a locomotion order
local function perform_locomotion_order_final(locomoting_character_str, faction_name, order_type, callback)
     cm:enable_movement_for_character(locomoting_character_str);

     local success = callback();
     if cm.locomotion_failed_warning_enabled and not success then
          script_error("WARNING: perform_locomotion_order() attempted to perform an order of type " ..
          order_type ..
          " with character with string id [" ..
          locomoting_character_str .. "] for faction [" .. faction_name .. "] but the order failed for some reason");
     end;
     return success;
end;


-- Attempt to perform a locomotion order. We look up the character from its char str (which is wasteful but locomotion orders through script don't happen often), check that it's the
-- correct faction's turn, and also check that we're in normal turn phase. If we're not in normal turn phase then it's likely the order is ultimately coming from a FactionTurnStart
-- event, where the game is in the "siege updates" turn phase and not yet in the "normal" turn phase where locomotion orders can succeed. If we're not in the normal turn phase, then
-- a FactionBeginTurnPhaseNormal listener is set up and the order re-issued when this is received. A failsafe FactionTurnEnd listener aborts the process if the faction turn is ended.
local function perform_locomotion_order(locomoting_character_str, order_type, callback)
     if not is_string(locomoting_character_str) then
          script_error("WARNING: attempting to perform a [" ..
          order_type ..
          "] locomotion order but supplied character identifier [" ..
          tostring(locomoting_character_str) .. "] is not a lookup string");
          return false;
     end;

     local character = cm:get_character(locomoting_character_str);
     if not character then
          script_error("WARNING: attempting to perform a [" ..
          order_type ..
          "] locomotion order but no supplied character identifier [" ..
          tostring(locomoting_character_str) .. "] did not specify a character");
          return false;
     end;

     local character_cqi = character:command_queue_index();
     local faction_name = character:faction():name();
     local whose_turn_it_is = cm:whose_turn_is_it();

     if whose_turn_it_is ~= faction_name then
          script_error("WARNING: attempting to perform a [" ..
          order_type ..
          "] locomotion order but it is not the turn of faction [" ..
          faction_name ..
          "] to which the locomoting character belongs, instead it is the turn of [" ..
          whose_turn_it_is .. "]. No order will be attempted.");
          return false;
     end;

     local success = true;

     if cm:model():world():is_turn_phase_normal() then
          -- Call the callback and error if it doesn't succeed
          success = perform_locomotion_order_final(locomoting_character_str, faction_name, order_type, callback);
     else
          local unique_id = order_type .. "_" .. core:get_unique_counter();

          out("\tgame is not in normal turn phase, establishing listener to wait for it to be. Unique id is " ..
          unique_id);

          -- We are not in the "normal turn phase" so cannot issue locomotion orders yet - listen for this faction entering it
          core:add_listener(
               unique_id,
               "FactionBeginTurnPhaseNormal",
               function(context)
                    return context:faction():name() == faction_name;
               end,
               function()
                    core:remove_listener(unique_id);
                    out("\tnormal turn phase entered, performing locomotion callback with unique id " .. unique_id);

                    -- Call the callback and error if it doesn't succeed
                    perform_locomotion_order_final(locomoting_character_str, faction_name, order_type, callback);
               end,
               false
          );

          -- Also listen for this (or any) faction ending the turn - abort the process if this happens
          core:add_listener(
               unique_id,
               "FactionTurnEnd",
               true,
               function()
                    core:remove_listener(unique_id);
                    script_error("WARNING: locomotion order with unique id " ..
                    unique_id ..
                    " enqueued for faction [" ..
                    faction_name .. "] but a FactionTurnEnd event has been received - cancelling this locomotion order");
               end,
               false
          );
     end;

     return success;
end;


--- @function attack
--- @desc Instructs a character heading a military force to attack another. This function wraps the episodic scripting function @episodic_scripting:attack.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string attacker, Attacker character string - see @"episodic_scripting:Character Lookups".
--- @p @string defender, Defender character string - see @"episodic_scripting:Character Lookups".
--- @p [opt=false] @boolean lay siege, Instructs the attacker to lay siege to the garrison of the target character.
--- @r @boolean command succeeded
function campaign_manager:attack(attacker, defender, lay_siege)
     if not validate.is_string(attacker) or not validate.is_string(defender) then
          return false;
     end;

     out("[LOCOMOTION] attack() is sending [" ..
     tostring(attacker) .. "] to " .. (lay_siege and "lay siege to [" or "attack [") .. tostring(defender) .. "]");

     return perform_locomotion_order(
          attacker,
          "attack",
          function()
               return self.game_interface:attack(attacker, defender, lay_siege or false);
          end
     );
end;

--- @function attack_queued
--- @desc Instructs a character heading a military force to attack another with a queued order. This function wraps the episodic scripting function @episodic_scripting:attack_queued.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string attacker, Attacker character string - see @"episodic_scripting:Character Lookups".
--- @p @string defender, Defender character string - see @"episodic_scripting:Character Lookups".
--- @p [opt=nil] @boolean lay siege, Instructs the attacker to lay siege to the garrison of the target character.
--- @r @boolean command succeeded
function campaign_manager:attack_queued(attacker, defender, lay_siege)
     if not validate.is_string(attacker) or not validate.is_string(defender) then
          return false;
     end;

     out("[LOCOMOTION] attack_queued() is sending [" ..
     tostring(attacker) .. "] to " .. (lay_siege and "lay siege to [" or "attack [") .. tostring(defender) .. "]");

     return perform_locomotion_order(
          attacker,
          "attack_queued",
          function()
               return self.game_interface:attack_queued(attacker, defender, lay_siege or false);
          end
     );
end;

--- @function attack_region
--- @desc Instructs a character heading a military force to attack a region. This function wraps the episodic scripting function @episodic_scripting:attack_region.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string attacker, Attacker character string - see @"episodic_scripting:Character Lookups".
--- @p @string region name, Target region name, from the <code>campaign_map_regions</code> database table.
--- @p [opt=true] @boolean should_attack_immediately, Specify if the command should besiege the settlement or start the battle immediately.
--- @r @boolean command succeeded
function campaign_manager:attack_region(attacker, region_name, should_attack_immediately)
     if not validate.is_string(attacker) or not validate.is_string(region_name) then
          return false;
     end;

     if should_attack_immediately ~= false then
          should_attack_immediately = true
     end

     out("[LOCOMOTION] attack_region() is sending [" ..
     tostring(attacker) .. "] to attack region [" .. region_name .. "]");

     return perform_locomotion_order(
          attacker,
          "attack_region",
          function()
               return self.game_interface:attack_region(attacker, region_name, should_attack_immediately);
          end
     );
end;

--- @function attack_garrison_by_cqi
--- @desc Instructs a character leading a military force to attack a garrison residence, specified by cqi. This function wraps the episodic scripting function @episodic_scripting:attack_garrison_by_cqi.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string attacker, Attacker character string - see @"episodic_scripting:Character Lookups".
--- @p @number garrison cqi, Garrison residence cqi.
--- @p [opt=true] @boolean should_attack_immediately, Specify if the garrison should be besieged or attacked immediately. Note that if siege equipment is required and you don't have any, the game will soft lock
--- @r @boolean command succeeded
function campaign_manager:attack_garrison_by_cqi(attacker, garrison_residence_cqi, should_attack_immediately)
     if not validate.is_string(attacker) or not validate.is_number(garrison_residence_cqi) then
          return false;
     end;

     if should_attack_immediately ~= false then
          should_attack_immediately = true
     end

     out("[LOCOMOTION] attack_garrison_by_cqi() is sending [" ..
     tostring(attacker) .. "] to attack garrison residence with cqi [" .. garrison_residence_cqi .. "]");

     return perform_locomotion_order(
          attacker,
          "attack_garrison_by_cqi",
          function()
               return self.game_interface:attack_garrison_by_cqi(attacker, garrison_residence_cqi,
                    should_attack_immediately);
          end
     );
end;

--- @function seek_exchange
--- @desc Instructs a character at the head of a military force to seek to exchange forces with another. This function wraps the episodic scripting function @episodic_scripting:seek_exchange.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string exchanging character, Exchanging character string - see @"episodic_scripting:Character Lookups".
--- @p @string target character, Target character string - see @"episodic_scripting:Character Lookups".
--- @p @boolean show ui, Show the exchange UI or not.
--- @r @boolean command succeeded
function campaign_manager:seek_exchange(exchanging_char_str, target_char_str, show_ui)
     if not validate.is_string(exchanging_char_str) or not validate.is_number(target_char_str) then
          return false;
     end;

     show_ui = not not show_ui;

     out("[LOCOMOTION] seek_exchange() is sending character [" ..
     exchanging_char_str ..
     "] to seek an exchange with character [" ..
     target_char_str .. "], the exchange ui will " .. (show_ui and "be shown" or "not be shown"));

     return perform_locomotion_order(
          exchanging_char_str,
          "seek_exchange",
          function()
               return self.game_interface:seek_exchange(exchanging_char_str, target_char_str, show_ui);
          end
     );
end;

--- @function move_to
--- @desc Instructs a character to move to a specified location. This function wraps the episodic scripting function @episodic_scripting:move_to.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string moving character, Moving character string - see @"episodic_scripting:Character Lookups".
--- @p @number x, Logical x co-ordinate of target position.
--- @p @number y, Logical y co-ordinate of target position.
--- @r @boolean command succeeded
function campaign_manager:move_to(moving_char_str, x, y)
     if not validate.is_string(moving_char_str) or not validate.is_number(x) or not validate.is_number(y) then
          return false;
     end;

     out("[LOCOMOTION] move_to() is moving character [" .. moving_char_str .. "] to position [" .. x .. ", " .. y .. "]");

     return perform_locomotion_order(
          moving_char_str,
          "move_to",
          function()
               return self.game_interface:move_to(moving_char_str, x, y);
          end
     );
end;

--- @function move_to_queued
--- @desc Instructs a character to move to a specified location with a queued action. This function wraps the episodic scripting function @episodic_scripting:move_to_queued.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string moving character, Moving character string - see @"episodic_scripting:Character Lookups".
--- @p @number x, Logical x co-ordinate of target position.
--- @p @number y, Logical y co-ordinate of target position.
--- @r @boolean command succeeded
function campaign_manager:move_to_queued(moving_char_str, x, y)
     if not validate.is_string(moving_char_str) or not validate.is_number(x) or not validate.is_number(y) then
          return false;
     end;

     out("[LOCOMOTION] move_to_queued() is moving character [" ..
     moving_char_str .. "] to position [" .. x .. ", " .. y .. "]");

     return perform_locomotion_order(
          moving_char_str,
          "move_to_queued",
          function()
               return self.game_interface:move_to_queued(moving_char_str, x, y);
          end
     );
end;

--- @function teleport_to
--- @desc Teleports a character to a logical position on the campaign map. This function wraps the episodic scripting function @episodic_scripting:teleport_to.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @desc This function can also reposition the camera, so it's best used on game creation to move characters around at the start of the campaign, rather than on the first tick or later.
--- @p @string teleporting character, Teleporting character string - see @"episodic_scripting:Character Lookups".
--- @p @number x, Logical x co-ordinate to teleport to.
--- @p @number y, Logical y co-ordinate to teleport to.
--- @r @boolean command succeeded
function campaign_manager:teleport_to(char_str, x, y)
     if not validate.is_string(char_str) or not validate.is_number(x) or not validate.is_number(y) then
          return false;
     end;

     out("[LOCOMOTION] teleport_to() is teleporting character [" ..
     char_str .. "] to position [" .. x .. ", " .. y .. "]");

     return perform_locomotion_order(
          char_str,
          "teleport_to",
          function()
               return self.game_interface:teleport_to(char_str, x, y);
          end
     );
end;

--- @function join_garrison
--- @desc Instructs a character leading a military force to join a garrison, specified by settlement key. This function wraps the episodic scripting function @episodic_scripting:join_garrison.
--- @desc This wrapper function will perform certain checks before issuing the order - see the documentation on @"campaign_manager:Character Locomotion Wrappers" for more information.
--- @p @string character string, Character string of character to teleport. This uses the standard character string lookup system.
--- @p @string garrison string, String of target garrison, from the <code>campaign_map_settlements</code> database table.
--- @r @boolean command succeeded
function campaign_manager:join_garrison(char_str, garrison_str)
     if not validate.is_string(char_str) or not validate.is_string(garrison_str) then
          return false;
     end;

     out("[LOCOMOTION] join_garrison() is sending character [" ..
     char_str .. "] to join garrison [" .. garrison_str .. "]");

     return perform_locomotion_order(
          char_str,
          "join_garrison",
          function()
               return self.game_interface:join_garrison(char_str, garrison_str);
          end
     );
end;

-----------------------------------------------------------------------------
--- @section Character Creation and Manipulation
-----------------------------------------------------------------------------


--- @function create_force
--- @desc Wrapper for create_force function on the underlying <a href="../../scripting_doc.html">game interface</a>, which instantly spawns an army with a general on the campaign map. This wrapper function adds debug output and success callback functionality.
--- @p string faction key, Faction key of the faction to which the force is to belong.
--- @p string unit list, Comma-separated list of keys from the <code>land_units</code> table. The force will be created with these units.
--- @p string region key, Region key of home region for this force.
--- @p number x, x logical co-ordinate of force.
--- @p number y, y logical co-ordinate of force.
--- @p boolean exclude named characters, Don't spawn a named character at the head of this force.
--- @p [opt=nil] function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @r @boolean force created
--- @example cm:create_force(
--- @example 	"troy_main_dan_apteron",
--- @example 	"troy_club_warriors,troy_club_warriors,troy_club_warriors,",
--- @example 	"troy_main_zonaea_aenos",
--- @example 	714,
--- @example 	353,
--- @example 	"scripted_force_1",
--- @example 	true,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_force(faction_key, unit_list, region_key, x, y, exclude_named_characters,
                                       success_callback)
     if not is_string(faction_key) then
          script_error("ERROR: create_force() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(unit_list) then
          script_error("ERROR: create_force() called but supplied unit list [" ..
          tostring(unit_list) .. "] is not a string");
          return;
     end;

     if unit_list == "" then
          script_error("ERROR: create_force() called but supplied unit list [" ..
          tostring(unit_list) .. "] is an empty string");
          return;
     end;

     if not is_string(region_key) then
          script_error("ERROR: create_force() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_boolean(exclude_named_characters) then
          script_error("ERROR: create_force() called but supplied exclude named characters switch [" ..
          tostring(exclude_named_characters) .. "] is not a boolean value");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local region = cm:get_region(region_key);
     if not is_region(region) then
          script_error("ERROR: create_force() called but supplied region key [" ..
          tostring(region_key) .. "] is not a valid region");
     end;

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());

     local listener_name = "campaign_manager_create_force_" .. id;

     -- establish a listener for the force being created
     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context)
               return context.string == id;
          end,
          function(context) self:force_created(id, listener_name, context:character(), success_callback) end,
          false
     );

     out("create_force() called:");
     out.inc_tab();

     out("faction_key: " .. faction_key);
     out("unit_list: " .. unit_list);
     out("region_key: " .. region_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("id: " .. id);
     out("exclude_named_characters: " .. tostring(exclude_named_characters));

     out.dec_tab();

     -- make the call to create the force
     return self.game_interface:create_force(faction_key, unit_list, region_key, x, y, id, exclude_named_characters);
end;

--- @function create_force_with_full_diplomatic_discovery
--- @desc Instantly spawn an army with a general on the campaign map. This function is a wrapper for the @episodic_scripting:create_force_with_full_diplomatic_discovery function provided by the episodic scripting interface, adding debug output and success callback functionality.
--- @p @string faction key, Faction key of the faction to which the force is to belong.
--- @p @string unit list, Comma-separated list of keys from the <code>land_units</code> table. The force will be created with these units.
--- @p @string region key, Region key of home region for this force.
--- @p @number x, x logical co-ordinate of force.
--- @p @number y, y logical co-ordinate of force.
--- @p @boolean exclude named characters, Don't spawn a named character at the head of this force.
--- @p [opt=nil] @function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @p [opt=false] @boolean surpress_ui_messages, Surpress ui messages and statistics upgrade
--- @r @boolean force created
--- @example cm:create_force_with_full_diplomatic_discovery(
--- @example 	"wh_main_dwf_dwarfs",
--- @example 	"wh_main_dwf_inf_hammerers,wh_main_dwf_inf_longbeards_1,wh_main_dwf_inf_quarrellers_0,wh_main_dwf_inf_quarrellers_0",
--- @example 	"wh_main_the_silver_road_karaz_a_karak",
--- @example 	714,
--- @example 	353,
--- @example 	"scripted_force_1",
--- @example 	true,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_force_with_full_diplomatic_discovery(faction_key, unit_list, region_key, x, y,
                                                                      exclude_named_characters, success_callback,
                                                                      surpress_ui_messages)
     if not is_string(faction_key) then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(unit_list) then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied unit list [" ..
          tostring(unit_list) .. "] is not a string");
          return;
     end;

     if unit_list == "" then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied unit list [" ..
          tostring(unit_list) .. "] is an empty string");
          return;
     end;

     if not is_string(region_key) then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_boolean(exclude_named_characters) then
          script_error(
          "ERROR: create_force_with_full_diplomatic_discovery() called but supplied exclude named characters switch [" ..
          tostring(exclude_named_characters) .. "] is not a boolean value");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local region = cm:get_region(region_key);
     if not is_region(region) then
          script_error("ERROR: create_force_with_full_diplomatic_discovery() called but supplied region key [" ..
          tostring(region_key) .. "] is not a valid region");
     end;

     if surpress_ui_messages ~= true then
          surpress_ui_messages = false
     end

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());

     local listener_name = "campaign_manager_create_force_" .. id;

     -- establish a listener for the force being created
     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context)
               return context.string == id;
          end,
          function(context)
               self:force_created(id, listener_name, context:character(), success_callback)
          end,
          false
     );

     out("create_force_with_full_diplomatic_discovery() called:");
     out.inc_tab();

     out("faction_key: " .. faction_key);
     out("unit_list: " .. unit_list);
     out("region_key: " .. region_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("id: " .. id);
     out("exclude_named_characters: " .. tostring(exclude_named_characters));

     out.dec_tab();

     -- make the call to create the force
     return self.game_interface:create_force_with_full_diplomatic_discovery(faction_key, unit_list, region_key, x, y, id,
          exclude_named_characters, surpress_ui_messages);
end;

--- @function create_force_with_budget
--- @desc Instantly spawn an army with a certain budget with a general on the campaign map. This function is a wrapper for the @episodic_scripting:create_force_with_budget function provided by the episodic scripting interface, adding debug output and success callback functionality.
--- @p @string faction key, Faction key of the faction to which the force is to belong.
--- @p @string region key, Region key of home region for this force.
--- @p @number budget, Budget of the force
--- @p @number unit count, Number of units in the force
--- @p @boolean attacking, Is the force on the attacking side
--- @p @number x, x logical co-ordinate of force.
--- @p @number y, y logical co-ordinate of force.
--- @p @string id, id of the force
--- @p [opt=nil] @function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @example cm:create_force_with_budget(
--- @example 	"phar_main_irsu",
--- @example 	"phar_main_east_sinai_beersheba",
--- @example 	1000,
--- @example 	5,
--- @example 	true,
--- @example 	525,
--- @example 	325,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi)
--- @example 	end
--- @example )
function campaign_manager:create_force_with_budget(faction_key, region_key, budget, unit_count, attacking, x, y,
                                                   success_callback)
     if not is_string(faction_key) then
          script_error("ERROR: create_force_with_budget() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string")
          return
     end

     if not is_string(region_key) then
          script_error("ERROR: create_force_with_budget() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return
     end

     if not is_number(budget) or budget < 0 then
          script_error("ERROR: create_force_with_budget() called but supplied budget [" ..
          tostring(budget) .. "] is not a positive number")
          return
     end

     if not is_number(unit_count) or unit_count < 0 then
          script_error("ERROR: create_force_with_budget() called but supplied unit count [" ..
          tostring(unit_count) .. "] is not a positive number")
          return
     end

     if not is_boolean(attacking) then
          script_error("ERROR: create_force_with_budget() called but supplied flag attacking [" ..
          tostring(attacking) .. "] is not a boolean")
          return
     end

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force_with_budget() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number")
          return
     end

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force_with_budget() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number")
          return
     end

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force_with_budget() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil")
          return
     end

     local region = cm:get_region(region_key)
     if not is_region(region) then
          script_error("ERROR: create_force_with_budget() called but supplied region key [" ..
          tostring(region_key) .. "] is not a valid region")
     end

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter())

     local listener_name = "campaign_manager_create_force_" .. id

     -- establish a listener for the force being created
     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context)
               return context.string == id
          end,
          function(context)
               self:force_created(id, listener_name, context:character(), success_callback)
          end,
          false
     )

     out("create_force_with_budget() called:")
     out.inc_tab()

     out("faction_key: " .. faction_key)
     out("region_key: " .. region_key)
     out("budget: " .. tostring(budget))
     out("unit_count: " .. tostring(unit_count))
     out("attacking: " .. tostring(attacking))
     out("x: " .. tostring(x))
     out("y: " .. tostring(y))
     out("id: " .. id)

     out.dec_tab()

     -- make the call to create the force
     self.game_interface:create_force_with_budget(faction_key, region_key, budget, unit_count, attacking, x, y, id)
end

--- @function create_force_with_general
--- @desc Wrapper for create_force_with_general function on the underlying <a href="../../scripting_doc.html">game interface</a>, which instantly spawn an army with a specific general on the campaign map. This wrapper function adds debug output and success callback functionality.
--- @p string faction key, Faction key of the faction to which the force is to belong.
--- @p string unit list, Comma-separated list of keys from the <code>land_units</code> table. The force will be created with these units. This can be a blank string, or nil, if an empty force is desired.
--- @p string region key, Region key of home region for this force.
--- @p number x, x logical co-ordinate of force.
--- @p number y, y logical co-ordinate of force.
--- @p string agent type, Character type of character at the head of the army (should always be "general"?).
--- @p string agent subtype, Character subtype of character at the head of the army.
--- @p string forename, Localised string key of the created character's forename. This should be given in the localised text lookup format i.e. a key from the <code>names</code> table with "names_name_" prepended.
--- @p string clan name, Localised string key of the created character's clan name. This should be given in the localised text lookup format i.e. a key from the <code>names</code> table with "names_name_" prepended.
--- @p string family name, Localised string key of the created character's family name. This should be given in the localised text lookup format i.e. a key from the <code>names</code> table with "names_name_" prepended.
--- @p string other name, Localised string key of the created character's other name. This should be given in the localised text lookup format i.e. a key from the <code>names</code> table with "names_name_" prepended.
--- @p boolean make faction leader, Make the spawned character the faction leader.
--- @p [opt=nil] function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @r @boolean force created
--- @example cm:create_force_with_general(
--- @example 	"troy_main_dan_apteron",
--- @example 	"troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,troy_club_warriors,",
--- @example 	"troy_main_zonaea_aenos"
--- @example 	714,
--- @example 	353,
--- @example 	"general",
--- @example 	"dwf_lord",
--- @example 	"names_name_2147344345",
--- @example 	"",
--- @example 	"names_name_2147345842",
--- @example 	"",
--- @example 	"scripted_force_1",
--- @example 	false,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_force_with_general(faction_key, unit_list, region_key, x, y, agent_type, agent_subtype,
                                                    forename, clan_name, family_name, other_name, make_faction_leader,
                                                    success_callback, art_set_id, create_event)
     if not is_string(faction_key) then
          script_error("ERROR: create_force_with_general() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not unit_list then
          unit_list = "";
     elseif not is_string(unit_list) then
          script_error("ERROR: create_force_with_general() called but supplied unit list [" ..
          tostring(unit_list) .. "] is not a string");
          return;
     end;

     if not is_string(region_key) then
          script_error("ERROR: create_force_with_general() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force_with_general() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force_with_general() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_string(agent_type) then
          script_error("ERROR: create_force_with_general() called but supplied agent_type [" ..
          tostring(agent_type) .. "] is not a string");
          return;
     end;

     if not is_string(agent_subtype) then
          script_error("ERROR: create_force_with_general() called but supplied agent_subtype [" ..
          tostring(agent_subtype) .. "] is not a string");
          return;
     end;

     if not is_string(forename) then
          script_error("ERROR: create_force_with_general() called but supplied forename [" ..
          tostring(forename) .. "] is not a string");
          return;
     end;

     if not is_string(clan_name) then
          script_error("ERROR: create_force_with_general() called but supplied clan_name [" ..
          tostring(clan_name) .. "] is not a string");
          return;
     end;

     if not is_string(family_name) then
          script_error("ERROR: create_force_with_general() called but supplied family_name [" ..
          tostring(family_name) .. "] is not a string");
          return;
     end;

     if not is_string(other_name) then
          script_error("ERROR: create_force_with_general() called but supplied other_name [" ..
          tostring(other_name) .. "] is not a string");
          return;
     end;

     if not is_boolean(make_faction_leader) then
          script_error("ERROR: create_force() called but supplied make faction leader switch [" ..
          tostring(make_faction_leader) .. "] is not a boolean value");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force_with_general() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local faction = cm:get_faction(faction_key);

     if not is_faction(faction) then
          script_error("ERROR: create_force_with_general() called but supplied faction [" ..
          tostring(faction_key) .. "] could not be found");
          return;
     end;

     if create_event == nil then
          create_event = false
     end;

     local region = cm:get_region(region_key);
     if not is_region(region) then
          script_error("ERROR: create_force_with_general() called but supplied region key [" ..
          tostring(region_key) .. "] is not a valid region");
     end;

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());
     local _art_set_id = art_set_id or ""

     local listener_name = "campaign_manager_create_force_" .. id;

     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context) return context.string == id end,
          function(context) self:force_created(id, listener_name, context:character(), success_callback) end,
          false
     );

     out("create_force_with_general() called:");
     out.inc_tab();

     out("faction_key: " .. faction_key);
     out("unit_list: " .. unit_list);
     out("region_key: " .. region_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("agent_type: " .. agent_type);
     out("agent_subtype: " .. agent_subtype);
     out("forename: " .. forename);
     out("clan_name: " .. clan_name);
     out("family_name: " .. family_name);
     out("other_name: " .. other_name);
     out("id: " .. id);
     out("make_faction_leader: " .. tostring(make_faction_leader));
     out("create_event: " .. tostring(create_event));

     out.dec_tab();

     -- make the call to create the force
     return self.game_interface:create_force_with_general(faction_key, unit_list, region_key, x, y, agent_type,
          agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, _art_set_id, create_event);
end;

--- @function create_force_with_existing_general
--- @desc Wrapper for create_force_with_existing_general function on the underlying <a href="../../scripting_doc.html">game interface</a>, which instantly spawn an army with a specific existing general on the campaign map. The general is specified by character string lookup. This wrapper function adds debug output and success callback functionality.
--- @p string character lookup, Character lookup string for the general character.
--- @p string faction key, Faction key of the faction to which the force is to belong.
--- @p string unit list, Comma-separated list of keys from the <code>land_units</code> table. The force will be created with these units.
--- @p string region key, Region key of home region for this force.
--- @p number x, x logical co-ordinate of force.
--- @p number y, y logical co-ordinate of force.
--- @p [opt=nil] function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @r @boolean force created
--- @example cm:create_force_with_existing_general(
--- @example 	cm:char_lookup_str(char_dwf_faction_leader),
--- @example 	"troy_main_dan_apteron",
--- @example 	"troy_club_warriors,troy_club_warriors,troy_club_warriors,",
--- @example 	"troy_main_zonaea_aenos"
--- @example 	714,
--- @example 	353,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_force_with_existing_general(char_str, faction_key, unit_list, region_key, x, y,
                                                             success_callback)
     if not is_string(char_str) then
          script_error("ERROR: create_force_with_existing_general() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return;
     end;

     if not is_string(faction_key) then
          script_error("ERROR: create_force_with_existing_general() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(unit_list) then
          script_error("ERROR: create_force_with_existing_general() called but supplied unit list [" ..
          tostring(unit_list) .. "] is not a string");
          return;
     end;

     if unit_list == "" then
          script_error("ERROR: create_force() called but supplied unit list [" ..
          tostring(unit_list) .. "] is an empty string");
          return;
     end;

     if not is_string(region_key) then
          script_error("ERROR: create_force_with_existing_general() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force_with_existing_general() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force_with_existing_general() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force_with_existing_general() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local faction = cm:get_faction(faction_key);

     if not is_faction(faction) then
          script_error("ERROR: create_force_with_existing_general() called but supplied faction [" ..
          tostring(faction_key) .. "] could not be found");
          return;
     end;

     local region = cm:get_region(region_key);
     if not is_region(region) then
          script_error("ERROR: create_force_with_existing_general() called but supplied region key [" ..
          tostring(region_key) .. "] is not a valid region");
          return;
     end;

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());

     local listener_name = "campaign_manager_create_force_" .. id;

     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context)
               return context.string == id;
          end,
          function(context)
               self:force_created(id, listener_name, context:character(), success_callback)
          end,
          false
     );

     out("create_force_with_existing_general() called:");
     out.inc_tab();

     out("char_str: " .. char_str);
     out("faction_key: " .. faction_key);
     out("unit_list: " .. unit_list);
     out("region_key: " .. region_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("id: " .. id);

     out.dec_tab();

     -- make the call to create the force
     return self.game_interface:create_force_with_existing_general(char_str, faction_key, unit_list, region_key, x, y, id);
end;

--- @function create_force_from_family_member
--- @desc Wrapper for @episodic_scripting:create_force_from_family_member, which instantly spawn an army with a general from the recruitment pool, specified by the cqi value of a @family_member. This wrapper function adds debug output and success callback functionality.
--- @p @number family member cqi, Family member command queue index value.
--- @p string faction key, Faction key of the faction to which the force is to belong.
--- @p string unit list, Comma-separated list of keys from the <code>land_units</code> table. The force will be created with these units.
--- @p string region key, Region key of home region for this force.
--- @p number x, x logical co-ordinate of force.
--- @p number y, y logical co-ordinate of force.
--- @p [opt=nil] function success callback, Callback to call once the force is created. The callback will be passed the created military force leader's cqi as a single argument.
--- @r @boolean force successfully created
--- @example cm:create_force_from_family_member(
--- @example 	123,
--- @example 	"troy_main_dan_apteron",
--- @example 	"troy_club_warriors,troy_club_warriors,troy_club_warriors,",
--- @example 	"troy_main_zonaea_aenos"
--- @example 	714,
--- @example 	353,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_force_from_family_member(fm_cqi, faction_key, unit_list, region_key, x, y,
                                                          success_callback)
     if not is_number(fm_cqi) then
          script_error("ERROR: create_force_with_existing_general() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return;
     end;

     if not is_string(faction_key) then
          script_error("ERROR: create_force_with_existing_general() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(unit_list) then
          script_error("ERROR: create_force_with_existing_general() called but supplied unit list [" ..
          tostring(unit_list) .. "] is not a string");
          return;
     end;

     if unit_list == "" then
          script_error("ERROR: create_force() called but supplied unit list [" ..
          tostring(unit_list) .. "] is an empty string");
          return;
     end;

     if not is_string(region_key) then
          script_error("ERROR: create_force_with_existing_general() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_force_with_existing_general() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_force_with_existing_general() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_force_with_existing_general() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local faction = cm:get_faction(faction_key);

     if not is_faction(faction) then
          script_error("ERROR: create_force_with_existing_general() called but supplied faction [" ..
          tostring(faction_key) .. "] could not be found");
          return;
     end;

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());

     local listener_name = "campaign_manager_create_force_" .. id;

     core:add_listener(
          listener_name,
          "ScriptedForceCreated",
          function(context)
               return context.string == id;
          end,
          function(context)
               self:force_created(id, listener_name, context:character(), success_callback)
          end,
          false
     );

     out("create_force_from_family_member() called:");
     out.inc_tab();

     out("family_member cqi: " .. fm_cqi);
     out("faction_key: " .. faction_key);
     out("unit_list: " .. unit_list);
     out("region_key: " .. region_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("id: " .. id);

     out.dec_tab();

     -- make the call to create the force
     return self.game_interface:create_force_from_family_member(fm_cqi, faction_key, unit_list, region_key, x, y, id);
end;

-- called by create_force() commands above when a force has been created. This attempts to find the newly-created
-- character and returns its cqi to the calling code.
function campaign_manager:force_created(id, listener_name, character, success_callback)
     if not is_function(success_callback) then
          return
     end

     if not character:is_null_interface() then
          -- remove this listener, call the success callback with the character cqi as parameter and exit
          core:remove_listener(listener_name)
          local cqi = character:command_queue_index()
          success_callback(cqi)
          return cqi
     end

     return false;
end;

--- @function kill_character
--- @desc Kills the specified character, with the ability to also destroy their whole force if they are commanding one. The character may be specified by a lookup string or by character cqi.
--- @p @string character lookup string, Character string of character to kill. This uses the standard character string lookup system. Alternatively, a @number may be supplied, which specifies a character cqi.
--- @p [opt=false] @boolean destroy force, Will also destroy the characters whole force if true.
function campaign_manager:kill_character(character_lookup_value, destroy_force)
     destroy_force = destroy_force or false;

     if not is_number(character_lookup_value) and not is_string(character_lookup_value) then
          script_error("ERROR: kill_character() called but supplied character lookup/cqi [" ..
          tostring(character_lookup_value) .. "] is not a number or a string");
          return false;
     end;

     local character_obj = is_number(character_lookup_value) and
     self:model():character_for_command_queue_index(character_lookup_value) or
     self:model():lookup_character(character_lookup_value);
     if character_obj and not character_obj:is_null_interface() then
          local lookup = is_string(character_lookup_value) and character_lookup_value or
          "character_cqi:" .. character_lookup_value;

          -- If this character has a force then they also currently have a unit so to kill the character AND the unit too we need to use a bespoke function
          if character_obj:has_military_force() == true then
               if destroy_force then
                    out("* killing character with lookup [" .. lookup .. "], their unit, and their military force");
               else
                    out("* killing character with lookup [" .. lookup .. "], their unit, but not their military force");
               end;
               self.game_interface:kill_character_and_commanded_unit(lookup, destroy_force);
          else
               out("* killing character with lookup [" .. lookup .. "] (this character has no military force)");
               self.game_interface:kill_character(lookup, destroy_force);
          end
          return true;
     else
          out("* kill_character() called for character with lookup/cqi [" ..
          character_lookup_value .. "] but no such character could be found, continuing");
     end
     return false;
end

--- @function add_building_to_force
--- @desc Adds one or more buildings to a horde army. The army is specified by the command queue index of the military force. A single building may be specified by a string key, or multiple buildings in a table.
--- @p number military force cqi, Command queue index of the military force to add the building(s) to.
--- @p object building(s), Building key or keys to add to the military force. This can be a single string or a numerically-indexed table.
function campaign_manager:add_building_to_force(cqi, building_level)
     if not is_number(cqi) then
          script_error("ERROR: add_building_to_force() called but supplied cqi [" .. tostring(cqi) .. "] is not a number");
          return false;
     end;

     if is_string(building_level) then
          out("add_building_to_force() called, adding building level [" ..
          building_level .. "] to military force cqi [" .. cqi .. "]");

          self.game_interface:add_building_to_force(cqi, building_level);
     elseif is_table(building_level) then
          out("add_building_to_force() called, adding buildings military force cqi [" .. cqi .. "]");

          for i = 1, #building_level do
               local current_building_level = building_level[i];

               if is_string(current_building_level) then
                    out("\tAdding building level [" .. current_building_level .. "]");

                    self.game_interface:add_building_to_force(cqi, current_building_level);
               else
                    script_error("ERROR: add_building_to_force() called but supplied building_level table element [" ..
                    tostring(current_building_level) .. "] is not a string");
                    return false;
               end;
          end;

          out("add_building_to_force() finished adding buildings");
     else
          script_error("ERROR: add_building_to_force() called but supplied building_level [" ..
          tostring(building_level) .. "] is not a string or table");
          return false;
     end;
end;

--- @function create_agent
--- @desc Wrapper for create_agent function on the underlying <a href="../../scripting_doc.html">game interface</a> which adds input validation and console output. This function creates an agent of a specified type on the campaign map.
--- @p string faction key, Faction key of the faction to which the agent is to belong.
--- @p string character type, Character type of the agent.
--- @p string character subtype, Character subtype of the agent.
--- @p number x, x logical co-ordinate of agent.
--- @p number y, y logical co-ordinate of agent.
--- @p string id, Unique string for agent.
--- @p [opt=nil] function success callback, Callback to call once the character is created. The callback will be passed the created character's cqi as a single argument.
--- @example cm:create_agent(
--- @example 	"troy_main_dan_apteron",
--- @example 	"troy_main_zonaea_aenos"
--- @example 	714,
--- @example 	353,
--- @example 	function(cqi)
--- @example 		out("Force created with char cqi: " .. cqi);
--- @example 	end
--- @example );
function campaign_manager:create_agent(faction_key, agent_key, subtype_key, x, y, success_callback)
     if not is_string(faction_key) then
          script_error("ERROR: create_agent() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(agent_key) then
          script_error("ERROR: create_agent() called but supplied agent key [" ..
          tostring(agent_key) .. "] is not a string");
          return;
     end;

     if not is_string(subtype_key) then
          script_error("ERROR: create_agent() called but supplied agent subtype key [" ..
          tostring(subtype_key) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: create_agent() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: create_agent() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: create_agent() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local faction = cm:get_faction(faction_key);

     if not is_faction(faction) then
          script_error("ERROR: create_agent() called but supplied faction [" ..
          tostring(faction_key) .. "] could not be found");
          return;
     end;

     -- this is now generated internally, rather than being passed in from the calling function
     local id = tostring(core:get_unique_counter());

     local listener_name = "campaign_manager_create_agent_" .. id;

     out("create_agent() called:");
     out.inc_tab();

     out("faction_key: " .. faction_key);
     out("agent_key: " .. agent_key);
     out("subtype_key: " .. subtype_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("id: " .. id);

     out.dec_tab();

     -- make the call to create the agent
     self.game_interface:create_agent(faction_key, agent_key, subtype_key, x, y, id);

     -- verify that the force was created immediately, return false if it somehow wasn't
     return self:agent_created(id, listener_name, faction_key, x, y, success_callback);
end;

--- @function respawn_convalescing_agent
--- @desc Wrapper for respawn_convalescing_agent function on the underlying <a href="../../scripting_doc.html">game interface</a> which adds input validation, text output, and a success callback. This function respawns an immortal agent that has been wounded.
--- @p string faction key, Faction key of the faction to which the agent is to belong.
--- @p number x, x logical co-ordinate of agent.
--- @p number y, y logical co-ordinate of agent.
--- @p @string character lookup, Character lookup string - see @"episodic_scripting:Character Lookups" for more information.
--- @p [opt=nil] function success callback, Callback to call once the character is created. The callback will be passed the created character's cqi as a single argument.
function campaign_manager:respawn_convalescing_agent(faction_key, x, y, character_lookup_string, success_callback)
     if not is_string(faction_key) then
          script_error("ERROR: respawn_convalescing_agent() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     if not is_string(character_lookup_string) then
          script_error("ERROR: respawn_convalescing_agent() called but supplied character_lookup_string key [" ..
          tostring(character_lookup_string) .. "] is not a string");
          return;
     end;

     if not is_number(x) or x < 0 then
          script_error("ERROR: respawn_convalescing_agent() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: respawn_convalescing_agent() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     if not is_function(success_callback) and not is_nil(success_callback) then
          script_error("ERROR: respawn_convalescing_agent() called but supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return;
     end;

     local faction = cm:get_faction(faction_key);

     if not is_faction(faction) then
          script_error("ERROR: respawn_convalescing_agent() called but supplied faction [" ..
          tostring(faction_key) .. "] could not be found");
          return;
     end;

     out("respawn_convalescing_agent() called:");
     out.inc_tab();
     out("faction_key: " .. faction_key);
     out("x: " .. tostring(x));
     out("y: " .. tostring(y));
     out("character lookup string: " .. character_lookup_string);

     out.dec_tab();

     -- make the call to create the agent
     self.game_interface:respawn_convalescing_agent(faction_key, x, y, character_lookup_string);
     return self:agent_created(nil, "", faction_key, x, y, success_callback);
end;

-- called by create_agent() and respawn_convalescing_agent() when an agent has been created. This attempts to find the newly-created character
-- and returns its cqi to the calling code. Multiple instances of this listener could be running at the time a ScriptedAgentCreated event
-- has occurred, so if this function can't find the agent it's looking for chances are there are a load being spawned at once and that
-- the relevant one will be along in a bit.
function campaign_manager:agent_created(id, listener_name, faction_key, x, y, success_callback)
     if not is_function(success_callback) then
          return;
     end;

     -- find the cqi of the agent just created
     local character_list = cm:get_faction(faction_key):character_list();

     for i = 0, character_list:num_items() - 1 do
          local char = character_list:item_at(i);

          if char:logical_position_x() == x and char:logical_position_y() == y then
               if char:character_type("champion") or char:character_type("dignitary") or char:character_type("spy") or char:character_type("engineer") or char:character_type("wizard") or char:character_type("runesmith") then
                    -- we have found it, remove this listener, call the success callback with the character cqi as parameter and exit
                    core:remove_listener(listener_name);

                    local cqi = char:command_queue_index();
                    success_callback(cqi);
                    return cqi;
               end;
          end;
     end;

     return false;
end;

--- @function reposition_starting_character_for_faction
--- @desc Repositions a specified character (the <i>target</i>) for a faction at start of a campaign, but only if another character (the <i>subject</i>) exists in that faction and is in command of an army. Like @campaign_manager:teleport_to which underpins this function it is for use at the start of a campaign in a game-created callback (see @campaign_manager:add_pre_first_tick_callback). It is intended for use in very specific circumstances.
--- @desc The characters involved are specified by forename key.
--- @p string faction key, Faction key of the subject and target characters.
--- @p string forename key, Forename key of the subject character from the names table using the full localisation format i.e. <code>names_name_[key]</code>.
--- @p string forename key, Forename key of the target character from the names table using the full localisation format i.e. <code>names_name_[key]</code>.
--- @p number x, x logical target co-ordinate.
--- @p number y, y logical target co-ordinate.
--- @return boolean Subject character exists.
--- @example cm:add_pre_first_tick_callback(
--- @example 	function()
--- @example 		cm:reposition_starting_character_for_faction(
--- @example 			"troy_main_dan_apteron",
--- @example 			"names_name_2147357619",
--- @example 			"names_name_2147357619",
--- @example 			643,
--- @example 			191
--- @example 		)
--- @example 	end
--- @example )
function campaign_manager:reposition_starting_character_for_faction(faction_name, subject_lord_forename,
                                                                    target_lord_forename, new_pos_x, new_pos_y)
     local faction = cm:get_faction(faction_name);

     if not faction then
          script_error(
          "ERROR: reposition_starting_character_for_faction() called but couldn't find faction with supplied name [" ..
          tostring(faction_name) .. "]");
          return false;
     end;

     if not is_string(subject_lord_forename) then
          script_error("ERROR: reposition_starting_character_for_faction() called but supplied lord name [" ..
          tostring(subject_lord_forename) .. "] is not a string");
          return false;
     end;

     if not is_string(target_lord_forename) then
          script_error("ERROR: reposition_starting_character_for_faction() called but supplied lord name [" ..
          tostring(target_lord_forename) .. "] is not a string");
          return false;
     end;

     if not is_number(new_pos_x) or new_pos_x < 0 then
          script_error("ERROR: reposition_starting_character_for_faction() called but supplied x co-ordinate [" ..
          tostring(new_pos_x) .. "] is not a positive number");
          return false;
     end;

     if not is_number(new_pos_y) or new_pos_y < 0 then
          script_error("ERROR: reposition_starting_character_for_faction() called but supplied y co-ordinate [" ..
          tostring(new_pos_y) .. "] is not a positive number");
          return false;
     end;

     -- get character and see if it has an army
     local char_list = faction:character_list();

     for i = 0, char_list:num_items() - 1 do
          local current_subject_char = char_list:item_at(i);

          if current_subject_char:get_forename() == subject_lord_forename then
               if self:char_is_general_with_army(current_subject_char) then
                    -- try and find the target char
                    local target_char = false;
                    if subject_lord_forename == target_lord_forename then
                         target_char = current_subject_char;
                    else
                         -- the subject char and target char are different, go searching for the latter
                         for j = 0, char_list:num_items() - 1 do
                              local current_target_char = char_list:item_at(j);
                              if current_target_char:get_forename() == target_lord_forename then
                                   target_char = current_target_char;
                                   break;
                              end;
                         end;
                    end;

                    if target_char then
                         out("Teleporting starting Lord with name " ..
                         target_lord_forename ..
                         " for faction " .. faction_name .. " to [" .. new_pos_x .. ", " .. new_pos_y .. "]");
                         self:teleport_to(self:char_lookup_str(target_char), new_pos_x, new_pos_y);
                    else
                         script_error(
                         "WARNING: reposition_starting_character_for_faction() wanted to perform teleport but could find no character in faction " ..
                         faction_name .. " with name " .. target_lord_forename);
                    end;
               end;
               return true;
          end;
     end;
end;

--- @function spawn_army_starting_character_for_faction
--- @desc Spawns a specified force if a character (the <i>subject</i>) exists within a faction with an army. It is intended for use at the start of a campaign in a game-created callback (see @campaign_manager:add_pre_first_tick_callback), in very specific circumstances.
--- @p string faction key, Faction key of the subject character.
--- @p string forename key, Forename key of the subject character from the names table using the full localisation format i.e. <code>names_name_[key]</code>.
--- @p string faction key, Faction key of the force to create.
--- @p string units, list of units to create force with (see documentation for @campaign_manager:create_force for more information).
--- @p string region key, Home region key for the created force.
--- @p number x, x logical target co-ordinate.
--- @p number y, y logical target co-ordinate.
--- @p boolean make_immortal, Set to <code>true</code> to make the created character immortal.
--- @example cm:add_pre_first_tick_callback(
--- @example 	function()
--- @example 		cm:spawn_army_starting_character_for_faction(
--- @example 			"troy_main_dan_apteron",
--- @example 			"names_name_2147352487",
--- @example 			"troy_main_dan_apteron",
--- @example 			"troy_club_warriors,troy_club_warriors,,troy_club_warriors,",
--- @example 			"troy_main_zonaea_aenos",
--- @example 			643,
--- @example 			188,
--- @example 			true
--- @example 		)
--- @example 	end
--- @example )
function campaign_manager:spawn_army_starting_character_for_faction(source_faction_name, subject_lord_forename,
                                                                    army_faction_name, army_units, army_home_region,
                                                                    pos_x, pos_y, make_immortal)
     local source_faction = cm:get_faction(source_faction_name);
     local army_faction = cm:get_faction(army_faction_name);

     if not source_faction then
          script_error(
          "ERROR: spawn_army_starting_character_for_faction() called but couldn't find source faction with supplied name [" ..
          tostring(source_faction_name) .. "]");
          return false;
     end;

     if not army_faction then
          script_error(
          "ERROR: spawn_army_starting_character_for_faction() called but couldn't find faction with supplied name [" ..
          tostring(army_faction_name) .. "]");
          return false;
     end;

     if not is_string(subject_lord_forename) then
          script_error("ERROR: spawn_army_starting_character_for_faction() called but supplied lord name [" ..
          tostring(subject_lord_forename) .. "] is not a string");
          return false;
     end;

     if not is_string(army_units) then
          script_error("ERROR: spawn_army_starting_character_for_faction() called but supplied army units [" ..
          tostring(army_units) .. "] is not a string");
          return false;
     end;

     if not is_string(army_home_region) then
          script_error("ERROR: spawn_army_starting_character_for_faction() called but supplied army home region [" ..
          tostring(army_home_region) .. "] is not a string");
          return false;
     end;

     if not is_number(pos_x) or pos_x < 0 then
          script_error("ERROR: spawn_army_starting_character_for_faction() called but supplied x co-ordinate [" ..
          tostring(pos_x) .. "] is not a positive number");
          return false;
     end;

     if not is_number(pos_y) or pos_y < 0 then
          script_error("ERROR: spawn_army_starting_character_for_faction() called but supplied y co-ordinate [" ..
          tostring(pos_y) .. "] is not a positive number");
          return false;
     end;

     -- get character and see if it has an army
     local char_list = source_faction:character_list();

     for i = 0, char_list:num_items() - 1 do
          local current_subject_char = char_list:item_at(i);

          if current_subject_char:get_forename() == subject_lord_forename then
               if self:char_is_general_with_army(current_subject_char) then
                    out("Found character " .. subject_lord_forename .. " in faction " .. source_faction_name);

                    self:create_force(
                         army_faction_name,
                         army_units,
                         army_home_region,
                         pos_x,
                         pos_y,
                         true,
                         function(cqi)
                              if make_immortal then
                                   local char_str = self:char_lookup_str(cqi);
                                   self:set_character_immortality(char_str, true);
                              end;
                         end
                    );
               else
                    return; -- we found the general, but he does not command an army
               end;

               return;
          end;
     end;
end;

--- @function move_character
--- @desc Helper function to move a character.
--- @p number cqi, Command-queue-index of the character to move.
--- @p number x, x co-ordinate of the intended destination.
--- @p number y, y co-ordinate of the intended destination.
--- @p [opt=false] boolean should replenish, Automatically replenish the character's action points in script should they run out whilst moving. This ensures the character will reach their intended destination in one turn (unless they fail for another reason).
--- @p [opt=true] boolean allow post movement, Allow the army to move after the order is successfully completed. Setting this to <code>false</code> disables character movement with @campaign_manager:disable_movement_for_character should the character successfully reach their destination.
--- @p [opt=nil] function success callback, Callback to call if the character successfully reaches the intended destination this turn.
--- @p [opt=nil] function fail callback, Callback to call if the character fails to reach the intended destination this turn.
function campaign_manager:move_character(char_cqi, log_x, log_y, should_replenish, allow_movement_afterwards,
                                         success_callback, fail_callback)
     if not is_number(char_cqi) and not is_string(char_cqi) then
          script_error("move_character ERROR: cqi provided [" .. tostring(char_cqi) .. "] is not a number or string");
          return false;
     end;

     if not is_number(log_x) or log_x < 0 then
          script_error("move_character ERROR: supplied logical x co-ordinate [" ..
          tostring(log_x) .. "] is not a positive number");
          return false;
     end;

     if not is_number(log_y) or log_y < 0 then
          script_error("move_character ERROR: supplied logical y co-ordinate [" ..
          tostring(log_x) .. "] is not a positive number");
          return false;
     end;

     if success_callback and not is_function(success_callback) then
          script_error("move_character ERROR: supplied success callback [" ..
          tostring(success_callback) .. "] is not a function or nil");
          return false;
     end;

     if fail_callback and not is_function(fail_callback) then
          script_error("move_character ERROR: supplied failure callback [" ..
          tostring(fail_callback) .. "] is not a function or nil");
          return false;
     end;

     should_replenish = not not should_replenish;

     if allow_movement_afterwards ~= false then
          allow_movement_afterwards = true;
     end;

     out("\tmove_character() :: moving character with cqi [" .. char_cqi .. "] to [" .. log_x .. ", " .. log_y .. "]");

     local char_str = self:char_lookup_str(char_cqi);

     self:enable_movement_for_character(char_str);

     self:move_character_action(char_str, char_cqi, log_x, log_y, should_replenish, allow_movement_afterwards,
          success_callback, fail_callback)
end;

function campaign_manager:move_character_action(char_str, char_cqi, log_x, log_y, should_replenish,
                                                allow_movement_afterwards, success_callback, fail_callback)
     -- Issue the raw movement order
     if not self:move_to(char_str, log_x, log_y) then
          fail_callback();
          return;
     end;

     -- Watch for character halting
     self:notify_on_character_halt(
          char_cqi,
          function(char)
               local ap_remaining = char:action_points_remaining_percent();
               if should_replenish and ap_remaining == 0 then
                    cm:callback(
                         function()
                              out("\tmove_character() :: Character with cqi [" ..
                              char_cqi ..
                              "] has exhausted its movement points, re-issuing the order to [" ..
                              log_x .. ", " .. log_y .. "]");
                              self:replenish_action_points(char_str);
                              self:move_character_action(char_str, char_cqi, log_x, log_y, should_replenish,
                                   allow_movement_afterwards, success_callback, fail_callback);
                         end,
                         0.2
                    );
               else
                    self:move_character_halted(char_cqi, log_x, log_y, should_replenish, allow_movement_afterwards,
                         success_callback, fail_callback);
               end;
          end,
          true -- must move first
     );
end;

--	a character moved by move_character has finished moving
function campaign_manager:move_character_halted(char_cqi, log_x, log_y, should_replenish, allow_movement_afterwards,
                                                success_callback, fail_callback)
     local character = self:get_character_by_cqi(char_cqi);

     if not character then
          script_error("WARNING: move_character_halted() called but couldn't find a character with cqi [" ..
          tostring(char_cqi) .. "] - how can this be?");
          return false;
     end;

     -- If we're not within 3 hexes of our intended destination, then call the failure callback (unless we weren't supplied one, in which case just call the success callback (with a bool indicating destination reached)
     if distance_squared(log_x, log_y, character:logical_position_x(), character:logical_position_y()) > 9 then
          if is_function(fail_callback) then
               fail_callback();
          elseif is_function(success_callback) then
               success_callback(false);
          end;
     else
          if is_function(success_callback) then
               success_callback(true);
          end;
     end;
end;

--- @function is_character_moving
--- @desc Calls one callback if a specified character is currently moving, and another if it's not. It does this by recording the character's position, waiting half a second and then comparing the current position with that just recorded.
--- @p number cqi, Command-queue-index of the subject character.
--- @p function moving callback, Function to call if the character is determined to be moving.
--- @p function not moving callback, Function to call if the character is determined to be stationary.
function campaign_manager:is_character_moving(char_cqi, is_moving_callback, is_not_moving_callback)
     if not is_number(char_cqi) then
          script_error("ERROR: is_character_moving() called but supplied cqi [" ..
          tostring(char_cqi) .. "] is not a number");
          return false;
     end;

     local cached_char = self:get_character_by_cqi(char_cqi);

     if not is_character(cached_char) then
          script_error("ERROR: is_character_moving() called but couldn't find char with cqi of [" .. char_cqi .. "]");
          return false;
     end;

     local cached_pos_x = cached_char:logical_position_x();
     local cached_pos_y = cached_char:logical_position_y();

     local callback_name = "is_character_moving_" .. self:char_lookup_str(char_cqi);

     self:callback(
          function()
               local current_char = self:get_character_by_cqi(char_cqi);

               if not is_character(current_char) then
                    -- script_error("WARNING: is_character_moving_action() called but couldn't find char with cqi of [" .. char_cqi .. "] after movement - did it die?");
                    return false;
               end;

               local current_pos_x = current_char:logical_position_x();
               local current_pos_y = current_char:logical_position_y();

               if cached_pos_x == current_pos_x and cached_pos_y == current_pos_y then
                    -- character hasn't moved
                    if is_function(is_not_moving_callback) then
                         is_not_moving_callback();
                    end;
               else
                    -- character has moved
                    if is_function(is_moving_callback) then
                         is_moving_callback();
                    end;
               end;
          end,
          0.5,
          callback_name
     );
end;

--- @function stop_is_character_moving
--- @desc Stops any running monitor started with @campaign_manager:is_character_moving, by character. Note that once the monitor completes (half a second after it was started) it will automatically shut itself down.
--- @p number cqi, Command-queue-index of the subject character.
function campaign_manager:stop_is_character_moving(char_cqi)
     local callback_name = "is_character_moving_" .. self:char_lookup_str(char_cqi);

     self:remove_callback(callback_name);
end;

--- @function notify_on_character_halt
--- @desc Calls the supplied callback as soon as a character is determined to be stationary. This uses @campaign_manager:is_character_moving to determine if the character moving so the callback will not be called the instant the character halts.
--- @p number cqi, Command-queue-index of the subject character.
--- @p function callback, Callback to call.
--- @p [opt=false] boolean must move first, If true, the character must be seen to be moving before this monitor will begin. In this case, it will only call the callback once the character has stopped again.
function campaign_manager:notify_on_character_halt(char_cqi, callback, must_move_first)
     if not is_function(callback) then
          script_error("ERROR: notify_on_character_halt() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     local process_name = "notify_on_character_halt_" .. char_cqi;

     if must_move_first then
          -- The character must be seen to move first, so watch for this happening
          self:notify_on_character_movement(
               process_name,
               char_cqi,
               function()
                    -- Character is now moving, call back in to this function to set up a monitor for when the movement finishes
                    self:notify_on_character_halt(char_cqi, callback, false);
               end
          );
     else
          -- Establish a listener for the character finishing its movement
          core:add_listener(
               process_name,
               "CharacterFinishedMovingEvent",
               function(context)
                    return context:character():command_queue_index() == char_cqi;
               end,
               function(context)
                    callback(context:character());
               end,
               false
          );
     end;
end;

--- @function stop_notify_on_character_halt
--- @desc Stops any monitor started by @campaign_manager:notify_on_character_halt, by character cqi.
--- @p number cqi, Command-queue-index of the subject character.
function campaign_manager:stop_notify_on_character_halt(char_cqi)
     local process_name = "notify_on_character_halt_" .. char_cqi;

     self:stop_notify_on_character_movement(process_name);
     core:remove_listener(process_name);
end;

--- @function notify_on_character_movement
--- @desc Calls the supplied callback as soon as a character is determined to be moving.
--- @p @string process name, name for this movement monitor, by which it can be cancelled later with @campaign_manager:stop_notify_on_character_movement. It is valid to have multiple notification processes with the same name.
--- @p number cqi, Command-queue-index of the subject character.
--- @p function callback, Callback to call.
function campaign_manager:notify_on_character_movement(process_name, char_cqi, callback)
     if not is_string(process_name) then
          script_error("ERROR: notify_on_character_movement() called but supplied process name [" ..
          tostring(process_name) .. "] is not a string");
          return false
     end;

     if not is_number(char_cqi) then
          script_error("ERROR: notify_on_character_movement() called but supplied character cqi [" ..
          tostring(char_cqi) .. "] is not a number");
          return false;
     end;

     local character = self:get_character_by_cqi(char_cqi);

     if not character then
          script_error("ERROR: notify_on_character_movement() called but no character with the supplied cqi [" ..
          tostring(char_cqi) .. "] could be found");
          return false;
     end;

     if not is_function(callback) then
          script_error("ERROR: notify_on_character_movement() called but supplied callback [" ..
          tostring(callback) .. "] is not a function");
          return false;
     end;

     -- create an entry in our active monitors list
     if not self.notify_on_character_movement_active_monitors[process_name] then
          self.notify_on_character_movement_active_monitors[process_name] = {};
     end;
     table.insert(self.notify_on_character_movement_active_monitors[process_name], char_cqi);

     local monitor_name = "notify_on_character_movement_" .. process_name .. "_" .. tostring(char_cqi);

     -- poll the character's motion status
     self:repeat_callback(
          function()
               local char = self:get_character_by_cqi(char_cqi);
               if char then
                    -- Character was found, check motion
                    if char:is_in_motion() then
                         self:remove_callback(monitor_name);
                         callback();
                         return;
                    end;
               else
                    -- Character was not found, so stop this process
                    self:remove_callback(monitor_name);
               end;
          end,
          0.2,
          monitor_name
     );
end;

--- @function stop_notify_on_character_movement
--- @desc Stops any monitor started by @campaign_manager:notify_on_character_movement, by process name.
--- @p @string process name
function campaign_manager:stop_notify_on_character_movement(process_name)
     local process_table = self.notify_on_character_movement_active_monitors[process_name];

     if not is_table(process_table) or #process_table == 0 then
          return;
     end;

     for i = 1, #process_table do
          core:remove_listener(process_table[i]);
     end;

     self.notify_on_character_movement_active_monitors[process_name] = {};
end;

--- @function teleport_characters_to
--- @desc Teleports characters to a logical position on the campaign map.
--- @desc If only 1 position is passed as argument, then all characters will be teleported to that position
--- @p forename_ids - array of strings
--- @p positions - array of tables, each table represents Vector2 that have x and y as keys. Positions length should be 1 or length of forename_ids
function campaign_manager:teleport_characters_to(forename_ids, positions)
     if not is_table(forename_ids) or not is_table(positions) then
          script_error("ERROR: teleport_characters_to forename_ids or positions isn't a table");
          return;
     end;
     if #positions <= 0 then
          script_error("ERROR: teleport_characters_to empty array of positions");
          return;
     end;

     for i = 1, #forename_ids do
          local position = positions[math.min(i, #positions)]
          if is_table(position) and is_number(position.x) and is_number(position.y) then
               self:teleport_to("forename:" .. forename_ids[i], position.x, position.y);
          end;
     end;
end;

function campaign_manager:find_nearest_valid_position(faction_key, start_x, start_y, in_same_region,
                                                      preferred_spawn_distance, max_iterations)
     local positions = {}
     table.insert(positions, { x = start_x, y = start_y })
     local x = -1
     local y = -1
     local i = 1
     local preferred_spawn_distance = preferred_spawn_distance or 0
     local max_interations = max_interations or 100
     while x == -1 and y == -1 and i < max_iterations and i <= #positions do
          local c = positions[i]
          x, y = cm:find_valid_spawn_location_for_character_from_position(faction_key, c.x, c.y, in_same_region,
               preferred_spawn_distance)
          -- return position if it is valid
          if x ~= -1 and y ~= -1 then
               return x, y
          end

          -- define adjacent positions
          local offset = c.x % 2
          local adjacents = {
               [1] = { x = c.x, y = c.y + 1 },
               [2] = { x = c.x + 1, y = c.y + offset },
               [3] = { x = c.x + 1, y = c.y + offset - 1 },
               [4] = { x = c.x, y = c.y - 1 },
               [5] = { x = c.x - 1, y = c.y + offset },
               [6] = { x = c.x - 1, y = c.y + offset - 1 }
          }

          -- adding adjacent positions
          local max_index = #positions
          for k = 1, #adjacents do
               local found = false
               for j = 1, max_index do
                    -- check if position is already added
                    if positions[j].x == adjacents[k].x and positions[j].y == adjacents[k].y then
                         found = true
                         break
                    end
               end

               -- add position in queue
               if not found then
                    table.insert(positions, { x = adjacents[k].x, y = adjacents[k].y })
               end
          end
          i = i + 1
     end

     -- failed to find valid position. Returning -1, -1
     return x, y
end

--- @function find_valid_spawn_location_for_character_from_character
--- @desc Utilise the pathfinder to locate a valid spawn point for a character, based around another character.
--- @desc Returns (-1, -1) if invalid, otherwise (x, y).
--- @p faction_key - strings
--- @p character_lookup_str - character lookup string
--- @p in_same_region - boolean
--- @p preferred_spawn_distance - optional number
function campaign_manager:find_valid_spawn_location_for_character_from_character(faction_key, character_lookup_str,
                                                                                 in_same_region, preferred_spawn_distance)
     local x = -1
     local y = -1
     x, y = self.game_interface:find_valid_spawn_location_for_character_from_character(faction_key, character_lookup_str,
          in_same_region, preferred_spawn_distance)

     if x == -1 and y == -1 then
          local character = self:get_character(character_lookup_str)
          if not is_character(character) then
               script_error(
               "ERROR: find_valid_spawn_location_for_character_from_character() called but supplied character [" ..
               tostring(character) .. "] is not a character")
               return x, y
          end
          local logical_pos_x = character:logical_position_x()
          local logical_pos_y = character:logical_position_y()
          x, y = self:find_nearest_valid_position(faction_key, logical_pos_x, logical_pos_y, in_same_region,
               preferred_spawn_distance, 100)
     end

     return x, y
end

--- @function find_valid_spawn_location_for_character_from_settlement
--- @desc Utilise the pathfinder to locate a valid spawn point for a character, based around settlement.
--- @desc Returns (-1, -1) if invalid, otherwise (x, y).
--- @p faction_key - strings
--- @p region_key - region_key string
--- @p on_sea - boolean
--- @p in_same_region - boolean
--- @p preferred_spawn_distance - optional number
function campaign_manager:find_valid_spawn_location_for_character_from_settlement(faction_key, region_key, on_sea,
                                                                                  in_same_region,
                                                                                  preferred_spawn_distance)
     local x = -1
     local y = -1
     x, y = self.game_interface:find_valid_spawn_location_for_character_from_settlement(faction_key, region_key, on_sea,
          in_same_region, preferred_spawn_distance)

     if x == -1 and y == -1 then
          local region = cm:get_region(region_key)
          if not is_region(region) then
               script_error(
               "ERROR: find_valid_spawn_location_for_character_from_settlement() called but supplied region [" ..
               tostring(region) .. "] is not valid")
               return x, y
          end

          local settlement = region:settlement()
          if not is_settlement(settlement) then
               script_error("ERROR: character_can_reach_settlement() called but supplied target settlement [" ..
               tostring(settlement) .. "] in region [ ] " .. tostring(region_key) .. "is not a settlement");
               return x, y
          end;

          local logical_pos_x = settlement:logical_position_x()
          local logical_pos_y = settlement:logical_position_y()
          x, y = self:find_nearest_valid_position(faction_key, logical_pos_x, logical_pos_y, in_same_region,
               preferred_spawn_distance, 100)
     end

     return x, y
end

--- @function character_forced_invisible
--- @desc Sets charcater forced_invisible property.
--- @p character_lookup - character lookup string
--- @p forced_invisible - boolean
function campaign_manager:character_forced_invisible(character_lookup, forced_invisible)
     if not is_string(character_lookup) then
          script_error("ERROR: character_forced_invisible() called but supplied character lookup [" ..
          tostring(character_lookup) .. "] is not a string");
          return false;
     end;

     -- make sure force_invisible is of type boolean
     forced_invisible = not not forced_invisible;
     self.game_interface:character_forced_invisible(character_lookup, forced_invisible);
end;

--- @function characters_forced_invisible
--- @desc Calls characters_forced_invisible for each forename id
--- @p forename_ids - array of lookup strings by character forename
--- @p forced_invisible - boolean
function campaign_manager:characters_forced_invisible(forename_ids, forced_invisible)
     if not is_table(forename_ids) then
          script_error("ERROR: characters_forced_invisible forename_ids isn't a table");
          return;
     end;

     for i = 1, #forename_ids do
          cm:character_forced_invisible("forename:" .. forename_ids[i], forced_invisible);
     end;
end;

--- @function enable_movement_for_character
--- @desc Enables movement for the supplied character. Characters are specified by lookup string. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output.
--- @p string char lookup string
function campaign_manager:enable_movement_for_character(char_str)
     if not is_string(char_str) then
          script_error("ERROR: enable_movement_for_character() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     out("** enabling movement for character " .. char_str);

     self.game_interface:enable_movement_for_character(char_str);
end;

--- @function disable_movement_for_character
--- @desc Disables movement for the supplied character. Characters are specified by lookup string. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output.
--- @p string char lookup string
function campaign_manager:disable_movement_for_character(char_str)
     if not is_string(char_str) then
          script_error("ERROR: disable_movement_for_character() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     out("** disabling movement for character " .. char_str);

     self.game_interface:disable_movement_for_character(char_str);
end;

--- @function enable_movement_for_faction
--- @desc Enables movement for the supplied faction. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output.
--- @p string faction key
function campaign_manager:enable_movement_for_faction(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: enable_movement_for_faction() called but supplied faction string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     out("** enabling movement for faction " .. faction_name);

     self.game_interface:enable_movement_for_faction(faction_name);
end;

--- @function disable_movement_for_faction
--- @desc Disables movement for the supplied faction. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output.
--- @p string faction key
function campaign_manager:disable_movement_for_faction(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: disable_movement_for_faction() called but supplied faction string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     out("** disabling movement for faction " .. faction_name);

     self.game_interface:disable_movement_for_faction(faction_name);
end;

function campaign_manager:force_add_ancillary_impl(char_str, anc_str, suppress_event_message, function_name, equip)
     if not is_string(char_str) then
          if is_character(char_str) then
               char_str = cm:char_lookup_str(char_str)
          else
               script_error("ERROR: " ..
               function_name .. "() called but supplied character string [" .. tostring(char_str) .. "] is not a string");
               return false;
          end
     end;

     if not is_string(anc_str) then
          script_error("ERROR: " ..
          function_name .. "() called but supplied ancillary string [" .. tostring(anc_str) .. "] is not a string");
          return false;
     end;

     if not is_boolean(suppress_event_message) and not is_nil(suppress_event_message) then
          script_error("ERROR: " ..
          function_name ..
          "() called but supplied suppress event message boolean [" ..
          tostring(suppress_event_message) .. "] is not a boolean");
          return false;
     end;

     out.traits("* " ..
     function_name ..
     "() is adding ancillary [" ..
     tostring(anc_str) ..
     "] to character [" ..
     tostring(char_str) .. "]" .. ((suppress_event_message and " and suppressing event message.") or ""));
     if equip then
          self.game_interface:force_add_and_equip_ancillary(char_str, anc_str, suppress_event_message or false);
     else
          self.game_interface:force_add_ancillary(char_str, anc_str, suppress_event_message or false);
     end
end

--- @function force_add_ancillary
--- @desc Forceably adds an ancillary to a character. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the traits tab of the console.
--- @p string character string, Character string of the target character, using the standard character string lookup system.
--- @p string ancillary key, Ancillary key to add.
--- @p [opt=false] @boolean suppress event message, Whether to suppress the event message that the ancillary was added.
function campaign_manager:force_add_ancillary(char_str, anc_str, suppress_event_message)
     cm:force_add_ancillary_impl(char_str, anc_str, suppress_event_message, "force_add_ancillary", false)
end;

--- @function force_add_and_equip_ancillary
--- @desc Grant the specified ancillary to the specified character and equips it. If another ancillary is equipped in the relevant slot then that ancillary is unequipped.
--- @p @string character lookup, Character lookup string. For more information, see @"episodic_scripting:Character Lookups".
--- @p @string ancillary key, Ancillary key, from the <code>ancillaries</code> table.
--- @p [opt=false] @boolean suppress event message, Whether to suppress the event message that the ancillary was added.
function campaign_manager:force_add_and_equip_ancillary(char_str, anc_str, suppress_event_message)
     cm:force_add_ancillary_impl(char_str, anc_str, suppress_event_message, "force_add_and_equip_ancillary", true)
end;

--- @function force_add_trait
--- @desc Forceably adds an trait to a character. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the traits tab of the console.
--- @p string character string, Character string of the target character, using the standard character string lookup system.
--- @p string trait key, Trait key to add.
--- @p [opt=false] boolean show message, Show message.
--- @p [opt=1] number points, Trait points to add. The underlying <code>force_add_trait</code> function is called for each point added.
function campaign_manager:force_add_trait(char_str, trait_str, show_msg, points)
     if not is_string(char_str) then
          script_error("ERROR: force_add_trait() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     if not is_string(trait_str) then
          script_error("ERROR: force_add_trait() called but supplied trait string [" ..
          tostring(trait_str) .. "] is not a string");
          return false;
     end;

     show_msg = not not show_msg;
     points = points or 1;

     out.traits("* force_add_trait() is adding trait [" ..
     tostring(trait_str) ..
     "] to character [" ..
     tostring(char_str) .. "], showing message: " .. tostring(show_msg) .. ", points: " .. tostring(points));

     self.game_interface:force_add_trait(char_str, trait_str, show_msg, points);
end;

--- @function add_trait_to_character_by_family_member
--- @desc Grants the specified trait to a character specified by a family member. If character object doesn't exist, the trait is added to the persistent data of the character. If the character already has the trait, a trait point will be added. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the traits tab of the console.
--- @p number family_member_cqi, CQI of the family member of the target character
--- @p string trait key, Trait key to add.
--- @p [opt=false] boolean show message, Show message.
--- @p [opt=1] number points, Trait points to add. The underlying <code>force_add_trait</code> function is called for each point added.
function campaign_manager:add_trait_to_character_by_family_member(family_member_cqi, trait_str, show_msg, points)
     if not is_number(family_member_cqi) then
          script_error("ERROR: add_trait_to_character_by_family_member() called but supplied family_member_cqi [" ..
          tostring(family_member_cqi) .. "] is not a number");
          return false;
     end;

     if not is_string(trait_str) then
          script_error("ERROR: add_trait_to_character_by_family_member() called but supplied trait string [" ..
          tostring(trait_str) .. "] is not a string");
          return false;
     end;

     show_msg = not not show_msg;
     points = points or 1;

     out.traits("* add_trait_to_character_by_family_member() is adding trait [" ..
     tostring(trait_str) ..
     "] to character with family_member_cqi [" ..
     tostring(family_member_cqi) .. "], showing message: " .. tostring(show_msg) .. ", points: " .. tostring(points));

     self.game_interface:add_trait_to_character_by_family_member(family_member_cqi, trait_str, show_msg, points);
end;

--- @function force_add_skill
--- @desc Forceably adds a skill to a character. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the traits tab of the console.
--- @p string character string, Character string of the target character, using the standard character string lookup system.
--- @p string skill key, Skill key to add.
function campaign_manager:force_add_skill(char_str, skill_str, direct_add, reset_unassigned_skill_points)
     if not is_string(char_str) then
          script_error("ERROR: force_add_skill() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     if not is_string(skill_str) then
          script_error("ERROR: force_add_skill() called but supplied skill string [" ..
          tostring(skill_str) .. "] is not a string");
          return false;
     end;

     out.traits("* force_add_skill() is adding skill [" ..
     tostring(skill_str) ..
     "] to character [" ..
     tostring(char_str) ..
     "] direct add [" ..
     (direct_add and "true" or "false") ..
     "] reset unassigned skill points [" .. (reset_unassigned_skill_points and "true" or "false") .. "]")
     self.game_interface:force_add_skill(char_str, skill_str, direct_add, reset_unassigned_skill_points)
end;

--- @function force_remove_skill
--- @desc Forcibly removes a skill from a character. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the traits tab of the console.
--- @p string character string, Character string of the target character, using the standard character string lookup system.
--- @p string skill key, Skill key to remove.
--- @p [opt=true] boolean refund skill point, Whether to refund a skill point when the skill is successfully removed
function campaign_manager:force_remove_skill(char_str, skill_str, refund_skill_point)
     if not is_string(char_str) then
          script_error("ERROR: force_remove_skill() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     if not is_string(skill_str) then
          script_error("ERROR: force_remove_skill() called but supplied skill string [" ..
          tostring(skill_str) .. "] is not a string");
          return false;
     end;

     if is_nil(refund_skill_point) then
          refund_skill_point = true
     end

     out.traits("* force_remove_skill() is removing skill [" ..
     tostring(skill_str) ..
     "] from character [" ..
     tostring(char_str) .. "] and refunding skill point is [" .. tostring(refund_skill_point) .. "]")
     self.game_interface:force_remove_skill(char_str, skill_str, refund_skill_point)
end;

--- @function reset_skills_for_character
--- @desc Forceably resets skilsl of a character. This calls the function force_reset_skills(), but adds validation and output. This output will be shown on the traits tab of the console.
--- @p number character cqi(command q index)
function campaign_manager:reset_skills_for_character(char_cqi)
     if not is_number(char_cqi) then
          script_error("ERROR: force_add_skill() called but supplied character string [" ..
          tostring(char_str) .. "] is not a string");
          return false;
     end;

     local character_str = "character_cqi:" .. tostring(char_cqi)
     out.traits("* reset_skills_for_character() is reseting skills of character [" .. tostring(char_str) .. "]");
     self.game_interface:force_reset_skills(char_str);
end;

--- @function rank_up_agent
--- @desc Forceably adds experience to a character in order for it to reach a certain rank (no downgrading is supported). This calls a couple of times the function add_agent_experience on the <a href="../../scripting_doc.html">game interface</a>.
--- @p string cqi, Character CQI as a string.
--- @p number rank, Rank to be reached.
function campaign_manager:rank_up_agent(cqi, rank)
     if not is_number(cqi) then
          script_error("ERROR: rank_up_agent() called but supplied character cqi [" ..
          tostring(cqi) .. "] is not a number");
          return false;
     end;

     if not is_number(rank) then
          script_error("ERROR: rank_up_agent() called but supplied rank [" .. tostring(rank) .. "] is not a number");
          return false;
     end;

     local model = self:model();
     if not model:has_character_command_queue_index(cqi) then
          script_error("ERROR: rank_up_agent() called but there is no character with the supplied character cqi [" ..
          tostring(cqi) .. "]");
          return false
     end;

     local character_str = "character_cqi:" .. tostring(cqi)
     local character = model:character_for_command_queue_index(cqi)
     local required_experience = character:experience_required_for_rank(rank)
     self.game_interface:add_agent_experience(character_str, required_experience);
end;

--- @function add_agent_experience
--- @desc Forceably adds experience to a character. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds output.
--- @p string character string, Character string of the target character, using the standard character string lookup system.
--- @p number experience, Experience to add.
--- @p [opt=false] boolean by_level, If set to true, the level/rank can be supplied instead of an exact amount of experience which is looked up from a table in the campaign manager. Note that this is not advised as this table is easily going out of sink with the DB. Use rank_up_agent function instead!
--- @p [opt=false] boolean suppress_output, If set to true output is added.
function campaign_manager:add_agent_experience(char_str, exp_to_give, by_level, suppress_output)
     if by_level then
          exp_to_give = self.character_xp_per_level[exp_to_give];
     end;
     if not not suppress_output then
          out("add_agent_experience() called, char_str is " ..
          tostring(char_str) .. " and experience to give is " .. tostring(exp_to_give));
     end
     return self.game_interface:add_agent_experience(char_str, exp_to_give);
end;

-- The amount of xp required for a character to attain each level
-- Ensure this matches the character_experience_skill_tiers table
campaign_manager.character_xp_per_level = {
     0, 900, 1900, 3000, 4200, 5500, 6890, 8370, 9940, 11510, -- 1 - 10
     13080, 14660, 16240, 17820, 19400, 20990, 22580, 24170, 25770, 27370, -- 11 - 20
     28980, 30590, 32210, 33830, 35460, 37100, 38740, 40390, 42050, 43710, -- 21 - 30
     45380, 47060, 48740, 50430, 52130, 53830, 55540, 57260, 58990, 60730 -- 31 - 40
};












-----------------------------------------------------------------------------
--- @section Co-ordinates
-----------------------------------------------------------------------------


--- @function log_to_dis
--- @desc Converts a set of logical co-ordinates into display co-ordinates.
--- @p number x, Logical x co-ordinate.
--- @p number y, Logical y co-ordinate.
--- @return number Display x co-ordinate.
--- @return number Display x co-ordinate.
function campaign_manager:log_to_dis(x, y)
     if not is_number(x) or x < 0 then
          script_error("ERROR: log_to_dis() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: log_to_dis() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     local display_x = x * 678.5 / 1016;
     local display_y = y * 555.37 / 720;

     return display_x, display_y;
end;

--- @function dis_to_log
--- @desc Converts a set of display co-ordinates into logical co-ordinates.
--- @p number x, Display x co-ordinate.
--- @p number y, Display y co-ordinate.
--- @return number Logical x co-ordinate.
--- @return number Logical x co-ordinate.
function campaign_manager:dis_to_log(x, y)
     if not is_number(x) or x < 0 then
          script_error("ERROR: dis_to_log() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a positive number");
          return;
     end;

     if not is_number(y) or y < 0 then
          script_error("ERROR: dis_to_log() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a positive number");
          return;
     end;

     return self:model():logical_position_for_display_position(x, y);
end;

--- @function distance_squared
--- @desc Returns the distance squared between two positions. The positions can be logical or display, as long as they are both in the same co-ordinate space. The squared distance is returned as it's faster to compare squared distances rather than taking the square-root.
--- @p number first x, x co-ordinate of the first position.
--- @p number first y, y co-ordinate of the first position.
--- @p number second x, x co-ordinate of the second position.
--- @p number second y, y co-ordinate of the second position.
--- @return number distance between positions squared.
function distance_squared(a_x, a_y, b_x, b_y)
     return (b_x - a_x) ^ 2 + (b_y - a_y) ^ 2;
end;

-----------------------------------------------------------------------------
--- @section Bonus Values
-----------------------------------------------------------------------------


--- @function get_characters_bonus_value
--- @desc Returns the scripted bonus value a supplied character has of a supplied id.
--- @p character character interface
--- @p @string Scripted bonus value key, from the <code>scripted_bonus_value_ids</code> database table.
--- @r @number Bonus value amount.
function campaign_manager:get_characters_bonus_value(character, id)
     if not is_character(character) then
          script_error("ERROR: get_characters_bonus_value() called, but supplied character [" ..
          tostring(region) .. "] is not a character object");
          return false;
     end;

     if not is_string(id) then
          script_error("ERROR: get_characters_bonus_value() called, but supplied id [" ..
          tostring(region) .. "] is not a string");
          return false;
     end;

     return character:bonus_values():scripted_value(id, "value");
end;

--- @function get_regions_bonus_value
--- @desc Returns the scripted bonus value a supplied region object has of a supplied id. It may also be supplied a region key in place of a region object.
--- @p object region interface or region key
--- @p @string Scripted bonus value key, from the <code>scripted_bonus_value_ids</code> database table.
--- @r @number Bonus value amount.
function campaign_manager:get_regions_bonus_value(region, id)
     if not is_string(region) and not is_region(region) then
          script_error("ERROR: get_regions_bonus_value() called, but supplied region [" ..
          tostring(region) .. "] is not a string or region object");
          return false;
     end;

     if not is_string(id) then
          script_error("ERROR: get_regions_bonus_value() called, but supplied id [" ..
          tostring(region) .. "] is not a string");
          return false;
     end;

     if is_string(region) then
          region = cm:get_region(region);

          if not is_region(region) then
               script_error("ERROR: get_regions_bonus_value() called, but supplied region [" ..
               tostring(region) .. "] is not a key of a valid region");
               return false;
          end;
     end;

     return region:bonus_values():scripted_value(id, "value");
end;
-- Lycia Bookmark!
--- @function get_factions_bonus_value
--- @desc Returns the scripted bonus value a supplied faction object has of a supplied id. It may also be supplied a faction key in place of a faction object.
--- @p object faction interface or faction key
--- @p @string Scripted bonus value key, from the <code>scripted_bonus_value_ids</code> database table.
--- @r @number Bonus value amount.
function campaign_manager:get_factions_bonus_value(faction, id)
     if not is_string(faction) and not is_faction(faction) then
          script_error("ERROR: get_factions_bonus_value() called, but supplied faction [" ..
          tostring(faction) .. "] is not a string or faction object");
          return false;
     end;

     if not is_string(id) then
          script_error("ERROR: get_factions_bonus_value() called, but supplied id [" ..
          tostring(faction) .. "] is not a string");
          return false;
     end;

     if is_string(faction) then
          faction = cm:get_faction(faction);

          if not is_faction(faction) then
               script_error("ERROR: get_factions_bonus_value() called, but supplied faction [" ..
               tostring(faction) .. "] is not a key of a valid faction");
               return false;
          end;
     end;

     return faction:bonus_values():scripted_value(id, "value");
end;

--- @function get_forces_bonus_value
--- @desc Returns the scripted bonus value a supplied character has of a supplied id.
--- @p military_force military force interface
--- @p @string Scripted bonus value key, from the <code>scripted_bonus_value_ids</code> database table.
--- @r @number Bonus value amount.
function campaign_manager:get_forces_bonus_value(military_force, id)
     if not is_militaryforce(military_force) then
          script_error("ERROR: get_forces_bonus_value() called, but supplied faction [" ..
          tostring(faction) .. "] is not a key of a valid faction");
          return false;
     end;

     if not is_string(id) then
          script_error("ERROR: get_forces_bonus_value() called, but supplied faction [" ..
          tostring(faction) .. "] is not a key of a valid faction");
          return false;
     end;

     return military_force:bonus_values():scripted_value(id, "value");
end;

-----------------------------------------------------------------------------
--- @section Debug Drawing
-----------------------------------------------------------------------------


--- @function draw_text
--- @desc Draws debug text in the 3D space
--- @p string text, Text to write
--- @p number x, Display x co-ordinate.
--- @p number y, Display y co-ordinate.
--- @p number z, Display z co-ordinate (height).
--- @p number duration, Duration to display the text for.
--- @p [opt=255] number r, Red value
--- @p [opt=255] number g, Green value
--- @p [opt=255] number b, Blue value
--- @p [opt=255] number a, Alpha value
function campaign_manager:draw_text(text, x_pos, y_pos, z_pos, duration, r, g, b, a)
     if not is_string(text) then
          script_error("ERROR: draw_text() called but supplied text [" .. tostring(text) .. "] is not a string");
          return;
     end;

     r = r or 255;
     g = g or 255;
     b = b or 255;
     a = a or 255;

     local debug_drawing = self:model():debug_drawing();
     debug_drawing:set_begin(x_pos, z_pos, y_pos);
     debug_drawing:set_colour(r, g, b, a);
     debug_drawing:set_draw_duration(duration);
     debug_drawing:draw_text(text);
end;

--- @function draw_2d_text
--- @desc Draws debug text to the screen, in 2D
--- @p string text, Text to write
--- @p number x, x pixel position.
--- @p number y, y pixel position.
--- @p number duration, Duration to display the text for.
--- @p [opt=255] number r, Red value
--- @p [opt=255] number g, Green value
--- @p [opt=255] number b, Blue value
--- @p [opt=255] number a, Alpha value
function campaign_manager:draw_2d_text(text, x_pos, y_pos, duration, r, g, b, a)
     if not is_string(text) then
          script_error("ERROR: draw_2d_text() called but supplied text [" .. tostring(text) .. "] is not a string");
          return;
     end;

     r = r or 255;
     g = g or 255;
     b = b or 255;
     a = a or 255;

     local debug_drawing = self:model():debug_drawing();
     debug_drawing:set_colour(r, g, b, a);
     debug_drawing:set_draw_duration(duration);
     debug_drawing:draw_text_screen_space(text, x_pos, y_pos);
end;

--- @function draw_line
--- @desc Draws a debug line in the 3D space
--- @p number x_start_pos, Start point display x co-ordinate.
--- @p number y_start_pos, Start point display y co-ordinate.
--- @p number z_start_pos, Start point display z co-ordinate (height).
--- @p number x_end_pos, End point display x co-ordinate.
--- @p number y_end_pos, End point display y co-ordinate.
--- @p number z_end_pos, End point display z co-ordinate (height).
--- @p number duration, Duration to display the text for.
--- @p [opt=255] number r, Red value
--- @p [opt=255] number g, Green value
--- @p [opt=255] number b, Blue value
--- @p [opt=255] number a, Alpha value
function campaign_manager:draw_line(x_start_pos, y_start_pos, z_start_pos, x_end_pos, y_end_pos, z_end_pos, duration, r,
                                    g, b, a)
     r = r or 255;
     g = g or 255;
     b = b or 255;
     a = a or 255;

     local debug_drawing = self:model():debug_drawing();
     debug_drawing:set_begin(x_start_pos, z_start_pos, y_start_pos);
     debug_drawing:set_end(x_end_pos, z_end_pos, y_end_pos);
     debug_drawing:set_colour(r, g, b, a);
     debug_drawing:set_draw_duration(duration);
     debug_drawing:draw_line();
end;

-----------------------------------------------------------------------------
--- @section Restricting Units, Buildings, and Technologies
--- @desc The game allows the script to place or lift restrictions on factions recruiting certain units, constructing certain buildings and researching certain technologies. Note that lifting a restriction with one of the following commands does not grant the faction access to that unit/building/technology, as standard requirements will still apply (e.g. building requirements to recruit a unit).
-----------------------------------------------------------------------------


--- @function restrict_units_for_faction
--- @desc Applies a restriction to or removes a restriction from a faction recruiting one or more unit types.
--- @p string faction name, Faction name.
--- @p table unit list, Numerically-indexed table of string unit keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_units_for_faction(faction_name, unit_list, value)
     if not is_string(faction_name) then
          script_error("ERROR: restrict_units_for_faction() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string");
          return;
     end;

     if not is_table(unit_list) then
          script_error("ERROR: restrict_units_for_faction() called but supplied unit_list [" ..
          tostring(unit_list) .. "] is not a table");
          return;
     end;

     if #unit_list == 0 then
          return
     end

     local game_interface = self.game_interface;

     if value ~= false then
          value = true;
     end;

     if value then
          for i = 1, #unit_list do
               local current_rec = unit_list[i];
               game_interface:add_event_restricted_unit_record_for_faction(current_rec, faction_name);
          end;
          out("restricted " .. tostring(#unit_list) .. " unit records for faction " .. faction_name);
     else
          for i = 1, #unit_list do
               local current_rec = unit_list[i];
               game_interface:remove_event_restricted_unit_record_for_faction(current_rec, faction_name);
          end;
          out("unrestricted " .. tostring(#unit_list) .. " unit records for faction " .. faction_name);
     end;
end;

--- @function restrict_buildings_for_faction
--- @desc Restricts or unrestricts a faction from constructing one or more building types.
--- @p string faction name, Faction name.
--- @p table building list, Numerically-indexed table of string building keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_buildings_for_faction(faction_name, building_list, value)
     if not is_string(faction_name) then
          script_error("ERROR: restrict_buildings_for_faction() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string");
          return;
     end;

     if not is_table(building_list) then
          script_error("ERROR: restrict_buildings_for_faction() called but supplied building_list [" ..
          tostring(building_list) .. "] is not a table");
          return;
     end;

     if #building_list == 0 then
          return
     end

     local game_interface = self.game_interface;

     if value ~= false then
          value = true;
     end;

     if value then
          for i = 1, #building_list do
               local current_rec = building_list[i];

               game_interface:add_event_restricted_building_record_for_faction(current_rec, faction_name);
          end;
          out.design("restricted " .. tostring(#building_list) .. " building records for faction " .. faction_name);
     else
          for i = 1, #building_list do
               local current_rec = building_list[i];

               game_interface:remove_event_restricted_building_record_for_faction(current_rec, faction_name);
          end;
          out.design("unrestricted " .. tostring(#building_list) .. " building records for faction " .. faction_name);
     end;
end;

--- @function restrict_building_chains_for_faction
--- @desc Restricts or unrestricts a faction from constructing buildings from one or more building chains.
--- @p string faction name, Faction name.
--- @p table building chain list, Numerically-indexed table of string building chain keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_building_chains_for_faction(faction_name, building_chain_list, value)
     if not is_string(faction_name) then
          script_error("ERROR: restrict_building_chains_for_faction() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string")
          return
     end

     if not is_table(building_chain_list) then
          script_error("ERROR: restrict_building_chains_for_faction() called but supplied building_chain_list [" ..
          tostring(building_chain_list) .. "] is not a table")
          return
     end

     if #building_chain_list == 0 then
          return
     end

     local game_interface = self.game_interface

     if value ~= false then
          value = true
     end

     if value then
          for i = 1, #building_chain_list do
               local current_rec = building_chain_list[i]

               game_interface:add_event_restricted_building_chain_record_for_faction(current_rec, faction_name)
          end
          out.design("restricted " ..
          tostring(#building_chain_list) .. " building chain records for faction " .. faction_name)
     else
          for i = 1, #building_chain_list do
               local current_rec = building_chain_list[i]

               game_interface:remove_event_restricted_building_chain_record_for_faction(current_rec, faction_name)
          end
          out.design("unrestricted " ..
          tostring(#building_chain_list) .. " building chain records for faction " .. faction_name)
     end
end

--- @function restrict_buildings_for_faction_with_manual_conversion
--- @desc Restricts or unrestricts a faction from constructing one or more building types, but sets them to be manualy converted for human factions if they acquire a region with them in it.
--- @p string faction name, Faction name.
--- @p table building list, Numerically-indexed table of string building keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_buildings_for_faction_with_manual_conversion(faction_name, building_list, value)
     if not is_string(faction_name) then
          script_error(
          "ERROR: restrict_buildings_for_faction_with_manual_conversion() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string")
          return
     end

     if not is_table(building_list) then
          script_error(
          "ERROR: restrict_buildings_for_faction_with_manual_conversion() called but supplied building_list [" ..
          tostring(building_list) .. "] is not a table")
          return
     end

     if #building_list == 0 then
          return
     end

     local game_interface = self.game_interface

     if value ~= false then
          value = true
     end

     if value then
          for i = 1, #building_list do
               local current_rec = building_list[i]

               game_interface:add_event_restricted_building_record_for_faction_with_manual_conversion(current_rec,
                    faction_name)
          end
          out.design("restricted " .. tostring(#building_list) .. " building records for faction " .. faction_name)
     else
          for i = 1, #building_list do
               local current_rec = building_list[i]

               game_interface:remove_event_restricted_building_record_for_faction_with_manual_conversion(current_rec,
                    faction_name)
          end
          out.design("unrestricted " .. tostring(#building_list) .. " building records for faction " .. faction_name)
     end;
end;

--- @function restrict_building_chains_for_faction_with_manual_conversion
--- @desc Restricts or unrestricts a faction from constructing buildings from one or more building chains, but sets them to be manualy converted for human factions if they acquire a region with them in it.
--- @p string faction name, Faction name.
--- @p table building chain list, Numerically-indexed table of string building chain keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_building_chains_for_faction_with_manual_conversion(faction_name, building_chain_list,
                                                                                      value)
     if not is_string(faction_name) then
          script_error(
          "ERROR: restrict_building_chains_for_faction_with_manual_conversion() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string")
          return
     end

     if not is_table(building_chain_list) then
          script_error(
          "ERROR: restrict_building_chains_for_faction_with_manual_conversion() called but supplied building_chain_list [" ..
          tostring(building_chain_list) .. "] is not a table")
          return
     end

     if #building_chain_list == 0 then
          return
     end

     local game_interface = self.game_interface

     if value ~= false then
          value = true
     end

     if value then
          for i = 1, #building_chain_list do
               local current_rec = building_chain_list[i]

               game_interface:add_event_restricted_building_chain_record_for_faction_with_manual_conversion(current_rec,
                    faction_name)
          end
          out.design("restricted " ..
          tostring(#building_chain_list) .. " building chain records for faction " .. faction_name)
     else
          for i = 1, #building_chain_list do
               local current_rec = building_chain_list[i]

               game_interface:remove_event_restricted_building_chain_record_for_faction_with_manual_conversion(
               current_rec, faction_name)
          end
          out.design("unrestricted " ..
          tostring(#building_chain_list) .. " building chain records for faction " .. faction_name)
     end
end

--- @function restrict_technologies_for_faction
--- @desc Restricts or unrestricts a faction from researching one or more technologies.
--- @p string faction name, Faction name.
--- @p table building list, Numerically-indexed table of string technology keys.
--- @p [opt=true] boolean should restrict, Set this to <code>true</code> to apply the restriction, <code>false</code> to remove it.
function campaign_manager:restrict_technologies_for_faction(faction_name, tech_list, value)
     if not is_string(faction_name) then
          script_error("ERROR: restrict_technologies_for_faction() called but supplied faction_name [" ..
          tostring(faction_name) .. "] is not a string");
          return;
     end;

     if not is_table(tech_list) then
          script_error("ERROR: restrict_technologies_for_faction() called but supplied tech_list [" ..
          tostring(tech_list) .. "] is not a table");
          return;
     end;

     if #tech_list == 0 then
          return
     end

     local game_interface = self.game_interface;

     if value ~= false then
          value = true;
     end;

     if value then
          for i = 1, #tech_list do
               local current_rec = tech_list[i];

               game_interface:lock_technology(faction_name, current_rec);
          end;
          out("restricted " .. tostring(#tech_list) .. " tech records for faction " .. faction_name);
     else
          for i = 1, #tech_list do
               local current_rec = tech_list[i];

               game_interface:unlock_technology(faction_name, current_rec);
          end;
          out("unrestricted " .. tostring(#tech_list) .. " tech records for faction " .. faction_name);
     end;
end;

-----------------------------------------------------------------------------
--- @section Effect Bundles
--- @desc These this section contains functions that add and remove effect bundles from factions, military forces and regions. In each case they wrap a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>, providing input validation and console output.
-----------------------------------------------------------------------------


--- @function apply_effect_bundle
--- @desc Applies an effect bundle to a faction for a number of turns (can be infinite).
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string faction key, Faction key of the faction to apply the effect to.
--- @p number turns, Number of turns to apply the effect bundle for. Supply 0 here to apply the effect bundle indefinitely (it can be removed later with @campaign_manager:remove_effect_bundle if required).
function campaign_manager:apply_effect_bundle(bundle_key, faction_name, turns)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_string(faction_name) then
          script_error("ERROR: apply_effect_bundle() called but supplied faction key [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     if not is_number(turns) then
          script_error("ERROR: apply_effect_bundle() called but supplied turn count [" ..
          tostring(turns) .. "] is not a number");
          return false;
     end;

     -- Prevent underflow - We assume -1 being passed is intended to be infinite
     if turns < 0 then
          turns = 0;
     end

     out.design(" & Applying effect bundle [" ..
     bundle_key .. "] to faction [" .. faction_name .. "] for [" .. turns .. "] turns");

     return self.game_interface:apply_effect_bundle(bundle_key, faction_name, turns);
end;

--- @function remove_effect_bundle
--- @desc Removes an effect bundle from a faction.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string faction key, Faction key of the faction to remove the effect from.
function campaign_manager:remove_effect_bundle(bundle_key, faction_name)
     if not is_string(bundle_key) then
          script_error("ERROR: remove_effect_bundle() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_string(faction_name) then
          script_error("ERROR: remove_effect_bundle() called but supplied faction key [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     out.design(" & Removing effect bundle [" .. bundle_key .. "] from faction [" .. faction_name .. "]");

     return self.game_interface:remove_effect_bundle(bundle_key, faction_name);
end;

--- @function apply_effect_bundle_to_force
--- @desc Applies an effect bundle to a military force by cqi for a number of turns (can be infinite).
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the military force to apply the effect bundle to.
--- @p number turns, Number of turns to apply the effect bundle for. Supply 0 here to apply the effect bundle indefinitely (it can be removed later with @campaign_manager:remove_effect_bundle_from_force if required).
function campaign_manager:apply_effect_bundle_to_force(bundle_key, mf_cqi, turns)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle_to_force() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_number(mf_cqi) then
          script_error("ERROR: apply_effect_bundle_to_force() called but supplied mf cqi [" ..
          tostring(mf_cqi) .. "] is not a number");
          return false;
     end;

     if not is_number(turns) then
          script_error("ERROR: apply_effect_bundle_to_force() called but supplied turn count [" ..
          tostring(turns) .. "] is not a number");
          return false;
     end;

     -- Prevent underflow - We assume -1 being passed is intended to be infinite
     if turns < 0 then
          turns = 0;
     end

     out.design(" & Applying effect bundle [" ..
     bundle_key .. "] to military force with cqi [" .. mf_cqi .. "] for [" .. turns .. "] turns");

     return self.game_interface:apply_effect_bundle_to_force(bundle_key, mf_cqi, turns);
end;

--- @function remove_effect_bundle_from_force
--- @desc Removes an effect bundle from a military force by cqi.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the military force to remove the effect from.
function campaign_manager:remove_effect_bundle_from_force(bundle_key, mf_cqi)
     if not is_string(bundle_key) then
          script_error("ERROR: remove_effect_bundle_from_force() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_number(mf_cqi) then
          script_error("ERROR: remove_effect_bundle_from_force() called but supplied mf cqi [" ..
          tostring(mf_cqi) .. "] is not a number");
          return false;
     end;

     out.design(" & Removing effect bundle [" .. bundle_key .. "] from military force with cqi [" .. mf_cqi .. "]");

     return self.game_interface:remove_effect_bundle_from_force(bundle_key, mf_cqi);
end;

--- @function apply_effect_bundle_to_characters_force
--- @desc This function applies an effect bundle to a military force for a number of turns (can be infinite). It differs from @campaign_manager:apply_effect_bundle_to_force by referring to the force by its commanding character's cqi.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the military force's commanding character to apply the effect bundle to.
--- @p number turns, Number of turns to apply the effect bundle for. Supply 0 here to apply the effect bundle indefinitely (it can be removed later with @campaign_manager:remove_effect_bundle_from_characters_force if required).
function campaign_manager:apply_effect_bundle_to_characters_force(bundle_key, char_cqi, turns)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle_to_characters_force() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_number(char_cqi) then
          script_error("ERROR: apply_effect_bundle_to_characters_force() called but supplied character cqi [" ..
          tostring(char_cqi) .. "] is not a number");
          return false;
     end;

     if not is_number(turns) then
          script_error("ERROR: apply_effect_bundle_to_characters_force() called but supplied turn count [" ..
          tostring(turns) .. "] is not a number");
          return false;
     end;

     -- Prevent underflow - We assume -1 being passed is intended to be infinite
     if turns < 0 then
          turns = 0;
     end

     out.design("& Applying effect bundle [" ..
     bundle_key .. "] to the force of character with cqi [" .. char_cqi .. "] for [" .. turns .. "] turns");

     return self.game_interface:apply_effect_bundle_to_characters_force(bundle_key, char_cqi, turns);
end;

--- @function remove_effect_bundle_from_characters_force
--- @desc Removes an effect bundle from a military force by its commanding character's cqi.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the character commander of the military force to remove the effect from.
function campaign_manager:remove_effect_bundle_from_characters_force(bundle_key, char_cqi)
     if not is_string(bundle_key) then
          script_error("ERROR: remove_effect_bundle_from_characters_force() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_number(char_cqi) then
          script_error("ERROR: remove_effect_bundle_from_characters_force() called but supplied character cqi [" ..
          tostring(char_cqi) .. "] is not a number");
          return false;
     end;

     out.design(" & Removing effect bundle [" ..
     bundle_key .. "] from the force of character with cqi [" .. char_cqi .. "]");

     return self.game_interface:remove_effect_bundle_from_characters_force(bundle_key, char_cqi);
end;

--- @function apply_effect_bundle_to_region
--- @desc Applies an effect bundle to a region for a number of turns (can be infinite).
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string region key, Key of the region to add the effect bundle to.
--- @p number turns, Number of turns to apply the effect bundle for. Supply 0 here to apply the effect bundle indefinitely (it can be removed later with @campaign_manager:remove_effect_bundle_from_region if required).
function campaign_manager:apply_effect_bundle_to_region(bundle_key, region_key, turns)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle_to_region() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_string(region_key) then
          script_error("ERROR: apply_effect_bundle_to_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     if not is_number(turns) then
          script_error("ERROR: apply_effect_bundle_to_region() called but supplied turn count [" ..
          tostring(turns) .. "] is not a number");
          return false;
     end;

     -- Prevent underflow - We assume -1 being passed is intended to be infinite
     if turns < 0 then
          turns = 0;
     end

     out.design(" & Applying effect bundle [" ..
     bundle_key .. "] to region with key [" .. region_key .. "] for [" .. turns .. "] turns");

     return self.game_interface:apply_effect_bundle_to_region(bundle_key, region_key, turns);
end;

--- @function remove_effect_bundle_from_region
--- @desc Removes an effect bundle from a region.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the character commander of the military force to remove the effect from.
function campaign_manager:remove_effect_bundle_from_region(bundle_key, region_key)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle_to_region() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_string(region_key) then
          script_error("ERROR: apply_effect_bundle_to_region() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string");
          return false;
     end;

     out.design(" & Removing effect bundle [" .. bundle_key .. "] from region with key [" .. region_key .. "]");

     return self.game_interface:remove_effect_bundle_from_region(bundle_key, region_key);
end;

--- @function apply_effect_bundle_to_province
--- @desc Applies an effect bundle to a province for a number of turns (can be infinite).
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string region key, Key of the region to add the effect bundle to.
--- @p number turns, Number of turns to apply the effect bundle for. Supply 0 here to apply the effect bundle indefinitely (it can be removed later with @campaign_manager:remove_effect_bundle_from_region if required).
function campaign_manager:apply_effect_bundle_to_province(bundle_key, region_key, turns)
     if not is_string(bundle_key) then
          script_error("ERROR: apply_effect_bundle_to_province() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string")
          return false
     end

     if not is_string(region_key) then
          script_error("ERROR: apply_effect_bundle_to_province() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     if not is_number(turns) then
          script_error("ERROR: apply_effect_bundle_to_province() called but supplied turn count [" ..
          tostring(turns) .. "] is not a number")
          return false
     end

     -- Prevent underflow - We assume -1 being passed is intended to be infinite
     if turns < 0 then
          turns = 0
     end

     out.design(" & Applying effect bundle [" ..
     bundle_key .. "] to province of region with key [" .. region_key .. "] for [" .. turns .. "] turns")

     return self.game_interface:apply_effect_bundle_to_province(bundle_key, region_key, turns)
end

--- @function remove_effect_bundle_from_province
--- @desc Removes an effect bundle from a province.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @p string number cqi, Command queue index of the character commander of the military force to remove the effect from.
function campaign_manager:remove_effect_bundle_from_province(bundle_key, region_key)
     if not is_string(bundle_key) then
          script_error("ERROR: remove_effect_bundle_from_province() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string")
          return false
     end

     if not is_string(region_key) then
          script_error("ERROR: remove_effect_bundle_from_province() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     out.design(" & Removing effect bundle [" .. bundle_key .. "] from region with key [" .. region_key .. "]")

     return self.game_interface:remove_effect_bundle_from_province(bundle_key, region_key)
end

--- @function clone_or_create_custom_effect_bundle
--- @desc Checks if the provided faction already has an active effect bundle with that key and returns a custom variant with cloned effects. Otherwise acts as create_custom_effect_bundle.
--- @p string faction key, Faction name from the factions table.
--- @p string effect bundle key, Effect bundle key from the effect bundles table.
--- @r @custom_effect_bundle custom effect bundle
function campaign_manager:clone_or_create_custom_effect_bundle(faction_key, bundle_key)
     if not is_string(bundle_key) then
          script_error("ERROR: clone_or_create_custom_effect_bundle() called but supplied bundle key [" ..
          tostring(bundle_key) .. "] is not a string");
          return false;
     end;

     if not is_string(faction_key) then
          script_error("ERROR: clone_or_create_custom_effect_bundle() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return false;
     end;

     local faction = cm:get_faction(faction_key)
     local new_custom_effect_bundle = cm:create_new_custom_effect_bundle(bundle_key)

     if faction:has_effect_bundle(bundle_key) then
          local original_effect_bundle = faction:get_effect_bundle(bundle_key)
          for i = 0, original_effect_bundle:effects():num_items() - 1 do
               local curr_effect = original_effect_bundle:effects():item_at(i)
               new_custom_effect_bundle:add_effect(curr_effect:key(), curr_effect:scope(), curr_effect:value())
          end
     end

     return new_custom_effect_bundle
end

-----------------------------------------------------------------------------
--- @section Shroud Manipulation
-----------------------------------------------------------------------------


--- @function lift_all_shroud
--- @desc Lifts the shroud on all regions. This may be useful for cutscenes in general and benchmarks in-particular.
function campaign_manager:lift_all_shroud()
     local region_list = self:model():world():region_manager():region_list();
     local local_faction_name = self:get_local_faction_name(true);
     for i = 0, region_list:num_items() - 1 do
          local curr_region = region_list:item_at(i);

          self.game_interface:make_region_visible_in_shroud(local_faction_name, curr_region:name());
     end;
end;

--- @function make_regions_visible_in_shroud_for_faction
--- @desc Lifts the shroud for a supplied faction from each region in a supplied list.
--- @p @string faction key, Faction key, from the <code>factions</code> database table.
--- @p @table region keys, Table of region keys, each from the <code>regions</code> database table.
function campaign_manager:make_regions_visible_in_shroud_for_faction(faction_key, region_keys)
     if not is_table(region_keys) then
          script_error("ERROR: make_regions_visible_in_shroud_for_faction() called but supplied region_keys [" ..
          tostring(region_keys) .. "] is not a table");
          return;
     end;

     if not is_string(faction_key) then
          script_error("ERROR: make_regions_visible_in_shroud_for_faction() called but supplied faction_key [" ..
          tostring(faction_key) .. "] is not a string");
          return;
     end;

     for i = 1, #region_keys do
          local region_key = region_keys[i];
          if is_string(region_key) then
               self.game_interface:make_region_visible_in_shroud(faction_key, region_key)
          end;
     end;
end;

-----------------------------------------------------------------------------
--- @section Diplomacy
--- @desc The @campaign_manager:force_diplomacy function can be used to restrict or unrestrict diplomacy between factions. The following types of diplomacy are available to restrict - not all of them may be supported by each project:
-----------------------------------------------------------------------------


-- campaign diplomacy types
--[[
campaign_manager.diplomacy_types = {
	["trade agreement"] = 2^0,						--- @desc <ul><li>"trade agreement"</li>
	["hard military access"] = 2^1,					--- @desc <li>"hard military access"</li>
	["cancel hard military access"] = 2^2,			--- @desc <li>"cancel hard military access"</li>
	["military alliance"] = 2^3,					--- @desc <li>"military alliance"</li>
	["regions"] = 2^4,								--- @desc <li>"regions"</li>
	["technology"] = 2^5,							--- @desc <li>"technology"</li>
	["state gift"] = 2^6,							--- @desc <li>"state gift"</li>
	["payments"] = 2^7,								--- @desc <li>"payments"</li>
	["vassal"] = 2^8,								--- @desc <li>"vassal"</li>
	["subjugate"] =  2^9,							--- @desc <li>"subjugate"</li>
	["become subject"] =,2^10						--- @desc <li>"become subject"</li>
	["peace"] = 2^11,								--- @desc <li>"peace"</li>
	["war"] = 2^12,									--- @desc <li>"war"</li>
	["join war"] = 2^13,							--- @desc <li>"join war"</li>
	["break trade"] = 2^14,							--- @desc <li>"break trade"</li>
	["break alliance"] = 2^15,						--- @desc <li>"break alliance"</li>
	["hostages"] = 2^16,							--- @desc <li>"hostages"</li>
	["marriage"] = 2^17,							--- @desc <li>"marriage"</li>
	["non aggression pact"] = 2^18,					--- @desc <li>"non aggression pact"</li>
	["soft military access"] = 2^19,				--- @desc <li>"soft military access"</li>
	["cancel soft military access"] = 2^20,			--- @desc <li>"cancel soft military access"</li>
	["defensive alliance"] = 2^21,					--- @desc <li>"defensive alliance"</li>
	["client state"] = 2^22,						--- @desc <li>"client state"</li>
	["form confederation"] = 2^23,					--- @desc <li>"form confederation"</li>
	["break non aggression pact"] = 2^24,			--- @desc <li>"break non aggression pact"</li>
	["break soft military access"] = 2^25,			--- @desc <li>"break soft military access"</li>
	["break defensive alliance"] = 2^26,			--- @desc <li>"break defensive alliance"</li>
	["break vassal"] = 2^27,						--- @desc <li>"break vassal"</li>
	["break subject"] = 2^28,						--- @desc <li>"break subject"</li>
	["break client state"] = 2^29,					--- @desc <li>"break client state"</li>
	["state gift unilateral"] = 2^30,				--- @desc <li>"state gift unilateral"</li>
	["diplomatic gift"] = 2^31,						--- @desc <li>"diplomatic gift"</li>
	["single barters"] = 2^32,						--- @desc <li>"single barters"</li>
	["barter agreements"] = 2^33,					--- @desc <li>"barter agreements"</li>
	["cancel barters"] = 2^34,						--- @desc <li>"cancel barters"</li>
	["dominance"] = 2^35,							--- @desc <li>"dominance"</li>
	["adoption in dynasty"] = 2^36,					--- @desc <li>"adoption in dynasty"</li>
	["forced inheritance"] = 2^37,					--- @desc <li>"forced inheritance"</li>
	["legitimacy support"] = 2^38,					--- @desc <li>"legitimacy support"</li>
	["political marriage"] = 2^39,					--- @desc <li>"political marriage"</li>
	["diplomatic marriage"] = 2^40,					--- @desc <li>"diplomatic marriage"</li>
	["all"] = (2^41 - 1)							--- @desc <li>"all"</li></ul>

};
]] --

--- @function force_diplomacy
--- @desc Restricts or unrestricts certain types of diplomacy between factions or groups of factions. Groups of factions may be specified with the strings <code>"all"</code>, <code>"faction:faction_key"</code>, <code>"subculture:subculture_key"</code> or <code>"culture:culture_key"</code>. A source and target faction/group of factions must be specified.
--- @desc Note that the <a href="../../scripting_doc.html">game interface</a> function that this function calls is <code>force_diplomacy_new</code>, not </code>force_diplomacy</code>.
--- @p @string source, Source faction/factions identifier.
--- @p @string target, Target faction/factions identifier.
--- @p @string type, Type of diplomacy to restrict. See the documentation for the @campaign_manager:Diplomacy section for available diplomacy types.
--- @p @boolean can offer, Can offer - set to <code>false</code> to prevent the source faction(s) from being able to offer this diplomacy type to the target faction(s).
--- @p @boolean can accept, Can accept - set to <code>false</code> to prevent the target faction(s) from being able to accept this diplomacy type from the source faction(s).
--- @p [opt=false] @boolean both directions, Causes this function to apply the same restriction from target to source as from source to target.
--- @p [opt=false] @boolean do not enable payments, The AI code assumes that the "payments" diplomatic option is always available, and by default this function keeps payments available, even if told to restrict it. Set this flag to <code>true</code> to forceably restrict payments, but this may cause crashes.
function campaign_manager:force_diplomacy(source, target, diplomacy_types, offer, accept, add_both_directions,
                                          do_not_enable_payments)
     add_both_directions = not not add_both_directions;
     do_not_enable_payments = not not do_not_enable_payments;

     -- #Troy: we send the bitmask as a string and process it as 64-bit in C++ so no more worries about Lua number precision.
     --[[
	-- workaround - lua's default number type doesn't have the precision to support the bitmask required for "all"
	if diplomacy_types == "all" then
		out.design("force_diplomacy_new() called, source: " .. tostring(source) .. ", target: " .. tostring(target) .. ", diplomacy_types: " .. tostring(diplomacy_types) .. ", offer: " .. tostring(offer) .. ", accept: " .. tostring(accept) .. ", add both directions: " .. tostring(add_both_directions) .. ", do not enable payments: " .. tostring(do_not_enable_payments));
		for diplomacy_type, bitmask in pairs(campaign_manager.diplomacy_types) do
			self.game_interface:force_diplomacy_new(source, target, bitmask, offer, accept);
			if add_both_directions then
				self.game_interface:force_diplomacy_new(target, source, bitmask, offer, accept);
			end;
		end;
		return;
	end;
	]]

     if source == target and offer ~= accept and add_both_directions then
          script_error(
          "ERROR: force_diplomacy() called with invalid arguments. source == target and offer ~= accept and add_both_directions == true. Using both directions for the same target and different value of offer and accept will work in the opposite way of what you expect! Probably add_both_directions is not needed?");
          return
     end

     local bitmask = self:generated_diplomacy_bitmask_s(diplomacy_types);

     out.design("force_diplomacy_new() called, source: " ..
     tostring(source) ..
     ", target: " ..
     tostring(target) ..
     ", diplomacy_types: " ..
     tostring(diplomacy_types) ..
     " (generating bitmask: " ..
     bitmask ..
     "), offer: " ..
     tostring(offer) ..
     ", accept: " ..
     tostring(accept) ..
     ", add both directions: " ..
     tostring(add_both_directions) .. ", do not enable payments: " .. tostring(do_not_enable_payments));

     self.game_interface:force_diplomacy_new_s(source, target, bitmask, offer, accept);

     if add_both_directions then
          self.game_interface:force_diplomacy_new_s(target, source, bitmask, accept, offer);
     end;

     -- the ai assumes that 'payments' will always be available, so if we are enabling a diplomatic relationship then always enable payments as well

     -- No longer the case in Troy - we do not use payments, substituted by Barters!
     --[[ if offer and not do_not_enable_payments then
		self.game_interface:force_diplomacy_new(source, target, self:generated_diplomacy_bitmask("payments"), true, false);
	end; ]]
end;

--[[
-- #Troy: the items are too many to be supported in this way any more. Now we send the bitmask to C++ as a string.
function campaign_manager:generated_diplomacy_bitmask(str)
	if not is_string(str) then
		script_error("ERROR: generate_diplomacy_bitmask() called but supplied diplomacy string [" .. tostring(str) .. "] is not a string");
		return 0;
	end;

	if string.len(str) == 0 then
		return 0;
	end;

	-- specifically allow a token of "all"
	if str == "all" then
		return self.diplomacy_types["all"];
	end;

	local tokens = {};

	local pointer = 1;

	while true do
		local next_separator = string.find(str, ",", pointer);

		if not next_separator then
			-- this is the last token, so exit the loop after storing it
			table.insert(tokens, string.sub(str, pointer));
			break;
		end;

		table.insert(tokens, string.sub(str, pointer, next_separator - 1));

		pointer = next_separator + 1;
	end;

	local bitmask = 0;

	for i = 1, #tokens do
		local current_token = tokens[i];

		if current_token == "all" then
			-- combining "all" with other token types is not allowed
			script_error("WARNING: generate_diplomacy_bitmask() was given a string [" .. str .. "] containing token [" .. current_token .. "] with other tokens - this token can only be used on its own, ignoring");
		else
			local current_token_value = self.diplomacy_types[current_token];
			if not current_token_value then
				script_error("WARNING: generate_diplomacy_bitmask() was given a string [" .. str .. "] containing unrecognised token [" .. current_token .. "], ignoring");
			else
				bitmask = bitmask + current_token_value;
			end;
		end;
	end;

	return bitmask;
end;
]]

campaign_manager.diplomacy_types_string = {
     "trade agreement",
     "hard military access",
     "cancel hard military access",
     "military alliance",
     "regions",
     "technology",
     "state gift",
     "payments",
     "vassal",
     "subjugate",
     "become subject",
     "peace",
     "war",
     "join war",
     "break trade",
     "break alliance",
     "hostages",
     "marriage",
     "non aggression pact",
     "soft military access",
     "cancel soft military access",
     "defensive alliance",
     "client state",
     "form confederation",
     "break non aggression pact",
     "break soft military access",
     "break defensive alliance",
     "break vassal",
     "break subject",
     "break client state",
     "state gift unilateral",
     "diplomatic gift",
     "single barters",
     "barter agreements",
     "cancel barters",
     "dominance",
     "adoption in dynasty",
     "forced inheritance",
     "legitimacy support",
     "political marriage",
     "diplomatic marriage",
     --"all" is processed separately
}

local _diplomacy_masks = {
     one_as_code = string.byte("1"),
     lookup = {}
}

-- Remember a reversed version of the diplomacy types list ({["trade agrement"] = 1, ...} instead of {[1] = "trade agreement", ...}) to facilitate fast searching
for k, v in ipairs(campaign_manager.diplomacy_types_string) do
     _diplomacy_masks.lookup[v] = k
end

-- Cache some values
_diplomacy_masks.length = #campaign_manager.diplomacy_types_string
_diplomacy_masks.zeroes = string.rep("0", _diplomacy_masks.length)
_diplomacy_masks.ones   = string.rep("1", _diplomacy_masks.length)

-- Generates a string 'bitmask' of 1's and 0's since the floating point numbers used by the Lua interpreter cannot represent very large integers precisely
function campaign_manager:generated_diplomacy_bitmask_s(str)
     if not is_string(str) then
          script_error("ERROR: generate_diplomacy_bitmask_s() called but supplied value for diplomacy string [" ..
          tostring(str) .. "] is not a string");
          return _diplomacy_masks.zeroes
     end

     if string.len(str) == 0 then
          return _diplomacy_masks.zeroes
     end

     -- Specifically allow a one-token string to be "all"
     if str == "all" then
          return _diplomacy_masks.ones
     end

     -- Since Lua' strings are immutable, use an array of character codes to build the string of ones and zeroes.
     local result_array = { _diplomacy_masks.zeroes:byte(1, _diplomacy_masks.length) }
     for item in string.gmatch(str, " *([%a%d ]*[%d%a])") do -- Get all comma-separated items from str; items may contain spaces but not start or end with a space
          local pos = _diplomacy_masks.lookup
          [item]                                         -- If it is a valid diplomacy type, pos is now its target position in the 'bitmask'
          if pos then
               result_array[pos] = _diplomacy_masks
               .one_as_code                              -- Replace '0' with '1' at the respective position in the resul
          else
               if item == "all" then
                    script_error("WARNING: generate_diplomacy_bitmask_s() was given a string [" ..
                    str ..
                    "] containing token [" ..
                    item .. "] with other tokens - this token can only be used on its own, ignoring.");
               else
                    script_error("WARNING: generate_diplomacy_bitmask_s() was given a string [" ..
                    str .. "] containing unrecognised token [" .. item .. "], ignoring.");
               end
          end
     end
     return string.char(unpack(result_array)):reverse() -- Convert the array of character codes { 49, 48, 49, ... } to a string "101..."
end

--- @function force_diplomacy_via_string
--- @desc A lightweight version of the force_diplomacy function that can be called without performance concerns.
--- @desc Note that the <a href="../../scripting_doc.html">game interface</a> function that this function calls is <code>force_diplomacy_new_s</code>, not </code>force_diplomacy</code>.
--- @p string source, Source faction/factions identifier.
--- @p string target, Target faction/factions identifier.
--- @p string type, Type of diplomacy to restrict. See the documentation for the @campaign_manager:Diplomacy section for available diplomacy types.
--- @p boolean can offer, Can offer - set to <code>false</code> to prevent the source faction(s) from being able to offer this diplomacy type to the target faction(s).
--- @p boolean can accept, Can accept - set to <code>false</code> to prevent the target faction(s) from being able to accept this diplomacy type from the source faction(s).
--- @p [opt=false] both directions, Causes this function to apply the same restriction from target to source as from source to target.
--- @p [opt=false] do not enable payments, The AI code assumes that the "payments" diplomatic option is always available, and by default this function keeps payments available, even if told to restrict it. Set this flag to <code>true</code> to forceably restrict payments, but this may cause crashes.
function campaign_manager:force_diplomacy_via_string(source, target, offer, accept, add_both_directions, type)
     local diplomacy_types_string = ""

     if type == "all" then
          diplomacy_types_string = string.rep("1", #self.diplomacy_types_string)
     else
          for i = 1, #self.diplomacy_types_string do
               if self.diplomacy_types_string[i] == type then
                    diplomacy_types_string = diplomacy_types_string .. '1'
               else
                    diplomacy_types_string = diplomacy_types_string .. '0'
               end
          end
     end

     out(diplomacy_types_string)
     out(string.len(diplomacy_types_string))

     self.game_interface:force_diplomacy_new_s(source, target, (diplomacy_types_string), offer, accept)

     if add_both_directions then
          self.game_interface:force_diplomacy_new_s(target, source, diplomacy_types_string, offer, accept)
     end
end

--- @function enable_all_diplomacy
--- @desc Enables or disables all diplomatic options between all factions.
--- @p boolean enable diplomacy
function campaign_manager:enable_all_diplomacy(value)
     self:force_diplomacy("all", "all", "all", value, value);

     -- apply default diplomatic records afterwards if required
     if value then
          core:trigger_event("ScriptEventAllDiplomacyEnabled");
     end;
end;

--- @function force_declare_war
--- @desc Forces war between two factions. This calls the function of the same name on the <a href="../../scripting_doc.html">game interface</a>, but adds validation and output. This output will be shown on the design tab of the console.
--- @p string faction key, Faction A key
--- @p string faction key, Faction B key
--- @p boolean invite faction a allies, Invite faction A's allies to the war
--- @p boolean invite faction b allies, Invite faction B's allies to the war
--- @p boolean forced choice, faction A will have lower treachery penalties if they have any treaties with faction B if this is true
function campaign_manager:force_declare_war(faction_a_name, faction_b_name, invite_faction_a_allies,
                                            invite_faction_b_allies, forced_choice)
     if not is_string(faction_a_name) then
          script_error("ERROR: force_declare_war() called but supplied faction_a_name string [" ..
          tostring(faction_a_name) .. "] is not a string");
          return false;
     end;

     if not is_string(faction_b_name) then
          script_error("ERROR: force_declare_war() called but supplied faction_b_name string [" ..
          tostring(faction_b_name) .. "] is not a string");
          return false;
     end;

     if not is_boolean(invite_faction_a_allies) then
          script_error("ERROR: force_declare_war() called but supplied invite_faction_a_allies flag [" ..
          tostring(invite_faction_a_allies) .. "] is not a boolean value");
          return false;
     end;

     if not is_boolean(invite_faction_b_allies) then
          script_error("ERROR: force_declare_war() called but supplied invite_faction_b_allies flag [" ..
          tostring(invite_faction_b_allies) .. "] is not a boolean value");
          return false;
     end;

     if not is_boolean(forced_choice) then
          script_error("ERROR: force_declare_war() called but supplied forced_choice flag [" ..
          tostring(forced_choice) .. "] is not a boolean value");
          return false;
     end;

     local faction_a = cm:get_faction(faction_a_name);
     local faction_b = cm:get_faction(faction_b_name);

     if not faction_a then
          script_error("ERROR: force_declare_war() called but supplied faction_a_name string [" ..
          tostring(faction_a_name) .. "] could not be used to find a valid faction");
          return false;
     end;

     if not faction_b then
          script_error("ERROR: force_declare_war() called but supplied faction_b_name string [" ..
          tostring(faction_b_name) .. "] could not be used to find a valid faction");
          return false;
     end;

     out.design("* force_declare_war() called");
     out.design("\tforcing war between:");

     if faction_a:is_human() then
          out.design("\t\t[" .. tostring(faction_a_name) .. "] (human)");
     else
          out.design("\t\t[" .. tostring(faction_a_name) .. "] (ai)");
     end;

     if faction_b:is_human() then
          out.design("\t\t[" .. tostring(faction_b_name) .. "] (human)");
     else
          out.design("\t\t[" .. tostring(faction_b_name) .. "] (ai)");
     end;

     if invite_faction_a_allies then
          out.design("\tinviting [" .. tostring(faction_a_name) .. "] allies");
     end;

     if invite_faction_b_allies then
          out.design("\tinviting [" .. tostring(faction_b_name) .. "] allies");
     end;

     self.game_interface:force_declare_war(faction_a_name, faction_b_name, invite_faction_a_allies,
          invite_faction_b_allies, forced_choice);
end;

----------------------------------------------------------------------------
-- get diplomacy panel context
----------------------------------------------------------------------------

-- list of all diplomatic options, which the diplomacy panel displays
-- option is the name of the uicomponent
-- result is a string signifying its meaning to the interventions listening to it
-- priority is the priority of the meaning (so the context of a compound offer like an alliance with a payment is always of the more-significant component)
campaign_manager.diplomatic_options = {
     { ["option"] = "diplomatic_option_trade_agreement",           ["result"] = "trade",          ["priority"] = 2 },
     { ["option"] = "diplomatic_option_cancel_trade_agreement",    ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_single_barter",             ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_barter_agreement",          ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_barter_agreement",   ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_hard_access",               ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_hard_access",        ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_military_alliance",         ["result"] = "alliance",       ["priority"] = 2 },
     { ["option"] = "diplomatic_option_cancel_military_alliance",  ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_trade_regions",             ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_trade_technology",          ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_state_gift",                ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_payment",                   ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_vassal",                    ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_vassal",             ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_subject",                   ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_subject",            ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_peace",                     ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "war_declared",                                ["result"] = "war",            ["priority"] = 2 },
     { ["option"] = "diplomatic_option_join_war",                  ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_trade_agreement",     ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_military_alliance",   ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_hostage",                   ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_mariiage",                  ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_nonaggression_pact",        ["result"] = "nap",            ["priority"] = 2 },
     { ["option"] = "diplomatic_option_cancel_nonaggression_pact", ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_soft_access",               ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_soft_access",        ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_defensive_alliance",        ["result"] = "alliance",       ["priority"] = 2 },
     { ["option"] = "diplomatic_option_cancel_defensive_alliance", ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_client_state",              ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_cancel_client_state",       ["result"] = "noninteractive", ["priority"] = 1 },
     { ["option"] = "diplomatic_option_confederation",             ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_nonaggression_pact",  ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_soft_access",         ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_defensive_alliance",  ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_vassal",              ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_subject",             ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_break_client_state",        ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_state_gift_unilateral",     ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_diplomatic_gift",           ["result"] = "interactive",    ["priority"] = 1 },
     { ["option"] = "diplomatic_option_ddominance",                ["result"] = "interactive",    ["priority"] = 1 }
};



function campaign_manager:start_diplomacy_panel_context_listener()
     if self.diplomacy_panel_context_listener_started then
          return false;
     end;

     self.diplomacy_panel_context_listener_started = true;

     local poll_interval = 0.2;

     self:callback(function() self:poll_diplomacy_panel_context(1, poll_interval) end, poll_interval);
end;

function campaign_manager:poll_diplomacy_panel_context(count, poll_interval)
     local diplomacy_panel_context = self:get_diplomacy_panel_context(count, poll_interval);

     if diplomacy_panel_context then
          self.diplomacy_panel_context_listener_started = false;
          core:trigger_event("ScriptEventDiplomacyPanelContext", diplomacy_panel_context);
     else
          self:callback(function() self:poll_diplomacy_panel_context(count + 1, poll_interval) end, poll_interval);
     end;
end;

function campaign_manager:get_diplomacy_panel_context(count, poll_interval)
     -- failsafe, for in case we don't find anything
     if count >= 20 then
          script_error("WARNING: get_diplomacy_panel_context() couldn't find a diplomacy panel context despite looking " ..
          count .. " times over " .. count * poll_interval .. "s - this should be investigated")
          return "invalid";
     end;

     local uic_diplomacy = find_uicomponent(core:get_ui_root(), "diplomacy_dropdown");

     local diplomatic_options = self.diplomatic_options;
     local result = false;
     local result_priority = 0;

     -- If we couldn't find the panel or it doesn't seem to be open then return a state so that the polling completes.
     -- Not really sure how this happens but it does.
     if not uic_diplomacy or not self:get_campaign_ui_manager():is_panel_open("diplomacy_dropdown") then
          return "invalid";
     end;

     for i = 1, #diplomatic_options do
          local current_option = diplomatic_options[i].option;

          local uic_option = find_uicomponent(uic_diplomacy, current_option);

          if uic_option and uic_option:Visible() then
               if diplomatic_options[i].priority > result_priority then
                    result_priority = diplomatic_options[i].priority;
                    result = diplomatic_options[i].result;

                    -- return immediately if the result is important enough
                    if result_priority == 2 then
                         break;
                    end;
               end;
          end;
     end;

     return result;
end;

-----------------------------------------------------------------------------
--- @section Objectives and Infotext
--- @desc Upon creation, the campaign manager automatically creates objectives manager and infotext manager objects which it stores internally. These functions provide a passthrough interface to the most commonly-used functions on these objects. See the documentation on the @objectives_manager and @infotext_manager pages for more details.
-----------------------------------------------------------------------------


--- @function set_objective
--- @desc Sets up a scripted objective for the player, which appears in the scripted objectives panel. This objective can then be updated, removed, or marked as completed or failed by the script at a later time.
--- @desc A key to the scripted_objectives table must be supplied with set_objective, and optionally one or two numeric parameters to show some running count related to the objective. To update these parameter values later, <code>set_objective</code> may be re-called with the same objective key and updated values.
--- @desc This function passes its arguments through @objectives_manager:set_objective on the objectives manager - see the documentation on that function for more information.
--- @p @string objective key, Objective key, from the scripted_objectives table.
--- @p [opt=nil] @number param a, First numeric objective parameter. If set, the objective will be presented to the player in the form [objective text]: [param a]. Useful for showing a running count of something related to the objective.
--- @p [opt=nil] @number param b, Second numeric objective parameter. A value for the first must be set if this is used. If set, the objective will be presented to the player in the form [objective text]: [param a] / [param b]. Useful for showing a running count of something related to the objective.
function campaign_manager:set_objective(...)
     return self.objectives:set_objective(...);
end;

--- @function set_objective_with_leader
--- @desc Sets up a scripted objective for the player which appears in the scripted objectives panel, with a @topic_leader. This objective can then be updated, removed, or marked as completed or failed by the script at a later time.
--- @desc A key to the scripted_objectives table must be supplied with set_objective, and optionally one or two numeric parameters to show some running count related to the objective. To update these parameter values later, <code>set_objective</code> may be re-called with the same objective key and updated values.
--- @desc This function passes its arguments through @objectives_manager:set_objective_with_leader on the objectives manager - see the documentation on that function for more information.
--- @p @string objective key, Objective key, from the scripted_objectives table.
--- @p [opt=nil] @number param a, First numeric objective parameter. If set, the objective will be presented to the player in the form [objective text]: [param a]. Useful for showing a running count of something related to the objective.
--- @p [opt=nil] @number param b, Second numeric objective parameter. A value for the first must be set if this is used. If set, the objective will be presented to the player in the form [objective text]: [param a] / [param b]. Useful for showing a running count of something related to the objective.
--- @p [opt=nil] @function callback, Optional callback to call when the objective is shown.
function campaign_manager:set_objective_with_leader(...)
     return self.objectives:set_objective_with_leader(...);
end;

--- @function complete_objective
--- @desc Marks a scripted objective as completed for the player to see. Note that it will remain on the scripted objectives panel until removed with @campaign_manager:remove_objective. This function passes its arguments through @objectives_manager:complete_objective on the objectives manager - see the documentation on that function for more information.
--- @desc Note also that is possible to mark an objective as complete before it has been registered with @campaign_manager:set_objective - in this case, it is marked as complete as soon as @campaign_manager:set_objective is called.
--- @p @string objective key, Objective key, from the scripted_objectives table.
function campaign_manager:complete_objective(...)
     return self.objectives:complete_objective(...);
end;

--- @function fail_objective
--- @desc Marks a scripted objective as failed for the player to see. Note that it will remain on the scripted objectives panel until removed with @campaign_manager:remove_objective. This function passes its arguments through @objectives_manager:fail_objective on the objectives manager - see the documentation on that function for more information.
--- @p @string objective key, Objective key, from the scripted_objectives table.
function campaign_manager:fail_objective(...)
     return self.objectives:fail_objective(...);
end;

--- @function remove_objective
--- @desc Removes a scripted objective from the scripted objectives panel. This function passes its arguments through @objectives_manager:remove_objective on the objectives manager - see the documentation on that function for more information.
--- @p @string objective key, Objective key, from the scripted_objectives table.
function campaign_manager:remove_objective(...)
     return self.objectives:remove_objective(...);
end;

--- @function activate_objective_chain
--- @desc Pass-through function for @objectives_manager:activate_objective_chain. Starts a new objective chain - see the documentation on the @objectives_manager page for more details.
--- @p string chain name, Objective chain name.
--- @p string objective key, Key of initial objective, from the scripted_objectives table.
--- @p [opt=nil] number number param a, First numeric parameter - see the documentation for @campaign_manager:set_objective for more details
--- @p [opt=nil] number number param b, Second numeric parameter - see the documentation for @campaign_manager:set_objective for more details
function campaign_manager:activate_objective_chain(...)
     return self.objectives:activate_objective_chain(...);
end;

--- @function activate_objective_chain_with_leader
--- @desc Starts a new objective chain, with a @topic_leader. This function passes its arguments through @objectives_manager:activate_objective_chain_with_leader on the objectives manager - see the documentation on that function for more information.
--- @p @string chain name, Objective chain name.
--- @p @string objective key, Key of initial objective, from the scripted_objectives table.
--- @p [opt=nil] @number number param a, First numeric parameter - see the documentation for @campaign_manager:set_objective for more details.
--- @p [opt=nil] @number number param b, Second numeric parameter - see the documentation for @campaign_manager:set_objective for more details.
function campaign_manager:activate_objective_chain_with_leader(...)
     return self.objectives:activate_objective_chain_with_leader(...);
end;

--- @function update_objective_chain
--- @desc Updates an existing objective chain. This function passes its arguments through @objectives_manager:update_objective_chain on the objectives manager - see the documentation on that function for more information.
--- @p @string chain name, Objective chain name.
--- @p @string objective key, Key of initial objective, from the scripted_objectives table.
--- @p [opt=nil] @number number param a, First numeric parameter - see the documentation for @battle_manager:set_objective for more details
--- @p [opt=nil] @number number param b, Second numeric parameter - see the documentation for @battle_manager:set_objective for more details
function campaign_manager:update_objective_chain(...)
     return self.objectives:update_objective_chain(...);
end;

--- @function end_objective_chain
--- @desc Ends an existing objective chain. This function passes its arguments through @objectives_manager:end_objective_chain on the objectives manager - see the documentation on that function for more information.
--- @p @string chain name, Objective chain name.
function campaign_manager:end_objective_chain(...)
     return self.objectives:end_objective_chain(...);
end;

--- @function reset_objective_chain
--- @desc Resets an objective chain so that it may be called again. This function passes its arguments through @objectives_manager:reset_objective_chain on the objectives manager - see the documentation on that function for more information.
--- @p @string chain name, Objective chain name.
function campaign_manager:reset_objective_chain(...)
     return self.objectives:reset_objective_chain(...);
end;

--- @function add_infotext
--- @desc Adds one or more lines of infotext to the infotext panel. This function passes through to @infotext_manager:add_infotext - see the documentation on the @infotext_manager page for more details.
--- @p object first param, Can be a string key from the advice_info_texts table, or a number specifying an initial delay in ms after the panel animates onscreen and the first infotext item is shown.
--- @p ... additional infotext strings, Additional infotext strings to be shown. <code>add_infotext</code> fades each of them on to the infotext panel in a visually-pleasing sequence.
function campaign_manager:add_infotext(...)
     return self.infotext:add_infotext(...);
end;

--- @function add_infotext_with_leader
--- @desc Adds one or more lines of infotext to the infotext panel, with a @topic_leader. This function passes through to @infotext_manager:add_infotext_with_leader - see the documentation on the @infotext_manager page for more details.
--- @p object first param, Can be a string key from the advice_info_texts table, or a number specifying an initial delay in ms after the panel animates onscreen and the first infotext item is shown.
--- @p ... additional infotext strings, Additional infotext strings to be shown. <code>add_infotext</code> fades each of them on to the infotext panel in a visually-pleasing sequence.
function campaign_manager:add_infotext_with_leader(...)
     return self.infotext:add_infotext_with_leader(...);
end;

--- @function add_infotext_simultaneously
--- @desc Adds one or more lines of infotext simultaneously to the infotext panel. This function passes through to @infotext_manager:add_infotext_simultaneously - see the documentation on the @infotext_manager page for more details.
--- @p object first param, Can be a string key from the advice_info_texts table, or a number specifying an initial delay in ms after the panel animates onscreen and the first infotext item is shown.
--- @p ... additional infotext strings, Additional infotext strings to be shown. <code>add_infotext_simultaneously</code> fades each of them on to the infotext panel in a visually-pleasing sequence.
function campaign_manager:add_infotext_simultaneously(...)
     return self.infotext:add_infotext_simultaneously(...);
end;

--- @function add_infotext_simultaneously_with_leader
--- @desc Adds one or more lines of infotext simultaneously to the infotext panel, with a @topic_leader. This function passes through to @infotext_manager:add_infotext_simultaneously_with_leader - see the documentation on the @infotext_manager page for more details.
--- @p object first param, Can be a string key from the advice_info_texts table, or a number specifying an initial delay in ms after the panel animates onscreen and the first infotext item is shown.
--- @p ... additional infotext strings, Additional infotext strings to be shown. <code>add_infotext_simultaneously</code> fades each of them on to the infotext panel in a visually-pleasing sequence.
function campaign_manager:add_infotext_simultaneously_with_leader(...)
     return self.infotext:add_infotext_simultaneously_with_leader(...);
end;

--- @function remove_infotext
--- @desc Pass-through function for @infotext_manager:remove_infotext. Removes a line of infotext from the infotext panel.
--- @p @string infotext key
function campaign_manager:remove_infotext(...)
     return self.infotext:remove_infotext(...);
end;

--- @function clear_infotext
--- @desc Pass-through function for @infotext_manager:clear_infotext. Clears the infotext panel.
function campaign_manager:clear_infotext(...)
     return self.infotext:clear_infotext(...);
end;

--- @function set_infotext_auto_clear_timer
--- @desc Pass-through function for @infotext_manager:set_auto_clear_timer. Clears all infotexts after the specified time. Mouse over the infotext panel will freeze the timer. A value <= 0 will cancel any current timer
--- @p @number seconds
--- @p [opt=false] @boolean should_dismiss_advice_on_infotext_auto_hide_time_elapsed
function campaign_manager:set_infotext_auto_clear_timer(...)
     self.infotext:set_auto_clear_timer(...)
end;

-----------------------------------------------------------------------------
--- @section Missions and Events
-----------------------------------------------------------------------------


--- @function cancel_mission
--- @desc Cancels (aborts) a specific custom mission from its database record key. This function wraps the @episodic_scripting:cancel_mission function on the game interface, adding console output.
--- @p string faction key, Faction key.
--- @p string mission key, Mission key.
function campaign_manager:cancel_mission(faction_key, mission_key)
     if not is_string(faction_key) then
          script_error("ERROR: cancel_mission() called but supplied faction name [" ..
          tostring(faction) .. "] is not a string");
          return false;
     end;

     if not is_string(mission_key) then
          script_error("ERROR: cancel_mission() called but supplied mission_key [" ..
          tostring(faction) .. "] is not a string");
          return false;
     end;
     self.game_interface:cancel_mission(faction_key, mission_key);
end

--- @function trigger_custom_mission
--- @desc Triggers a specific custom mission from its database record key. This mission must be defined in the missions.txt file that accompanies each campaign. This function wraps the @episodic_scripting:trigger_custom_mission function on the game interface, adding console output and event type whitelisting.
--- @p string faction key, Faction key.
--- @p string mission key, Mission key, from missions.txt file.
--- @p [opt=false] boolean do not cancel, By default this function cancels this custom mission before issuing it, to avoid multiple copies of the mission existing at once. Supply <code>true</code> here to prevent this behaviour.
--- @p [opt=false] boolean whitelist, Supply <code>true</code> here to also whitelist the mission event type, so that it displays even if event feed restrictions are in place (see @campaign_manager:suppress_all_event_feed_messages and @campaign_manager:whitelist_event_feed_event_type).
function campaign_manager:trigger_custom_mission(faction, mission, do_not_cancel, whitelist)
     if not is_string(faction) then
          script_error("ERROR: trigger_custom_mission() called but supplied faction name [" ..
          tostring(faction) .. "] is not a string");
          return false;
     end;

     if not do_not_cancel then
          self.game_interface:cancel_mission(faction, mission);
     end;

     if whitelist == true then
          self:whitelist_event_feed_event_type("faction_event_mission_issuedevent_feed_target_mission_faction");
     end;

     out("++ triggering mission " .. tostring(mission) .. " for faction " .. tostring(faction));

     return self.game_interface:trigger_custom_mission(faction, mission);
end;

--- @function trigger_custom_mission_from_string
--- @desc Triggers a custom mission from a string passed into the function. The mission string must be supplied in a custom format - see the missions.txt that commonly accompanies a campaign for examples. Alternatively, use a @mission_manager which is able to construct such strings internally.
--- @desc This wraps a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>.
--- @p string faction key
--- @p string mission, Mission definition string.
--- @p [opt=false] boolean whitelist, Supply <code>true</code> here to also whitelist the mission event type, so that it displays even if event feed restrictions are in place (see @campaign_manager:suppress_all_event_feed_messages and @campaign_manager:whitelist_event_feed_event_type).
function campaign_manager:trigger_custom_mission_from_string(faction_name, mission_string, whitelist)
     out("++ triggering mission from string for faction " ..
     tostring(faction_name) .. " mission string is " .. tostring(mission_string));

     if whitelist == true then
          self:whitelist_event_feed_event_type("faction_event_mission_issuedevent_feed_target_mission_faction");
     end;

     return self.game_interface:trigger_custom_mission_from_string(faction_name, mission_string);
end;

--- @function trigger_mission
--- @desc Instructs the campaign director to attempt to trigger a mission of a particular type, based on a mission record from the database. The mission will be triggered if its conditions, defined in the <code>cdir_events_mission_option_junctions</code>, pass successfully. The function returns whether the mission was successfully triggered or not.
--- @desc This function wraps the @episodic_scripting:trigger_mission function on the game interface, adding console output and event type whitelisting.
--- @p string faction key, Faction key.
--- @p string mission key, Mission key, from the missions table.
--- @p [opt=false] @boolean fire immediately, Fire immediately - if this is set, then any turn delay for the mission set in the <code>cdir_event_mission_option_junctions</code> table will be disregarded.
--- @p [opt=false] boolean whitelist, Supply <code>true</code> here to also whitelist the mission event type, so that it displays even if event feed restrictions are in place (see @campaign_manager:suppress_all_event_feed_messages and @campaign_manager:whitelist_event_feed_event_type).
--- @return @boolean mission triggered successfully
function campaign_manager:trigger_mission(faction, mission, fire_immediately, whitelist)
     fire_immediately = not not fire_immediately;

     out("++ triggering mission from db " ..
     tostring(mission) .. " for faction " .. tostring(faction) .. ", fire_immediately: " .. tostring(fire_immediately));

     if whitelist == true then
          self:whitelist_event_feed_event_type("faction_event_mission_issuedevent_feed_target_mission_faction");
     end;

     return self.game_interface:trigger_mission(faction, mission, fire_immediately);
end;

--- @function trigger_custom_dilemma
--- @desc Compels the campaign director to trigger a custom dilemma, based on a record from the database, preferentially wrapped in an intervention. The delivery of the dilemma will be wrapped in an intervention in singleplayer mode, whereas in multiplayer mode the dilemma is triggered directly.
--- @p string faction_key, Faction key.
--- @p string dilemma_key, Dilemma key, from the dilemma table.
--- @p string payload1, Payload string for first choice.
--- @p string payload2, Payload string for second choice.
--- @p [opt=nil] string payload3, Payload string for third choice.
--- @p [opt=nil] string payload4, Payload string for fourth choice.
function campaign_manager:trigger_custom_dilemma(faction_key, dilemma_key, payload1, payload2, payload3, payload4)
     if self:is_multiplayer() then
          return self:trigger_custom_dilemma_raw(faction_key, dilemma_key, payload1, payload2, payload3, payload4);
     end;

     -- in singleplayer, wrap the delivery of the dilemma in an intervention
     self:trigger_transient_intervention(
          "dilemma_" .. faction_key .. "_" .. dilemma_key,
          function(intervention)
               local process_name = "dilemma_" .. faction_key .. "_" .. dilemma_key .. "_listeners";

               -- start a one second countdown - if no dilemma has appeared in this time assume that something has gone wrong, error and abort
               self:repeat_callback(
                    function()
                         if CampaignUI.DoesEventTypeRequireResponse("faction_event_dilemmaevent_feed_target_dilemma_faction") then
                              return
                         else
                              script_error(
                              "WARNING: trigger_dilemma() called but no dilemma was issued, is there a problem with the data? Faction key is [" ..
                              faction_key ..
                              "] and dilemma key is [" ..
                              dilemma_key .. "]. Completing the associated intervention, but no dilemma was triggered.");
                              core:remove_listener(process_name);
                              intervention:complete();
                              cm:remove_callback(process_name);
                         end
                         return;
                    end,
                    1,
                    process_name
               );

               -- listen for the dilemma being issued
               core:add_listener(
                    process_name,
                    "DilemmaChoiceMadeEvent",
                    function(context) return context:dilemma() == dilemma_key end,
                    function()
                         cm:remove_callback(process_name);

                         -- dilemma has been issued, complete intervention
                         intervention:complete();
                    end,
                    false
               );

               -- trigger the actual dilemma
               return self:trigger_custom_dilemma_raw(faction_key, dilemma_key, payload1, payload2, payload3, payload4);
          end,
          true,
          function()
               return
          end
     );
end

--- @function trigger_custom_dilemma_raw
--- @desc Compels the campaign director to trigger a custom dilemma, based on a record from the database. This wraps a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>.
--- @p string faction_key, Faction key.
--- @p string dilemma_key, Dilemma key, from the dilemma table.
--- @p string payload1, Payload string for first choice.
--- @p string payload2, Payload string for second choice.
--- @p [opt=nil] string payload3, Payload string for third choice.
--- @p [opt=nil] string payload4, Payload string for fourth choice.
function campaign_manager:trigger_custom_dilemma_raw(faction_key, dilemma_key, payload1, payload2, payload3, payload4)
     if payload4 then
          self.game_interface:trigger_custom_dilemma(faction_key, dilemma_key, payload1, payload2, payload3, payload4)
     elseif payload3 then
          self.game_interface:trigger_custom_dilemma(faction_key, dilemma_key, payload1, payload2, payload3)
     else
          self.game_interface:trigger_custom_dilemma(faction_key, dilemma_key, payload1, payload2)
     end
end

--- @function trigger_dilemma
--- @desc Triggers dilemma with a specified key, based on a record from the database, preferentially wrapped in an intervention. The delivery of the dilemma will be wrapped in an intervention in singleplayer mode, whereas in multiplayer mode the dilemma is triggered directly. It is preferred to use this function to trigger a dilemma, unless the calling script is running from within an intervention in which case @campaign_manager:trigger_dilemma_raw should be used.
--- @p @string faction key, Faction key, from the <code>factions</code> table.
--- @p @string dilemma key, Dilemma key, from the <code>dilemmas</code> table.
--- @p @function trigger callback, Callback to call when the intervention actually gets triggered.
--- @return @boolean Dilemma triggered successfully. <code>true</code> is always returned if an intervention is generated.
function campaign_manager:trigger_dilemma(faction_key, dilemma_key, on_trigger_callback)
     if not is_string(faction_key) then
          script_error("ERROR: trigger_dilemma() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return false;
     end;

     if not is_string(dilemma_key) then
          script_error("ERROR: trigger_dilemma() called but supplied dilemma key [" ..
          tostring(dilemma_key) .. "] is not a string");
          return false;
     end;

     if on_trigger_callback and not is_function(on_trigger_callback) then
          script_error("ERROR: trigger_dilemma() called but supplied trigger callback [" ..
          tostring(on_trigger_callback) .. "] is not a function");
          return false;
     end;

     if self:model():world():whose_turn_is_it():name() ~= faction_key then
          script_error("ERROR: trigger_dilemma() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not taking it's turn currently. Dilemma will not be triggered!")
          return false
     end

     -- trigger the dilemma immediately in mp
     if self:is_multiplayer() then
          return self:trigger_dilemma_raw(faction_key, dilemma_key, true, true);
     end;

     --local process_name = "dilemma_" .. faction_key .. "_" .. dilemma_key;

     -- in singleplayer, wrap the delivery of the dilemma in an intervention
     self:trigger_transient_intervention(
          "dilemma_" .. faction_key .. "_" .. dilemma_key,
          function(intervention)
               local process_name = "dilemma_" .. faction_key .. "_" .. dilemma_key .. "_listeners";

               -- start a one second countdown - if no dilemma has appeared in this time assume that something has gone wrong, error and abort
               self:repeat_callback(
                    function()
                         if CampaignUI.DoesEventTypeRequireResponse("faction_event_dilemmaevent_feed_target_dilemma_faction") then
                              return
                         else
                              script_error(
                              "WARNING: trigger_dilemma() called but no dilemma was issued, is there a problem with the data? Faction key is [" ..
                              faction_key ..
                              "] and dilemma key is [" ..
                              dilemma_key .. "]. Completing the associated intervention, but no dilemma was triggered.");
                              core:remove_listener(process_name);
                              intervention:complete();
                              cm:remove_callback(process_name);
                         end
                         return;
                    end,
                    1,
                    process_name
               );

               -- listen for the dilemma being issued
               core:add_listener(
                    process_name,
                    "DilemmaIssuedEvent",
                    function(context) return context:dilemma() == dilemma_key end,
                    function()
                         cm:remove_callback(process_name);

                         -- dilemma has been issued, complete intervention
                         intervention:complete();
                    end,
                    false
               );

               -- call the on-trigger callback
               if on_trigger_callback then
                    on_trigger_callback();
               end;

               -- trigger the actual dilemma
               self:trigger_dilemma_raw(faction_key, dilemma_key, true, true);
          end,
          true,
          function()
               return
          end
     );

     return true;
end;

--- @function trigger_dilemma_raw
--- @desc Compels the campaign director to trigger a dilemma of a particular type, based on a record from the database. This function is a raw wrapper for the @episodic_scripting:trigger_dilemma function on the game interface, adding console output and event type whitelisting, but not featuring the intervention-wrapping behaviour of @campaign_manager:trigger_dilemma. Use this function if triggering the dilemma from within an intervention, but @campaign_manager:trigger_dilemma for all other instances.
--- @p @string faction key, Faction key, from the <code>factions</code> table.
--- @p @string dilemma key, Dilemma key, from the <code>dilemmas</code> table.
--- @p [opt=false] @boolean fire immediately, Fire immediately. If set, the dilemma will fire immediately, otherwise the dilemma will obey any wait period set in the <code>cdir_events_dilemma_options</code> table.
--- @p [opt=false] @boolean whitelist, Supply <code>true</code> here to also whitelist the dilemma event type, so that it displays even if event feed restrictions are in place (see @campaign_manager:suppress_all_event_feed_messages and @campaign_manager:whitelist_event_feed_event_type).
--- @return @boolean Dilemma triggered successfully.
function campaign_manager:trigger_dilemma_raw(faction_key, dilemma_key, fire_immediately, whitelist)
     if not is_string(faction_key) then
          script_error("ERROR: trigger_dilemma_raw() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not a string");
          return false;
     end;

     if not is_string(dilemma_key) then
          script_error("ERROR: trigger_dilemma_raw() called but supplied dilemma key [" ..
          tostring(dilemma_key) .. "] is not a string");
          return false;
     end;

     if self:model():world():whose_turn_is_it():name() ~= faction_key then
          script_error("ERROR: trigger_dilemma_raw() called but supplied faction key [" ..
          tostring(faction_key) .. "] is not taking it's turn currently. Dilemma will not be triggered!")
          return false
     end

     fire_immediately = not not fire_immediately;

     out("++ triggering dilemma from db " ..
     tostring(dilemma_key) ..
     " for faction " .. tostring(faction_key) .. ", fire_immediately: " .. tostring(fire_immediately));

     if whitelist then
          self:whitelist_event_feed_event_type("faction_event_dilemmaevent_feed_target_dilemma_faction");
     end;

     return self.game_interface:trigger_dilemma(faction_key, dilemma_key, fire_immediately);
end;

--- @function trigger_dilemma_with_targets
--- @desc Triggers a dilemma with a specified key and one or more target game objects, preferentially wrapped in an intervention. The delivery of the dilemma will be wrapped in an intervention in singleplayer mode, whereas in multiplayer mode the dilemma is triggered directly. It is preferred to use this function to trigger a dilemma with targets, unless the calling script is running from within an intervention in which case @campaign_manager:trigger_dilemma_with_targets_raw should be used.
--- @desc The game object or objects to associate the dilemma with are specified by command-queue index. The dilemma will need to pass any conditions set up in the <code>cdir_events_dilemma_option_junctions</code> table in order to trigger.
--- @p @number faction cqi, Command-queue index of the faction to which the dilemma is issued. This must be supplied.
--- @p @string dilemma key, Dilemma key, from the <code>dilemmas</code> table.
--- @p [opt=0] @number target faction cqi, Command-queue index of a target faction.
--- @p [opt=0] @number secondary faction cqi, Command-queue index of a second target faction.
--- @p [opt=0] @number character cqi, Command-queue index of a target character.
--- @p [opt=0] @number military force cqi, Command-queue index of a target military force.
--- @p [opt=0] @number region cqi, Command-queue index of a target region.
--- @p [opt=0] @number settlement cqi, Command-queue index of a target settlement.
--- @p @function trigger callback, Callback to call when the intervention actually gets triggered.
--- @p [opt=0] @number family_member_cqi, Command-queue index of a target family member.
--- @return @boolean Dilemma triggered successfully. <code>true</code> is always returned if an intervention is generated.
function campaign_manager:trigger_dilemma_with_targets(faction_cqi, dilemma_key, target_faction_cqi,
                                                       secondary_faction_cqi, character_cqi, mf_cqi, region_cqi,
                                                       settlement_cqi, on_trigger_callback, family_member_cqi)
     --other args are checked in triger_dilemma_with_targets_raw

     if on_trigger_callback and not is_function(on_trigger_callback) then
          script_error("ERROR: trigger_dilemma_with_targets() called but supplied trigger callback [" ..
          tostring(on_trigger_callback) .. "] is not a function");
          return false;
     end;

     -- trigger the dilemma immediately in mp
     if self:is_multiplayer() then
          return self:trigger_dilemma_with_targets_raw(faction_cqi, dilemma_key, target_faction_cqi,
               secondary_faction_cqi, character_cqi, mf_cqi, region_cqi, settlement_cqi, false, family_member_cqi);
     end;

     -- in singleplayer, wrap the delivery of the dilemma in an intervention
     self:trigger_transient_intervention(
          "dilemma_" .. faction_cqi .. "_" .. dilemma_key,
          function(intervention)
               local process_name = "dilemma_" .. faction_cqi .. "_" .. dilemma_key .. "_listeners";

               -- start a one second countdown - if no dilemma has appeared in this time assume that something has gone wrong, error and abort
               self:repeat_callback(
                    function()
                         if CampaignUI.DoesEventTypeRequireResponse("faction_event_dilemmaevent_feed_target_dilemma_faction") then
                              return
                         else
                              script_error(
                              "WARNING: trigger_dilemma() called but no dilemma was issued, is there a problem with the data? Faction cqi is [" ..
                              tostring(faction_cqi) ..
                              "] and dilemma key is [" ..
                              dilemma_key .. "]. Completing the associated intervention, but no dilemma was triggered.");
                              core:remove_listener(process_name);
                              intervention:complete();
                              cm:remove_callback(process_name);
                         end
                         return;
                    end,
                    1,
                    process_name
               );

               -- listen for the dilemma being issued
               core:add_listener(
                    process_name,
                    "DilemmaIssuedEvent",
                    function(context) return context:dilemma() == dilemma_key end,
                    function()
                         cm:remove_callback(process_name);

                         -- dilemma has been issued, complete intervention
                         intervention:complete();
                    end,
                    false
               );

               -- call the on-trigger callback
               if on_trigger_callback then
                    on_trigger_callback();
               end;

               -- trigger the actual dilemma
               self:trigger_dilemma_with_targets_raw(faction_cqi, dilemma_key, target_faction_cqi, secondary_faction_cqi,
                    character_cqi, mf_cqi, region_cqi, settlement_cqi, true, family_member_cqi);
          end,
          true,
          function(intervention)
               intervention:set_allow_when_advice_disabled(true);
          end
     );

     return true;
end;

--- @function trigger_dilemma_with_targets_raw
--- @desc Directly triggers a dilemma with a specified key and one or more target game objects. This function is a raw wrapper for the @episodic_scripting:trigger_dilemma_with_targets function on the game interface, adding console output and event type whitelisting, but not featuring the intervention-wrapping behaviour of @campaign_manager:trigger_dilemma_with_targets. Use this function if triggering the dilemma from within an intervention, but @campaign_manager:trigger_dilemma_with_targets (or @campaign_manager:trigger_dilemma) in all other instances.
--- @desc The game object or objects to associate the dilemma with are specified by command-queue index. The dilemma will need to pass any conditions set up in the <code>cdir_events_dilemma_option_junctions</code> table in order to trigger.
--- @p @number faction cqi, Command-queue index of the faction to which the dilemma is issued. This must be supplied.
--- @p @string dilemma key, Dilemma key, from the <code>dilemmas</code> table.
--- @p [opt=0] @number target faction cqi, Command-queue index of a target faction.
--- @p [opt=0] @number secondary faction cqi, Command-queue index of a second target faction.
--- @p [opt=0] @number character cqi, Command-queue index of a target character.
--- @p [opt=0] @number military force cqi, Command-queue index of a target military force.
--- @p [opt=0] @number region cqi, Command-queue index of a target region.
--- @p [opt=0] @number settlement cqi, Command-queue index of a target settlement.
--- @p [opt=false] @boolean whitelist, bool to whitelist the event feed event even if events are suppressed
--- @p [opt=0] @number family_member_cqi, Command-queue index of a target family member.
--- @return @boolean Dilemma triggered successfully.
function campaign_manager:trigger_dilemma_with_targets_raw(faction_cqi, dilemma_key, target_faction_cqi,
                                                           secondary_faction_cqi, character_cqi, mf_cqi, region_cqi,
                                                           settlement_cqi, whitelist, family_member_cqi)
     if not is_number(faction_cqi) then
          script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied faction cqi [" ..
          tostring(faction_cqi) .. "] is not a number");
          return false;
     end;

     local faction = cm:model():faction_for_command_queue_index(faction_cqi);

     if faction:is_null_interface() then
          script_error("ERROR: trigger_dilemma_with_targets_raw() called but no faction with supplied cqi [" ..
          faction_cqi .. "] could be found");
          return false;
     end;

     if not is_string(dilemma_key) then
          script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied dilemma key [" ..
          tostring(dilemma_key) .. "] is not a string");
          return false;
     end;

     if self:model():world():whose_turn_is_it() ~= faction then
          script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied faction key [" ..
          tostring(faction) .. "] is not taking it's turn currently. Dilemma will not be triggered!")
          return false
     end

     local target_faction = false;

     if target_faction_cqi then
          if not is_number(target_faction_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied target faction cqi [" ..
               tostring(target_faction_cqi) .. "] is not a number or nil");
               return false;
          end;

          if target_faction_cqi ~= 0 then
               target_faction = cm:model():faction_for_command_queue_index(target_faction_cqi);

               if target_faction:is_null_interface() then
                    script_error(
                    "ERROR: trigger_dilemma_with_targets_raw() called but no target faction with supplied cqi [" ..
                    target_faction_cqi .. "] could be found");
                    return false;
               end;
          end;
     else
          target_faction_cqi = 0;
     end;

     local secondary_faction = false;

     if secondary_faction_cqi then
          if not is_number(secondary_faction_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied secondary faction cqi [" ..
               tostring(secondary_faction_cqi) .. "] is not a number or nil");
               return false;
          end;

          if secondary_faction_cqi ~= 0 then
               secondary_faction = cm:model():faction_for_command_queue_index(secondary_faction_cqi);

               if secondary_faction:is_null_interface() then
                    script_error(
                    "ERROR: trigger_dilemma_with_targets_raw() called but no secondary faction with supplied cqi [" ..
                    secondary_faction_cqi .. "] could be found");
                    return false;
               end;
          end;
     else
          secondary_faction_cqi = 0;
     end;

     local character = false;

     if character_cqi then
          if not is_number(character_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied character cqi [" ..
               tostring(character_cqi) .. "] is not a number or nil");
               return false;
          end;

          if character_cqi ~= 0 then
               character = cm:get_character_by_cqi(character_cqi);

               if not character then
                    script_error("ERROR: trigger_dilemma_with_targets_raw() called but no character with supplied cqi [" ..
                    character_cqi .. "] could be found");
                    return false;
               end;
          end;
     else
          character_cqi = 0;
     end;

     local mf = false;

     if mf_cqi then
          if not is_number(mf_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied military force cqi [" ..
               tostring(mf_cqi) .. "] is not a number or nil");
               return false;
          end;

          if mf_cqi ~= 0 then
               mf = cm:model():military_force_for_command_queue_index(mf_cqi);

               if mf:is_null_interface() then
                    script_error(
                    "ERROR: trigger_dilemma_with_targets_raw() called but no military force with supplied mf cqi [" ..
                    mf_cqi .. "] could be found");
                    return false;
               end;
          end;
     else
          mf_cqi = 0;
     end;

     if region_cqi then
          if not is_number(region_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied region cqi [" ..
               tostring(region_cqi) .. "] is not a number or nil");
               return false;
          end;
     else
          region_cqi = 0;
     end;

     if settlement_cqi then
          if not is_number(settlement_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied region cqi [" ..
               tostring(settlement_cqi) .. "] is not a number or nil");
               return false;
          end;
     else
          settlement_cqi = 0;
     end;

     local family_member = false

     if family_member_cqi then
          if not is_number(family_member_cqi) then
               script_error("ERROR: trigger_dilemma_with_targets_raw() called but supplied family member cqi [" ..
               tostring(family_member_cqi) .. "] is not a number or nil");
               return false
          end;

          if family_member_cqi ~= 0 then
               family_member = cm:model():family_member_for_command_queue_index(family_member_cqi)

               if not family_member then
                    script_error(
                    "ERROR: trigger_dilemma_with_targets_raw() called but no family_member with supplied cqi [" ..
                    family_member_cqi .. "] could be found");
                    return false;
               end
          end
     else
          family_member_cqi = 0
     end

     -- console output
     out("++ triggering dilemma [" ..
     tostring(dilemma_key) ..
     "] with targets from db for faction with cqi [" ..
     tostring(faction_cqi) .. "] (key: " .. faction:name() .. "), whitelisting event type: " .. tostring(whitelist));
     if target_faction then
          out("\ttarget faction [" .. target_faction:name() .. "] with cqi [" .. target_faction_cqi .. "] specified");
     end;
     if secondary_faction then
          out("\tsecondary faction [" ..
          secondary_faction:name() .. "] with cqi [" .. secondary_faction_cqi .. "] specified");
     end;
     if character then
          out("\tcharacter with cqi [" ..
          character_cqi ..
          "] specified (faction [" ..
          character:faction():name() ..
          ", position [" .. character:logical_position_x() .. ", " .. character:logical_position_y() .. "])");
     end;
     if mf then
          out("\tmilitary force with cqi [" ..
          character_cqi ..
          "] specified (faction [" ..
          mf:general_character():faction():name() ..
          ", position [" ..
          mf:general_character():logical_position_x() .. ", " .. mf:general_character():logical_position_y() .. "])");
     end;
     if region_cqi ~= 0 then
          out("\tregion with cqi [" .. region_cqi .. "] specified");
     end;
     if settlement_cqi ~= 0 then
          out("\tsettlement with cqi [" .. settlement_cqi .. "] specified");
     end;
     if family_member then
          out("\tfamily member with cqi [" ..
          family_member_cqi .. "] specified (faction [" .. family_member:faction():name() .. "])")
     end

     if whitelist then
          self:whitelist_event_feed_event_type("faction_event_dilemmaevent_feed_target_dilemma_faction");
     end;

     return self.game_interface:trigger_dilemma_with_targets(faction_cqi, dilemma_key, target_faction_cqi,
          secondary_faction_cqi, character_cqi, mf_cqi, region_cqi, settlement_cqi, family_member_cqi);
end;

--- @function trigger_incident
--- @desc Instructs the campaign director to attempt to trigger a specified incident, based on record from the database. The incident will be triggered if its conditions, defined in the <code>cdir_events_incident_option_junctions</code>, pass successfully. The function returns whether the incident was successfully triggered or not.
--- @desc This function wraps the @episodic_scripting:trigger_incident function on the game interface, adding console output and event type whitelisting.
--- @p @string faction key, Faction key.
--- @p @string incident key, Incident key, from the incidents table.
--- @p [opt=false] @boolean fire immediately, Fire immediately - if this is set, then any turn delay for the incident set in the <code>cdir_event_incident_option_junctions</code> table will be disregarded.
--- @p [opt=false] @boolean whitelist, Supply <code>true</code> here to also whitelist the dilemma event type, so that it displays even if event feed restrictions are in place (see @campaign_manager:suppress_all_event_feed_messages and @campaign_manager:whitelist_event_feed_event_type).
--- @return @boolean incident was triggered
function campaign_manager:trigger_incident(faction, incident, fire_immediately, whitelist)
     fire_immediately = not not fire_immediately;

     out("++ triggering incident from db " ..
     tostring(incident) .. " for faction " .. tostring(faction) .. ", fire_immediately: " .. tostring(fire_immediately));

     if whitelist == true then
          self:whitelist_event_feed_event_type("faction_event_character_incidentevent_feed_target_incident_faction");
          self:whitelist_event_feed_event_type("faction_event_region_incidentevent_feed_target_incident_faction");
          self:whitelist_event_feed_event_type("faction_event_incidentevent_feed_target_incident_faction");
     end;

     return self.game_interface:trigger_incident(faction, incident, fire_immediately);
end;

-- get mission manager by mission key
-- for internal usage, hence not being documented
function campaign_manager:get_mission_manager(mission_key, custom_id)
     local _custom_id = custom_id or ""
     local _name = mission_key .. _custom_id

     for _key, _mm in pairs(self.mission_managers) do
          if _key == _name then
               return _mm
          end
     end
end;

-- internal function that a mission manager calls to register itself
function campaign_manager:register_mission_manager(mission_manager)
     if not is_missionmanager(mission_manager) then
          script_error("ERROR: register_mission_manager() called but supplied mission manager [" ..
          tostring(mission_manager) .. "] is not a mission manager");
          return false;
     end;

     if self:get_mission_manager(mission_manager.mission_key, mission_manager.custom_id) then
          script_error("ERROR: register_mission_manager() called but supplied mission manager with key [" ..
          mission_manager.mission_key .. "] is already registered");
          return false;
     end;

     local _name = mission_manager.mission_key .. mission_manager.custom_id

     self.mission_managers[_name] = mission_manager;
end;

--	handles the saving of mission managers to the savegame
function campaign_manager:mission_managers_to_string()
     local str = "";
     for mission_key, mission_manager in pairs(self.mission_managers) do
          str = str .. mission_manager:state_to_string();
     end;

     return str;
end;

--	handles the loading of mission managers from the savegame
function campaign_manager:mission_managers_from_string(str)
     local pointer = 1;

     while true do
          local next_separator = string.find(str, "%", pointer);

          if not next_separator then
               break;
          end;

          local first_token = string.sub(str, pointer, next_separator - 1);
          local mission_key = ""
          local started = false
          local completed = false
          local _custom_id = ""
          local faction_key = ""
          pointer = next_separator + 1;

          next_separator = string.find(str, "%", pointer);

          if not next_separator then
               script_error("ERROR: mission_managers_from_string() called but supplied string is malformed: " .. str);
               return false;
          end;

          if tonumber(first_token) then
               -- New style mission manager from string - tostring(self.version) .. "%" .. self.custom_id .. "%" .. self.mission_key .. "%";
               local _version = first_token

               _custom_id = string.sub(str, pointer, next_separator - 1);
               pointer = next_separator + 1;
               next_separator = string.find(str, "%", pointer);

               if not next_separator then
                    script_error("ERROR: mission_managers_from_string() called but supplied string is malformed: " .. str);
                    return false;
               end;

               mission_key = string.sub(str, pointer, next_separator - 1);

               if tonumber(_version) >= 2 then
                    pointer = next_separator + 1
                    next_separator = string.find(str, "%", pointer);

                    if not next_separator then
                         script_error("ERROR: mission_managers_from_string() called but supplied string is malformed: " ..
                         str);
                         return false;
                    end;

                    faction_key = string.sub(str, pointer, next_separator - 1);
               end
          else
               -- Old style mission manager from string - mission_key .. "%" .. tostring(self.started) .. "%" .. tostring(self.completed) .. "%";
               mission_key = first_token
               started = string.sub(str, pointer, next_separator - 1);

               if started == "true" then
                    started = true;
               elseif started == "false" then
                    started = false;
               else
                    script_error("ERROR: mission_managers_from_string() called but parsing failed, boolean flag [" ..
                    tostring(started) .. "] couldn't be decyphered, string is " .. str);
               end;

               pointer = next_separator + 1;

               next_separator = string.find(str, "%", pointer);

               if not next_separator then
                    script_error("ERROR: mission_managers_from_string() called but supplied string is malformed: " .. str);
                    return false;
               end;

               completed = string.sub(str, pointer, next_separator - 1);

               if completed == "true" then
                    completed = true;
               elseif completed == "false" then
                    completed = false;
               else
                    script_error("ERROR: mission_managers_from_string() called but parsing failed, boolean flag [" ..
                    tostring(completed) .. "] couldn't be decyphered, string is " .. str);
                    return false;
               end;
          end

          -- This is a quick and ugly fix, I will kill this whole string saving as soon as I get some time
          -- You can think of this as a "post load fixup" - never trust what the script saved, just go and ask the model so you know for sure
          local fac, check_mission_key, _mission_manager
          if faction_key ~= "" then
               fac = self:get_faction(faction_key)
               check_mission_key = mission_key
          else
               _mission_manager = self:get_mission_manager(mission_key, _custom_id);
               if not _mission_manager then
                    script_error("ERROR:  mission_managers_from_string() is attempting to set up a mission with key [" ..
                    tostring(mission_key) ..
                    "] but it isn't registered. All missions should be registered before the first tick.");
                    return false;
               end

               fac = self:get_faction(_mission_manager.faction_name)
               check_mission_key = _mission_manager.mission_key
          end

          started             = fac:mission_is_active(check_mission_key, _custom_id)
          local has_succeeded = fac:mission_has_succeeded(check_mission_key, _custom_id)
          local was_canceled  = fac:mission_was_canceled(check_mission_key, _custom_id)
          local has_timed_out = fac:mission_has_expired(check_mission_key, _custom_id)

          if has_succeeded or was_canceled or has_timed_out then
               completed = true
          end

          if not completed then
               -- find the mission manager in the registered list and set it up
               _mission_manager = _mission_manager or self:get_mission_manager(mission_key, _custom_id);

               if not _mission_manager then
                    script_error("ERROR:  mission_managers_from_string() is attempting to set up a mission with key [" ..
                    tostring(mission_key) ..
                    "] but it isn't registered. All missions should be registered before the first tick.");
                    return false;
               elseif _mission_manager then
                    _mission_manager:start_from_savegame(started, completed);
               end;
          end

          pointer = next_separator + 1;
     end;
end;

--- @function suppress_all_event_feed_messages
--- @desc Suppresses or unsuppresses all event feed message from being displayed. With this suppression in place, event panels won't be shown on the UI at all but will be queued and then shown when the suppression is removed. The suppression must not be kept on during the end-turn sequence.
--- @desc When suppressing, we whitelist dilemmas as they lock the model, and also mission succeeded event types as the game tends to flow better this way.
--- @p [opt=true] boolean activate suppression
function campaign_manager:suppress_all_event_feed_messages(value)
     if value ~= false then
          value = true;
     end;

     if self.all_event_feed_messages_suppressed == value then
          return;
     end;

     self.all_event_feed_messages_suppressed = value;

     out(">> suppress_all_event_feed_messages(" .. tostring(value) .. ") called");

     CampaignUI.SuppressAllEventTypesInUI(value);

     -- if we are suppressing, then whitelist certain event types so that they still get through
     if value then
          -- whitelist dilemma messages in the UI, in case there's one already pending
          self:whitelist_event_feed_event_type("faction_event_dilemmaevent_feed_target_dilemma_faction");

          -- also whitelist mission succeeded events, the flow just works better if the player gets immediate feedback about these things
          self:whitelist_event_feed_event_type("faction_event_mission_successevent_feed_target_mission_faction");
     end;
end;

--- @function whitelist_event_feed_event_type
--- @desc While suppression has been activated with @campaign_manager:suppress_all_event_feed_messages an event type may be whitelisted and allowed to be shown with this function. This allows scripts to hold all event messages from being displayed except those of a certain type. This is useful for advice scripts which may want to talk about those messages, for example.
--- @desc If event feed suppression is not active then calling this function will have no effect.
--- @p string event type, Event type to whitelist. This is compound key from the <code>event_feed_targeted_events</code> table, which is the event field and the target field of a record from this table, concatenated together.
--- @new_example Whitelisting the "enemy general dies" event type
--- @example cm:whitelist_event_feed_event_type("character_dies_battleevent_feed_target_opponent")
function campaign_manager:whitelist_event_feed_event_type(event_type)
     out(">> whitelist_event_feed_event_type() called, event_type is " .. tostring(event_type));

     CampaignUI.WhiteListEventTypeInUI(event_type);
end;

--- @function disable_event_feed_events
--- @desc Wrapper for the function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>. Disables event feed events by category, subcategory or individual event type. Unlike @campaign_manager:suppress_all_event_feed_messages the events this call blocks are discarded. Use this function to prevent certain events from appearing.
--- @p boolean should disable, Should disable event type(s).
--- @p [opt=""] string event categories, Event categories to disable. Supply "" or false/nil to not disable/enable events by categories in this function call. Supply "all" to disable all event types.
--- @p [opt=""] string event subcategories, Event subcategories to disable. Supply "" or false/nil to not disable/enable events by subcategories in this function call.
--- @p [opt=""] string event, Event to disable. Supply "" or false/nil to not disable/enable an individual event in this function call.
function campaign_manager:disable_event_feed_events(disable, categories, subcategories, events)
     categories = categories or "";
     subcategories = subcategories or "";
     events = events or "";
     --out("disable_event_feed_events() called: ["..tostring(disable).."], ["..categories.."], ["..subcategories.."], ["..events.."]");

     local all_categories =
     "troy_event_category_agent;troy_event_category_character;troy_event_category_conquest;troy_event_category_diplomacy;troy_event_category_faction;troy_event_category_military;troy_event_category_provinces;troy_event_category_traits_ancillaries;troy_event_category_world";

     if categories == "all" then
          self.game_interface:disable_event_feed_events(disable, all_categories, subcategories, events);
     else
          self.game_interface:disable_event_feed_events(disable, categories, subcategories, events);
     end
end

--- @function show_message_event
--- @desc Constructs and displays an event. This wraps a the @episodic_scripting:show_message_event function of the same name on the underlying @episodic_scripting, although it provides input validation, output, whitelisting and a progression callback.
--- @p string faction key, Faction key to who the event is targeted.
--- @p string title loc key, Localisation key for the event title. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p string primary loc key, Localisation key for the primary detail of the event. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p string secondary loc key, Localisation key for the secondary detail of the event. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p boolean persistent, Sets this event to be persistent instead of transient.
--- @p number index, Index indicating the type of event.
--- @p [opt=false] function end callback, Specifies a callback to call when this event is dismissed. Note that if another event message shows first for some reason, this callback will be called early.
--- @p [opt=0] number callback delay, Delay in seconds before calling the end callback, if supplied.
--- @p [opt=false] boolean dont whitelist, By default this function will whitelist the scripted event message type with @campaign_manager:whitelist_event_feed_event_type. Set this flag to <code>true</code> to prevent this.
--- @p [opt=0] @number param 1, 1st numeric parameter to pass through to the underlying message event generator. This is only used in specific circumstances.
--- @p [opt=0] @number param 2, 2nd numeric parameter to pass through to the underlying message event generator. This is only used in specific circumstances.
--- @p [opt=0] @number param 3, 3rd numeric parameter to pass through to the underlying message event generator. This is only used in specific circumstances.
--- @p [opt=0] @string str_param 1, 1st string parameter to pass through to the underlying message event generator. This is only used in specific circumstances.
--- @p [opt=0] @string str_param 2, 2nd string parameter to pass through to the underlying message event generator. This is only used in specific circumstances.
--- @p [opt=0] @string str_param 3, 3rd string parameter to pass through to the underlying message event generator. This is only used in specific circumstances.

function campaign_manager:show_message_event(faction_key, title_loc_key, primary_detail_loc_key, secondary_detail_loc_key,
                                             is_persistent, index_num, end_callback, delay, suppress_whitelist,
                                             _number_param_1, _number_param_2, _number_param_3, str_param_1, str_param_2,
                                             str_param_3)
     if not cm:get_faction(faction_key) then
          script_error("ERROR: show_message_event() called but no faction with supplied name [" ..
          tostring(faction_key) .. "] could be found");
          return false;
     end;

     if not is_string(title_loc_key) then
          script_error("ERROR: show_message_event() called but supplied title localisation key [" ..
          tostring(title_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_string(primary_detail_loc_key) then
          script_error("ERROR: show_message_event() called but supplied primary detail localisation key [" ..
          tostring(primary_detail_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_string(secondary_detail_loc_key) then
          script_error("ERROR: show_message_event() called but supplied secondary detail localisation key [" ..
          tostring(secondary_detail_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_boolean(is_persistent) then
          script_error("ERROR: show_message_event() called but supplied is_persistent flag [" ..
          tostring(is_persistent) .. "] is not a boolean value");
          return false;
     end;

     if not is_number(index_num) then
          script_error("ERROR: show_message_event() called but supplied index number [" ..
          tostring(index_num) .. "] is not a number");
          return false;
     end;

     if end_callback and not is_function(end_callback) then
          script_error("ERROR: show_message_event() called but supplied end_callback [" ..
          tostring(end_callback) .. "] is not a function or nil");
          return false;
     end;

     if delay and not is_number(delay) then
          script_error("ERROR: show_message_event() called but supplied end_callback [" ..
          tostring(delay) .. "] is not a number or nil");
          return false;
     end;

     out("show_message_event() called, showing event for faction [" ..
     faction_key ..
     "] with title [" ..
     title_loc_key ..
     "], primary detail [" ..
     primary_detail_loc_key .. "] and secondary detail [" .. tostring(secondary_detail_loc_key) .. "]");

     if end_callback then
          out("\tsetting up progress listener");
          local progress_name = "show_message_event_" .. title_loc_key;

          core:add_listener(
               progress_name,
               "PanelOpenedCampaign",
               function(context) return context.string == "events" end,
               function()
                    self:progress_on_events_dismissed(
                         progress_name,
                         end_callback,
                         delay
                    );
               end,
               false
          );
     end;

     if not suppress_whitelist then
          if is_persistent then
               cm:whitelist_event_feed_event_type("scripted_persistent_eventevent_feed_target_faction");
          else
               cm:whitelist_event_feed_event_type("scripted_transient_eventevent_feed_target_faction");
          end;
     end;

     local number_param_1 = _number_param_1 or 0
     local number_param_2 = _number_param_2 or 0
     local number_param_3 = _number_param_3 or 0

     local _str_param_1 = str_param_1 or ""
     local _str_param_2 = str_param_2 or ""
     local _str_param_3 = str_param_3 or ""

     self.game_interface:show_message_event(faction_key, title_loc_key, primary_detail_loc_key, secondary_detail_loc_key,
          is_persistent, index_num, number_param_1, number_param_2, number_param_3, _str_param_1, _str_param_2,
          _str_param_3);
end;

function campaign_manager:show_configurable_message_event(faction_key, title_loc_key, primary_detail_loc_key,
                                                          secondary_detail_loc_key, index, number_param_1, number_param_2,
                                                          number_param_3, str_param_1, str_param_2, str_param_3)
     if not cm:get_faction(faction_key) then
          script_error("ERROR: show_message_event() called but no faction with supplied name [" ..
          tostring(faction_key) .. "] could be found")
          return false
     end

     if not is_string(title_loc_key) then
          script_error("ERROR: show_message_event() called but supplied title localisation key [" ..
          tostring(title_loc_key) .. "] is not a string")
          return false
     end

     if not is_string(primary_detail_loc_key) then
          script_error("ERROR: show_message_event() called but supplied primary detail localisation key [" ..
          tostring(primary_detail_loc_key) .. "] is not a string")
          return false
     end

     if not is_string(secondary_detail_loc_key) then
          script_error("ERROR: show_message_event() called but supplied secondary detail localisation key [" ..
          tostring(secondary_detail_loc_key) .. "] is not a string")
          return false
     end

     if not is_number(index) then
          script_error("ERROR: show_message_event() called but supplied index number [" ..
          tostring(index_num) .. "] is not a number")
          return false
     end

     local _number_param_1 = number_param_1 or 0
     local _number_param_2 = number_param_2 or 0
     local _number_param_3 = number_param_3 or 0

     local _str_param_1 = str_param_1 or ""
     local _str_param_2 = str_param_2 or ""
     local _str_param_3 = str_param_3 or ""

     self.game_interface:show_configurable_message_event(faction_key, title_loc_key, primary_detail_loc_key,
          secondary_detail_loc_key, index, _number_param_1, _number_param_2, _number_param_3, _str_param_1, _str_param_2,
          _str_param_3)
end

function campaign_manager:add_event_feed_event(event_key, faction_key, index, str_param1, str_param2, str_param3,
                                               int_param1, int_param2, int_param3)
     if not event_key or not is_string(event_key) or event_key == "" then
          script_error("ERROR: add_event_feed_event() called but supplied event_key [" ..
          tostring(event_key) .. "] is not valid")
          return false
     end

     if not cm:get_faction(faction_key) then
          script_error("ERROR: add_event_feed_event() called but no faction with supplied name [" ..
          tostring(faction_key) .. "] could be found")
          return false
     end

     if not is_number(index) then
          script_error("ERROR: add_event_feed_event() called but supplied index number [" ..
          tostring(index) .. "] is not a number")
          return false
     end

     if str_param1 and not is_string(str_param1) then
          script_error("ERROR: add_event_feed_event() called but supplied str_param1 localisation key [" ..
          tostring(str_param1) .. "] is not a string")
          return false
     end

     if str_param2 and not is_string(str_param2) then
          script_error("ERROR: add_event_feed_event() called but supplied str_param2 localisation key [" ..
          tostring(str_param2) .. "] is not a string")
          return false
     end

     if str_param3 and not is_string(str_param3) then
          script_error("ERROR: add_event_feed_event() called but supplied str_param1 localisation key [" ..
          tostring(str_param3) .. "] is not a string")
          return false
     end

     if int_param1 and not is_number(int_param1) then
          script_error("ERROR: add_event_feed_event() called but supplied int_param1 [" ..
          tostring(int_param1) .. "] is not a number")
          return false
     end

     if int_param2 and not is_number(int_param2) then
          script_error("ERROR: add_event_feed_event() called but supplied int_param2 [" ..
          tostring(int_param2) .. "] is not a number")
          return false
     end

     if int_param3 and not is_number(int_param3) then
          script_error("ERROR: add_event_feed_event() called but supplied int_param3 [" ..
          tostring(int_param3) .. "] is not a number")
          return false
     end

     local _int_param1 = int_param1 or 0
     local _int_param2 = int_param2 or 0
     local _int_param3 = int_param3 or 0

     local _str_param1 = str_param1 or ""
     local _str_param2 = str_param2 or ""
     local _str_param3 = str_param3 or ""

     self.game_interface:add_event_feed_event(event_key, faction_key, _str_param1, _str_param2, _str_param3, _int_param1,
          _int_param2, _int_param3, index)
end

--- @function show_message_event_located
--- @desc Constructs and displays a located event. This wraps a function of the same name on the underlying <a href="../../scripting_doc.html">game interface</a>, although it provides input validation, output, whitelisting and a progression callback.
--- @p string faction key, Faction key to who the event is targeted.
--- @p string title loc key, Localisation key for the event title. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p string primary loc key, Localisation key for the primary detail of the event. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p string secondary loc key, Localisation key for the secondary detail of the event. This should be supplied in the full [table]_[field]_[key] localisation format, or can be a blank string.
--- @p number x, Logical x co-ordinate of event target.
--- @p number y, Logical y co-ordinate of event target.
--- @p boolean persistent, Sets this event to be persistent instead of transient.
--- @p number index, Index indicating the type of event.
--- @p [opt=false] function end callback, Specifies a callback to call when this event is dismissed. Note that if another event message shows first for some reason, this callback will be called early.
--- @p [opt=0] number callback delay, Delay in seconds before calling the end callback, if supplied.
function campaign_manager:show_message_event_located(faction_key, title_loc_key, primary_detail_loc_key,
                                                     secondary_detail_loc_key, x, y, is_persistent, index_num,
                                                     end_callback, delay)
     if not cm:get_faction(faction_key) then
          script_error("ERROR: show_message_event_located() called but no faction with supplied name [" ..
          tostring(faction_key) .. "] could be found");
          return false;
     end;

     if not is_string(title_loc_key) then
          script_error("ERROR: show_message_event_located() called but supplied title localisation key [" ..
          tostring(title_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_string(primary_detail_loc_key) then
          script_error("ERROR: show_message_event_located() called but supplied primary detail localisation key [" ..
          tostring(primary_detail_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_string(secondary_detail_loc_key) then
          script_error("ERROR: show_message_event_located() called but supplied secondary detail localisation key [" ..
          tostring(secondary_detail_loc_key) .. "] is not a string");
          return false;
     end;

     if not is_number(x) then
          script_error("ERROR: show_message_event_located() called but supplied x co-ordinate [" ..
          tostring(x) .. "] is not a number");
          return false;
     end;

     if not is_number(y) then
          script_error("ERROR: show_message_event_located() called but supplied y co-ordinate [" ..
          tostring(y) .. "] is not a number");
          return false;
     end;

     if not is_boolean(is_persistent) then
          script_error("ERROR: show_message_event_located() called but supplied is_persistent flag [" ..
          tostring(is_persistent) .. "] is not a boolean value");
          return false;
     end;

     if not is_number(index_num) then
          script_error("ERROR: show_message_event_located() called but supplied index_num [" ..
          tostring(index_num) .. "] is not a number");
          return false;
     end;

     if end_callback and not is_function(end_callback) then
          script_error("ERROR: show_message_event_located() called but supplied end_callback [" ..
          tostring(end_callback) .. "] is not a function or nil");
          return false;
     end;

     if delay and not is_number(delay) then
          script_error("ERROR: show_message_event_located() called but supplied end_callback [" ..
          tostring(delay) .. "] is not a number or nil");
          return false;
     end;

     out("show_message_event_located() called, showing event for faction [" ..
     faction_key ..
     "] with title [" ..
     title_loc_key ..
     "], primary detail [" ..
     primary_detail_loc_key ..
     "] and secondary detail [" .. secondary_detail_loc_key .. "] at co-ordinates [" .. x .. ", " .. y .. "]");

     if end_callback then
          local progress_name = "show_message_event_located_" .. title_loc_key;

          core:add_listener(
               progress_name,
               "PanelOpenedCampaign",
               function(context) return context.string == "events" end,
               function()
                    self:progress_on_events_dismissed(
                         progress_name,
                         end_callback,
                         delay
                    );
               end,
               false
          );
     end;

     self.game_interface:show_message_event_located(faction_key, title_loc_key, primary_detail_loc_key,
          secondary_detail_loc_key, x, y, is_persistent, index_num);
end;

-----------------------------------------------------------------------------
--- @section Transient Interventions
--- @desc @intervention offer a script method for locking the campaign UI and progression until the sequence of scripted events has finished. The main intervention interface should primarily be used when creating interventions, but this section lists functions that can be used to quickly create transient throwaway interventions, whose state is not saved into the savegame. See @"intervention:Transient Interventions" for more information.
-----------------------------------------------------------------------------

--- @function trigger_transient_intervention
--- @desc Creates, starts, and immediately triggers a transient intervention with the supplied paramters. This should trigger immediately unless another intervention is running, in which case it should trigger afterwards.
--- @desc The trigger callback that is supplied to this function will be passed the intervention object when it is called. This callback <strong>must</strong> call @intervention:complete on this object, or cause it to be called, as the UI will be softlocked until the intervention is completed. See @intervention documentation for more information.
--- @p @string name, Name for intervention. This should be unique amongst interventions.
--- @p @function callback, Trigger callback to call.
--- @p [opt=true] @boolean debug, Sets the intervention into debug mode, in which it will produce more output. Supply <code>false</code> to suppress this behaviour.
--- @p [opt=nil] @function configuration callback, If supplied, this function will be called with the created intervention supplied as a single argument before the intervention is started. This allows calling script to configure the intervention before being started.
function campaign_manager:trigger_transient_intervention(name, callback, is_debug, config_callback)
     if is_debug ~= false then
          is_debug = true;
     end;

     -- ti = transient intervention
     local ti = intervention:new(
          name,
          0,
          callback, -- intervention object will be passed to supplied callback as an argument
          is_debug,
          true
     );

     ti:set_must_trigger(true);

     if not ti then
          return false;
     end;

     ti:add_trigger_condition(
          "ScriptEventStartTransientIntervention",
          function(context)
               return context.string == name;
          end
     );

     if is_function(config_callback) then
          config_callback(ti);
     end;

     ti:start();

     core:trigger_event("ScriptEventStartTransientIntervention", name);
end;

-----------------------------------------------------------------------------
--- @section Turn Countdown Events
--- @desc The turn countdown event system allows client scripts to register a string event with the campaign manager. The campaign manager will then trigger the event at the start of turn, a set number of turns later. This works even if the game is saved and reloaded. It is intended to be a secure mechanism for causing a scripted event to occur a number of turns in the future.
-----------------------------------------------------------------------------


--- @function add_turn_countdown_event
--- @desc Registers a turn countdown event. The supplied script event will be triggered after the specified number of turns has passed, when the <code>FactionTurnStart</code> event is received for the specified faction.
--- @p @string faction key, Key of the faction on whose turn start the event will be triggered.
--- @p @number turns, Number of turns from now to trigger the event.
--- @p @string event, Event to trigger. By convention, script event names begin with <code>"ScriptEvent"</code>
--- @p [opt=""] @string context string, Optional context string to trigger with the event.
function campaign_manager:add_turn_countdown_event(faction_name, turn_offset, event_name, context_str)
     if not is_string(faction_name) then
          script_error("ERROR: add_turn_countdown_event() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     -- if it's not the current faction's turn, then increase the turn_offset by 1, as when the faction starts their turn that will count
     --[[
	if self:whose_turn_is_it() ~= faction_name then
		turn_offset = turn_offset + 1;
	end;
	]]

     return self:add_absolute_turn_countdown_event(faction_name, turn_offset + self.game_interface:model():turn_number(),
          event_name, context_str);
end;

--- @function add_turn_countdown_event_on_event
--- @desc Registers a turn countdown event with @campaign_manager:add_turn_countdown_event when the supplied trigger event is received by script. Note that while the turn countdown event is saved into the savegame when triggered, the trigger event listener is not, so it will need to be re-established on script load.
--- @p [opt=nil] @string trigger event, Trigger event. When this event is received by script, the turn countdown event will be registered. If this is @nil or a blank string then the turn countdown event is registered immediately.
--- @p [opt=nil] @function condition, Condition that must be met when the trigger event is received, for the turn countdown event to be registered. If the value specified is <code>true</code> then no conditional check is performed and the turn countdown event will be registered as soon as the trigger event is received.
--- @p @string faction key, Key of the faction on whose turn start the event will be triggered.
--- @p @number turns, Number of turns from now to trigger the event.
--- @p @string event, Event to trigger. By convention, script event names begin with <code>"ScriptEvent"</code>
--- @p [opt=""] @string context string, Optional context string to trigger with the event.
function campaign_manager:add_turn_countdown_event_on_event(trigger_event, trigger_condition, faction_name, turn_offset,
                                                            event_name, context_str)
     if is_string(trigger_event) and string.len(trigger_event) > 0 then
          -- a valid trigger event was supplied, so listen for it
          core:add_listener(
               "add_turn_countdown_event_on_event",
               trigger_event,
               trigger_condition,
               function() self:add_turn_countdown_event(faction_name, turn_offset, event_name, context_str) end,
               false
          );
     else
          -- no valid trigger event was supplied, so just add the turn countdown event directly
          self:add_turn_countdown_event(faction_name, turn_offset, event_name, context_str);
     end;
end;

--- @function add_absolute_turn_countdown_event
--- @desc Registers a turn coutdown event to trigger on a specified absolute turn. The supplied script event will be triggered when the faction specified starts the supplied turn. If the game has already advanced past the turn specified then the event will never trigger.
--- @p @string faction key, Key of the faction on whose turn start the event will be triggered.
--- @p @number turns, Number of turns from now to trigger the event.
--- @p @string event, Event to trigger. By convention, script event names begin with <code>"ScriptEvent"</code>
--- @p [opt=""] @string context string, Optional context string to trigger with the event.
function campaign_manager:add_absolute_turn_countdown_event(faction_name, turn_to_trigger, event_name, context_str)
     if not is_string(faction_name) then
          script_error("ERROR: add_absolute_turn_countdown_event() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     -- can only check that faction exists after the model is created
     if core:is_ui_created() then
          local faction = cm:get_faction(faction_name);

          if not faction then
               script_error("ERROR: add_absolute_turn_countdown_event() called but faction with supplied name [" ..
               faction_name .. "] could not be found");
               return false;
          end;
     end;

     if not is_number(turn_to_trigger) then
          script_error("ERROR: add_absolute_turn_countdown_event() called but supplied trigger turn [" ..
          tostring(turn_to_trigger) .. "] is not a number");
          return false;
     end;

     if not is_string(event_name) then
          script_error("ERROR: add_absolute_turn_countdown_event() called but supplied event name [" ..
          tostring(event_name) .. "] is not a string");
          return false;
     end;

     if not context_str then
          context_str = "";
     end;

     if not is_string(context_str) then
          script_error("ERROR: add_absolute_turn_countdown_event() called but supplied context string [" ..
          tostring(context_str) .. "] is not a string or nil");
          return false;
     end;

     local record = {};
     record.turn_to_trigger = turn_to_trigger;
     record.event_name = event_name;
     record.context_str = context_str;

     -- if we have no sub-table for this faction then create it
     if not self.turn_countdown_events[faction_name] then
          self.turn_countdown_events[faction_name] = {};
     end;

     -- if we have no elements then start the listener
     if #self.turn_countdown_events[faction_name] == 0 then
          core:add_listener(
               "turn_start_countdown_" .. faction_name,
               "FactionTurnStart",
               function(context)
                    return context.string == faction_name;
               end,
               function(context)
                    self:check_turn_countdown_events(context.string)
               end,
               true
          );
     end;

     table.insert(self.turn_countdown_events[faction_name], record);
end;

-- internal function to check turn countdown events this turn
function campaign_manager:check_turn_countdown_events(faction_name)
     local turn_countdown_events = self.turn_countdown_events[faction_name];

     if not is_table(turn_countdown_events) then
          script_error(
          "WARNING: check_turn_countdown_events() called but could not find a table corresponding to given faction name [" ..
          faction_name .. "], how can this be?");
          return false;
     end;

     local turn_number = self.game_interface:model():turn_number();

     for i = 1, #turn_countdown_events do
          local current_record = turn_countdown_events[i];

          if current_record.turn_to_trigger <= turn_number then
               local event_name = current_record.event_name;
               local context_str = current_record.context_str;
               table.remove(turn_countdown_events, i);

               -- trigger the event itself
               core:trigger_event(event_name, context_str);

               self:check_turn_countdown_events(faction_name);
               return;
          end;
     end;

     if #turn_countdown_events == 0 then
          core:remove_listener("turn_start_countdown_" .. faction_name);
     end;
end;

-- saving state of turn countdown events
function campaign_manager:turn_countdown_events_to_string()
     local state_str = "";

     out("turn_countdown_events_to_string() called");
     for faction_name, record_list in pairs(self.turn_countdown_events) do
          for i = 1, #record_list do
               local record = record_list[i];

               out("\tprocessing faction " .. faction_name);
               out("\t\trecord is " .. tostring(record));
               out("\t\trecord.turn_to_trigger is " .. tostring(record.turn_to_trigger));
               out("\t\trecord.event_name is " .. tostring(record.event_name));
               out("\t\trecord.context_str is " .. tostring(record.context_str));

               state_str = state_str ..
               faction_name ..
               "%" .. record.turn_to_trigger .. "%" .. record.event_name .. "%" .. record.context_str .. "%";
          end;
     end;

     return state_str;
end;

-- loading state of turn countdown events
function campaign_manager:turn_countdown_events_from_string(state_str)
     local pointer = 1;

     while true do
          local next_separator = string.find(state_str, "%", pointer);

          if not next_separator then
               break;
          end;

          local faction_name = string.sub(state_str, pointer, next_separator - 1);
          pointer = next_separator + 1;

          next_separator = string.find(state_str, "%", pointer);

          if not next_separator then
               script_error("ERROR: turn_countdowns_from_string() called but supplied string is malformed: " .. state_str);
               return false;
          end;

          local turn_to_trigger_str = string.sub(state_str, pointer, next_separator - 1);
          local turn_to_trigger = tonumber(turn_to_trigger_str);

          if not turn_to_trigger then
               script_error("ERROR: turn_countdowns_from_string() called but parsing failed, turns remaining number [" ..
               tostring(turn_to_trigger_str) .. "] couldn't be decyphered, string is " .. state_str);
               return false;
          end;

          pointer = next_separator + 1;

          next_separator = string.find(state_str, "%", pointer);

          if not next_separator then
               script_error("ERROR: turn_countdowns_from_string() called but supplied string is malformed: " .. state_str);
               return false;
          end;

          local event_name = string.sub(state_str, pointer, next_separator - 1);

          pointer = next_separator + 1;

          next_separator = string.find(state_str, "%", pointer);

          if not next_separator then
               script_error("ERROR: turn_countdowns_from_string() called but supplied string is malformed: " .. state_str);
               return false;
          end;

          local context_str = string.sub(state_str, pointer, next_separator - 1);

          pointer = next_separator + 1;

          self:add_absolute_turn_countdown_event(faction_name, turn_to_trigger, event_name, context_str);
     end;
end;

-----------------------------------------------------------------------------
---	@section Interventions
-----------------------------------------------------------------------------


-- Registering an intervention manager with the campaign manager - not publicly documented
function campaign_manager:set_intervention_manager(im)
     self.intervention_manager = im;
end;

-- Returns the campaign manager's internally stored intervention manager.
function campaign_manager:get_intervention_manager()
     if self.intervention_manager then
          return self.intervention_manager;
     else
          return intervention_manager:new();
     end;
end;

--- @function get_active_intervention
--- @desc Gets the currently-active intervention, or <code>false</code> if no intervention is currently active.
--- @r @intervention active intervention
function campaign_manager:get_active_intervention()
     return self:get_intervention_manager():get_active_intervention();
end;

-----------------------------------------------------------------------------
--	chapter mission registration
--	internal functions for chapter missions
-----------------------------------------------------------------------------

function campaign_manager:register_chapter_mission(ch)
     self.chapter_missions[ch.chapter_number] = ch;
end;

function campaign_manager:chapter_mission_exists_with_number(value)
     return not not self.chapter_missions[value];
end;

-----------------------------------------------------------------------------
--- @section Region Change Monitor
--- @desc When started, a region change monitor stores a record of what regions a faction holds when their turn ends and compares it to the regions the same faction holds when their next turn starts. If the two don't match, then the faction has gained or lost a region and this system fires some custom script events accordingly to notify other script.
--- @desc If the monitored faction has lost a region, the event <code>ScriptEventFactionLostRegion</code> will be triggered at the start of that faction's turn, with the region lost attached to the context. Should the faction have gained a region during the end-turn sequence, the event <code>ScriptEventFactionGainedRegion</code> will be triggered, with the region gained attached to the context.
--- @desc Region change monitors are disabled by default, and have to be opted-into by client scripts with @campaign_manager:start_faction_region_change_monitor each time the scripts load.
-----------------------------------------------------------------------------


--- @function start_faction_region_change_monitor
--- @desc Starts a region change monitor for a faction.
--- @p string faction key
function campaign_manager:start_faction_region_change_monitor(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: start_faction_region_change_monitor() called but supplied name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     -- see if we already have listeners started for this faction (the data may be reinstated from the savegame)
     if not self.faction_region_change_list[faction_name] then
          self.faction_region_change_list[faction_name] = {};
     end;

     core:remove_listener("faction_region_change_monitor_" .. faction_name);

     core:add_listener(
          "faction_region_change_monitor_" .. faction_name,
          "FactionTurnStart",
          function(context) return context:faction():name() == faction_name end,
          function(context)
               self:faction_region_change_monitor_process_turn_start(context:faction())
          end,
          true
     );

     core:add_listener(
          "faction_region_change_monitor_" .. faction_name,
          "FactionTurnEnd",
          function(context) return context:faction():name() == faction_name end,
          function(context)
               self:faction_region_change_monitor_process_turn_end(context:faction())
          end,
          true
     );

     self:add_first_tick_callback(
          function()
               self:faction_region_change_monitor_validate_on_load(faction_name);
          end
     );
end;

--- @function stop_faction_region_change_monitor
--- @desc Stops a running region change monitor for a faction.
--- @p string faction key
function campaign_manager:stop_faction_region_change_monitor(faction_name)
     if not is_string(faction_name) then
          script_error("ERROR: stop_faction_region_change_monitor() called but supplied faction name [" ..
          tostring(faction_name) .. "] is not a string");
          return false;
     end;

     core:remove_listener("faction_region_change_monitor_" .. faction_name);

     self.faction_region_change_list[faction_name] = nil;
end;

-- validates region change monitor saved data
function campaign_manager:faction_region_change_monitor_validate_on_load(faction_name)
     -- if it's currently this faction's turn then process the turn end - this means that the data will be current if loading from a savegame (or from a new game)
     if self:whose_turn_is_it() == faction_name then
          self:faction_region_change_monitor_process_turn_end(cm:get_faction(faction_name));
     else
          -- validate that the cached region list contains valid data
          local cached_region_list = self.faction_region_change_list[faction_name];

          -- compare cached list to current list, to see if the subject faction has lost a region
          for i = 1, #cached_region_list do
               local current_cached_region = cached_region_list[i];

               if not cm:get_region(current_cached_region) then
                    script_error(
                    "WARNING: faction_region_change_monitor_validate_on_load() called but couldn't find region corresponding to key [" ..
                    current_cached_region .. "] stored in cached region list - regenerating cached list");
                    self:faction_region_change_monitor_process_turn_end(cm:get_faction(faction_name));
                    return;
               end;
          end;
     end;
end;

-- called on turn end
function campaign_manager:faction_region_change_monitor_process_turn_end(faction)
     local faction_name = faction:name();
     local region_list = faction:region_list();

     -- rebuild the cached list of regions owned by this faction
     self.faction_region_change_list[faction_name] = {};

     for i = 0, region_list:num_items(i) - 1 do
          table.insert(self.faction_region_change_list[faction_name], region_list:item_at(i):name());
     end;
end;

-- called on turn start
function campaign_manager:faction_region_change_monitor_process_turn_start(faction)
     local should_issue_grudge_messages = true;

     -- don't do anything on turn one or two
     if self:model():turn_number() <= 2 then
          should_issue_grudge_messages = false;
     end;

     local faction_name = faction:name();
     local region_list = faction:region_list();

     -- create a list of the regions the faction currently has
     local current_region_list = {};

     for i = 0, region_list:num_items(i) - 1 do
          table.insert(current_region_list, region_list:item_at(i):name());
     end;

     local cached_region_list = self.faction_region_change_list[faction_name];

     local regions_gained = {};
     local regions_lost = {};

     -- compare cached list to current list, to see if the subject faction has lost a region
     for i = 1, #cached_region_list do
          local current_cached_region = cached_region_list[i];
          local current_cached_region_found = false;

          if cm:get_region(current_cached_region) then
               for j = 1, #current_region_list do
                    if current_cached_region == current_region_list[j] then
                         current_cached_region_found = true;
                         break;
                    end;
               end;

               if not current_cached_region_found then
                    table.insert(regions_lost, current_cached_region);
               end;
          else
               script_error(
               "WARNING: faction_region_change_monitor_process_turn_start() called but couldn't find region corresponding to key [" ..
               current_cached_region .. "] stored in cached region list - discarding cached list and using current");
               cached_region_list = current_region_list;
               regions_lost = {};
          end;
     end;

     -- compare current list to cached list, to see if the subject faction has gained a region
     for i = 1, #current_region_list do
          local current_region = current_region_list[i];
          local current_region_found = false;

          for j = 1, #cached_region_list do
               if current_region == cached_region_list[j] then
                    current_region_found = true;
                    break;
               end;
          end;

          if not current_region_found then
               table.insert(regions_gained, current_region);
          end;
     end;

     -- trigger script events for each region this faction has lost or gained
     if should_issue_grudge_messages then
          for i = 1, #regions_lost do
               core:trigger_event("ScriptEventFactionLostRegion", faction, cm:get_region(regions_lost[i]));
          end;

          for i = 1, #regions_gained do
               core:trigger_event("ScriptEventFactionGainedRegion", faction, cm:get_region(regions_gained[i]));
          end;
     end;
end;

-- saving game
function campaign_manager:faction_region_change_monitor_to_str()
     local savestr = "";

     for faction_name, region_table in pairs(self.faction_region_change_list) do
          savestr = savestr .. faction_name;

          for i = 1, #region_table do
               savestr = savestr .. "%" .. region_table[i];
          end;

          savestr = savestr .. ";";
     end;

     return savestr;
end;

-- loading game
function campaign_manager:faction_region_change_monitor_from_str(str)
     if str == "" then
          return;
     end;

     local pointer = 1;

     while true do
          local next_separator = string.find(str, ";", pointer);

          if not next_separator then
               script_error("ERROR: faction_region_change_monitor_from_str() called but supplied string is malformed: " ..
               str);
               return false;
          end;

          local faction_str = string.sub(str, pointer, next_separator - 1);

          if string.len(faction_str) == 0 then
               script_error(
               "ERROR: faction_region_change_monitor_from_str() called but supplied string contains a zero-length faction record: " ..
               str);
               return false;
          end;

          self:single_faction_region_change_monitor_from_str(faction_str);

          pointer = next_separator + 1;

          if pointer > string.len(str) then
               -- we have reached the end of the string
               return;
          end;
     end;
end;

function campaign_manager:single_faction_region_change_monitor_from_str(str)
     local pointer = 1;
     local next_separator = string.find(str, "%", pointer);

     if not next_separator then
          -- we have a faction with no regions, so just start the monitor
          self:start_faction_region_change_monitor(str);
          return;
     end;

     local faction_name = string.sub(str, pointer, next_separator - 1);

     -- create a record in the faction_region_change_list for this faction
     self.faction_region_change_list[faction_name] = {};

     local pointer = next_separator + 1;

     while true do
          next_separator = string.find(str, "%", pointer);

          if not next_separator then
               -- this is the last region in the string, so add it, start the monitor and then return
               table.insert(self.faction_region_change_list[faction_name], string.sub(str, pointer));
               self:start_faction_region_change_monitor(faction_name);
               return;
          end;

          table.insert(self.faction_region_change_list[faction_name], string.sub(str, pointer, next_separator - 1));

          pointer = next_separator + 1;
     end;
end;

-----------------------------------------------------------------------------
--- @section Miscellaneous Monitors
-----------------------------------------------------------------------------


--- @function find_lowest_public_order_region_on_turn_start
--- @desc Starts a monitor for a faction which, on turn start for that faction, triggers a event with the faction and the region they control with the lowest public order attached. This is useful for advice scripts that may wish to know where the biggest public order problems for a faction are. This function will need to be called by client scripts each time the script starts.
--- @desc The event triggered is <code>ScriptEventFactionTurnStartLowestPublicOrder</code>, and the faction and region may be returned by calling <code>faction()</code> and <code>region()</code> on the context object supplied with it.
--- @p string faction key
function campaign_manager:find_lowest_public_order_region_on_turn_start(faction_name)
     local faction = cm:get_faction(faction_name);

     if not faction then
          script_error(
          "ERROR: find_lowest_public_order_region_on_turn_start() called but no faction with supplied name [" ..
          tostring(faction_name) .. "] could be found");
          return false;
     end;

     core:add_listener(
          "find_lowest_public_order_region_on_turn_start",
          "ScriptEventFactionTurnStart",
          function(context)
               return context:faction():name() == faction_name;
          end,
          function(context)
               local lowest_public_order = 200;
               local lowest_public_order_region = false;
               local faction = cm:get_faction(faction_name);
               local region_list = faction:region_list();

               -- find lowest public order
               for i = 0, region_list:num_items() - 1 do
                    local current_region = region_list:item_at(i);
                    local current_public_order = current_region:public_order();

                    if current_public_order < lowest_public_order then
                         lowest_public_order = current_public_order;
                         lowest_public_order_region = current_region;
                    end;
               end;

               if lowest_public_order_region then
                    out("*** triggering ScriptEventFactionTurnStartLowestPublicOrder for " ..
                    faction_name .. ", lowest_public_order_region is " .. lowest_public_order_region:name());
                    core:trigger_event("ScriptEventFactionTurnStartLowestPublicOrder", faction,
                         lowest_public_order_region);
               end;
          end,
          true
     );
end;

--- @function generate_region_rebels_event_for_faction
--- @desc <code>RegionRebels</code> events are sent as a faction ends their turn but before the <code>FactionTurnEnd</code> event is received. If called, this function listens for <code>RegionRebels</code> events for the specified faction, then waits for the <code>FactionTurnEnd</code> event to be received and sends a separate event. This flow of events works better for advice scripts.
--- @desc The event triggered is <code>ScriptEventRegionRebels</code>, and the faction and region may be returned by calling <code>faction()</code> and <code>region()</code> on the context object supplied with it.
--- @p string faction key
function campaign_manager:generate_region_rebels_event_for_faction(faction_name)
     if not cm:get_faction(faction_name) then
          script_error(
          "ERROR: generate_region_rebels_event_for_faction() called but couldn't find a faction with supplied name [" ..
          tostring(faction_name) .. "]");
          return false;
     end;

     core:add_listener(
          "region_rebels_event_for_faction",
          "RegionRebels",
          function(context) return context:region():owning_faction():name() == faction_name end,
          function(context)
               local region_name = context:region():name();

               -- a region has rebelled, listen for the FactionTurnEnd event and send the message then
               core:add_listener(
                    "region_rebels_event_for_faction",
                    "FactionTurnEnd",
                    function(context) return context:faction():name() == faction_name end,
                    function(context)
                         core:trigger_event("ScriptEventRegionRebels", cm:get_faction(faction_name),
                              cm:get_region(region_name));
                    end,
                    false
               );
          end,
          true
     )
end;

--- @function start_hero_action_listener
--- @desc This fuction starts a listener for hero actions committed against a specified faction and sends out further events based on the outcome of those actions. It is of most use for listening for hero actions committed against a player faction.
--- @desc This function called each time the script starts for the monitors to continue running. Once started, the function triggers the following events:
--- @desc <table class="simple"><tr><td><strong>Event Name</strong></td><td><strong>Context Functions</strong></td><td><strong>Description</strong></td></tr><tr><td><code>ScriptEventAgentActionSuccessAgainstCharacter</code></td><td><code>character</br>target_character</code></td><td>A foreign agent (<code>character</code>) committed a successful action against a character (<code>target_character</code>) of the subject faction.</td></tr><tr><td><code>ScriptEventAgentActionFailureAgainstCharacter</code></td><td><code>character</br>target_character</code></td><td>A foreign agent (<code>character</code>) failed when attempting an action against a character (<code>target_character</code>) of the subject faction.</td></tr><tr><td><code>ScriptEventAgentActionSuccessAgainstCharacter</code></td><td><code>character</br>garrison_residence</code></td><td>A foreign agent (<code>character</code>) committed a successful action against a garrison residence (<code>garrison_residence</code>) of the subject faction.</td></tr><tr><td><code>ScriptEventAgentActionFailureAgainstCharacter</code></td><td><code>character</br>garrison_residence</code></td><td>A foreign agent (<code>character</code>) failed when attempting an action against a garrison residence (<code>garrison_residence</code>) of the subject faction.</td></tr></table>
--- @p string faction key
function campaign_manager:start_hero_action_listener(faction_name)
     local faction = cm:get_faction(faction_name);

     if not faction then
          script_error("ERROR: start_hero_action_listener() called but couldn't find faction with specified name [" ..
          tostring(faction_name) .. "]");
          return false;
     end;

     -- listen for hero actions committed against characters in specified faction
     core:add_listener(
          "character_character_target_action_" .. faction_name,
          "CharacterCharacterTargetAction",
          function(context)
               return context:target_character():faction():name() == faction_name and
               context:character():faction():name() ~= faction_name;
          end,
          function(context)
               if context:mission_result_critial_success() or context:mission_result_success() then
                    core:trigger_event("ScriptEventAgentActionSuccessAgainstCharacter", context:character(),
                         context:target_character());                                                                     -- first character is accessible at character() on context, second at target_character()
               else
                    core:trigger_event("ScriptEventAgentActionFailureAgainstCharacter", context:character(),
                         context:target_character());                                                                     -- first character is accessible at character() on context, second at target_character()
               end;
          end,
          true
     );

     -- listen for hero actions committed against characters in specified faction
     core:add_listener(
          "character_character_target_action_" .. faction_name,
          "CharacterGarrisonTargetAction",
          function(context)
               return context:garrison_residence():faction():name() == faction_name and
               context:character():faction():name() ~= faction_name;
          end,
          function(context)
               if context:mission_result_critial_success() or context:mission_result_success() then
                    core:trigger_event("ScriptEventAgentActionSuccessAgainstGarrison", context:character(),
                         context:garrison_residence());
               else
                    core:trigger_event("ScriptEventAgentActionFailureAgainstGarrison", context:character(),
                         context:garrison_residence());
               end;
          end,
          true
     );
end;

function campaign_manager:create_custom_unit_from_key(unit_key, raise_custom_flag)
     if raise_custom_flag == nil then
          raise_custom_flag = true
     end

     return self.game_interface:create_custom_unit_from_key(unit_key, raise_custom_flag)
end

function campaign_manager:num_units_in_faction_mercenary_pool(faction_cqi, unit_key, custom_id)
     if custom_id == nil then
          custom_id = ""
     end

     return self.game_interface:num_units_in_faction_mercenary_pool(faction_cqi, unit_key, custom_id)
end

function campaign_manager:add_units_to_faction_mercenary_pool(faction_cqi, unit_key, count, custom_id)
     if custom_id == nil then
          custom_id = ""
     end
     return self.game_interface:add_units_to_faction_mercenary_pool(faction_cqi, unit_key, count, custom_id)
end

function campaign_manager:add_units_to_province_mercenary_pool_by_region(region_key, unit_key, count, custom_id)
     if custom_id == nil then
          custom_id = ""
     end
     return self.game_interface:add_units_to_province_mercenary_pool_by_region(faction_cqi, unit_key, count, custom_id)
end

-----------------------------------------------------------------------------
--- @section Region slot modifiers
-----------------------------------------------------------------------------



--- @function replace_building_in_region_slot
--- @desc Instantly destroys the current building in the slot and instantly builds the new building in the slot. Uses instantly_upgrade_building_in_region and instantly_dismantle_building_in_region. Will not expend resources.
--- @desc Will also update the building level record for the currently-constructing building if such in the slot and constructing_building_level_key is supplied
--- @p string region_key, region key
--- @p number slot_num, slot index
--- @p string building_level_key, building_level_key of the building to build
--- @p string constructing_building_level_key, (optional) building_level_key of the currently-constructed building
function campaign_manager:replace_building_in_region_slot(region_key, slot_num, building_level_key,
                                                          constructing_building_level_key)
     if not is_string(region_key) then
          script_error("ERROR: replace_building_in_region_slot() called but supplied region key [" ..
          tostring(region_key) .. "] is not a string")
          return false
     end

     if not is_number(slot_num) then
          script_error("ERROR: replace_building_in_region_slot() called but supplied slot number [" ..
          tostring(slot_num) .. "] is not a number")
          return false
     end

     if not is_string(building_level_key) then
          script_error("ERROR: replace_building_in_region_slot() called but supplied target building key [" ..
          tostring(building_level_key) .. "] is not a string")
          return false
     end

     local region = cm:get_region(region_key)
     if not region then
          script_error("ERROR: replace_building_in_region_slot() called but supplied region key [" ..
          tostring(region_key) .. "] does not correspond to a region")
          return false
     end

     local slot_list = region:slot_list()
     if slot_num > slot_list:num_items() then
          script_error("ERROR: replace_building_in_region_slot() called but supplied slot number [" ..
          tostring(slot_num) .. "] is larger than the amount of slots the region has")
          return false
     end

     local slot = slot_list:item_at(slot_num - 1)
     self.game_interface:region_slot_replace_building(slot, building_level_key, constructing_building_level_key or "")
end

-----------------------------------------------------------------------------
--- @section Military Force slot modifiers
-----------------------------------------------------------------------------



--- @function instantly_dismantle_building_in_force
--- @desc Instantly dismantles the building in the supplied slot index of the supplied force.
--- @p number force_cqi, military force command queue index
--- @p number slot_index, military force slot index
--- @p [opt=true] boolean recoup_resources, whether to recoup the resources for the dismantled building
--- @p [opt=false] boolean silent, whether to suppress the firing of an event feed event for the dismantled building
function campaign_manager:instantly_dismantle_building_in_force(force_cqi, slot_index, recoup_resources, silent)
     if recoup_resources == nil then
          recoup_resources = true
     end

     silent = not not silent

     if not is_number(force_cqi) then
          script_error("ERROR: instantly_dismantle_building_in_force() called but supplied force cqi [" ..
          tostring(force_cqi) .. "] is not a number")
          return false
     end

     if not is_number(slot_index) then
          script_error("ERROR: instantly_dismantle_building_in_force() called but supplied slot index [" ..
          tostring(slot_index) .. "] is not a number")
          return false
     end

     local force = cm:get_military_force_by_cqi(force_cqi)
     if not force then
          script_error("ERROR: instantly_dismantle_building_in_force() called but supplied military force cqi [" ..
          tostring(force_cqi) .. "] does not correspond to a military force")
          return false
     end

     local force_slots = force:slots()
     if slot_index > force_slots:num_items() then
          script_error("ERROR: instantly_dismantle_building_in_force() called but supplied slot index [" ..
          tostring(slot_index) .. "] is larger than the amount of slots the force has.")
          return false
     end

     local slot = force_slots:item_at(slot_index - 1)

     self.game_interface:military_force_slot_instantly_dismantle_building(slot, recoup_resources, silent)
end

--- @function instantly_upgrade_building_in_force
--- @desc Instantly upgrades the supplied building key in the supplied slot index of the supplied force.
--- @p number force_cqi, military force command queue index
--- @p number slot_index, military force slot index
--- @p string target_building_key, the building key to upgrade the current building/slot in slot_index to
function campaign_manager:instantly_upgrade_building_in_force(force_cqi, slot_index, target_building_key)
     if not is_number(force_cqi) then
          script_error("ERROR: instantly_upgrade_building_in_force() called but supplied force cqi [" ..
          tostring(force_cqi) .. "] is not a number")
          return false
     end

     if not is_number(slot_index) then
          script_error("ERROR: instantly_upgrade_building_in_force() called but supplied slot number [" ..
          tostring(slot_index) .. "] is not a number")
          return false
     end

     if not is_string(target_building_key) then
          script_error("ERROR: instantly_upgrade_building_in_force() called but supplied target building key [" ..
          tostring(target_building_key) .. "] is not a string")
          return false
     end

     local force = cm:get_military_force_by_cqi(force_cqi)
     if not force then
          script_error("ERROR: instantly_upgrade_building_in_force() called but supplied military force cqi [" ..
          tostring(force_cqi) .. "] does not correspond to a military force")
          return false
     end

     local force_slots = force:buildings()
     if slot_index > force_slots:num_items() then
          script_error("ERROR: instantly_upgrade_building_in_force() called but supplied slot index [" ..
          tostring(slot_index) .. "] is larger than the amount of slots the force has.")
          return false
     end

     local slot = force_slots:item_at(slot_index - 1)

     self.game_interface:military_force_slot_instantly_upgrade_building(slot, target_building_key)
end

--- @function replace_building_in_force_slot
--- @desc Instantly destroys the current building in the slot and instantly builds the new building in the slot. Uses instantly_dismantle_building_in_force and instantly_upgrade_building_in_force. Will not expend resources.
--- @p number force_cqi, military force command queue index
--- @p number slot_index, military force slot index
--- @p string building_level_key, building_level_key of the building to build
--- @p boolean recoup_resources, whether to recoup the resources for the dismantled building
function campaign_manager:replace_building_in_force_slot(force_cqi, slot_index, building_level_key, recoup_resources)
     self:instantly_dismantle_building_in_force(force_cqi, slot_index, recoup_resources)
     self:instantly_upgrade_building_in_force(force_cqi, slot_index, building_level_key)
end

-----------------------------------------------------------------------------
--- @section Benchmark Scripts
-----------------------------------------------------------------------------


--- @function show_benchmark_if_required
--- @desc Shows a benchmark constructed from supplied parameters if the campaign loaded in benchmark mode, otherwise calls a supplied callback. The intention is for this to be called on or around the first tick of the script that's loaded when playing as the benchmark faction (the benchmark loads with the player as a certain faction). If benchmark mode is set, this function plays the supplied cindy scene for the supplied duration, then quits the campaign.
--- @p function non-benchmark callback, Function to call if this campaign has not been loaded in benchmarking mode.
--- @p string cindy file, Cindy file to show for the benchmark.
--- @p number benchmark duration, Benchmark duration in seconds.
--- @p number cam x, Start x position of camera.
--- @p number cam y, Start y position of camera.
--- @p number cam d, Start distance of camera.
--- @p number cam b, Start bearing of camera (in radians).
--- @p number cam h, Start height of camera.
--- @example cm:add_first_tick_callback_sp_new(
--- @example 	function()
--- @example 		cm:start_intro_cutscene_on_loading_screen_dismissed(
--- @example 			function()
--- @example 				cm:show_benchmark_if_required(
--- @example 					function() cutscene_intro_play() end,
--- @example 					"script/benchmarks/scenes/campaign_benchmark.CindyScene",
--- @example 					92.83,
--- @example 					348.7,
--- @example 					330.9,
--- @example 					10,
--- @example 					0,
--- @example 					10
--- @example 				);
--- @example 			end
--- @example 		);
--- @example 	end
--- @example );
function campaign_manager:show_benchmark_if_required(non_benchmark_callback, cindy_str, duration, start_x, start_y,
                                                     start_d, start_b, start_h)
     if not is_function(non_benchmark_callback) then
          script_error("ERROR: show_benchmark_if_required() called but supplied callback [" ..
          tostring(non_benchmark_callback) .. "] is not a function");
          return false;
     end;

     if not is_string(cindy_str) then
          script_error("ERROR: show_benchmark_if_required() called but supplied cindy path [" ..
          tostring(cindy_str) .. "] is not a string");
          return false;
     end;

     if not is_number(duration) or duration <= 0 then
          script_error("ERROR: show_benchmark_if_required() called but supplied duration [" ..
          tostring(duration) .. "] is not a number greater than zero");
          return false;
     end;

     if not is_number(start_x) or start_x <= 0 then
          script_error("ERROR: show_benchmark_if_required() called but supplied start x co-ordinate [" ..
          tostring(start_x) .. "] is not a number greater than zero");
          return false;
     end;

     if not is_number(start_y) or start_y <= 0 then
          script_error("ERROR: show_benchmark_if_required() called but supplied start y co-ordinate [" ..
          tostring(start_y) .. "] is not a number greater than zero");
          return false;
     end;

     if not is_number(start_d) or start_d <= 0 then
          script_error("ERROR: show_benchmark_if_required() called but supplied start d co-ordinate [" ..
          tostring(start_d) .. "] is not a number greater than zero");
          return false;
     end;

     if not is_number(start_b) then
          script_error("ERROR: show_benchmark_if_required() called but supplied start b co-ordinate [" ..
          tostring(start_b) .. "] is not a number");
          return false;
     end;

     if not is_number(start_h) or start_h <= 0 then
          script_error("ERROR: show_benchmark_if_required() called but supplied start h co-ordinate [" ..
          tostring(start_h) .. "] is not a number greater than zero");
          return false;
     end;

     if not self:is_benchmark_mode() then
          -- don't do benchmark camera pan
          non_benchmark_callback();
          return;
     end;

     out("*******************************************************************************");
     out("show_benchmark_if_required() is showing benchmark");
     out("showing cindy scene: " .. cindy_str .. " with duration " .. tostring(duration));
     out("*******************************************************************************");


     local ui_root = core:get_ui_root();

     self:set_camera_position(start_x, start_y, start_d, start_b, start_h);
     self:show_shroud(false);
     CampaignUI.EnableCinematicMode(true);
     ui_root:LockPriority(50)
     self:override_ui("disable_settlement_labels", true);
     self:cindy_playback(cindy_str);

     self:callback(
          function()
               ui_root:UnLockPriority();
               ui_root:InterfaceFunction("QuitForScript");
          end,
          duration
     );
end;

function campaign_manager:break_if_in_debugger()
     CampaignUI.BreakIfInDebugger();
end;

-----------------------------------------------------------------------------
--- @section Iteration Helpers
-----------------------------------------------------------------------------

--- @function recursive_iterate
--- @desc Iterates through an object with specific instructions on iteration steps. The goal is to go through multiple lists and to reach only what is relevant for you. For example, you can iterate through all building slots without having to write a lot of for loops
--- @p function iterate_function, Function to call for each object when iterating. Should accept 1 argument, the object
--- @p object object, The starting object from where we begin the iteration
--- @p table iteration_instructions, A list of instructions on how to iterate through the object
--- @example cm:recursive_iterate(
--- @example 	function(slot)
--- @example 		out("slot name="..slot:name()..", slot type="..slot:type())
--- @example 	end,
--- @example 	cm:model():world(),
--- @example 	{ "faction_list", "region_list", "slot_list" }
--- @example );
function campaign_manager:recursive_iterate(iterate_function, object, iteration_instructions)
     if #iteration_instructions == 0 then
          iterate_function(object)
          return
     end

     local method = table.remove(iteration_instructions, 1)

     local objects_list = object[method](object)

     cm:iterate(function(new_object)
          cm:recursive_iterate(iterate_function, new_object, iteration_instructions)
     end, objects_list)

     table.insert(iteration_instructions, 1, method)
end

--- @function iterate
--- @desc Iterates through a regular table with ipairs or through a list script interface object.
--- @p function iterate_function, Function to call for each object when iterating. Should accept 1 argument, the object
--- @p object objects, The objects we are iterating through
--- @example cm:iterate(
--- @example 	function(faction)
--- @example 		out(faction:name())
--- @example 	end,
--- @example 	(using_all_factions and cm:model():world():faction_list()) or { faction1, faction2, faction3 }
--- @example );
function campaign_manager:iterate(iterate_function, objects)
     if is_table(objects) then
          cm:iterate_list(iterate_function, objects)
     else
          cm:iterate_list_script_interface(iterate_function, objects)
     end
end

--- @function iterate_list_script_interface
--- @desc Iterates through a list script interface object.
--- @p function iterate_function, Function to call for each object when iterating. Should accept 1 argument, the object
--- @p object objects, The objects we are iterating through
--- @example cm:iterate(
--- @example 	function(faction)
--- @example 		out(faction:name())
--- @example 	end,
--- @example 	cm:model():world():faction_list()
--- @example );
function campaign_manager:iterate_list_script_interface(iterate_function, objects)
     if (self.iterate_break_levels or 0) > 0 then
          self.iterate_break_levels = self.iterate_break_levels - 1
          return
     end

     local num_objects = objects:num_items()

     for i = 0, num_objects - 1 do
          local object = objects:item_at(i)
          iterate_function(object)

          if (self.iterate_break_levels or 0) > 0 then
               self.iterate_break_levels = self.iterate_break_levels - 1
               return
          end
     end
end

--- @function iterate_list
--- @desc Iterates through a regular lua array with ipairs
--- @p function iterate_function, Function to call for each object when iterating. Should accept 1 argument, the object
--- @p object objects, The objects we are iterating through
--- @example cm:iterate(
--- @example 	function(it)
--- @example 		out(it)
--- @example 	end,
--- @example 	{ "string1", "string2", "string3" }
--- @example );
function campaign_manager:iterate_list(iterate_function, list)
     if (self.iterate_break_levels or 0) > 0 then
          self.iterate_break_levels = self.iterate_break_levels - 1
          return
     end

     for _, object in ipairs(list) do
          iterate_function(object)

          if (self.iterate_break_levels or 0) > 0 then
               self.iterate_break_levels = self.iterate_break_levels - 1
               return
          end
     end
end

--- @function iterate_factions
--- @desc Iterates through factions in a list or through all in the game's model
--- @p function iterate_function, Function to call for each faction when iterating. Should accept 1 argument, the faction
--- @p [opt=nil] object list, A list of factions we're iterating through. If nil will iterate through ALL factions
--- @example cm:iterate_factions(
--- @example 	function(faction)
--- @example 		out(faction:name())
--- @example 	end
--- @example );
function campaign_manager:iterate_factions(iterate_function, list)
     if list == nil then
          list = cm:model():world():faction_list()
     end

     cm:iterate(iterate_function, list)
end

--- @function iterate_forces
--- @desc Iterates through forces in a list, faction or through all in the game's model
--- @p function iterate_function, Function to call for each force when iterating. Should accept 1 argument, the force
--- @p [opt=nil] object list, A list of forces we're iterating through or a faction script interface. If nil will iterate through ALL forces
--- @example cm:iterate_forces(
--- @example 	function(force)
--- @example 		out(tostring(force:command_queue_index()))
--- @example 	end
--- @example );
function campaign_manager:iterate_forces(iterate_function, list)
     --faction support
     if is_table(list) or is_militaryforcelist(list) then
          cm:iterate(iterate_function, list)
          return
     end

     local list_is_faction = is_faction(list)

     if list ~= nil and not list_is_faction then
          out("ERROR: Trying to iterate forces over something that is not a faction")
          return
     end

     local object = nil
     local iteration_instructions = nil

     if list_is_faction then
          object = list
          iteration_instructions = { "military_force_list" }
     else
          object = cm:model():world()
          iteration_instructions = { "faction_list", "military_force_list" }
     end

     cm:recursive_iterate(iterate_function, object, iteration_instructions)
end

--- @function iterate_regions
--- @desc Iterates through regions in a list, faction or through all in the game's model
--- @p function iterate_function, Function to call for each region when iterating. Should accept 1 argument, the region
--- @p [opt=nil] object list, A list of regions we're iterating through or a faction script interface. If nil will iterate through ALL regions
--- @example cm:iterate_regions(
--- @example 	function(region)
--- @example 		out(region:name())
--- @example 	end
--- @example );
function campaign_manager:iterate_regions(iterate_function, list)
     --faction support
     if is_table(list) or is_regionlist(list) then
          cm:iterate(iterate_function, list)
          return
     end

     local list_is_faction = is_faction(list)

     if list ~= nil and not list_is_faction then
          out("ERROR: Trying to iterate regions over something that is not a faction")
          return
     end

     local object = nil
     local iteration_instructions = nil

     if list_is_faction then
          object = list
          iteration_instructions = { "region_list" }
     else
          object = cm:model():world():region_manager()
          iteration_instructions = { "region_list" }
     end

     cm:recursive_iterate(iterate_function, object, iteration_instructions)
end

--- @function iterate_characters
--- @desc Iterates through characters in a list, faction or through all in the game's model
--- @p function iterate_function, Function to call for each character when iterating. Should accept 1 argument, the character
--- @p [opt=nil] object list, A list of characters we're iterating through or a faction script interface. If nil will iterate through ALL characters
--- @example cm:iterate_characters(
--- @example 	function(character)
--- @example 		out(character:get_forename())
--- @example 	end
--- @example );
function campaign_manager:iterate_characters(iterate_function, list)
     --faction support
     if is_table(list) or is_characterlist(list) then
          cm:iterate(iterate_function, list)
          return
     end

     local list_is_faction = is_faction(list)

     if list ~= nil and not list_is_faction then
          out("ERROR: Trying to iterate characters over something that is not a faction")
          return
     end

     local object = nil
     local iteration_instructions = nil

     if list_is_faction then
          object = list
          iteration_instructions = { "character_list" }
     else
          object = cm:model():world()
          iteration_instructions = { "faction_list", "character_list" }
     end

     cm:recursive_iterate(iterate_function, object, iteration_instructions)
end

--- @function iterate_break
--- @desc Breaks through an iteration, default of 1 level
--- @p [opt=nil] number num_levels, Number of levels to break through. 1 by default
--- @example cm:iterate_characters(
--- @example 	function(character)
--- @example 		out(character:get_forename())
--- @example 		if character:get_forename() == "cool_guy_666" then
---
---
--- @example 			-- Iteration will break here
--- @example 			cm:iterate_break()
--- @example 			return
--- @example 		end
--- @example 	end
--- @example );
--- @example
--- @example cm:recursive_iterate(
--- @example 	function(slot)
--- @example 		if slot:name() == "cool_slot_322" then
--- @example 			-- Iteration will break for slots and we will go to the next region here
--- @example 			cm:iteration_break()
--- @example 			return
--- @example 		elseif slot:name() == "very_cool_slot_1337" then
--- @example 			-- Iteration will break for slots and for regions, and we will go to the next faction
--- @example 			cm:iteration_break(2)
--- @example 			return
--- @example 		end
--- @example 	end,
--- @example 	cm:model():world(),
--- @example 	{ "faction_list", "region_list", "slot_list" }
--- @example );
function campaign_manager:iterate_break(num_levels)
     self.iterate_break_levels = num_levels or 1
end
