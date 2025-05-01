out("fort_mod_init")
------------------------------------------
--Fort tracker and supporting listeners.
------------------------------------------
--Fort tracker has 3 set up forts, due to them being present on startpos. force cqi's are gatherd by first time setup function.
local first_time_run = false

--need to populate the tracker with cosntructedforts ona  first time run. see first time function run
local fort_tracker = {
     --["phar_main_hattussa_hattussa"] = {["faction_name"] = "phar_main_suppiluliuma", ["fort_cqi"] = 0},
     --["phar_map_hanigalbat_shadikanni"] = {["faction_name"] = "phar_map_ninurta", ["fort_cqi"] = 0},
     --["phar_main_tyre_sidon"] = {["faction_name"] = "phar_main_bay", ["fort_cqi"] = 0}

}

-- Listener identifies if a fort building has been built. If so, region and building are tracked.
core:add_listener(
     "ers_fort_built",
     "BuildingCompleted",
     function(context)
          local building_level = context:building():name()
          if string.find(building_level, "ers_fort") then
               return true
          end
     end,
     function(context)
          local region_name = context:building():region():name()
          local faction_name = context:building():faction():name()
          local garrison_residence = context:building():slot():garrison_residence()
          local slot_garrison_cqi = cm:get_armed_citizenry_from_garrison(garrison_residence)
          out("fort_mod: Region: " .. region_name .. " has a fort and is being added to our tracker")
          fort_tracker[region_name] = {}
          fort_tracker[region_name].faction_name = faction_name
          fort_tracker[region_name].fort_cqi = slot_garrison_cqi
     end,
     true
)

--listener listens for building demolished event and removes the tracking from fort tracker.
core:add_listener(
     "ers_fort_demolished",
     "BuildingDemolished",
     function(context)
          local building_level = context:building():name()
          if string.find(building_level, "ers_fort") then
               return true
          end
     end,
     function(context)
          local region_name = context:building():region():name()
          out("fort_mod: Region: " .. region_name .. " no longer has a fort removing tracking")
          if fort_tracker[region_name] then
               fort_tracker[region_name] = nil
          else
               out("fort_mod: Error: Region was not tracked")
          end
     end,
     true
)

--think this is to see if the force of a fort is killed in battle. Just making sure that whenthis occurs we update the tracker so we don't keep sapwning whatever the destoryed force was.
core:add_listener(
     "ers_force_destroyed",
     "MilitaryForceDestroyed",
     function(context)
          local force_int = context:military_force()

          if fort_tracker[force_int:general_character():region():name()] then
               out("fort_mod: Destroyed force region tracked for fort")
               return true
          end
     end,
     function(context)
          local force_cqi = context:cqi()
          local force_int = context:military_force()
          local destruction_region = force_int:general_character():region():name()

          if fort_tracker[destruction_region].fort_cqi == force_cqi then
               out("fort_mod: destroyed force is one we have tracked in a fort")
               local slot_list = force_int:general_character():region():slot_list()
               out("fort_mod: holladaayy?")
               cm:callback(
                    function()
                         out("fort_mod: holla")
                         --local slot_list = force_int:general_character():region():slot_list() --could this be too late thanks to the allback?
                         out("fort_mod: " .. tostring(slot_list))
                         for i = 0, slot_list:num_items() - 1 do
                              local slot = slot_list:item_at(i)
                              out("fort_mod: " .. tostring(slot))
                              if not slot:is_null_interface() and slot:is_infrastructure_slot() then
                                   local slot_name = slot:building():name()
                                   out("fort_mod: " .. slot_name)
                                   if string.find(slot_name, "ers_fort") then
                                        local faction_name = slot:building():faction():name()
                                        out("fort_mod: holla1")
                                        local garrison_residence = slot:garrison_residence()
                                        out("fort_mod: holla2")
                                        local garrison_army = cm:get_armed_citizenry_from_garrison(garrison_residence)
                                        out("fort_mod: holla3")
                                        local force_cqi = garrison_army:command_queue_index()
                                        out("fort_mod: holla4")
                                        local region_name = context:region():name()
                                        out("fort_mod: updating region after destruction :" ..
                                        region_name .. "with for owned by: " ..
                                        faction_name .. " with a cqi of: " .. force_cqi)
                                        fort_tracker[region_name].faction_name = faction_name
                                        fort_tracker[region_name].fort_cqi = force_cqi
                                        break
                                   end
                              end
                         end
                         out("fort_mod: ERROR The fort seems to be dead, hopefully our demolished event picked it up..")
                    end

                    , 0.1)
          end
     end,
     true
)

