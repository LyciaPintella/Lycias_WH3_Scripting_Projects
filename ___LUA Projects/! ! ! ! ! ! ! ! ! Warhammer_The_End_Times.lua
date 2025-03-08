-- Total War: Warhammer III
-- Warhammer: The End Times
-- proaliahmadr

CI_EVERCHOSEN = {
     faction_key = "wh_main_chs_chaos"
}

function table.contains(tbl, item)
     for _, v in ipairs(tbl) do
          if v == item then
               return true
          end
     end
     return false
end

local function campaign_fix()
     core:add_listener(
          "campaign_fix_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():is_human()
          end,
          function(context)
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if not faction:is_null_interface() then
                         cm:apply_effect_bundle("mod_campaign_fix", faction:name(), -1)
                         cm:force_diplomacy("faction:" .. faction:name(), "faction:" .. CI_EVERCHOSEN.faction_key,
                              "form confederation", false, true)
                         cm:force_diplomacy("faction:" .. faction:name(), "faction:" .. CI_EVERCHOSEN.faction_key,
                              "vassal", false, true)
                    end
               end
          end,
          true
     )
end

local function domination()
     core:add_listener(
          "domination_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():name() == "wh_main_chs_chaos"
          end,
          function(context)
               if cm:get_saved_value("coronation_executed") then return end
               local faction_list = cm:model():world():faction_list()
               local north_cultures = {
                    "wh_main_chs_chaos",
                    "wh_dlc08_nor_norsca"
               }
               local factions_met = cm:get_faction(CI_EVERCHOSEN.faction_key):factions_met()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if table.contains(north_cultures, faction:culture()) and
                        not faction:is_human() and
                        not faction:is_null_interface() and
                        not faction:is_dead() and
                        not faction:is_rebel() and
                        not faction:is_quest_battle_faction() and
                        not faction:is_vassal() and
                        not faction:at_war_with(cm:get_faction(CI_EVERCHOSEN.faction_key)) then
                         for j = 0, factions_met:num_items() - 1 do
                              local target = factions_met:item_at(j)
                              if target:name() == faction:name() then
                                   cm:force_declare_war(CI_EVERCHOSEN.faction_key, faction:name(), true, true)
                                   cm:force_diplomacy("faction:" .. CI_EVERCHOSEN.faction_key,
                                        "faction:" .. faction:name(), "peace", false, false, true)
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function coronation()
     core:add_listener(
          "coronation_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():name() == "wh_main_chs_chaos"
          end,
          function(context)
               if cm:get_saved_value("coronation_executed") then return end
               local faction = context:faction()
               local everchosen = faction:faction_leader()
               local required_ancillaries = {
                    "wh_main_anc_armour_the_armour_of_morkar",
                    "wh_main_anc_talisman_the_eye_of_sheerian",
                    "wh_main_anc_weapon_the_slayer_of_kings",
                    "wh_main_anc_enchanted_item_the_crown_of_domination",
                    "wh_main_anc_mount_chs_archaon_dorghar"
               }
               for _, ancillary in ipairs(required_ancillaries) do
                    if not everchosen:has_ancillary(ancillary) then return end
               end
               if cm:get_faction(CI_EVERCHOSEN.faction_key):is_human() then
                    cm:register_instant_movie("Warhammer/chs_rises")
               end
               cm:apply_effect_bundle("mod_end_times", CI_EVERCHOSEN.faction_key, -1)
               cm:instantly_research_all_technologies(CI_EVERCHOSEN.faction_key)
               cm:faction_add_pooled_resource(CI_EVERCHOSEN.faction_key, "wh3_dlc20_chs_souls_spent_und",
                    "gifts_of_chaos", 25000)
               cm:faction_add_pooled_resource(CI_EVERCHOSEN.faction_key, "wh3_dlc20_chs_souls_spent_kho",
                    "gifts_of_chaos", 25000)
               cm:faction_add_pooled_resource(CI_EVERCHOSEN.faction_key, "wh3_dlc20_chs_souls_spent_nur",
                    "gifts_of_chaos", 25000)
               cm:faction_add_pooled_resource(CI_EVERCHOSEN.faction_key, "wh3_dlc20_chs_souls_spent_sla",
                    "gifts_of_chaos", 25000)
               cm:faction_add_pooled_resource(CI_EVERCHOSEN.faction_key, "wh3_dlc20_chs_souls_spent_tze",
                    "gifts_of_chaos", 25000)
               local faction_list = cm:model():world():faction_list()
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if faction:culture() == "wh_main_chs_chaos" and
                        faction:name() ~= CI_EVERCHOSEN.faction_key and
                        not faction:is_human() and
                        not faction:is_null_interface() and
                        not faction:is_dead() and
                        not faction:is_rebel() and
                        not faction:is_quest_battle_faction() and
                        not faction:is_vassal() then
                         cm:force_confederation(CI_EVERCHOSEN.faction_key, faction:name())
                    end
                    if faction:is_human() then
                         cm:show_message_event(
                              faction:name(),
                              "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_primary_detail",
                              "",
                              "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_end_secondary_detail",
                              true,
                              29
                         )
                    end
               end
               cm:set_saved_value("coronation_executed", true)
          end,
          true
     )
end

local function invasion()
     core:add_listener(
          "invasion_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():name() == "wh_main_chs_chaos"
          end,
          function(context)
               if not cm:get_saved_value("coronation_executed") then return end
               local everchosen_faction = cm:get_faction(CI_EVERCHOSEN.faction_key)
               local faction_list = cm:model():world():faction_list()
               local factions_met = everchosen_faction:factions_met()
               local everchosen_cultures = {
                    "wh_main_chs_chaos",
                    "wh_dlc08_nor_norsca",
                    "wh_dlc03_bst_beastmen",
                    "wh3_main_dae_daemons",
                    "wh3_main_kho_khorne",
                    "wh3_main_nur_nurgle",
                    "wh3_main_sla_slaanesh",
                    "wh3_main_tze_tzeentch"
               }
               local chaos_cultures = {
                    "wh_main_chs_chaos",
                    "wh_dlc08_nor_norsca",
                    "wh_dlc03_bst_beastmen",
                    "wh3_main_dae_daemons",
                    "wh3_main_kho_khorne",
                    "wh3_main_nur_nurgle",
                    "wh3_main_sla_slaanesh",
                    "wh3_main_tze_tzeentch",
                    "wh2_main_skv_skaven",
                    "wh3_dlc23_chd_chaos_dwarfs"
               }
               local chaos_factions = {
                    "wh2_main_def_cult_of_pleasure",
                    "wh2_dlc11_vmp_the_barrow_legion"
               }
               for i = 0, faction_list:num_items() - 1 do
                    local faction = faction_list:item_at(i)
                    if not faction:is_null_interface() and
                        not faction:is_dead() and
                        not faction:is_rebel() and
                        not faction:is_quest_battle_faction() and
                        not faction:is_vassal() then
                         if table.contains(everchosen_cultures, faction:culture()) then
                              cm:make_diplomacy_available(CI_EVERCHOSEN.faction_key, faction:name())
                         end
                         if faction:culture() == "wh_dlc08_nor_norsca" and
                             not faction:is_human() then
                              cm:force_make_vassal(CI_EVERCHOSEN.faction_key, faction:name())
                         end
                         if not table.contains(chaos_cultures, faction:culture()) and
                             not table.contains(chaos_factions, faction:name()) and
                             not faction:at_war_with(everchosen_faction) then
                              for j = 0, factions_met:num_items() - 1 do
                                   local target = factions_met:item_at(j)
                                   if target:name() == faction:name() then
                                        cm:force_declare_war(CI_EVERCHOSEN.faction_key, faction:name(), true, true)
                                        cm:force_diplomacy("faction:" .. CI_EVERCHOSEN.faction_key,
                                             "faction:" .. faction:name(), "peace", false, false, true)
                                        break
                                   end
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function defeated()
     core:add_listener(
          "defeated_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():is_human()
          end,
          function(context)
               if not cm:get_saved_value("coronation_executed") then return end
               if cm:get_saved_value("defeated_executed") then return end
               local faction = context:faction()
               if cm:get_faction(CI_EVERCHOSEN.faction_key):is_dead() then
                    if faction:is_human() then
                         cm:show_message_event(
                              faction:name(),
                              "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_defeated_primary_detail",
                              "",
                              "event_feed_strings_text_wh_event_feed_string_scripted_event_chaos_invasion_defeated_secondary_detail",
                              true,
                              29
                         )
                    end
               end
               cm:set_saved_value("defeated_executed", true)
          end,
          true
     )
end

local function dark_fortress()
     core:add_listener(
          "dark_fortress_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_dlc08_nor_norsca" and
                   context:faction():is_vassal() and
                   not context:faction():is_human()
          end,
          function(context)
               local master = context:faction():master()
               if master:culture() == "wh_main_chs_chaos" then
                    local faction_region_list = context:faction():region_list()
                    local faction_region_count = faction_region_list:num_items()
                    for i = 1, faction_region_count do
                         local region = faction_region_list:item_at(i - 1)
                         if region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group") then
                              cm:transfer_region_to_faction(region:name(), master:name())
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_marauders()
     core:add_listener(
          "warband_upgrade_marauders_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              local rank = unit:experience_level()
                              if unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mkho" then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_marauders_mkho_dualweapons")
                                   cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character), rank)
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mnur" then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_marauders_mnur_greatweapons")
                                   cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character), rank)
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_msla" then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_marauders_msla_hellscourges")
                                   cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character), rank)
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mtze" then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_marauders_mtze_spears")
                                   cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character), rank)
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_mark()
     core:add_listener(
          "warband_upgrade_mark_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              local rank = unit:experience_level()
                              if unit:unit_key() == "wh_dlc01_chs_inf_forsaken_0" then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_forsaken_mkho")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_nur_inf_forsaken_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_forsaken_msla")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_tze_inf_forsaken_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if unit:unit_key() == "wh_main_chs_mon_chaos_spawn" then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_kho_mon_spawn_of_khorne_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_nur_mon_spawn_of_nurgle_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_sla_mon_spawn_of_slaanesh_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_tze_mon_spawn_of_tzeentch_0")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if (unit:unit_key() == "wh_main_chs_inf_chaos_marauders_0" or unit:unit_key() == "wh_main_chs_inf_chaos_marauders_1") then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_marauders_mkho_dualweapons")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_marauders_mnur_greatweapons")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_marauders_msla_hellscourges")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_marauders_mtze_spears")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if (unit:unit_key() == "wh_main_chs_inf_chaos_warriors_0" or unit:unit_key() == "wh_main_chs_inf_chaos_warriors_1" or unit:unit_key() == "wh_dlc01_chs_inf_chaos_warriors_2") then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_kho_inf_chaos_warriors_2")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_warriors_mnur_greatweapons")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_warriors_msla_hellscourges")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chaos_warriors_mtze_halberds")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if (unit:unit_key() == "wh_main_chs_inf_chosen_0" or unit:unit_key() == "wh_main_chs_inf_chosen_1" or unit:unit_key() == "wh_dlc01_chs_inf_chosen_2") then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chosen_mkho_dualweapons")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chosen_mnur_greatweapons")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chosen_msla_hellscourges")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_inf_chosen_mtze_halberds")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if (unit:unit_key() == "wh_main_chs_cav_marauder_horsemen_0" or unit:unit_key() == "wh_main_chs_cav_marauder_horsemen_1") then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_marauder_horsemen_mkho_throwing_axes")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_marauder_horsemen_mnur_throwing_axes")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_marauder_horsemen_msla_javelins")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_marauder_horsemen_mtze_javelins")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if (unit:unit_key() == "wh_main_chs_cav_chaos_knights_0" or unit:unit_key() == "wh_main_chs_cav_chaos_knights_1") then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_knights_mkho_lances")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_knights_mnur_lances")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_knights_msla_lances")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_knights_mtze_lances")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if unit:unit_key() == "wh_main_chs_cav_chaos_chariot" then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_chariot_mkho")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_nur_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_chariot_mnur")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_sla_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_chariot_msla")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   elseif character:has_skill("wh3_dlc20_skill_authority_tze_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc20_chs_cav_chaos_chariot_mtze")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                              if unit:unit_key() == "wh_dlc01_chs_cav_gorebeast_chariot" then
                                   if character:has_skill("wh3_dlc20_skill_authority_kho_lord") then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_main_kho_cav_gorebeast_chariot")
                                        cm:add_experience_to_units_commanded_by_character(cm:char_lookup_str(character),
                                             rank)
                                   end
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_undivided()
     core:add_listener(
          "warband_upgrade_undivided_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              if unit:unit_key() == "wh_dlc01_chs_inf_forsaken_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh_main_chs_mon_chaos_spawn")
                              end
                              if (unit:unit_key() == "wh_main_chs_inf_chaos_marauders_0" or unit:unit_key() == "wh_main_chs_inf_chaos_marauders_1") and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh_main_chs_inf_chaos_warriors_0")
                              end
                              if (unit:unit_key() == "wh_main_chs_inf_chaos_warriors_0" or unit:unit_key() == "wh_main_chs_inf_chaos_warriors_1" or unit:unit_key() == "wh_dlc01_chs_inf_chaos_warriors_2") and unit:experience_level() >= 7 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character), "wh_main_chs_inf_chosen_0")
                              end
                              if (unit:unit_key() == "wh_main_chs_cav_marauder_horsemen_0" or unit:unit_key() == "wh_main_chs_cav_marauder_horsemen_1") and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh_dlc06_chs_cav_marauder_horsemasters_0")
                              end
                              if unit:unit_key() == "wh_dlc06_chs_cav_marauder_horsemasters_0" and unit:experience_level() >= 6 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh_main_chs_cav_chaos_knights_1")
                              end
                              if unit:unit_key() == "wh_main_chs_cav_chaos_chariot" and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh_dlc01_chs_cav_gorebeast_chariot")
                              end
                         end
                    end
               end
          end,
          true
     )
