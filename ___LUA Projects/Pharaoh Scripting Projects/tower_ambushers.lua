--What script does:
-- for each character in an enemy region that has a tower present. At the end of its turn, roll a dice, if roll passes,
-- tower sends a small force to ambush the enemy.
--the small force is designed to take out any very small or weak stacks, or harass larger ones. Ideally though, it is used to intercept invading armies and reinforced by refugee camps or..



-- define the units we want in ambush forces here, broken down by realm, should include that realms units - ideally fast or skirmishing ones (suppose to be scouts)
out("MYMOD: SCRIPT INIT")
---@type table<string, string> #indexed with building level, contains unit list as comma spearated string.
local tower_garrison_table = {
     ["phar_main_ers_outpost_fenkhu_1"] =
     "phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers",                                                                          --4 canaanite rock throwers
     ["phar_main_ers_outpost_highlands_1"] =
     "phar_main_nat_hig_kaskian_javelin_throwers,phar_main_nat_hig_kaskian_javelin_throwers,phar_main_nat_hig_kaskian_javelin_throwers",                                                                                                                 -- 3 kaskian javelins
     ["phar_main_ers_outpost_isuwa_1"] =
     "phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers",                                                                                                          -- 4 isuwan slingers
     ["phar_main_ers_outpost_kush_1"] =
     "phar_main_nat_nub_nubian_hunters,phar_main_nat_nub_nubian_hunters,phar_main_nat_nub_nubian_hunters",                                                                                                                                               --3 nubian hunters
     ["phar_main_ers_outpost_lower_egypt_1"] =
     "phar_main_nat_low_lower_egyptian_militia_slingers,phar_main_nat_low_lower_egyptian_militia_slingers,phar_main_nat_low_lower_egyptian_militia_slingers,phar_main_nat_low_lower_egyptian_militia_slingers",                                          --4 lower egyptian militia slingers
     ["phar_main_ers_outpost_lowlands_1"] =
     "phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers,phar_main_nat_isu_isuwan_slingers",                                                                                                          -- 4 isuwan slingers
     ["phar_main_ers_outpost_nubia_1"] =
     "phar_main_nat_nub_nubian_hunters,phar_main_nat_nub_nubian_hunters,phar_main_nat_nub_nubian_hunters",                                                                                                                                               --3 nubian hunters
     ["phar_main_ers_outpost_retjennu_1"] =
     "phar_main_nat_sin_habiru_militia,phar_main_nat_sin_habiru_archers,phar_main_nat_sin_habiru_archers",                                                                                                                                               -- 1 habiru militia, 2 habiru archers
     ["phar_main_ers_outpost_sinai_1"] =
     "phar_main_nat_sin_habiru_militia,phar_main_nat_sin_habiru_archers,phar_main_nat_sin_habiru_archers",                                                                                                                                               -- 1 habiru militia, 2 habiru archers
     ["phar_main_ers_outpost_upper_egypt_1"] =
     "phar_main_nat_upp_upper_egyptian_militia_slingers,phar_main_nat_upp_upper_egyptian_militia_slingers,phar_main_nat_upp_upper_egyptian_militia_slingers,phar_main_nat_upp_upper_egyptian_militia_slingers",                                          --4 upper egyptian militia slingers
     ["phar_main_ers_outpost_western_desert_1"] =
     "phar_main_nat_wes_libu_slingersphar_main_nat_wes_libu_slingers,phar_main_nat_wes_libu_slingers,phar_main_nat_wes_libu_slingers,phar_main_nat_wes_libu_slingers",                                                                                   -- 4 libu slingers
     ["phar_main_ers_outpost_yamhad_1"] =
     "phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers,phar_main_nat_fen_canaanite_rock_throwers",                                                                          --4 canaanite rock throwers
     ["phar_map_ers_outpost_aber_nahra_1"] =
     "phar_map_nat_aber_ahlamu_nomads,phar_map_nat_aber_ahlamu_nomads,phar_map_nat_aber_ahlamu_camel_riders",                                                                                                                                            --2 ahlamu nomads tribesmen, 1 ahlamu pack camel
     ["phar_map_ers_outpost_achaea_1"] =
     "phar_map_nat_ach_achaean_stoneslingers,phar_map_nat_ach_achaean_stoneslingers,phar_map_nat_ach_achaean_stoneslingers,phar_map_nat_ach_achaean_stoneslingers",                                                                                      --4 achean slingers
     ["phar_map_ers_outpost_assuwa_1"] =
     "phar_map_nat_wil_trojan_slingers,phar_map_nat_wil_trojan_slingers,phar_map_nat_wil_trojan_slingers,phar_map_nat_wil_trojan_slingers",                                                                                                              --4 assuwan slingers
     ["phar_map_ers_outpost_haltamti_1"] =
     "phar_map_nat_halt_elamite_slingers,phar_map_nat_halt_elamite_slingers,phar_map_nat_halt_elamite_slingers,phar_map_nat_halt_elamite_slingers",                                                                                                      --4elamite slingers
     ["phar_map_ers_outpost_mat_assur_1"] =
     "phar_map_nat_assur_akkadian_hunters,phar_map_nat_assur_akkadian_hunters,phar_map_nat_assur_akkadian_hunters",                                                                                                                                      --3 akkandian hunters
     ["phar_map_ers_outpost_mat_tamti_1"] =
     "phar_map_nat_assur_akkadian_farmers,phar_map_nat_tamti_akkadian_archers,phar_map_nat_tamti_akkadian_archers",                                                                                                                                      --1 akkadian farmer, 2x akkadian archers
     ["phar_map_ers_outpost_thrace_1"] =
     "phar_map_nat_thr_forest_skirmishers,phar_map_nat_thr_forest_skirmishers,phar_map_nat_thr_forest_skirmishers",                                                                                                                                      --3 forest skirmishers
     ["phar_map_ers_outpost_zagros_1"] =
     "phar_map_nat_zag_urartu_hunters,phar_map_nat_zag_urartu_hunters,phar_map_nat_zag_urartu_hunters",                                                                                                                                                  -- 3 uratu hunters
}