--When region change event occurs, we do a quick check to update our fort tracker to ensure that it has the right faction name and cqi.
core:add_listener(
     "ers_fort_demolished",
     "RegionFactionChangeEvent",
     function(context)
          return fort_tracker[context:region():name()]
     end,
     function(context)
          out("fort_mod: Region we are tracking has ownership changed: " .. context:region():name())
          local slot_list = context:region():slot_list()
          for i = 0, slot_list:num_items() - 1 do
               local slot = slot_list:item_at(i)
               if not slot:is_null_interface() and slot:is_infrastructure_slot() then
                    local slot_name = slot:building():name()
                    if string.find(slot_name, "ers_fort") then
                         local faction_name = slot:building():faction():name()
                         local garrison_residence = slot:garrison_residence()
                         local force_cqi = cm:get_armed_citizenry_from_garrison(garrison_residence)
                         local region_name = context:region():name()
                         out("fort_mod: updating region :" ..
                         region_name .. "with for owned by: " .. faction_name .. " with a cqi of: " .. force_cqi)
                         fort_tracker[region_name].faction_name = faction_name
                         fort_tracker[region_name].fort_cqi = force_cqi
                         break
                    else
                         out("fort_mod: ERROR The fort seems to be dead, hopefully our demolished event picked it up..")
                    end
               end
          end
     end,
     true
)

--Fort's don't convert when setto indipendant, can only be razed. So the razing to demolished event SHOULD pick up instances where fort is taken out when the region is owned by the player.

function fort_reinforce()
     if first_time_run == false then
          out("fort_mod: First time run. grabbing all regions with forts to populate tracker.")
          local region_list = cm:model():world():region_manager():region_list()

          for i = 0, region_list:num_items() - 1 do
               local this_region = region_list:item_at(i)
               local slot_list = this_region:slot_list()
               for j = 0, slot_list:num_items() - 1 do
                    this_slot = slot_list:item_at(j)
                    if not this_slot:is_null_interface() and this_slot:is_infrastructure_slot() then
                         local slot_building = this_slot:building()
                         if not slot_building:is_null_interface() then
                              local slot_name = slot_building:name()
                              if string.find(slot_name, "ers_fort") then
                                   out("fort_mod: Fort is called: " .. slot_name)
                                   local faction_name = this_slot:building():faction():name()
                                   local region_name = this_region:name()
                                   local garrison_residence = this_slot:garrison_residence()
                                   local army = cm:get_armed_citizenry_from_garrison(garrison_residence)
                                   if army ~= false then
                                        local force_cqi = army:command_queue_index()

                                        out("fort_mod: updating region :" ..
                                        region_name .. "with for owned by: " ..
                                        faction_name .. " with a cqi of: " .. force_cqi)
                                        fort_tracker[region_name] = {}
                                        fort_tracker[region_name].faction_name = faction_name
                                        fort_tracker[region_name].fort_cqi = force_cqi
                                   else
                                        out("fort_mod: ERROR: cannot update region :" ..
                                        region_name ..
                                        "with fort owned by: " .. faction_name .. " because no garrison can be found")
                                   end
                              end
                         end
                    end
               end
          end
          first_time_run = true
     end
end

------------------------------------------
--Army Spawn Tracker and supporting functions
------------------------------------------


local army_spawn_tracker = {
     --["spawned_army_cqi"] = {["originator_cqi"] = 0, ["unit_cqi_list"] = {}, ["originator_cqi_list"] = {}}
}