end

function warband_upgrade_khorne()
     core:add_listener(
          "warband_upgrade_khorne_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              if unit:unit_key() == "wh3_main_kho_inf_bloodletters_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_kho_inf_bloodletters_1")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_inf_forsaken_mkho" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_kho_mon_spawn_of_khorne_0")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mkho" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mkho_dualweapons") and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_kho_inf_chaos_warriors_2")
                              end
                              if (unit:unit_key() == "wh3_main_kho_inf_chaos_warriors_0" or unit:unit_key() == "wh3_main_kho_inf_chaos_warriors_1" or unit:unit_key() == "wh3_main_kho_inf_chaos_warriors_2") and unit:experience_level() >= 7 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chosen_mkho_dualweapons")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_cav_marauder_horsemen_mkho_throwing_axes" and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_cav_chaos_knights_mkho_lances")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_cav_chaos_knights_mkho" or unit:unit_key() == "wh3_dlc20_chs_cav_chaos_knights_mkho_lances") and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_kho_cav_skullcrushers_0")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_cav_chaos_chariot_mkho" and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_kho_cav_gorebeast_chariot")
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_nurgle()
     core:add_listener(
          "warband_upgrade_nurgle_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              if unit:unit_key() == "wh3_main_nur_inf_plaguebearers_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_nur_inf_plaguebearers_1")
                              end
                              if unit:unit_key() == "wh3_main_nur_inf_forsaken_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_nur_mon_spawn_of_nurgle_0")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mnur" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mnur_greatweapons") and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_warriors_mnur_greatweapons")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_mnur" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_mnur_greatweapons") and unit:experience_level() >= 7 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chosen_mnur_greatweapons")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_cav_marauder_horsemen_mnur_throwing_axes" and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_cav_chaos_knights_mnur_lances")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_cav_chaos_knights_mnur" or unit:unit_key() == "wh3_dlc20_chs_cav_chaos_knights_mnur_lances") and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc25_nur_cav_rot_knights")
                              end
                              if unit:unit_key() == "wh_main_chs_mon_trolls" then
                                   if character:has_skill("wh3_dlc20_skill_authority_nur_lord") and unit:experience_level() >= 6 then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh3_dlc25_nur_mon_bile_trolls")
                                   elseif not character:has_skill("wh3_dlc20_skill_authority_nur_lord") and unit:experience_level() >= 3 then
                                        cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                        cm:grant_unit_to_character(cm:char_lookup_str(character),
                                             "wh_dlc01_chs_mon_trolls_1")
                                   end
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_slaanesh()
     core:add_listener(
          "warband_upgrade_slaanesh_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              if unit:unit_key() == "wh3_main_sla_inf_daemonette_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_sla_inf_daemonette_1")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_inf_forsaken_msla" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_sla_mon_spawn_of_slaanesh_0")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_msla" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_msla_hellscourges") and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_warriors_msla_hellscourges")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_msla" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_msla_hellscourges") and unit:experience_level() >= 7 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chosen_msla_hellscourges")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_cav_marauder_horsemen_msla_javelins" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_sla_cav_hellstriders_1")
                              end
                              if (unit:unit_key() == "wh3_main_sla_cav_hellstriders_0" or unit:unit_key() == "wh3_main_sla_cav_hellstriders_1") and unit:experience_level() >= 6 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_cav_chaos_knights_msla_lances")
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function warband_upgrade_tzeentch()
     core:add_listener(
          "warband_upgrade_tzeentch_listener",
          "FactionTurnStart",
          function(context)
               return context:faction():culture() == "wh_main_chs_chaos" and
                   not context:faction():is_human()
          end,
          function(context)
               local faction = context:faction()
               local character_list = faction:character_list()
               for i = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(i)
                    if not character:is_null_interface() and character:has_military_force() then
                         local force = character:military_force()
                         local unit_list = force:unit_list()
                         for j = 0, unit_list:num_items() - 1 do
                              local unit = unit_list:item_at(j)
                              if unit:unit_key() == "wh3_main_tze_inf_pink_horrors_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_tze_inf_pink_horrors_1")
                              end
                              if unit:unit_key() == "wh3_main_tze_inf_forsaken_0" and unit:experience_level() >= 4 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_tze_mon_spawn_of_tzeentch_0")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mtze" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_marauders_mtze_spears") and unit:experience_level() >= 5 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chaos_warriors_mtze_halberds")
                              end
                              if (unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_mtze" or unit:unit_key() == "wh3_dlc20_chs_inf_chaos_warriors_mtze_halberds") and unit:experience_level() >= 7 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_inf_chosen_mtze_halberds")
                              end
                              if unit:unit_key() == "wh3_dlc20_chs_cav_marauder_horsemen_mtze_javelins" and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_dlc20_chs_cav_chaos_knights_mtze_lances")
                              end
                              if (unit:unit_key() == "wh3_main_tze_cav_chaos_knights_0" or unit:unit_key() == "wh3_dlc20_chs_cav_chaos_knights_mtze_lances") and unit:experience_level() >= 8 then
                                   cm:remove_unit_from_character(cm:char_lookup_str(character), unit:unit_key())
                                   cm:grant_unit_to_character(cm:char_lookup_str(character),
                                        "wh3_main_tze_cav_doom_knights_0")
                              end
                         end
                    end
               end
          end,
          true
     )