--this table is designed to store the force cqi of spawned ambush armies and their target. Uses force cqi, because characters can die in battle.
---@type table<number,number>
local cqi_tracker = {}

--this table tracks the characers who have ended their turn in an enemy region that has a tower outpost, popualted on character turn end listener. These are Ambush candidates.
---@type table<number, string> # CQI and region name
local invading_army_tracker = {
     --[char_cqi] = "region_name"
}
--this is a varaible to set how likely an ambush occurs for EACH character on enemy soil. 100 = 100% chance of occuring.
local ambush_chance = 40    --100 for testing purposes.

---------------------------------------------------
--Listeners
---------------------------------------------------

-- We will check if a character is an ambush candidate at the end of thier turn (e.g. after theyhave done their movement) and recordsthem in invasion tracker.
core:add_listener(
     "invading_character",
     "CharacterTurnEnd",
     function(context)
          local char_region = context:character():region();
          local char_faction = context:character():faction();
          local region_faction = char_region:owning_faction();
          local char_cqi = context:character():cqi()
          --game has no agents, no need to do military force check.
          if char_faction == region_faction then
               --out("MYMOD: the character "..char_cqi.." is in thier own region, ignore")
               return false
          end

          if not char_faction:at_war_with(region_faction) then
               --out("MYMOD: character "..char_cqi.." is not in an enemy region, ignore")
               return false
          end

          if locate_tower_outpost(char_region) == false then
               --out("MYMOD: character "..char_cqi.." is in region wihtout tower, ignore")
               return false
          end

          if context:character():military_force():is_armed_citizenry() then
               --out("MYMOD: character "..char_cqi.." is a garrison residence, ignore")
               return false
          end

          out("MYMOD: character " ..
          char_cqi ..
          " is in anotehr factions region " ..
          context:character():region():name() .. " and they are at war. Is a candidate for ambush.")
          return true
     end,

     function(context)
          invading_army_tracker[context:character():cqi()] = context:character():region():name()
     end,

     true
)