-- Function retrieves the cqi of the origianl force in fort, from the spawend armies cqi.
function get_originator_cqi_from_spawn(force_cqi)
     if not army_spawn_tracker[force_cqi] then
          out("fort_mod: ERROR given cqi:" .. force_cqi .. "is not tracked as a spawned army")
          return false
     end
     return army_spawn_tracker[force_cqi].originator_cqi
end

--function gets the spawned armies list of unit cqi's based on the spawnforce cqi
function get_spawned_unit_cqi_list_from_spawn_army(force_cqi)
     if not army_spawn_tracker[force_cqi] then
          out("fort_mod: ERROR given cqi:" .. force_cqi .. "is not tracked as a spawned army")
          return false
     end
     out("fort_mod: returning " .. tostring(army_spawn_tracker[force_cqi].unit_cqi_list))
     return army_spawn_tracker[force_cqi].unit_cqi_list
end

--function providesthe unit cqi's of the original fort army force
function get_originator_unit_cqi_list_from_spawn_army(force_cqi)
     if not army_spawn_tracker[force_cqi] then
          out("fort_mod: ERROR given cqi:" .. force_cqi .. "is not tracked as a spawned army")
          return false
     end
     out("fort_mod: returning " .. tostring(army_spawn_tracker[force_cqi].originator_cqi_list))
     return army_spawn_tracker[force_cqi].originator_cqi_list
end

--function adds a new entry to our force tracker.
function add_army_spawn_entry(spawn_cqi, fort_cqi)
     if not spawn_cqi or not fort_cqi then
          out("fort_mod: ERROR not enough paramters submitted.")
          return
     end
     army_spawn_tracker[spawn_cqi] = {}
     army_spawn_tracker[spawn_cqi].originator_cqi = fort_cqi
     army_spawn_tracker[spawn_cqi].originator_cqi_list = get_unit_cqi_from_force_cqi(fort_cqi)
     army_spawn_tracker[spawn_cqi].unit_cqi_list = get_unit_cqi_from_force_cqi(spawn_cqi)
     out("fort_mod: Adding: " .. spawn_cqi .. " to tracker with originator: " .. fort_cqi .. "and two cqi lists")
end

function remove_spaend_army_from_tracking(spawn_cqi)
     out("fort_mod: Removing " .. spawn_cqi .. " from tracker, note other function must kill army.")
     army_spawn_tracker[spawn_cqi] = nil
end

------------------------------------------
--Supporting functions
------------------------------------------

-- function takes two lists of tracked unitcqi's and takes the hp of one and applies it to the ither. units are paired by their key value. cqi lists provided will always be 0 to 19 index
function transfer_health_to_force(cqi_list, target_cqi_list)
     out("fort_mod: transfer health function called!")
     local model = cm:model()
     for i = 0, 19 do                                                         --indexes at 0, but 0 will be cahracter.
          if cqi_list[i] ~= nil and target_cqi_list[i] ~= nil then
               local this_unit = model:unit_for_command_queue_index(cqi_list[i]) --hoping this returns nil if false.
               local this_target_unit = model:unit_for_command_queue_index(target_cqi_list[i])

               if this_unit:is_null_interface() and not this_target_unit:is_null_interface() then
                    out("fort_mod: source unit is non existant, likely died in battle, target unit hp set to 1")
                    cm:set_unit_soldiers_or_hitpoints(this_target_unit, 1)
               elseif not this_unit:is_null_interface() and not this_target_unit:is_null_interface() then
                    out("fort_mod: source unit transferring to target unit")
                    local current_hp = this_unit:num_soldiers_or_hitpoints()
                    cm:set_unit_soldiers_or_hitpoints(this_target_unit, current_hp)
               elseif this_unit:is_null_interface() and this_target_unit:is_null_interface() then
                    out("fort_mod: Neither army has a unit, likely smaller than a 20 stack")
               else
                    out("fort_mod: ERROR trying to transfer hp to a non existant unit. This should not happen!")
               end
          elseif cqi_list[i] == nil and target_cqi_list[i] == nil then
               out("fort_mod: no tracked unit")
          else
               out("fort_mod: error, cqi table mismatch")
          end
     end