end

local settings = {
     opinion_threshold = -1,
     opinion_floor = -100,
     base_chance = 1,
     max_chance = 100,
     use_scaling = 1,
     max_war = 1,
     max_war_archaon = 999,
     peace_cooldown = 10
}

local vars = {
     ln = math.log(settings.max_chance - settings.base_chance + 1),
     divisor = settings.opinion_threshold - settings.opinion_floor
}

local function calc_scaled_chance(opinion)
     local range = settings.max_chance - settings.base_chance
     local normalized_opinion = (opinion - settings.opinion_floor) /
     (settings.opinion_threshold - settings.opinion_floor)
     return settings.base_chance + range * (1 - normalized_opinion)
end

local function persist_table(table_name, table_data, on_load_callback)
     cm:add_saving_game_callback(function(context)
          cm:save_named_value("wh3" .. table_name, table_data, context)
     end)
     cm:add_loading_game_callback(function(context)
          on_load_callback(cm:load_named_value("wh3" .. table_name, table_data, context))
     end)
end

local peacetreaty = {}

local function manage_peace_treaties(faction_key, enemy_faction_key, turn)
     peacetreaty[faction_key] = peacetreaty[faction_key] or {}
     if turn then
          peacetreaty[faction_key][enemy_faction_key] = { turn = turn }
          if peacetreaty[enemy_faction_key] then
               peacetreaty[enemy_faction_key][faction_key] = nil
          end
     else
          peacetreaty[faction_key][enemy_faction_key] = nil
          if not next(peacetreaty[faction_key]) then
               peacetreaty[faction_key] = nil
          end
     end
