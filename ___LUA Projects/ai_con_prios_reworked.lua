local modSettings = {
     enable_Bret_Barracks_Replacement = true,          -- Replace starting Bretonnian barracks with stables.
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
     if modSettings.enable_Bret_Barracks_Replacement then
          local turn_number = cm:model():turn_number()
          cm:callback(function()
               if (turn_number == 1) then
                    loop_through_list()
                    remove_barracks("wh3_main_combi_region_desolation_of_drakenmoor")
               end
          end, 2.0)
     end
end

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
     local mctMod = context:mct():get_mod_by_key("ai_construction_priorities_reworked")
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


local function initialize_mct()
    local mod = get_mct():get_mod_by_key("ai_construction_priorities_reworked")
    --modSettings.enable_Bret_Barracks_Replacement = mod:get_option_by_key("enable_Bret_Barracks_Replacement")

    out("modSettings.enable_Bret_Barracks_Replacement " ..
        tostring(modSettings.enable_Bret_Barracks_Replacement) .. "")
end

core:add_listener(
     "ai_construction_priorities_reworked",
     "MctInitialized",
     true,
     function(context)
          out("AI Construction Priorities Reworked: MCT settings initialized " .. "")
          get_mct_settings(context)
          isUsingMCT = true
     end,
     true
)


core:add_listener(
     "ai_construction_priorities_reworked_mct_setting_finalized",
     "MctFinalized",
     true,
     function(context)
          out("AI Construction Priorities Reworked: MCT settings finalized " .. "")
          get_mct_settings(context)
     end,
     true
)

cm:add_first_tick_callback(function()
     initialize_mct()
end);

cm:add_first_tick_callback_new(function()
     initialize_bretonnian_barracks_replacement()
end)