end

function get_unit_cqi_from_force_cqi(force_cqi)
     out("fort_mod: get_unit_cqi_from force func called")
     local force_interface = cm:get_military_force_by_cqi(force_cqi)
     local unit_list = force_interface:unit_list()
     local table_to_return = {}

     for i = 0, unit_list:num_items() - 1 do --not index 0 is general
          local this_unit = unit_list:item_at(i)
          local this_unit_cqi = this_unit:command_queue_index()
          --out("fort_mod: cqi "..this_unit_cqi)
          table_to_return[i] = this_unit_cqi
     end
     out("fort_mod: returning unit_list")
     return table_to_return
end

--function returns a string containing units for the given force_cqi
function generate_unit_list_string_from_force(force_cqi)
     out("fort_mod: getting string info for force: " .. force_cqi)

     local force_int = cm:get_military_force_by_cqi(force_cqi)
     local unit_list = force_int:unit_list()
     for i = 1, unit_list:num_items() - 1 do    --need to start from 1 and not 0, because 0 is the general key!
          --out("fort_mod: unit no. "..i)
          local unit = unit_list:item_at(i)
          local unit_key = unit:unit_key()
          --out("fort_mod: key: "..unit_key)
          if i == 1 and is_unit(unit) then   --index here needs to be 1 too
               --out("fort_mod:Adding first unit to list string")
               units_list_string = unit_key
          elseif is_unit(unit) then
               --out("fort_mod:Adding additional unit to list")
               units_list_string = units_list_string .. "," .. unit_key
          end
     end
     out("fort_mod: returning string: " .. units_list_string)
     return units_list_string
end

------------------------------------------
--spawning listener
------------------------------------------

core:add_listener(
     "army_attacking_fort_mod",
     "PendingBattleAboutToBeCreated",
     function(context)
          local target_char_region = context:target_character():region():name()
          if not fort_tracker[target_char_region] then
               out("fort_mod: Region is not tracked to have fort. Ignoring")
               return false
          end

          local battle_type = context:battle_type()
          if battle_type == "settlement_sally" or battle_type == "settlement" or battle_type == "settlement_unfortified" or battle_type == "settlement_standard" or battle_type == "fort_standard" or battle_type == "settlement_relief" then
               out("fort_mod: Battle is a settlement or fort. Ignoring.")
               return
          end

          --[[ local target_char_faction = context:target_character():faction():name()
       local stored_faction =cm:get_faction(fort_tracker[target_char_region].faction_name)
        if not (target_char_faction:name() == fort_tracker[target_char_region].faction_name) or not (target_char_faction:allied_with(stored_faction)) then
            out("fort_mod: fort owner is not the defending army, or an ally. Ignoring")
            return
        end]]

          if not (fort_tracker[target_char_region].faction_name == context:target_character():faction():name()) and not (fort_tracker[target_char_region].faction_name == context:character():faction():name()) then
               out("fort_mod: fort owner:" ..
               fort_tracker[target_char_region].faction_name ..
               "is not involved in the battle" ..
               context:target_character():faction():name() .. "and" .. context:character():faction():name() .. "Ignoring")
               return
          end

          out("fort_mod: A character is being attacked in a region where they, have a fort.")
          return true
     end,
     function(context)
          local target_char_region = context:target_character():region():name()
          local target_char = context:target_character()
          local attacking_char = context:character()
          local char_to_reinforce = ""

          --we need to find out if the fort owner is attacking or defending and make sure we spawn an army by the right character!
          if target_char:faction():name() == fort_tracker[target_char_region].faction_name then
               char_to_reinforce = target_char
          elseif attacking_char:faction():name() == fort_tracker[target_char_region].faction_name then
               char_to_reinforce = attacking_char
          else
               out("fort_mod: error - fort owner is not attacker or defender :0")
          end


          local region_fort_owner_name = fort_tracker[target_char_region].faction_name
          local lookup_str = cm:char_lookup_str(char_to_reinforce)
          local x, y = cm:find_valid_spawn_location_for_character_from_character(region_fort_owner_name, lookup_str, true)
          local fort_cqi = fort_tracker[target_char_region].fort_cqi
          local fort_unit_string = generate_unit_list_string_from_force(fort_cqi)
          out("fort_mod: about to create force." .. region_fort_owner_name .. " | " .. target_char_region .. " | " ..
          x .. y)
          out("fort_mod: unit list is: " .. fort_unit_string)

          cm:create_force(
               region_fort_owner_name,
               fort_unit_string,
               target_char_region,
               x, y,
               true,
               function(general_cqi)
                    out("fort_mod: arm spawn callback made")
                    local char_int = cm:get_character_by_cqi(general_cqi)
                    local force_cqi = char_int:military_force():command_queue_index()
                    add_army_spawn_entry(force_cqi, fort_cqi) -- the forces are both tracked.

                    --transfering fort unit hp to clone army.
                    --out("fort_mod: spawn army trakced, transfering hp prep")
                    local spawn_army_cqi_list = get_spawned_unit_cqi_list_from_spawn_army(force_cqi)
                    local fort_cqi_list = get_originator_unit_cqi_list_from_spawn_army(force_cqi)
                    --out("fort_mod: spawn army trakced, transfering hp")
                    transfer_health_to_force(fort_cqi_list, spawn_army_cqi_list)

                    -- we will want to kill this army without spawning dilemma event
                    local general_str = cm:char_lookup_str(general_cqi)
                    cm:force_add_trait(general_str, "nobody_trait")
               end
          )
     end,
     true
)