end

local function get_peace_turn(faction_key, enemy_faction_key)
     return (peacetreaty[faction_key] and peacetreaty[faction_key][enemy_faction_key] and peacetreaty[faction_key][enemy_faction_key].turn)
         or
         (peacetreaty[enemy_faction_key] and peacetreaty[enemy_faction_key][faction_key] and peacetreaty[enemy_faction_key][faction_key].turn)
end

local function is_peace_expired(faction_key, enemy_faction_key)
     local turn = get_peace_turn(faction_key, enemy_faction_key)
     if not turn then return true end
     if turn == -1 then return false end
     if turn + settings.peace_cooldown < cm:turn_number() then
          manage_peace_treaties(faction_key, enemy_faction_key, nil)
          return true
     end
     return false
end

local function dynamic_ai_war()
     persist_table("peacetreaty", peacetreaty, function(t) peacetreaty = t end)
     core:add_listener(
          "peace_listener",
          "PositiveDiplomaticEvent",
          function(context)
               return context:is_peace_treaty()
          end,
          function(context)
               manage_peace_treaties(context:proposer():name(), context:recipient():name(), cm:turn_number())
          end,
          true
     )
     core:add_listener(
          "war_listener",
          "FactionTurnStart",
          function(context)
               return not context:faction():is_human()
          end,
          function(context)
               local attacker = context:faction()
               if attacker:is_human() or
                   attacker:is_null_interface() or
                   attacker:is_dead() or
                   attacker:is_rebel() or
                   attacker:is_quest_battle_faction() or
                   attacker:is_vassal() or
                   attacker:factions_at_war_with():num_items() >= settings.max_war then
                    return
               end
               for i = 0, attacker:factions_met():num_items() - 1 do
                    local target = attacker:factions_met():item_at(i)
                    if not target:is_human() and
                        not target:is_null_interface() and
                        not target:is_dead() and
                        not target:is_rebel() and
                        not target:is_quest_battle_faction() and
                        not target:is_vassal() and
                        not attacker:at_war_with(target) and
                        not attacker:is_ally_vassal_or_client_state_of(target) and
                        not target:is_ally_vassal_or_client_state_of(attacker) and
                        not target:non_aggression_pact_with(attacker) then
                         local attitude = attacker:diplomatic_attitude_towards(target:name())
                         if attitude <= settings.opinion_threshold and is_peace_expired(attacker:name(), target:name()) then
                              local war_chance = (attitude <= settings.opinion_floor) and settings.max_chance
                                  or (settings.use_scaling ~= 0 and calc_scaled_chance(attitude) or settings.base_chance)
                              if cm:random_number(100, 1) < war_chance then
                                   cm:force_declare_war(attacker:name(), target:name(), true, true)
                                   break
                              end
                         end
                    end
               end
          end,
          true
     )
