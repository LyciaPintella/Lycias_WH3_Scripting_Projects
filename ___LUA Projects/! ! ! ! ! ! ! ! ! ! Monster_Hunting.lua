--local function out(text)
--    if type(text) == "string" then
--        local file = io.open("Kerb_log.txt", "a")
--            file:write(tostring("turn ".. cm:turn_number()) .. " " .. text .. "\n")
--            file:close()
--    end
--end

PJ_MONSTER_HUNT = PJ_MONSTER_HUNT or {}
local mod = PJ_MONSTER_HUNT

--- Lookup: building superchain to unit_key.
---for no longer superchain
mod.region_to_unit = {
     wh3_main_combi_region_the_golden_tower = "pj_monster_hunt_lzd_mon_carnosaur_supreme",
     wh3_main_combi_region_shrine_of_asuryan = "pj_monster_hunt_nor_mon_phoenix_flamespyre_supreme",
     wh3_main_combi_region_shrine_of_khaine = "pj_monster_hunt_chs_mon_dragon_ogre_shaggoth_supreme",
     wh3_main_combi_region_the_oak_of_ages = "pj_monster_hunt_wef_forest_dragon_supreme",
     wh3_main_combi_region_skavenblight = "pj_monster_hunt_skv_mon_hell_pit_abomination_supreme",
     wh3_main_combi_region_karak_eight_peaks = "pj_monster_hunt_grn_mon_arachnarok_spider_supreme",
     wh3_main_combi_region_erengrad = "pj_monster_hunt_nor_mon_war_mammoth_supreme",
     wh3_main_combi_region_castle_drakenhof = "pj_monster_hunt_vmp_mon_terrorgheist_supreme",
     wh3_main_combi_region_clar_karond = "pj_monster_hunt_def_mon_war_hydra_supreme",
     wh3_main_combi_region_ziggurat_of_dawn = "pj_monster_hunt_bst_mon_cygor_supreme",
     wh3_main_combi_region_zharr_naggrund = "pj_monster_hunt_grn_mon_giant_supreme",
     wh3_main_combi_region_ancient_city_of_quintex = "pj_monster_hunt_def_mon_medusa",
     wh3_main_combi_region_kislev = "pj_monster_hunt_frost_wyrm",
     wh3_main_combi_region_wei_jin = "wh2_dlc15_hef_mon_moon_dragon_imrik_boss"
}



--- unit_key to faction_key
--- Tells if a unit belongs to any faction.
mod.unit_to_faction = {}

--- unit_key to region_key
--- Tells what region made the unit available.
--- Used to check in region faction change events.




local function binding_iter(binding)
     local pos = 0
     local num_items = binding:num_items()
     return function()
          if pos < num_items then
               local item = binding:item_at(pos)
               pos = pos + 1
               return item
          end
          return
     end
end

---@param faction CA_FACTION
---@param unit_key string
mod.faction_has_unit = function(faction, unit_key)
     ---@type CA_MILITARY_FORCE
     for military_force in binding_iter(faction:military_force_list()) do
          if military_force:unit_list():has_unit(unit_key) and not military_force:is_armed_citizenry() and military_force:has_general() then
               return true, military_force:general_character()
          end
     end

     return false
end

mod.remove_unit = function(faction_key, unit_key)
     cm:add_unit_to_faction_mercenary_pool(
          cm:get_faction(faction_key),
          unit_key,
          "renown", --string recruitment source,
          0, -- unit count
          100, -- replenishment
          0, -- max_units
          0.10, -- number max per turn,
          "",
          "",
          "",
          true, --boolean partial replenishment,
          unit_key --string mercenary unit group
     )
end

local remove_unit_from_faction = function(faction_key, unit_key)
     out("initiating remove unit for" .. faction_key .. " " .. unit_key)
     local has_unit, general = mod.faction_has_unit(cm:get_faction(faction_key), unit_key)
     if has_unit then
          --if not cm:get_faction(faction_key):is_human() then
          out("REMOVING unit from character " .. unit_key)
          cm:remove_unit_from_character(cm:char_lookup_str(general), unit_key)
          --end
     end
     out("REMOVING unit from " .. faction_key .. " " .. unit_key)
     mod.remove_unit(faction_key, unit_key)
     mod.unit_to_faction[unit_key] = nil
end

mod.is_horde_faction = function(faction_key)
     local faction = cm:get_faction(faction_key)

     local is_horde_faction = true
     for military_force in binding_iter(faction:military_force_list()) do
          if not military_force:is_null_interface() then
               local is_horde = string.find(military_force:force_type():key(), "HORDE")
               is_horde_faction = is_horde_faction and is_horde
          end
     end

     return is_horde_faction
end

mod.ai_horde_already_has_a_monster = function(faction_key)
     local faction = cm:get_faction(faction_key)
     if faction:is_human() then
          return false
     end

     local is_horde_faction = mod.is_horde_faction(faction_key)

     if not is_horde_faction then
          return false
     end

     for _, owning_faction_key in pairs(mod.unit_to_faction) do
          if owning_faction_key == faction_key then
               return true
          end
     end
end