------------------------------------------
--Cleanup Listeners
------------------------------------------

core:add_listener(
     "tp_clean_up_army_been_fought",
     "BattleCompleted",
     function(context)
          for cqi, data in pairs(army_spawn_tracker) do
               if cm:pending_battle_cache_mf_is_involved(cqi) then
                    out("fort_mod: battle ended with a spawned army participating: " .. cqi)
                    return true
               end
          end
          out("fort_mod: battle has no cqi beign tracked")
     end,
     function(context)
          local spawned_army = 0
          for cqi, data in pairs(army_spawn_tracker) do
               if cm:pending_battle_cache_mf_is_involved(cqi) then
                    out("fort_mod: identified spawned army: " .. cqi)
                    spawned_army = cqi
               end
          end
          local spawn_army_int = cm:get_military_force_by_cqi(spawned_army)
          local spawn_army_unit_cqi_list = get_spawned_unit_cqi_list_from_spawn_army(spawned_army)
          local originator_army_unit_list = get_originator_unit_cqi_list_from_spawn_army(spawned_army)
          out("fort_mod: Transfering hp")
          transfer_health_to_force(spawn_army_unit_cqi_list, originator_army_unit_list)

          if spawn_army_int == false then
               out(
               "fort_mod: military force is false, probably wiped, the transfer function should have handled updating fort garrison, removing from tracker")
               army_spawn_tracker[spawned_army] = nil
          else
               out("fort_mod: the army survived, kill it!")
               local char_cqi = spawn_army_int:general_character():cqi()
               cm:kill_character_and_commanded_unit("character_cqi:" .. char_cqi, true)
               army_spawn_tracker[spawned_army] = nil
          end
     end,
     true
)


--saving trackers
cm:add_saving_game_callback(function(context)
     cm:save_named_value("fort_tracker", fort_tracker, context)
     cm:save_named_value("army_spawn_tracker", army_spawn_tracker, context)
end)
cm:add_loading_game_callback(function(context)
     fort_tracker = cm:load_named_value("fort_tracker", fort_tracker, context)
     army_spawn_tracker = cm:load_named_value("army_spawn_tracker", army_spawn_tracker, context)
end)