-- Listener will go through regions which have ambush candidates present in them, attempt to spawn an ambushing army.
core:add_listener(
     "invasion_checks",
     "RegionTurnStart",
     function(context)
          local region_name = context:region():name()
          for cqi, region in pairs(invading_army_tracker) do
               if region == region_name then
                    out("MYMOD: current region " .. region_name .. " is logged in invasion tracker, invasion potential.")
                    return true
               end
          end
          --out("MYMOD: current region "..region_name.." is not logged in invasion tracker, ignore.")
          return false
     end,
     function(context)
          local this_region_invader_list = {}
          local region_name = context:region():name()

          --quickly extract the relevant invaders from the invasion tracker to limit processing.
          for cqi, region in pairs(invading_army_tracker) do
               if region == region_name then
                    out("MYMOD: Adding character " .. cqi .. " to temporary candidate list for " .. region)
                    table.insert(this_region_invader_list, cqi)
               end
          end

          --out("MYMOD: Processing temporary candidate list)
          for i = 1, #this_region_invader_list do
               local this_char_cqi = this_region_invader_list[i]
               local this_char = cm:get_character_by_cqi(this_char_cqi)

               --lets quickly check the tracked invader is still in region.
               if not this_char:region():name() == region_name then
                    out("MYMOD: Ambush candidate " ..
                    this_char_cqi .. " is no longer in " .. region_name .. ". Removing from candidate tracker")
                    invading_army_tracker[this_char_cqi] = nil
               elseif not this_char:faction():at_war_with(context:region():owning_faction()) then
                    out("MYMOD: Ambush candidate " ..
                    this_char_cqi .. " is no longer at war with" ..
                    region_name .. " owner. Removing from candidate tracker")
                    invading_army_tracker[this_char_cqi] = nil
               else
                    out("MYMOD: Character " .. this_char_cqi ..
                    " is still viable ambush candidate rolling dice to ambush")
                    if random_number_chance(ambush_chance) then
                         out("MYMOD: Roll passes, getting relevant info for spawning army.")
                         local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_character(
                         context:region():owning_faction():name(), cm:char_lookup_str(this_char_cqi), true)
                         local outpost_name = locate_tower_outpost(context:region())
                         local army_units = ""

                         if not outpost_name == false then
                              army_units = get_army_units(outpost_name) --the units in the army we want to spawn.
                         else
                              out(
                              "MYMOD: Error,somehow we got false when we were expecting true, was the tower destroyed?")
                         end

                         out("MYMOD: Creating force now to attack character " .. this_char_cqi)

                         cm:create_force(
                              context:region():owning_faction():name(),
                              army_units,
                              region_name,
                              pos_x,
                              pos_y,
                              true,
                              function(general_cqi)
                                   out("MYMOD: Spawned army callback fired, removing " ..
                                   this_char_cqi .. " from ambush candidate")
                                   invading_army_tracker[this_char_cqi] = nil
                                   local char_int = cm:get_character_by_cqi(general_cqi)
                                   local force_cqi = char_int:military_force():command_queue_index()
                                   local inv_char_int = cm:get_character_by_cqi(this_char_cqi)

                                   --force ambush stance.
                                   cm:activate_stance_to_force(true, "MILITARY_FORCE_ACTIVE_STANCE_TYPE_STALKING",
                                        force_cqi)
                                   cm:apply_effect_bundle_to_force("tp_mod_scripted_ambush_buff", force_cqi, 1) --spawned army is buuffed to be good ambushers.


                                   cm:force_character_force_into_stance("character_cqi:" .. general_cqi,
                                        "MILITARY_FORCE_ACTIVE_STANCE_TYPE_STALKING")

                                   --and attack

                                   local uim = cm:get_campaign_ui_manager();
                                   uim:override("retreat"):lock();


                                   local ambusher_str = cm:char_lookup_str(general_cqi)
                                   cm:force_add_trait(ambusher_str, "nobody_trait")
                                   local ambushed_str = cm:char_lookup_str(inv_char_int)
                                   cm:attack(ambusher_str, ambushed_str, true)

                                   --track for cleanup.

                                   local invader_force_cqi = inv_char_int:military_force():command_queue_index()
                                   out("MYMOD: Tracking army with force cqi: " ..
                                   force_cqi ..
                                   "lead by char " ..
                                   general_cqi .. " vs " .. invader_force_cqi .. " char lead is " .. this_char_cqi)
                                   cqi_tracker[force_cqi] = invader_force_cqi
                              end
                         );
                         break
                    else
                         out("MYMOD: Ambush roll failed, candiate " ..
                         this_char_cqi .. " survives this round, removing from candidate tracker")
                         invading_army_tracker[this_char_cqi] = nil
                    end
               end
          end
     end,
     true
)

------------------------
-- CLEANUP - Kills spawned armies
------------------------

--basic cleanup after battle.
core:add_listener(
     "tp_clean_up_army_been_fought",
     "BattleCompleted",
     function(context)
          for ambusher, defender in pairs(cqi_tracker) do
               --out("MYMOD: tracker:"..ambusher.." ambushing "..defender)
               if cm:pending_battle_cache_mf_is_attacker(ambusher) or cm:pending_battle_cache_mf_is_defender(ambusher) or cm:pending_battle_cache_mf_is_attacker(defender) or cm:pending_battle_cache_mf_is_defender(defender) then
                    out("MYMOD: attacker or defender in battle is in our tracker.")
                    --we shouldn't assume the ambushing army is the attacker. It might have been ambushed itself whislt attempting its attack move, or somehow survived an inteded deletion and is being attacked.
                    return true
               end
          end
     end,
     function(context)
          local army_to_cull = 0 --this doesn't needto be embedded in teh below loop, there should NEVER be more than 1 spawned army in a battle.

          for ambusher, defender in pairs(cqi_tracker) do
               out("MYMOD: tracker:" .. ambusher .. " ambushing " .. defender)
               if cm:pending_battle_cache_mf_is_attacker(ambusher) then
                    out("MYMOD: our ambusher is the attacker.")
                    local uim = cm:get_campaign_ui_manager();
                    uim:override("retreat"):unlock();
                    army_to_cull = ambusher
                    break
               elseif cm:pending_battle_cache_mf_is_defender(ambusher) then
                    out("MYMOD: our ambusher is the defender.")
                    local uim = cm:get_campaign_ui_manager();
                    uim:override("retreat"):unlock();
                    army_to_cull = ambusher
                    break
               elseif cm:pending_battle_cache_mf_is_defender(defender) or cm:pending_battle_cache_mf_is_defender(defender) then
                    out("MYMOD: Hmmm, the defending army from our ambush is in a battle without our ambusher...")
               end
          end
          out("MYMOD: attempting to get force interface from cqi: " .. army_to_cull)
          local force_int = cm:get_military_force_by_cqi(army_to_cull)
          out("MYMOD: we got our force int, could be nil" .. tostring(force_int))

          if force_int == false then
               out("MYMOD: spawned army was destroyed, removing " .. army_to_cull .. " from tracker")
               cqi_tracker[army_to_cull] = nil
          else
               out("MYMOD: we can make safe assumption that army " ..
               army_to_cull .. "is alive after battle and needs killing.")
               local char_cqi = force_int:general_character():cqi()
               out("MYMOD: if " ..
               char_cqi .. "is nil or false, then I need to do another check if the force is not properly killed.")
               cm:kill_character_and_commanded_unit("character_cqi:" .. char_cqi, true)
               cqi_tracker[army_to_cull] = nil
               out("MYMOD: deletion should be complete.")
          end

          out("MYMOD: battleCompleted eventy response ended.")
     end,
     true
)

core:add_listener(
     "tp_region_clean_up",
     "RegionTurnEnd",
     function(context)
          local region_name = context:region():name()
          for cqi, region in pairs(invading_army_tracker) do
               if region == region_name then
                    out("MYMOD: current region " .. region_name .. " is logged in invasion tracker, invasion potential.")
                    return true
               end
          end
          --out("MYMOD: current region "..region_name.." is not logged in invasion tracker, ignore.")
          return false
     end,
     function(context)
          local region_name = context:region():name()
          for army, region in pairs(invading_army_tracker) do
               if region == region_name then
                    out(
                    "MYMOD: Turn end. Cleaning upo ambush candidate tracker in case some funny business means an army is still there.")
                    invading_army_tracker[army] = nil
               end
          end
     end,
     true
)

--------------------------------------------------------
--utility functions
--------------------------------------------------------

function cache_clearout()
     out("MYMOD: Looknig to clear the cache of any rascal data that somehow is clinging on!")

     for ambusher, defender in pairs(cqi_tracker) do
          out("MYMOD: ambusher > defender: " .. ambusher .. " > " .. defender)
          local ambusher_int = cm:get_military_force_by_cqi(ambusher)
          local defender_int = cm:get_military_force_by_cqi(defender)
          if ambusher_int == false then
               out("MYMOD: Ambusher is dead, we should stop tracking.")
               cqi_tracker[ambusher] = nil
          elseif defender_int == false then
               out("MYMOD: INVESTIGATE! our attacker" ..
               ambusher .. "somehow is alive, even though their target is no longer alive. Someone got a free army!")
               cqi_tracker[ambusher] = nil
          end
     end
end

---@param building_level string # The building level of the outpost that can define regional garrison.
---@return string # string of comma separated unit keys
function get_army_units(building_level)
     for tower_key, unit_list in pairs(tower_garrison_table) do
          if tower_key == building_level then
               return unit_list
          end
     end
     out("MYMOD: ERROR get_army_units supplied string that is not being tracked.")
     return ""
end

---@param region unknown # region interface.
---@return string | boolean # outpost name if true, otherwise false
function locate_tower_outpost(region)
     --out("MYMOD: lets find a tower for "..region:name())
     local region_slots = region:slot_list()
     for i = 0, region_slots:num_items() - 1 do
          local this_slot = region_slots:item_at(i);
          if not this_slot:is_null_interface() then
               if this_slot:has_building() then
                    --out("MYMOD: regions slot iteration: "..this_slot:building():name())
                    if string.find(this_slot:building():name(), "outpost") then
                         --region has an lookout post.
                         post_detected = true
                         local outpost_name = this_slot:building():name()
                         out("MYMOD: outpost detected with name " .. outpost_name)
                         return outpost_name
                    end
               end
          end
     end
     --out("MYMOD: No outpost detected returning false")
     return false
end

---@param force_cqi number # force cqi
---@return number | nil # char cqi
function get_char_cqi_from_force_cqi(force_cqi)
     out("MYMOD: getting char cqi from force cqi with " .. force_cqi)
     local force_int = cm:get_military_force_by_cqi(force_cqi)
     if force_int:has_general() then
          local character_cqi = force_int:general_character():command_queue_index()
          out("MYMOD: returning cqi")
          return character_cqi
     else
          out("MYMOD: ERROR army has no general")
          return nil
     end
end

---@param threshold number # supply the percentage chance you want to set. e.g.100 is a 100% firing chance.
---@return boolean
function random_number_chance(threshold)
     local r = math.random(1, 100)
     if r <= threshold then
          return true
     else
          return false
     end
end

--saving trackers
cm:add_saving_game_callback(function(context)
     cm:save_named_value("invading_army_tracker", invading_army_tracker, context)
     cm:save_named_value("cqi_tracker", cqi_tracker, context)
end)
cm:add_loading_game_callback(function(context)
     invading_army_tracker = cm:load_named_value("invading_army_tracker", invading_army_tracker, context)
     cqi_tracker = cm:load_named_value("cqi_tracker", cqi_tracker, context)
end)