mod.add_unit = function(faction_key, unit_key)
     if mod.faction_has_unit(cm:get_faction(faction_key), unit_key)
         or mod.ai_horde_already_has_a_monster(faction_key)
     then
          if mod.faction_has_unit(cm:get_faction(faction_key), unit_key) then
               out(faction_key .. " already has the unit, SKIPPING")
          end
          if mod.ai_horde_already_has_a_monster(faction_key) then
               out(faction_key .. " is a horde faction, SKIPPING")
          end
          return
     end


     out("adding " .. unit_key .. " to " .. faction_key)
     if mod.is_horde_faction(faction_key) then
          out("  IT IS A HORDE FACTION")
     end
     -- out(debug.traceback())

     cm:add_unit_to_faction_mercenary_pool(
          cm:get_faction(faction_key),
          unit_key,
          "renown", --string recruitment source,
          1, -- unit count
          100, -- replenishment
          10, -- max_units
          0.10, -- number max per turn,
          "",
          "",
          "",
          true, --boolean partial replenishment,
          unit_key --string mercenary unit group
     )

     mod.unit_to_faction[unit_key] = faction_key
end

---@param char CA_CHAR
---@param garrison CA_GARRISON_RESIDENCE
mod.on_occupied_or_razed = function(char, garrison)
     local region_name = garrison:region():name()
     for region_key, unit_key in pairs(mod.region_to_unit) do
          if region_key == region_name then
               mod.add_unit(char:faction():name(), unit_key)
          end
     end
end



mod.init = function()
     core:remove_listener("pj_monster_hunt_on_region_faction_ownership_change")
     core:add_listener(
          "pj_monster_hunt_on_region_faction_ownership_change",
          "RegionFactionChangeEvent",
          function()
               return true
          end,
          function(context)
               ---@type CA_FACTION
               local previous_faction = context:previous_faction():name()
               ---@type CA_REGION
               local region = context:region()

               for region_key, unit_key in pairs(mod.region_to_unit) do
                    if region_key == region:name() then
                         out("RegionFactionChangeEvent for a monster region for " ..
                         unit_key .. " attepmting to remove monster from " .. previous_faction)
                         remove_unit_from_faction(previous_faction, unit_key)
                    end
               end
          end,
          true
     )



     core:remove_listener("pj_monster_hunt_on_garrison_occupied")
     core:add_listener(
          "pj_monster_hunt_on_garrison_occupied",
          "GarrisonOccupiedEvent",
          function()
               return true
          end,
          function(context)
               ---@type CA_CHAR
               local char = context:character()
               ---@type CA_GARRISON_RESIDENCE
               local gr = context:garrison_residence()
               mod.on_occupied_or_razed(char, gr)
          end,
          true
     )

     core:remove_listener("pj_monster_hunt_on_razed_settlement")
     core:add_listener(
          "pj_monster_hunt_on_razed_settlement",
          "CharacterRazedSettlement",
          function()
               return true
          end,
          function(context)
               ---@type CA_CHAR
               local char = context:character()
               ---@type CA_GARRISON_RESIDENCE
               local gr = context:garrison_residence()
               mod.on_occupied_or_razed(char, gr)
          end,
          true
     )
end

cm:add_first_tick_callback(function()
     mod.init()
end)

---HERE remove _new, add faction turn start listner with saved value one time check, if statement based on turn # > 10
---this happens only on the initial first tick of a new campaign
cm:add_first_tick_callback(function()
     local player_faction_name = cm:get_local_faction_name()
     core:add_listener(
          "Kerb_Mon_Hunt_quest_issuer",
          "FactionTurnStart",
          function(context)
               if context:faction():name() == player_faction_name and cm:turn_number() == 10 and not cm:get_saved_value("kerb_mon_missions_spawned") then
                    out("turn 10, issuing kerb monster hunt quests and unlocking monsters");
                    return true
               else
                    return false
               end
          end,
          function(context)
               cm:trigger_mission(player_faction_name, "kerb_carnosaur", true);
               cm:trigger_mission(player_faction_name, "kerb_phoenix", true);
               cm:trigger_mission(player_faction_name, "kerb_dragon_ogre", true);
               cm:trigger_mission(player_faction_name, "kerb_forest_dragon", true);
               cm:trigger_mission(player_faction_name, "kerb_abomination", true);
               cm:trigger_mission(player_faction_name, "kerb_arachnarok", true);
               cm:trigger_mission(player_faction_name, "kerb_mammoth", true);
               cm:trigger_mission(player_faction_name, "kerb_terrorgheist", true);
               cm:trigger_mission(player_faction_name, "kerb_hydra", true);
               cm:trigger_mission(player_faction_name, "kerb_cygor", true);
               cm:trigger_mission(player_faction_name, "kerb_giant", true);
               cm:trigger_mission(player_faction_name, "kerb_medusa", true);
               cm:trigger_mission(player_faction_name, "kerb_frost_wyrm", true);
               cm:trigger_mission(player_faction_name, "kerb_moon_dragon", true);
               for region_key, unit_key in pairs(mod.region_to_unit) do
                    local region_owner = cm:get_region(region_key):owning_faction():name()
                    mod.add_unit(region_owner, unit_key)
               end
               cm:set_saved_value("kerb_mon_missions_spawned", true);
          end,
          false);
end)

if debug.traceback():find('pj_loadfile') then
     mod.init()
end