end

local function dynamic_ai_war_archaon()
     persist_table("peacetreaty", peacetreaty, function(t) peacetreaty = t end)
     core:add_listener(
          "peace_listener_archaon",
          "PositiveDiplomaticEvent",
          function(context)
               return context:is_peace_treaty()
          end,
          function(context)
               manage_peace_treaties(context:proposer():name(), context:recipient():name(), cm:turn_number())
          end,
          true
     )
     core:add_listener(
          "war_listener_archaon",
          "FactionTurnStart",
          function(context)
               return not context:faction():is_human()
          end,
          function(context)
               local attacker = context:faction()
               if attacker:is_human() or
                   attacker:is_null_interface() or
                   attacker:is_dead() or
                   attacker:is_rebel() or
                   attacker:is_quest_battle_faction() or
                   attacker:is_vassal() or
                   attacker:factions_at_war_with():num_items() >= settings.max_war_archaon then
                    return
               end
               for i = 0, attacker:factions_met():num_items() - 1 do
                    local target = attacker:factions_met():item_at(i)
                    if target:name() == "wh_main_chs_chaos" and
                        not target:is_human() and
                        not target:is_null_interface() and
                        not target:is_dead() and
                        not target:is_rebel() and
                        not target:is_quest_battle_faction() and
                        not target:is_vassal() and
                        not attacker:at_war_with(target) and
                        not attacker:is_ally_vassal_or_client_state_of(target) and
                        not target:is_ally_vassal_or_client_state_of(attacker) and
                        not target:non_aggression_pact_with(attacker) then
                         local attitude = attacker:diplomatic_attitude_towards(target:name())
                         if attitude <= settings.opinion_threshold and is_peace_expired(attacker:name(), target:name()) then
                              local war_chance = (attitude <= settings.opinion_floor) and settings.max_chance
                                  or (settings.use_scaling ~= 0 and calc_scaled_chance(attitude) or settings.base_chance)
                              if cm:random_number(100, 1) < war_chance then
                                   cm:force_declare_war(attacker:name(), target:name(), true, true)
                                   break
                              end
                         end
                    end
               end
          end,
          true
     )
end

cm:add_first_tick_callback(function()
     campaign_fix()
     domination()
     coronation()
     invasion()
     defeated()
     dark_fortress()
     warband_upgrade_marauders()
     warband_upgrade_mark()
     warband_upgrade_undivided()
     warband_upgrade_khorne()
     warband_upgrade_nurgle()
     warband_upgrade_slaanesh()
     warband_upgrade_tzeentch()
     dynamic_ai_war()
     dynamic_ai_war_archaon()
end)