local debug_mode = false;

local dilemma_workspace = {};
local fv_dilemma_pending = {};
local player_capture_dilemma_queue = {};

--until the stupid "dilemma twice in a row doesn't reset faction details" problem gets fixed, we're stuck with crap workaround.
local last_dilemma = {};
local is_cursed_dilemma = {
     fudging_vassals_climate_dilemma = true,
};
local ugly_flag_dilemmas = {
     fudging_vassals_climate_dilemma = true,
};


--sick of the stupid name shuffling because there's no forward referencing
--so let's put all vassal-finding functions into a single table.
local vassal_manager = {
     do_not_confederate = {
          --in theory these 2 should only ever go in one direction:
          { "wh2_dlc13_lzd_spirits_of_the_jungle", "wh2_dlc13_lzd_defenders_of_the_great_plan" },
          { "wh2_main_def_har_ganeth",             "wh2_dlc10_def_blood_voyage" },
          --duplicate because we don't know what direction they're going in
          { "wh3_main_ksl_the_ice_court",          "wh3_main_ksl_the_great_orthodoxy" },
          { "wh3_main_ksl_the_great_orthodoxy",    "wh3_main_ksl_the_ice_court" },
     }
};

local function fv_reset_pending_dilemma(faction_key)
     dilemma_workspace[faction_key] = false;
     fv_dilemma_pending[faction_key] = false;
end

local function fv_is_dilemma_pending(faction_key)
     return not not fv_dilemma_pending[faction_key];
end

local function fv_get_dilemma_payload(faction_key)
     return dilemma_workspace[faction_key];
end

--how do I OOP
--[[
local player_capture_dilemma_type = {
	type = "",	--"vassal capture", "climate mismatch", "home province", "subjugation", "liberate"
	region_key = "",
	faction_key = "",
	vassal_key = ""
}
--]]

local fv_check_dilemma_queue; --forward declaration, will be fixed later.
local function fv_enqueue_dilemma(pcdt)
     local player_faction = cm:get_faction(pcdt.faction_key);
     if not player_faction or player_faction:is_null_interface() then
          out("FUDGINGVASSALS ERROR something went very wrong: " .. table.tostring(pcdt));
          return;
     end

     out("FUDGINGVASSALS dilemma enqueued (right now? " .. tostring(right_now) .. "): " .. table.tostring(pcdt));
     if not is_table(player_capture_dilemma_queue[pcdt.faction_key]) then
          player_capture_dilemma_queue[pcdt.faction_key] = {};
     end
     table.insert(player_capture_dilemma_queue[pcdt.faction_key], pcdt);

     if player_faction:is_factions_turn() then
          fv_check_dilemma_queue(pcdt.faction_key);
     end
end

local function fv_delete_vassal_capture(player_key, region_key)
     if not player_capture_dilemma_queue[player_key] then
          return false;
     end

     local found = 0;
     local new_pcdq = {};
     for i, d in pairs(player_capture_dilemma_queue[player_key]) do
          if d.region_key == region_key then
               if d.type == "vassal capture" then
                    out("FUDGINGVASSALS fv_delete_vassal_capture intercepted vassal capture dilemma queued for " ..
                    player_key .. " @ spot " .. tostring(i));
                    found = found + 1;
               elseif d.type == "home province" then
                    out("FUDGINGVASSALS fv_delete_vassal_capture intercepted home province dilemma queued for " ..
                    player_key .. " @ spot " .. tostring(i));
                    found = found + 1;
               else
                    table.insert(new_pcdq, d);
               end
          else
               table.insert(new_pcdq, d);
          end
     end
     if debug_mode and found > 0 then
          out("FUDGINGVASSALS DEBUG before interception player_capture_dilemma_queue[" ..
          player_key .. "] = " .. table.tostring(player_capture_dilemma_queue[player_key]));
     end
     player_capture_dilemma_queue[player_key] = new_pcdq;
     if debug_mode and found > 0 then
          out("FUDGINGVASSALS DEBUG after  interception player_capture_dilemma_queue[" ..
          player_key .. "] = " .. table.tostring(player_capture_dilemma_queue[player_key]));
     end
     return found > 0;
end


--FYI this is NOT legacy code, it serves the purpose of ensuring pcdq doesn't get out of whack.
--How does it get out of whack?  How does anything.
local function fv_fix_dilemma_queue_for_multiplayer()
     if not cm:get_saved_value("fv_queue_moved_to_mp") then
          local new_queue = {};
          local hf = cm:get_human_factions();
          for i = 1, #hf do
               new_queue[hf[i]] = {};
          end
          for j = 1, #player_capture_dilemma_queue do
               local pcdt = player_capture_dilemma_queue[j];
               if not is_table(new_queue[pcdt.faction_key]) then
                    out("FUDGINGVASSALS ERROR how does this happen? " .. pcdt.faction_key .. " isn't a human faction?");
                    new_queue[pcdt.faction_key] = {};
               end
               local pcd_copy = {
                    ["faction_key"] = pcdt.faction_key,
                    ["type"] = pcdt.type,
                    ["region_key"] = pcdt.region_key,
                    ["vassal_key"] = pcdt.vassal_key,
               };
               table.insert(new_queue[pcdt.faction_key], pcd_copy);
          end

          if debug_mode then
               out("FUDGINGVASSALS DEBUG before mp conversion: " .. table.tostring(player_capture_dilemma_queue));
          end
          player_capture_dilemma_queue = new_queue;
          if debug_mode then
               out("FUDGINGVASSALS DEBUG after mp conversion: " .. table.tostring(player_capture_dilemma_queue));
          end
          cm:set_saved_value("fv_queue_moved_to_mp", true);
     end
end

local vassal_diplomacy_adjusted = {};

local fv_attrition_protection_by_faction = {
     ["wh2_dlc09_skv_clan_rictus"] = "fv_protector_attrition_immunity_eb_wh2_dlc09_skv_clan_rictus",
     ["wh2_dlc11_cst_noctilus"] = "fv_protector_attrition_immunity_eb_wh2_dlc11_cst_noctilus",
     ["wh2_dlc11_def_the_blessed_dread_separatists"] =
     "fv_protector_attrition_immunity_eb_wh2_dlc11_def_the_blessed_dread_separatists",
     ["wh2_dlc11_vmp_the_barrow_legion"] = "fv_protector_attrition_immunity_eb_wh2_dlc11_vmp_the_barrow_legion",
     ["wh2_dlc12_lzd_cult_of_sotek"] = "fv_protector_attrition_immunity_eb_wh2_dlc12_lzd_cult_of_sotek",
     ["wh2_dlc17_lzd_oxyotl"] = "fv_protector_attrition_immunity_eb_wh2_dlc17_lzd_oxyotl",
     ["wh2_main_def_cult_of_pleasure"] = "fv_effect_attrition_immunity_chaos_territory_only_bundle",
     ["wh2_main_hef_yvresse"] = "underdogs_effect_attrition_immunity_mist_of_yvresse_bundle",
     ["wh2_main_lzd_tlaqua"] = "fv_protector_attrition_immunity_eb_wh2_main_lzd_tlaqua",
     ["wh2_main_skv_clan_eshin"] = "fv_protector_attrition_immunity_eb_wh2_main_skv_clan_eshin",
     ["wh2_main_skv_clan_moulder"] = "fv_protector_attrition_immunity_eb_wh2_main_skv_clan_moulder",
     --warriors of chaos >_<
     ["wh3_dlc20_chs_valkia"] = "fv_attrition_protection_eb_wh3_main_sc_kho_khorne",
     ["wh3_dlc20_chs_festus"] = "fv_attrition_protection_eb_wh3_main_sc_nur_nurgle",
     ["wh3_dlc20_chs_azazel"] = "fv_attrition_protection_eb_wh3_main_sc_sla_slaanesh",
     ["wh3_dlc20_chs_vilitch"] = "fv_attrition_protection_eb_wh3_main_sc_tze_tzeentch",
};


local fv_attritions_owner_must_be_protected_from_by_faction = {
     ["wh2_main_hef_yvresse"] = "underdogs_effect_attrition_immunity_mist_of_yvresse_bundle",
};

local fv_ritual_attritions = {
     "fv_ritual_attrition_immunity_eb_storm_standstorm",
     "fv_ritual_attrition_immunity_eb_mist",
     "fv_ritual_attrition_immunity_eb_kislev_winter",
     "fv_ritual_attrition_immunity_eb_lizard_defenders",
};

--if this table looks jank it's because there's alot of overlap between subcultures and attrition resistance.
--TODO TW3 get rid of the following effect bundles since we're not using them anymore:
--	fv_attrition_protection_eb_wh3_main_sc_ogr_ogre_kingdoms
--	fv_attrition_protection_eb_wh3_main_sc_dae_daemons
--	fv_attrition_protection_eb_wh_dlc03_sc_bst_beastmen
--	fv_attrition_protection_eb_wh_dlc08_sc_nor_norsca
--	fv_attrition_protection_eb_wh_main_sc_grn_savage_orcs
--	fv_attrition_protection_eb_wh2_main_sc_hef_high_elves
--	fv_attrition_protection_eb_wh2_main_sc_lzd_lizardmen
--	fv_attrition_protection_eb_wh3_main_sc_cth_cathay
--	fv_attrition_protection_eb_wh_main_sc_brt_bretonnia
--	fv_attrition_protection_eb_wh_main_sc_teb_teb
--	fv_attrition_protection_eb_wh3_main_sc_ksl_kislev
--TODO TW3 keep these IFF warriors of chaos end up needing special consideration
--	fv_attrition_protection_eb_wh3_main_sc_kho_khorne
--	fv_attrition_protection_eb_wh3_main_sc_nur_nurgle
--	fv_attrition_protection_eb_wh3_main_sc_sla_slaanesh
--	fv_attrition_protection_eb_wh3_main_sc_tze_tzeentch
local fv_attrition_protection_by_subculture = {
     ["wh2_dlc09_sc_tmb_tomb_kings"] = "fv_attrition_protection_eb_wh2_dlc09_sc_tmb_tomb_kings",
     ["wh2_dlc11_sc_cst_vampire_coast"] = "fv_attrition_protection_eb_wh2_dlc11_sc_cst_vampire_coast",
     ["wh2_main_sc_def_dark_elves"] = "fv_attrition_protection_eb_wh2_main_sc_def_dark_elves",
     ["wh2_main_sc_hef_high_elves"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh2_main_sc_lzd_lizardmen"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh2_main_sc_skv_skaven"] = "fv_attrition_protection_eb_wh2_main_sc_skv_skaven",
     ["wh3_main_sc_cth_cathay"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh3_main_sc_dae_daemons"] = "fv_attrition_protection_eb_wh_main_sc_chs_chaos",
     ["wh3_main_sc_kho_khorne"] = "fv_attrition_protection_eb_wh3_main_sc_kho_khorne",
     ["wh3_main_sc_ksl_kislev"] = "fv_attrition_protection_eb_wh2_main_sc_def_dark_elves",
     ["wh3_main_sc_nur_nurgle"] = "fv_attrition_protection_eb_wh3_main_sc_nur_nurgle",
     ["wh3_main_sc_ogr_ogre_kingdoms"] = "fv_attrition_protection_eb_wh_main_sc_dwf_dwarfs",
     ["wh3_main_sc_sla_slaanesh"] = "fv_attrition_protection_eb_wh3_main_sc_sla_slaanesh",
     ["wh3_main_sc_tze_tzeentch"] = "fv_attrition_protection_eb_wh3_main_sc_tze_tzeentch",
     ["wh_dlc03_sc_bst_beastmen"] = "fv_attrition_protection_eb_wh_main_sc_chs_chaos",
     ["wh_dlc05_sc_wef_wood_elves"] = "fv_attrition_protection_eb_wh_dlc05_sc_wef_wood_elves",
     ["wh_dlc08_sc_nor_norsca"] = "fv_attrition_protection_eb_wh_main_sc_chs_chaos",
     ["wh_main_sc_brt_bretonnia"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh_main_sc_chs_chaos"] = "fv_attrition_protection_eb_wh_main_sc_chs_chaos",
     ["wh_main_sc_dwf_dwarfs"] = "fv_attrition_protection_eb_wh_main_sc_dwf_dwarfs",
     ["wh_main_sc_emp_empire"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh_main_sc_grn_greenskins"] = "fv_attrition_protection_eb_wh_main_sc_grn_greenskins",
     ["wh_main_sc_grn_savage_orcs"] = "fv_attrition_protection_eb_wh2_dlc09_sc_tmb_tomb_kings",
     ["wh_main_sc_teb_teb"] = "fv_attrition_protection_eb_wh_main_sc_emp_empire",
     ["wh_main_sc_vmp_vampire_counts"] = "fv_attrition_protection_eb_wh_main_sc_vmp_vampire_counts",
     ["wh3_dlc23_sc_chd_chaos_dwarfs"] = "fv_attrition_protection_eb_wh_main_sc_chs_chaos",
};


--literally, F these guys.
--These 53 factions come from db/cai_diplomacy_excluded_factions_tables/data__
--Attempting to do diplomacy with these guys will hard crash the game.
--TODO TW3 can't we move this to a faction set to make the game engine do the work?
local diplomacy_excluded = {
     ["wh2_dlc10_def_blood_voyage"] = true,
     ["wh2_main_bst_blooded_axe_brayherd"] = true,
     ["wh2_main_bst_manblight_brayherd"] = true,
     ["wh2_main_bst_ripper_horn_brayherd"] = true,
     ["wh2_main_bst_shadowgor_brayherd"] = true,
     ["wh2_main_bst_skrinderkin_brayherd"] = true,
     ["wh2_main_bst_stone_horn_brayherd"] = true,
     ["wh2_main_chs_chaos_incursion_def"] = true,
     ["wh2_main_chs_chaos_incursion_hef"] = true,
     ["wh2_main_chs_chaos_incursion_lzd"] = true,
     ["wh2_main_grn_arachnos_waaagh"] = true,
     ["wh2_main_grn_blue_vipers_waaagh"] = true,
     ["wh2_main_nor_hung_incursion_def"] = true,
     ["wh2_main_nor_hung_incursion_hef"] = true,
     ["wh2_main_nor_hung_incursion_lzd"] = true,
     ["wh2_main_nor_hung_incursion_skv"] = true,
     ["wh2_main_skv_unknown_clan_def"] = true,
     ["wh2_main_skv_unknown_clan_hef"] = true,
     ["wh2_main_skv_unknown_clan_lzd"] = true,
     ["wh2_main_skv_unknown_clan_skv"] = true,
     ["wh3_main_grn_dark_land_orcs_waaagh"] = true,
     ["wh3_main_grn_drippin_fangs_waaagh"] = true,
     ["wh3_main_grn_moon_howlerz_waaagh"] = true,
     ["wh3_main_grn_tusked_sunz_waaagh"] = true,
     ["wh3_main_kho_brazen_throne"] = true,
     ["wh3_main_nur_bubonic_swarm"] = true,
     ["wh3_main_rogue_shadow_legion"] = true,
     ["wh3_main_rogue_the_bloody_harvest"] = true,
     ["wh3_main_rogue_the_fluxion_host"] = true,
     ["wh3_main_rogue_the_pleasure_tide"] = true,
     ["wh3_main_rogue_the_putrid_swarm"] = true,
     ["wh3_main_sla_rapturous_excess"] = true,
     ["wh3_main_tze_all_seeing_eye"] = true,
     ["wh_dlc03_bst_beastmen_brayherd"] = true,
     ["wh_dlc03_bst_beastmen_chaos_brayherd"] = true,
     ["wh_dlc03_bst_beastmen_rebels_brayherd"] = true,
     ["wh_dlc03_bst_jagged_horn_brayherd"] = true,
     ["wh_dlc03_bst_redhorn_brayherd"] = true,
     ["wh_main_grn_black_venom_waaagh"] = true,
     ["wh_main_grn_bloody_spearz_waaagh"] = true,
     ["wh_main_grn_broken_nose_waaagh"] = true,
     ["wh_main_grn_crooked_moon_waaagh"] = true,
     ["wh_main_grn_greenskins_rebels_waaagh"] = true,
     ["wh_main_grn_greenskins_waaagh"] = true,
     ["wh_main_grn_necksnappers_waaagh"] = true,
     ["wh_main_grn_orcs_of_the_bloody_hand_waaagh"] = true,
     ["wh_main_grn_red_eye_waaagh"] = true,
     ["wh_main_grn_red_fangs_waaagh"] = true,
     ["wh_main_grn_scabby_eye_waaagh"] = true,
     ["wh_main_grn_skull-takerz_waaagh"] = true,
     ["wh_main_grn_skullsmasherz_waaagh"] = true,
     ["wh_main_grn_teef_snatchaz_waaagh"] = true,
     ["wh_main_grn_top_knotz_waaagh"] = true,
}


--for the possibility that the player can take regions from a vassal,
--Chaos Dwarfs need to know whether it should be a factory or an outpost.
local chd_has_special_dilemma = {
     ["fudging_vassals_region_capture_dilemma"] = true,
     ["fudging_vassals_another_home_province_dilemma"] = true,
     ["fudging_vassals_another_home_province_multi_dilemma"] = true,
}


--we need this in case someone is using a mod that removes transitive diplomacy.
--This function is globally available so they can mod it out if they want to.
function fv_apply_dilemma_diplomatic_bonus(faction_a, faction_b, bonus_key)
     cm:apply_dilemma_diplomatic_bonus(faction_a, faction_b, bonus_key);
     cm:apply_dilemma_diplomatic_bonus(faction_b, faction_a, bonus_key);
end

--note first param expects script interfaces, not command queue indices!
--note also doesn't support on_trigger_callback or force_dilemma_immediately, maybe add that later?
local function please_trigger_dilemma_with_targets(faction, dilemma_key, target_faction, secondary_faction, character, mf,
                                                   region, settlement)
     local dbldr = cm:create_dilemma_builder(dilemma_key);
     out("FUDGINGVASSALS new dilemma is on its way: " .. dilemma_key);

     --TODO does it make sense to put this before the targets are specified?
     local dilemma_choices = dbldr:possible_choices();
     for i = 1, #dilemma_choices do
          dbldr:remove_choice_payload(dilemma_choices[i]);
     end

     for i = 1, #dilemma_choices do
          local payload_builder = cm:create_payload()
          payload_builder:clear()
          dbldr:add_choice_payload(dilemma_choices[i], payload_builder)
     end

     local default_set = false;

     local first_target_set = false;
     if target_faction then
          if not default_set then
               default_set = true;
               dbldr:add_target("default", target_faction);
               out("FUDGINGVASSALS default target set: " .. cm:campaign_obj_to_string(target_faction));
          else
               first_target_set = true;
               dbldr:add_target("target_faction_1", target_faction);
               out("FUDGINGVASSALS target_faction_1 set: " .. cm:campaign_obj_to_string(target_faction));
          end
     end

     if secondary_faction then
          if first_target_set then
               dbldr:add_target("target_faction_2", secondary_faction);
               out("FUDGINGVASSALS target_faction_2 set: " .. cm:campaign_obj_to_string(secondary_faction));
          else
               dbldr:add_target("target_faction_1", secondary_faction);
               out("FUDGINGVASSALS target_faction_1 set: " .. cm:campaign_obj_to_string(secondary_faction));
          end
     end

     if character then
          if not default_set then
               dbldr:add_target("default", character:family_member());
               default_set = true;
               out("FUDGINGVASSALS default target set: " .. cm:campaign_obj_to_string(character));
          else
               dbldr:add_target("target_character_1", character);
               out("FUDGINGVASSALS target_character_1 set: " .. cm:campaign_obj_to_string(character));
          end
     end
     if mf then
          if not default_set then
               default_set = true;
               dbldr:add_target("default", mf);
               out("FUDGINGVASSALS default target set: " .. cm:campaign_obj_to_string(mf));
          else
               dbldr:add_target("target_military_1", mf);
               out("FUDGINGVASSALS target_military_1 set: " .. cm:campaign_obj_to_string(mf));
          end
     end
     if region then
          default_set = true;
          dbldr:add_target("mission_objective", region);
          out("FUDGINGVASSALS mission_objective set: " .. cm:campaign_obj_to_string(region));
     end
     if settlement then
          out("FUDGINGVASSALS settlement specified, but we're going to ignore it: " ..
          cm:campaign_obj_to_string(settlement));
     end

     if cm:get_local_faction(true):is_faction(faction) then
          if ugly_flag_dilemmas[dilemma_key] then
               --TODO TW3 if this happens more than once, put this in a library
               core:add_listener(
                    "fv_ugly_flag_die",
                    "DilemmaIssuedEvent",
                    function(context)
                         return context:dilemma() == dilemma_key;
                    end,
                    function()
                         core:add_listener(
                              "remove_ugly_flag_dilemma_PanelOpenedCampaign",
                              "PanelOpenedCampaign",
                              function(context)
                                   return context.string == "events";
                              end,
                              function(context)
                                   if debug_mode then
                                        out("FUDGINGVASSALS DEBUG events panel open!");
                                   end

                                   local ugly_flag = find_uicomponent(core:get_ui_root(), "event_layouts",
                                        "dilemma_active", "dilemma", "background", "main_holder", "details_holder",
                                        "faction_flag_holder");
                                   if ugly_flag then
                                        if debug_mode then
                                             out("FUDGINGVASSALS DEBUG found found the stupid flag!");
                                        end
                                        ugly_flag:PropagateVisibility(false);
                                   end
                              end,
                              false
                         );
                    end,
                    false
               );
          end
     end

     out("FUDGINGVASSALS launching custom dilemma!");
     cm:launch_custom_dilemma_from_builder(dbldr, faction);
end


--this was mostly cobbled together from lib_campaign_intervention.lua.
--The intervention is there to stop other dilemmas/interventions from
--stealing camera but also to stop us from stealing from them.
local function fv_zoom_camera_to_region(region_obj, faction_key, post_zoom_callback)
     local settlement = region_obj:settlement();
     local targ_x = settlement:display_position_x();
     local targ_y = settlement:display_position_y() + 10;

     local targ_d = 7;
     local targ_b = 0;
     local targ_h = 7;

     --these values are longer than the wh2 version
     --because we need more time for the bootleg trigger_dilemma
     --to spring into action.
     if cm:is_multiplayer() then
          --what is scrolling is what's causing the desync?
          if post_zoom_callback and is_function(post_zoom_callback) then
               post_zoom_callback();
          end
     else
          cm:trigger_transient_intervention(
               "fudging_vassals_zoom_camera_" .. region_obj:name(),
               function(intervention)
                    cm:scroll_camera_from_current(false, 0.70,
                         { targ_x, targ_y, targ_d * 3, targ_b, targ_h * 3 }
                    );
                    cm:callback(function()
                         intervention:complete();
                         if post_zoom_callback and is_function(post_zoom_callback) then
                              post_zoom_callback();
                         end
                    end, 1.5);
               end,
               BOOL_INTERVENTION_DEBUG, --??
               function(intervention)
                    -- allow transient located scripted event to be shown while intervention is active
                    intervention:whitelist_events("scripted_transient_located_eventevent_feed_target_faction");
               end
          );
     end
end


--really horrific feeling that using please_trigger_dilemma_with_targets from a
--callback means those objects are invalid, but only in multiplayer which is why
--it went unnoticed for so long.
local function bootleg_trigger_dilemma_with_targets(player_faction_key, dilemma_key, target_faction_key,
                                                    secondary_faction_key, character_cqi, mf_cqi, region_key)
     if debug_mode then
          out("FUDGINGVASSALS DEBUG bootleg_trigger_dilemma_with_targets (" ..
          tostring(player_faction_key) ..
          ", " ..
          tostring(dilemma_key) ..
          ", " ..
          tostring(target_faction_key) ..
          ", " ..
          tostring(secondary_faction_key) ..
          ", " .. tostring(character_cqi) .. ", " .. tostring(mf_cqi) .. ", " .. tostring(region_key) .. ")");
     end

     --and yet, here we are, with another fucking callback.
     local fuck_my_life = function()
          local faction = cm:get_faction(player_faction_key);
          local target_faction = cm:get_faction(target_faction_key);

          local secondary_faction = nil;
          if secondary_faction_key then
               secondary_faction = cm:get_faction(secondary_faction_key);
          end

          local character = nil;
          if character_cqi > 0 then
               character = cm:get_character_by_cqi(character_cqi);
          end

          local mf = nil;
          if mf_cqi > 0 then
               mf = cm:get_military_force_by_cqi(mf_cqi);
          end

          local region = nil;
          if region_key then
               region = cm:get_region(region_key);
          end
          local settlement = nil;

          please_trigger_dilemma_with_targets(faction, dilemma_key, target_faction, secondary_faction, character, mf,
               region, settlement);
     end

     local player_faction = cm:get_faction(player_faction_key);
     if last_dilemma[player_faction:command_queue_index()] == dilemma_key and is_cursed_dilemma[dilemma_key] then
          out("FUDGINGVASSALS " ..
          player_faction_key .. " already got " .. dilemma_key .. " gonna use a shit dilemma to clear it.");
          cm:trigger_dilemma(player_faction_key, "fudging_vassals_ghost_faction_suspected_dilemma", fuck_my_life);
     else
          fuck_my_life();
     end
end


local function fv_transfer_dark_fortress_from_vassal_to_chaos_faction(region_key, protector_key)
     local protector = cm:get_faction(protector_key);
     local region = cm:get_region(region_key);
     local vassal = region:owning_faction();
     if (not vassal) or vassal:is_null_interface() or (not vassal:is_vassal_of(protector)) then
          out("FUDGINGVASSALS ERROR " ..
          region_key ..
          "'s current owner is not a vassal of the desired new owner " .. protector_key .. ", how did we get here?");
          return;
     end

     if common.get_context_value("CcoCampaignSettlement", region:settlement():cqi(), "IsAssociatedWithVassal(\"norscan_homeland\")") then
          local vassal_key = vassal:name();

          --ownership goes protector > vassal > grandchild
          local grandchild_key = common.get_context_value("CcoCampaignSettlement", region:settlement():cqi(),
               "VassalFactionContext(\"norscan_homeland\").FactionRecordContext.Key");

          cm:disable_event_feed_events(true, "", "", "diplomacy_treaty_broken_soft_military_access");

          local needs_subjugation = false;
          local grandchild = cm:get_faction(grandchild_key);
          if not (grandchild:is_dead() or grandchild:was_confederated()) then
               if grandchild:is_vassal_of(vassal) then
                    out("FUDGINGVASSALS " .. protector_key .. " will take responsibility for " .. grandchild_key);
                    needs_subjugation = true;
               elseif grandchild:is_vassal_of(protector) then
                    out("FUDGINGVASSALS " .. grandchild_key .. " is already a vassal of " .. protector_key);
               else
                    out("FUDGINGVASSALS " .. vassal_key .. " hasn't yet taken responsibility for " .. grandchild_key);
                    needs_subjugation = true;
               end
          end

          if needs_subjugation then
               core:add_listener(
                    "fv_cpsod_vassal_vassal" .. region_key .. protector_key,
                    "RegionFactionChangeEvent",
                    function(context)
                         local region = context:region();
                         if (not region) or region:is_null_interface() or region:is_abandoned() then
                              return false;
                         end
                         return region:name() == region_key and region:owning_faction():name() == protector_key;
                    end,
                    function(context)
                         cm:force_make_vassal(protector_key, grandchild_key);
                         fv_apply_dilemma_diplomatic_bonus(grandchild_key, vassal_key, 1);
                    end,
                    false
               );
          end

          out("FUDGINGVASSALS " .. protector_key .. " will take control of the dark fortress " .. region_key);
          cm:transfer_region_to_faction(region_key, protector_key);

          cm:trigger_incident_with_targets(
               protector:command_queue_index(),
               "fv_dark_fortress_recovery_incident",
               vassal:command_queue_index(),
               grandchild:command_queue_index(),
               0,
               0,
               region:cqi(),
               region:settlement():cqi()
          );

          fv_delete_vassal_capture(protector_key, region_key);

          --gotta be 0.2 becuase fv_transfer_region_to_faction already has a delay of 0.1, blah
          cm:callback(function()
               cm:disable_event_feed_events(false, "", "", "diplomacy_treaty_broken_soft_military_access");
          end, 0.2);
     else
          out("FUDGINGVASSALS " ..
          region_key .. " is not associated with a Norscan vassal, using regular transfer instead.");
          cm:transfer_region_to_faction(region_key, protector_key);
     end
end


local encamp_stances = {
     "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP",
     "MILITARY_FORCE_ACTIVE_STANCE_TYPE_FIXED_CAMP",
     "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP_RAIDING",
};

local function fv_remove_garrison_occupant(region_obj)
     local region_key = region_obj:name();
     if debug_mode then
          out("FUDGINGVASSALS DEBUG fv_remove_garrison_occupant region_key = " ..
          region_key ..
          ", garrison has army = " ..
          tostring(region_obj:garrison_residence():has_army()) ..
          ", has navy = " .. tostring(region_obj:garrison_residence():has_navy()));
          if region_obj:garrison_residence():has_army() then
               out("FUDGINGVASSALS DEBUG fv_remove_garrison_occupant garrison army has general = " ..
               tostring(region_obj:garrison_residence():army():has_general()));
               if region_obj:garrison_residence():army():has_general() then
                    out("FUDGINGVASSALS DEBUG fv_remove_garrison_occupant garrison army general = " ..
                    cm:campaign_obj_to_string(region_obj:garrison_residence():army():general_character()));
               end
          end
     end
     if region_obj:garrison_residence():has_army() and region_obj:garrison_residence():army():has_general() then
          local current_char = region_obj:garrison_residence():army():general_character();
          if debug_mode then
               out("FUDGINGVASSALS DEBUG fv_remove_garrison_occupant " ..
               cm:campaign_obj_to_string(current_char) .. " is garrisoned in " .. region_key);
          end
          local xpos, ypos = cm:find_valid_spawn_location_for_character_from_settlement(
               region_obj:owning_faction():name(),
               region_key,
               false,
               true,
               2
          );
          if xpos ~= -1 then
               local cqi = current_char:command_queue_index();
               local cls = cm:char_lookup_str(current_char);
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG moving " ..
                    cls .. " to [" .. tostring(xpos) .. ", " .. tostring(ypos) .. "]");
               end

               core:add_listener(
                    "fv_remove_garrison_occupant_clg" .. cls,
                    "CharacterLeavesGarrison",
                    function(context)
                         return context:character():command_queue_index() == cqi;
                    end,
                    function(context)
                         local cc = context:character();
                         if not cc:has_military_force() then
                              out(
                              "FUDGINGVASSALS ERROR fv_remove_garrison_occupant character doesn't have military force??");
                              return;
                         end
                         cm:replenish_action_points(cls);

                         local stance_key = false;
                         for i = 1, #encamp_stances do
                              if cc:military_force():can_activate_stance(encamp_stances[i]) then
                                   stance_key = encamp_stances[i];
                                   if debug_mode then
                                        out("FUDGINGVASSALS DEBUG fv_remove_garrison_occupant can activate " ..
                                        stance_key);
                                   end
                                   break;
                              end
                         end

                         if not stance_key then
                              out("FUDGINGVASSALS fv_remove_garrison_occupant cannot encamp, let's quit.");
                              cm:zero_action_points(cls);
                              return;
                         end

                         core:add_listener(
                              "fv_remove_garrison_occupant_fas" .. cls,
                              "ForceAdoptsStance",
                              function(context)
                                   return context:military_force():general_character():command_queue_index() == cqi;
                              end,
                              function(context)
                                   cm:zero_action_points(cls);
                              end,
                              false
                         );

                         cm:force_character_force_into_stance(cls, "MILITARY_FORCE_ACTIVE_STANCE_TYPE_SET_CAMP");
                    end,
                    false
               );
               cm:leave_garrison(cls, xpos, ypos);
          else
               out(
               "FUDGINGVASSALS ERROR fv_remove_garrison_occupant couldn't find a good place to eject the army sitting here.");
          end
     end
end


local function fv_transfer_region_to_faction(region_key, faction_key)
     --out ("FUDGINGVASSALS DEBUG fv_transfer_region_to_faction " .. tostring (region_key) .. " -> " .. tostring (faction_key));
     local region_obj = cm:get_region(region_key);
     if not region_obj then
          out("FUDGINGVASSALS ERROR fv_transfer_region_to_faction couldn't find region " .. region_key);
          return false;
     end

     local faction_obj = region_obj:owning_faction();
     if not faction_obj then
          out("FUDGINGVASSALS ERROR fv_transfer_region_to_faction can't transfer un-owned region " .. region_key);
          return false;
     end

     fv_remove_garrison_occupant(region_obj);

     local current_owner_key = region_obj:owning_faction():name();
     core:add_listener(
          "fv_transfer_region_to_faction" .. region_key .. faction_key,
          "RegionFactionChangeEvent",
          function(context)
               local region = context:region();
               return region:name() == region_key and region:owning_faction():name() == faction_key;
          end,
          function(context)
               out("FUDGINGVASSALS fv_transfer_region_to_faction " ..
               tostring(region_key) .. " transferred to " .. tostring(faction_key));
               fv_apply_dilemma_diplomatic_bonus(current_owner_key, faction_key, 2);
               local region_cqi = context:region():cqi();
               cm:callback(function()
                    cm:heal_garrison(region_cqi);
                    out("FUDGINGVASSALS garrison should be healed now.");
               end, 0.1);
          end,
          false
     );

     if vassal_manager:dark_fortress_should_be_transferred_to_chaos_master(region_obj, faction_key) then
          if debug_mode then
               out("FUDGINGVASSALS DEBUG " ..
               region_key ..
               " is a dark fortress captured by a vassal and the vassal's protector is Chaos. Passing the buck.");
          end
          fv_transfer_dark_fortress_from_vassal_to_chaos_faction(region_key, faction_key);
     else
          if debug_mode then
               out("FUDGINGVASSALS DEBUG " .. region_key .. " is not a dark fortress. Transferring now.");
          end
          cm:transfer_region_to_faction(region_key, faction_key);
     end
end


local chd_building_bases = {
     ["outpost"] = "wh3_dlc23_chd_settlement_outpost_",
     ["factory"] = "wh3_dlc23_chd_settlement_factory_",
};
local function fv_transfer_region_to_faction_chd(region_key, faction_key, building_type)
     if not chd_building_bases[building_type] then
          out("FUDGINGVASSALS ERROR fv_transfer_region_to_faction_chd invalid building type: " ..
          tostring(building_type));
     elseif debug_mode then
          out("FUDGINGVASSALS DEBUG fv_transfer_region_to_faction_chd region_key = " ..
          tostring(region_key) ..
          ", faction_key = " .. tostring(faction_key) .. ", building_type = " .. tostring(building_type));
     end

     local building_base_key = chd_building_bases[building_type];
     local region = cm:get_region(region_key);
     fv_remove_garrison_occupant(region);

     if region:is_province_capital() then
          --TODO TW3 do we need another dilemma for how big you want your tower?
          cm:transfer_region_to_faction(region_key, faction_key);
          fv_delete_vassal_capture(faction_key, region_key)
     else
          local building_level = 1;

          if not region:is_abandoned() then
               local slot = region:settlement():primary_slot();
               if slot:has_building() then
                    building_level = slot:building():building_level();
                    if building_level < 1 then
                         building_level = 1;
                    elseif building_level > 3 then
                         building_level = 3;
                    end
               end
          end

          core:add_listener(
               "fv_chorf_reassign_rfce1" .. region_key .. faction_key,
               "RegionFactionChangeEvent",
               function(context)
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG fv_chorf_reassign_rfce1 region: " ..
                         context:region():name() .. ", reason: " .. context:reason());
                    end
                    return context:region():name() == region_key and context:reason() == "abandoned";
               end,
               function(context)
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG fv_chorf_reassign_rfce1 fired!");
                    end
                    core:add_listener(
                         "fv_chorf_reassign_rfce2" .. region_key .. faction_key,
                         "RegionFactionChangeEvent",
                         function(context)
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG fv_chorf_reassign_rfce2 region: " ..
                                   context:region():name() .. ", new owner: " .. context:region():owning_faction():name());
                              end
                              return context:region():name() == region_key and
                              context:region():owning_faction():name() == faction_key;
                         end,
                         function(context)
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG fv_chorf_reassign_rfce2 we will build " ..
                                   building_base_key .. tostring(building_level));
                              end
                              cm:region_slot_instantly_upgrade_building(context:region():settlement():primary_slot(),
                                   building_base_key .. tostring(building_level))
                              cm:callback(function()
                                   local primary_slot = cm:get_region(region_key):settlement():primary_slot();
                                   if primary_slot:has_building() then
                                        if not primary_slot:building():name():starts_with(building_base_key) then
                                             if debug_mode then
                                                  out("FUDGINGVASSALS DEBUG fv_transfer_region_to_faction_chd " ..
                                                  region_key .. " doesn't have the right building, gonna try again.");
                                             end
                                             cm:region_slot_instantly_upgrade_building(primary_slot,
                                                  building_base_key .. tostring(building_level))
                                        end
                                   else
                                        out("FUDGINGVASSALS ERROR fv_transfer_region_to_faction_chd " ..
                                        region_key .. " has nothing in the primary slot??");
                                   end
                              end, 0.1);
                         end,
                         false
                    );
                    cm:transfer_region_to_faction(region_key, faction_key);
                    fv_delete_vassal_capture(faction_key, region_key)
               end,
               false
          );

          --this *should* work regardless of whether the region is already abandoned or not.
          cm:set_region_abandoned(region_key);
     end
end


--Everyone with the same subculture should be granted the option to confederate, with a few exceptions.
function vassal_manager:is_ok_to_confederate(protector_obj, vassal_obj)
     local protector_key = protector_obj:name();
     local vassal_key = vassal_obj:name();

     if protector_obj:subculture() ~= vassal_obj:subculture() then
          if debug_mode then
               out("FUDGINGVASSALS DEBUG no confederation between " ..
               protector_key .. " and " .. vassal_key .. " due to different subculture.");
          end
          return false;
     end

     --allowing Empire confederations would be cheating the Imperial Politics system!
     if not (protector_obj:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() and
              vassal_obj:pooled_resource_manager():resource("emp_imperial_authority"):is_null_interface())
     then
          if debug_mode then
               out("FUDGINGVASSALS DEBUG confederation between " ..
               protector_key .. " and/or " .. vassal_key .. " will be handled with Empire politics.");
          end
          return false;
     end

     for _, fp in pairs(self.do_not_confederate) do
          if fp[1] == protector_key and fp[2] == vassal_key then
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " .. protector_key .. " should never offer to confederate " .. vassal_key);
               end
               return false;
          end
     end
     if debug_mode then
          out("FUDGINGVASSALS DEBUG should be OK for " .. protector_key .. " to offer confederation to " .. vassal_key);
     end
     return true;
end

function vassal_manager:dark_fortress_should_be_transferred_to_chaos_master(region_obj, transfer_recipient_key)
     if not region_obj or region_obj:is_abandoned() then
          return false;
     end

     local region_owner = region_obj:owning_faction();
     return region_obj:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group") and
         region_owner:is_vassal() and
         region_owner:master():subculture() == "wh_main_sc_chs_chaos" and
         region_owner:master():name() == transfer_recipient_key;
end

--the big assumption here is that we want other vassals at home in the same
--province as region_obj but who are NOT the the vassal owning region_obj.
--Obviously if region_obj's owner is home in that province, we want to leave them alone.
function vassal_manager:find_already_home_in_province(region_obj, vassal_owner)
     local province_key = region_obj:province_name();

     if region_obj:owning_faction():home_region():province_name() == province_key then
          out("FUDGINGVASSALS " ..
          region_obj:owning_faction():name() ..
          "'s home province is " .. province_key .. " so we don't care that they captured a region in this province.");
          return {};
     end

     local is_vassals_in_province = {};

     for _, current_region in model_pairs(region_obj:province():regions()) do
          if not current_region:is_abandoned() then
               local current_faction = current_region:owning_faction();
               if (not current_faction:is_faction(vassal_owner)) and
                   current_faction:is_vassal_of(vassal_owner) and
                   current_faction:has_home_region() and
                   current_faction:home_region():province_name() == province_key
               then
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG " ..
                         current_faction:name() .. " has their home province is " .. province_key);
                    end
                    is_vassals_in_province[current_faction:name()] = current_faction:region_list():num_items();
               end
          end
     end

     local vassal_keys = {};
     for k, v in pairs(is_vassals_in_province) do
          table.insert(vassal_keys, { k, v });
     end
     --sort by region list first, then faction_key.
     table.sort(vassal_keys, function(v1, v2)
          if v1[2] == v2[2] then
               return v1[1] < v2[1]
          else
               return v1[2] < v2[2]
          end
     end);
     for _, v in pairs(vassal_keys) do
          out("FUDGINGVASSALS found " ..
          v[1] .. " in " .. province_key .. " and they have " .. tostring(v[2]) .. " region(s) total.");
     end

     return vassal_keys;
end

function vassal_manager:find_closest_for_region(region_obj, ignore_vassal_key)
     local distance = 9999999;
     local vassal_key = false;

     local region_owner = region_obj:owning_faction();
     local region_x = region_obj:settlement():logical_position_x();
     local region_y = region_obj:settlement():logical_position_y();

     for _, current_faction in model_pairs(region_owner:vassals()) do
          if current_faction:has_home_region() and current_faction:name() ~= ignore_vassal_key then
               local vassal_distance = distance_squared(
                    region_x,
                    region_y,
                    current_faction:home_region():settlement():logical_position_x(),
                    current_faction:home_region():settlement():logical_position_y()
               );
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " ..
                    current_faction:name() ..
                    " is a vassal of " .. region_owner:name() .. " and is " .. vassal_distance .. " hex^2 away.");
               end

               if vassal_distance < distance then
                    vassal_key = current_faction:name();
                    distance = vassal_distance;
               end
          end
     end

     if vassal_key then
          if debug_mode then
               out("FUDGINGVASSALS DEBUG find_closest_for_region selected " ..
               vassal_key .. " while ignoring " .. tostring(ignore_vassal_key));
          end
     else
          if ignore_vassal_key then
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG find_closest_for_region couldn't find a closer vassal, stuck with " ..
                    tostring(ignore_vassal_key));
               end
               vassal_key = ignore_vassal_key
          else
               out("FUDGINGVASSALS find_closest_for_region selected no one!");
          end
     end

     return vassal_key;
end

function vassal_manager:find_smallest_for_region(region_obj)
     local all_vassals = {};
     local climate_happy_vassals = {};
     local region_owner = region_obj:owning_faction();
     for _, current_faction in model_pairs(region_owner:factions_met()) do
          if current_faction:is_vassal_of(region_owner) then
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " .. current_faction:name() .. " is a vassal of " .. region_owner:name());
               end
               table.insert(all_vassals, current_faction:name());
               if current_faction:get_climate_suitability(region_obj:settlement():get_climate()) == "suitability_good" then
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG " .. current_faction:name() .. " can settle " .. region_obj:name());
                    end
                    table.insert(climate_happy_vassals, current_faction:name());
               end
          end
     end

     local vassal_key = false;
     local num_settlements = 999;

     for j = 1, #climate_happy_vassals do
          local current_faction = cm:get_faction(climate_happy_vassals[j]);
          if current_faction:region_list():num_items() < num_settlements then
               vassal_key = current_faction:name();
               num_settlements = current_faction:region_list():num_items();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " ..
                    vassal_key .. " is suitable for this climate and has " .. num_settlements .. " settlements.");
               end
          end
     end
     if not vassal_key then
          for j = 1, #all_vassals do
               local current_faction = cm:get_faction(all_vassals[j]);
               if current_faction:region_list():num_items() < num_settlements then
                    vassal_key = current_faction:name();
                    num_settlements = current_faction:region_list():num_items();
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG " .. vassal_key .. " has " .. num_settlements .. " settlements.");
                    end
               end
          end
     end

     if debug_mode then
          if vassal_key then
               out("FUDGINGVASSALS DEBUG vassal:find_smallest_for_region selected " .. vassal_key);
          else
               out("FUDGINGVASSALS DEBUG vassal:find_smallest_for_region couldn't find a small vassal.");
          end
     end

     return vassal_key;
end

function vassal_manager:find_smallest_already_in_province(region_obj)
     local region_owner = region_obj:owning_faction();
     local result_key = false;
     local num_settlements = 999;

     for _, current_region in model_pairs(region_obj:province():regions()) do
          if (not current_region:is_abandoned()) and
              current_region:owning_faction():is_vassal_of(region_owner) and
              current_region:owning_faction():region_list():num_items() < num_settlements
          then
               num_settlements = current_region:owning_faction():region_list():num_items();
               result_key = current_region:owning_faction():name();
          end
     end

     if debug_mode then
          if result_key then
               out("FUDGINGVASSALS DEBUG find_smallest_already_in_province selected " .. result_key);
          else
               out("FUDGINGVASSALS DEBUG find_smallest_already_in_province couldn't find vassal in province.");
          end
     end

     return result_key;
end

function vassal_manager:find_best_for_region(region_obj)
     local vassal_key = self:find_smallest_already_in_province(region_obj);

     if not vassal_key then
          vassal_key = self:find_smallest_for_region(region_obj);
     end

     if debug_mode then
          out("FUDGINGVASSALS DEBUG find_best_for_region selected " ..
          tostring(vassal_key) .. " for " .. region_obj:name());
     end
     return vassal_key;
end

local function check_dilemma_queue_for_player(player_faction_key)
     if debug_mode then
          out("FUDGINGVASSALS DEBUG check_dilemma_queue_for_player player_capture_dilemma_queue[" ..
          player_faction_key .. "] = " .. table.tostring(player_capture_dilemma_queue[player_faction_key]));
          out("FUDGINGVASSALS DEBUG empire_demand_return_queue = " .. table.tostring(empire_demand_return_queue));
     end
     local vassal_owner = cm:get_faction(player_faction_key);
     if not vassal_owner:is_factions_turn() then
          out("FUDGINGVASSALS check_dilemma_queue_for_player called but it is not " .. player_faction_key .. "'s turn.");
          return;
     elseif fv_is_dilemma_pending(player_faction_key) then
          out("FUDGINGVASSALS check_dilemma_queue_for_player called but " ..
          player_faction_key .. " another has another dilemma pending.");
          return;
     end

     --apparently testing this table's existence at every fucking opportunity isn't
     --sufficient to actually ensure it exists when needed :-(
     if nil == player_capture_dilemma_queue[player_faction_key] then
          out("FUDGINGVASSALS ERROR how is it possible that player_capture_dilemma_queue[" ..
          player_faction_key .. "] wasn't initialized yet??");
          player_capture_dilemma_queue[player_faction_key] = {};
     end

     for i = 1, #(player_capture_dilemma_queue[player_faction_key]) do
          local pcdt = player_capture_dilemma_queue[player_faction_key][i];

          --don't worry, we force quit later.
          table.remove(player_capture_dilemma_queue[player_faction_key], i);

          out("FUDGINGVASSALS processing dilemma for " .. player_faction_key);
          out(table.tostring(pcdt));

          if "liberate" == pcdt.type then
               local liberator = cm:get_faction(pcdt.faction_key);
               local liberated = cm:get_faction(pcdt.vassal_key); --this is a lie, shut up.
               if is_faction(liberator) and
                   is_faction(liberated) and
                   liberated:has_home_region() and
                   not liberated:is_vassal_of(liberator)
               then
                    --TODO TW3 you know we wouldn't have to duplicate this if the workspace was just the pcdt, right?????

                    fv_dilemma_pending[player_faction_key] = true;
                    dilemma_workspace[player_faction_key] = pcdt.vassal_key;

                    fv_zoom_camera_to_region(liberated:home_region(), player_faction_key, function()
                         bootleg_trigger_dilemma_with_targets(player_faction_key, "fudging_vassals_liberate_dilemma",
                              liberated:name(), nil, 0, 0, nil);
                    end);
               else
                    out("FUDGINGVASSALS " ..
                    pcdt.faction_key ..
                    " may have liberated " ..
                    pcdt.vassal_key .. " as a military ally, but it is no longer possible to vassalize them.");
               end
          else
               local vassal = cm:get_faction(pcdt.vassal_key);

               if not vassal:is_vassal_of(vassal_owner) then
                    out("FUDGINGVASSALS " .. pcdt.vassal_key .. " is no longer vassal of " .. player_faction_key);
                    return;
               end

               --Please stop whining about this code being ugly.
               --Everytime you try to make this code less ugly, you break someone's campaign.
               local region = cm:get_region(pcdt.region_key);
               if (not region) or region:is_abandoned() then
                    out("FUDGINGVASSALS " .. pcdt.region_key .. " is not a valid region to have a dilemma over.");
                    return;
               elseif region:owning_faction():name() ~= pcdt.vassal_key and not ("home province" == pcdt.type) then
                    out("FUDGINGVASSALS " .. pcdt.vassal_key .. " no longer owns " .. pcdt.region_key);
                    return;
               elseif region:owning_faction():name() ~= player_faction_key and ("home province" == pcdt.type) then
                    out("FUDGINGVASSALS " .. player_faction_key .. " no longer owns " .. pcdt.region_key);
                    return;
               elseif vassal:has_home_region() and vassal:home_region():name() == region:name() and vassal:region_list():num_items() == 1 and "vassal capture" == pcdt.type then
                    out("FUDGINGVASSALS " ..
                    pcdt.vassal_key .. " can't afford to give away its home region " .. pcdt.region_key);
                    return;
               end

               fv_dilemma_pending[player_faction_key] = true;
               dilemma_workspace[player_faction_key] = pcdt.region_key;

               if "home province" == pcdt.type then
                    fv_zoom_camera_to_region(region, player_faction_key, function()
                         bootleg_trigger_dilemma_with_targets(vassal_owner:name(),
                              "fudging_vassals_home_province_dilemma", vassal:name(), nil, 0, 0, region:name());
                    end);
               elseif "subjugation" == pcdt.type then
                    fv_zoom_camera_to_region(region, player_faction_key, function()
                         bootleg_trigger_dilemma_with_targets(vassal_owner:name(), "fudging_vassals_subjugation_dilemma",
                              vassal:name(), nil, 0, 0, nil);
                    end);
               elseif "subjugate_or_confederate" == pcdt.type then
                    fv_zoom_camera_to_region(region, player_faction_key, function()
                         bootleg_trigger_dilemma_with_targets(vassal_owner:name(),
                              "fudging_vassals_confederate_return_dilemma", vassal:name(), nil, 0, 0, nil);
                    end);
               elseif "confederation" == pcdt.type then
                    fv_zoom_camera_to_region(region, player_faction_key, function()
                         bootleg_trigger_dilemma_with_targets(vassal_owner:name(),
                              "fudging_vassals_confederation_dilemma", vassal:name(), nil, 0, 0, nil);
                    end);
               elseif "vassal capture" == pcdt.type then
                    local dilemma_key = "fudging_vassals_region_capture_dilemma";
                    local second_faction_key = nil;

                    --check if this region belongs in another vassal's home province
                    local other_vassals = vassal_manager:find_already_home_in_province(region, vassal_owner);
                    out("FUDGINGVASSALS DEBUG check if this region should belong to another vassal? " ..
                    tostring(#other_vassals) .. " vassals have their home region in " .. region:province_name());
                    if #other_vassals == 1 then
                         local other_vassal_key = other_vassals[1][1];
                         out("FUDGINGVASSALS even though " ..
                         vassal:name() ..
                         " captured " ..
                         pcdt.region_key .. " that province would be better suited to " .. other_vassal_key);
                         dilemma_key = "fudging_vassals_another_home_province_dilemma";
                         second_faction_key = other_vassal_key;

                         --we only check if this is an empire vs empire capture if the player is also empire
                         if not vassal_owner:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() then
                              --(It was kind of that CA employee to leave this public.)
                              local elector_key = get_elector_faction_from_region(region);

                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG elector_key = " ..
                                   tostring(elector_key) ..
                                   ", playing emp: " ..
                                   tostring(not vassal_owner:pooled_resource_manager():resource("emp_loyalty")
                                   :is_null_interface()));
                              end

                              if elector_key then
                                   --this region traditionally belonged to an Empire faction!
                                   local emp_faction_key = EMPIRE_ELECTOR_COUNTS[elector_key].faction_key;
                                   local emp_faction = cm:get_faction(emp_faction_key);
                                   if emp_faction_key == pcdt.vassal_key then
                                        out("FUDGINGVASSALS actually " ..
                                        pcdt.region_key ..
                                        " belonged to elector .. " ..
                                        elector_key .. " so we're going to let them keep it.");
                                        dilemma_key = false;
                                   elseif not emp_faction:at_war_with(vassal_owner) then
                                        if emp_faction_key == other_vassal_key then
                                             if vassal:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() then
                                                  out("FUDGINGVASSALS actually " ..
                                                  pcdt.region_key ..
                                                  " belonged to elector .. " ..
                                                  elector_key .. " so we need a custom Empire return dilemma.");
                                                  second_faction_key = emp_faction_key;
                                                  dilemma_key = "fudging_vassals_empire_return_dilemma";
                                             else
                                                  out("FUDGINGVASSALS " ..
                                                  pcdt.vassal_key ..
                                                  " is an empire faction and " ..
                                                  pcdt.region_key ..
                                                  " used to be owned by an " ..
                                                  elector_key .. ", so this *should* be Empire politics as usual.");
                                                  for qq, edrd in pairs(empire_demand_return_queue) do
                                                       if debug_mode then
                                                            out(
                                                            "FUDGINGVASSALS DEBUG looking at empire_demand_return_queue[" ..
                                                            tostring(qq) .. "] = " .. table.tostring(edrd));
                                                       end
                                                       if edrd.player == player_faction_key and
                                                           edrd.region == pcdt.region_key and
                                                           edrd.conquerer == pcdt.vassal_key
                                                       then
                                                            out(
                                                            "FUDGINGVASSALS empire_demand_return_queue already has this queued in spot #" ..
                                                            tostring(qq) .. ", let's ignore it.");
                                                            dilemma_key = false;
                                                       end
                                                  end
                                             end
                                        else
                                             --this region belonged to an elector count, but neither vassal nor other vassal
                                             --are that elector count, so we won't do anything special.
                                        end
                                   end
                              end
                         end
                    elseif #other_vassals > 1 then
                         --shit has hit the fan and we need a better dilemma.
                         local guaranteed_desync = {
                              vassal1 = other_vassals[1][1],
                              vassal2 = other_vassals[2][1],
                              idiot_vassal = vassal:name(),
                              region_key = pcdt.region_key,
                         };
                         out("FUDGINGVASSALS what a mess! " .. table.tostring(guaranteed_desync));
                         --TODO TW3 could the problem be here where we're not confirming both factions are vassals of vassal_owner?
                         dilemma_workspace[player_faction_key] = guaranteed_desync;
                         vassal = cm:get_faction(guaranteed_desync.vassal1);
                         second_faction_key = guaranteed_desync.vassal2;
                         dilemma_key = "fudging_vassals_another_home_province_multi_dilemma";
                    else
                         --no other vassals but still need to check for elector counts
                         local elector_key = get_elector_faction_from_region(region);

                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG elector_key = " ..
                              tostring(elector_key) ..
                              ", playing emp: " ..
                              tostring(not vassal_owner:pooled_resource_manager():resource("emp_loyalty")
                              :is_null_interface()));
                         end
                         if elector_key and not vassal_owner:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() then
                              --this region traditionally belonged to an Empire faction!
                              local emp_faction_key = EMPIRE_ELECTOR_COUNTS[elector_key].faction_key;
                              local emp_faction = cm:get_faction(emp_faction_key);
                              if not emp_faction:is_dead() then
                                   if vassal:pooled_resource_manager():resource("emp_loyalty"):is_null_interface() then
                                        out("FUDGINGVASSALS actually " ..
                                        pcdt.region_key ..
                                        " belonged to elector .. " ..
                                        elector_key .. " so we need a custom Empire return dilemma.");
                                        second_faction_key = emp_faction_key;
                                        dilemma_key = "fudging_vassals_empire_return_dilemma";
                                   else
                                        out("FUDGINGVASSALS " ..
                                        pcdt.vassal_key ..
                                        " is an empire faction and " ..
                                        pcdt.region_key ..
                                        " used to be owned by an " ..
                                        elector_key .. ", so this is Empire politics as usual.");
                                        for qq, edrd in pairs(empire_demand_return_queue) do
                                             if edrd.player == player_faction_key and
                                                 edrd.region == pcdt.region_key and
                                                 edrd.conquerer == pcdt.vassal_key
                                             then
                                                  out(
                                                  "FUDGINGVASSALS empire_demand_return_queue already hash this queued in spot #" ..
                                                  tostring(qq) .. ", let's ignore it.");
                                                  dilemma_key = false;
                                                  break;
                                             end
                                        end
                                   end
                              end
                         end
                    end

                    if ("fudging_vassals_region_capture_dilemma" == dilemma_key) and not vassal_owner:is_allowed_to_capture_territory() then
                         out("FUDGINGVASSALS hordes can't capture territory! Skipping");
                         dilemma_key = false;
                    end

                    --TODO for fudging_vassals_another_home_province_dilemma we should zoom out so we can see both

                    if vassal_owner:culture() == "wh3_dlc23_chd_chaos_dwarfs" and
                        not region:is_province_capital() and
                        chd_has_special_dilemma[dilemma_key]
                    then
                         out("FUDGINGVASSALS " ..
                         vassal_owner:name() .. " is Chaos Dwarfs, so they get a special dilemma.");
                         dilemma_key = dilemma_key .. "_chd";
                    end

                    if dilemma_key then
                         fv_zoom_camera_to_region(region, player_faction_key, function()
                              bootleg_trigger_dilemma_with_targets(vassal_owner:name(), dilemma_key, vassal:name(),
                                   second_faction_key, 0, 0, region:name());
                         end);
                    else
                         out("FUDGINGVASSALS couldn't find a dilemma_key for " .. table.tostring(pcdt));
                         fv_reset_pending_dilemma(player_faction_key);
                         fv_check_dilemma_queue(player_faction_key);
                    end
               else
                    fv_reset_pending_dilemma(player_faction_key);
                    out("FUDGINGVASSALS ERROR " .. tostring(pcdt.type) .. " is not a supported player capture dilemma!");
               end
          end

          --force quit to avoid iterating over a table that we're modifying.
          return;
     end
end


--The delay must be *at least* 2 seconds otherwise we detect the wrong region owner.
fv_check_dilemma_queue = function(faction_key)
     --The entire original point of keeping this separate from the callback
     --is to stop multiple dilemmas from firing at once, which leads to
     --questions such as why are we still doing this T_T
     local pcd_delay = 2.0; -- + 0.2 * #player_capture_dilemma_queue;
     cm:callback(function() check_dilemma_queue_for_player(faction_key); end, pcd_delay);
end


--If we vassalize Yvresse and Batman goes and activates the Mist of Yvresse x_x
local function fv_protect_owner_from_attrition(human_faction)
     for faction_key, local_effect_bundle_key in pairs(fv_attritions_owner_must_be_protected_from_by_faction) do
          local faction = cm:get_faction(faction_key);
          --whoops no Yvresse in Realms of Chaos!
          if faction then
               if faction:is_vassal_of(human_faction) then
                    if not human_faction:has_effect_bundle(local_effect_bundle_key) then
                         out("FUDGINGVASSALS " ..
                         faction_key ..
                         " is a vassal of " ..
                         human_faction:name() .. ", granting the latter " .. local_effect_bundle_key);
                         cm:apply_effect_bundle(local_effect_bundle_key, human_faction:name(), -1);
                    end
               else
                    if human_faction:has_effect_bundle(local_effect_bundle_key) then
                         out("FUDGINGVASSALS " ..
                         faction_key ..
                         " is no longer a vassal of " .. human_faction:name() .. ", removing " .. local_effect_bundle_key);
                         cm:remove_effect_bundle(local_effect_bundle_key, human_faction:name());
                    end
               end
          end
     end
end


local function disable_diplomacy_for_vassal(faction_key)
     cm:force_diplomacy("all", "faction:" .. faction_key, "war", false, false, true);
     vassal_diplomacy_adjusted[faction_key] = true;
end


local function disable_attrition_for_vassal(vassal)
     local vassal_owner = vassal:master();

     local attrition_protection_eb = fv_attrition_protection_by_faction[vassal_owner:name()];
     if attrition_protection_eb and not vassal:has_effect_bundle(attrition_protection_eb) then
          out("FUDGINGVASSALS " ..
          vassal_owner:name() .. " grants " .. attrition_protection_eb .. " to " .. vassal:name());
          cm:apply_effect_bundle(attrition_protection_eb, vassal:name(), -1);
     end

     if vassal_owner:subculture() ~= vassal:subculture() and
         fv_attrition_protection_by_subculture[vassal_owner:subculture()] ~= fv_attrition_protection_by_subculture[vassal:subculture()]
     then
          attrition_protection_eb = fv_attrition_protection_by_subculture[vassal_owner:subculture()];
          if attrition_protection_eb and not vassal:has_effect_bundle(attrition_protection_eb) then
               out("FUDGINGVASSALS " ..
               vassal_owner:name() ..
               " is " .. vassal_owner:subculture() .. " so " .. vassal:name() .. " gets " .. attrition_protection_eb);
               cm:apply_effect_bundle(attrition_protection_eb, vassal:name(), -1);
          end
     else
          if debug_mode then
               out("FUDGINGVASSALS DEBUG " ..
               vassal_owner:name() ..
               " has similar subculture as " .. vassal:name() .. " so no need for attrition protection.");
          end
     end
end


local function enable_diplomacy_for_former_vassal(former_vassal_key)
     local diplo_str = "faction:" .. former_vassal_key;

     for _, faction in model_pairs(cm:model():world():faction_list()) do
          local faction_key = faction:name();
          if not faction:is_vassal() then
               cm:force_diplomacy("faction:" .. faction_key, diplo_str, "war", true, true, true);
          end
     end
     vassal_diplomacy_adjusted[former_vassal_key] = false;

     local faction = cm:get_faction(former_vassal_key);
     if faction:is_allowed_to_capture_territory() and faction:culture() ~= "wh_main_grn_greenskins" then
          -- Greenskins cannot trade
          -- but everyone else should be free to (in theory)
          cm:force_diplomacy("faction:" .. former_vassal_key, "all", "break trade", true, true, true);
     end
end


local function enable_attrition_for_former_vassal(former_vassal)
     local faction_key = former_vassal:name();
     if former_vassal:is_vassal() then
          out("FUDGINGVASSALS ERROR " .. faction_key .. " is still a vassal?  Are they a ghost faction?");
     end

     --remove faction-specific attrition protections.
     for _, attrition_protection_eb in pairs(fv_attrition_protection_by_faction) do
          if former_vassal:has_effect_bundle(attrition_protection_eb) then
               out("FUDGINGVASSALS " ..
               faction_key .. " is no longer a vassal, so they no longer get " .. attrition_protection_eb);
               cm:remove_effect_bundle(attrition_protection_eb, faction_key);
          end
     end

     --remove subculture-specific attrition protections.
     for _, attrition_protection_eb in pairs(fv_attrition_protection_by_subculture) do
          if former_vassal:has_effect_bundle(attrition_protection_eb) then
               out("FUDGINGVASSALS " ..
               faction_key .. " is no longer a vassal, so they no longer get " .. attrition_protection_eb);
               cm:remove_effect_bundle(attrition_protection_eb, faction_key);
          end
     end

     --if they happened to have any ritual-specific attrition protection,
     --then get rid of it because they no longer deserve it.
     for i = 1, #fv_ritual_attritions do
          if former_vassal:has_effect_bundle(fv_ritual_attritions[i]) then
               out("FUDGINGVASSALS " ..
               faction_key .. " is no longer a vassal, so they no longer get " .. fv_ritual_attritions[i]);
               cm:remove_effect_bundle(fv_ritual_attritions[i], faction_key);
          end
     end
end


local function stop_vassal_breakage(owning_faction_key, vassal_key)
     if vassal_key ~= "wh2_dlc16_wef_drycha" then
          cm:force_diplomacy("faction:" .. owning_faction_key, "faction:" .. vassal_key, "break vassal,break trade", true,
               true, false);
          --TODO TW3 you changed this from false, false, false to false, true, false, so doublecheck this doesn't break anything.
          cm:force_diplomacy("faction:" .. vassal_key, "faction:" .. owning_faction_key, "break vassal,break trade,war",
               false, true, false);
     end

     local faction = cm:get_faction(owning_faction_key);
     local vassal = cm:get_faction(vassal_key);
     if faction:is_allowed_to_capture_territory() and faction:culture() ~= "wh_main_grn_greenskins" and vassal:culture() ~= "wh_main_grn_greenskins" then
          -- Greenskins cannot trade
          -- but everyone else should be free to (in theory)
          cm:force_diplomacy("faction:" .. owning_faction_key, "faction:" .. vassal_key, "break trade", false, false,
               true);
     end
end


local function adjust_situation_by_attitude(owning_faction, vassal)
     local owning_faction_key = owning_faction:name();
     if not owning_faction:is_human() then
          if debug_mode then
               out("FUDGINGVASSALS adjust_situation_by_attitude " .. owning_faction_key .. " isn't human so who cares?");
          end
          return;
     end

     local wc = cm:war_coordination();
     local attitude = vassal:diplomatic_attitude_towards(owning_faction_key);
     if attitude < -50 then
          out("FUDGINGVASSALS " ..
          vassal:name() .. " hates " .. owning_faction_key .. " so no vision buff and minor allegiance nerf.");
          wc:set_faction_favour_points_toward_faction(owning_faction, vassal, -1);
          return;
     elseif attitude < 10 then
          out("FUDGINGVASSALS " ..
          vassal:name() .. " doesn't like " .. owning_faction_key .. " so won't share intel or change allegiance.");
          for _, region in model_pairs(vassal:region_list()) do
               cm:make_region_seen_in_shroud(owning_faction_key, region:name());
          end
     else
          if debug_mode then
               out("FUDGINGVASSALS " ..
               vassal:name() .. " likes " .. owning_faction_key .. " so sharing vision and buffing allegiance.");
          end
          for _, region in model_pairs(vassal:region_list()) do
               cm:make_region_visible_in_shroud(owning_faction_key, region:name());
          end
          wc:set_faction_favour_points_toward_faction(owning_faction, vassal, 9);
          cm:treasury_mod(vassal:name(), 350);
     end
end


skaven_good_times = {
     wh2_main_skv_clan_skyre = "wh2_dlc12_under_empire_annexation_doomsday_1",
     wh2_main_skv_clan_pestilens = "wh2_dlc14_under_empire_annexation_plague_cauldron_1",
};

local function fudging_vassals_wsr(world)
     status, details = xpcall(
          function()
               --Check for dead factions first. Otherwise when they come back, we won't
               --realize that their diplomacy should be restricted, and then we'll get
               --dragged into another war.
               local dead_needs_adjusting = {};
               for faction_key, faction_is_vassal in pairs(vassal_diplomacy_adjusted) do
                    if faction_is_vassal then
                         local current_faction = cm:get_faction(faction_key);
                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG fudging_vassals_wsr " ..
                              faction_key ..
                              " (" ..
                              tostring(faction_is_vassal) ..
                              ") is_dead = " ..
                              tostring(current_faction:is_dead()) ..
                              ", faction_is_alive = " .. tostring(cm:faction_is_alive(current_faction)));
                         end
                         if current_faction and current_faction:is_dead() then
                              out("FUDGINGVASSALS " .. faction_key .. " was a vassal, now they are dead.");
                              table.insert(dead_needs_adjusting, faction_key);
                         end
                    end
               end

               for _, faction_key in pairs(dead_needs_adjusting) do
                    enable_diplomacy_for_former_vassal(faction_key);
                    local current_faction = cm:get_faction(faction_key);
                    enable_attrition_for_former_vassal(current_faction);
               end


               --new round, start fresh.
               local vassal_protectors = {};
               for _, faction_a in model_pairs(world:faction_list()) do
                    if faction_a:is_vassal() and not faction_a:is_dead() then
                         local vassal_key = faction_a:name();
                         --This may feel like a failure but it's unavoidable when
                         --everyone else is running their own mods that affect
                         --everyone's diplomacy.
                         disable_diplomacy_for_vassal(vassal_key);

                         local protector_key = faction_a:master():name();
                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG " .. protector_key .. " is responsible for " .. vassal_key);
                         end
                         if vassal_protectors[protector_key] then
                              table.insert(vassal_protectors[protector_key], vassal_key);
                         else
                              vassal_protectors[protector_key] = { vassal_key };
                         end

                         disable_attrition_for_vassal(faction_a);
                    else
                         local non_vassal_key = faction_a:name();
                         if vassal_diplomacy_adjusted[non_vassal_key] then
                              out("FUDGINGVASSALS " ..
                              non_vassal_key .. " is no longer a vassal, unrestricting diplomacy.");
                              enable_diplomacy_for_former_vassal(non_vassal_key);
                              enable_attrition_for_former_vassal(faction_a);
                         end

                         --[[
					for _, nvmf in model_pairs (faction_a:military_force_list()) do
						if nvmf:has_effect_bundle ("fv_vassal_leader_buff") then
							out ("FUDGINGVASSALS " .. cm:campaign_obj_to_string (nvmf) .. " shouldn't have a buff, removing.");
							cm:remove_effect_bundle_from_force ("fv_vassal_leader_buff", nvmf:command_queue_index());
						end
					end
--]]
                    end
               end

               for protector_key, our_vassals in pairs(vassal_protectors) do
                    local protector = cm:get_faction(protector_key);
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG fudging_vassals_wsr processing vassals for " .. protector_key);
                    end

                    local seducible_vassals = {};
                    local undercity_slots = {};

                    for _, vassal_key in pairs(our_vassals) do
                         local vassal = cm:get_faction(vassal_key);

                         if vassal:culture() == "wh2_main_skv_skaven" then
                              if not skaven_good_times[vassal:name()] then
                                   skaven_good_times[vassal:name()] = "wh2_dlc12_under_empire_annexation_war_camp";
                              end
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG looking @ Skaven vassal " ..
                                   cm:campaign_obj_to_string(vassal));
                              end
                              for j, fsm in model_pairs(vassal:foreign_slot_managers()) do
                                   local region = fsm:region();
                                   local protectors_region = not region:is_abandoned() and
                                   (vassal:master():is_faction(region:owning_faction()) or region:owning_faction():is_ally_vassal_or_client_state_of(vassal:master()));
                                   if debug_mode then
                                        out("FUDGINGVASSALS \tundercity #" ..
                                        tostring(j) ..
                                        ": " ..
                                        cm:campaign_obj_to_string(region) ..
                                        ", protector's region: " .. tostring(protectors_region));
                                   end
                                   if protectors_region then
                                        for k, slot in model_pairs(fsm:slots()) do
                                             if slot:has_building() then
                                                  local building_key = slot:building();
                                                  local problem = false;
                                                  for _, chain in pairs(skaven_good_times) do
                                                       if building_key:starts_with(chain) then
                                                            problem = true;
                                                            break;
                                                       end
                                                  end
                                                  if debug_mode then
                                                       out("FUDGINGVASSALS DEBUG \t\tslot #" ..
                                                       tostring(k) ..
                                                       ": " ..
                                                       slot:building() .. ", potential problem: " .. tostring(problem));
                                                  end
                                                  if problem then
                                                       table.insert(undercity_slots, slot);
                                                  end
                                             end
                                        end
                                   end
                              end
                         end

                         --Check which of these vassals is an insufferable simp.
                         if not vassal:pooled_resource_manager():resource("wh3_main_sla_seductive_influence"):is_null_interface() then
                              if vassal:pooled_resource_manager():resource("wh3_main_sla_seductive_influence"):value() >= 100 or
                                  vassal:has_effect_bundle("wh3_main_bundle_seductive_influence_max") or
                                  vassal:has_effect_bundle("wh3_main_bundle_seductive_influence_max_chaos")
                              then
                                   seducible_vassals[vassal_key] = true;
                              end
                         end

                         --	make sure the vassal isn't at war with anyone the protector isn't.
                         for _, venemy in model_pairs(vassal:factions_at_war_with()) do
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG checking if " ..
                                   vassal_key ..
                                   "'s protector (" ..
                                   protector_key ..
                                   ") is at war with vassal enemy " ..
                                   venemy:name() .. ": " .. tostring(protector:at_war_with(venemy)));
                              end
                              if not protector:at_war_with(venemy) then
                                   if venemy:is_dead() then
                                        if debug_mode then
                                             out("FUDGINGVASSALS DEBUG cannot force peace between " ..
                                             venemy:name() ..
                                             " and " .. vassal_key .. " because the former doesn't exist.");
                                        end
                                   elseif diplomacy_excluded[venemy:name()] then
                                        if debug_mode then
                                             out("FUDGINGVASSALS DEBUG cannot force peace between " ..
                                             venemy:name() ..
                                             " and " .. vassal_key .. " because diplomacy is restricted!");
                                        end
                                   elseif "wh2_dlc10_def_blood_voyage" == vassal_key then
                                        if debug_mode then
                                             out(
                                             "FUDGINGVASSALS not forcing peace between Blood Voyage and anyone because LMAO GET REKT.");
                                        end
                                   else
                                        out("FUDGINGVASSALS forcing peace between " ..
                                        venemy:name() ..
                                        " and " ..
                                        vassal_key .. " because " .. protector_key .. " is not at war with them.");
                                        cm:force_make_peace(vassal_key, venemy:name());
                                   end
                              end
                         end

                         --	now who is the protector at war with that our our_vassals aren't?
                         for _, enemy in model_pairs(protector:factions_at_war_with()) do
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG checking if " ..
                                   vassal_key ..
                                   " is at war with " ..
                                   protector_key ..
                                   "'s enemy " ..
                                   enemy:name() ..
                                   ": at war? " ..
                                   tostring(vassal:at_war_with(enemy)) ..
                                   ", quest battle faction? " .. tostring(enemy:is_quest_battle_faction()));
                              end
                              if not (vassal:at_war_with(enemy) or enemy:is_quest_battle_faction()) then
                                   out("FUDGINGVASSALS forcing " ..
                                   vassal_key ..
                                   " to stop being lazy and fight " ..
                                   enemy:name() .. " because " .. protector_key .. " is at war with them.");
                                   --that 5th parameter is NOT a typo, it is in fact Morbin' time.
                                   cm:force_declare_war(vassal_key, enemy:name(), false, false, true);
                              end
                         end


                         --	prevent breaking but only for this protector's vassals.
                         --	don't worry about undoing it later because we don't care.
                         stop_vassal_breakage(protector_key, vassal_key);
                    end

                    for _, slot in pairs(undercity_slots) do
                         out("FUDGINGVASSALS removing " ..
                         slot:building() ..
                         " from " .. slot:slot_manager():region():name() .. " before it causes a problem!");
                         cm:foreign_slot_instantly_upgrade_building(slot);
                    end

                    --	slaanesh's vassals hate each other, which is kinda dumb
                    if Seductive_Influence ~= nil and Seductive_Influence:faction_is_slaanesh(protector) then
                         for svi, vassal_a_key in pairs(our_vassals) do
                              if seducible_vassals[vassal_a_key] then
                                   for svj, vassal_b_key in pairs(our_vassals) do
                                        if svi ~= svj and seducible_vassals[vassal_b_key] then
                                             if debug_mode then
                                                  out("FUDGINGVASSALS DEBUG making " ..
                                                  vassal_a_key ..
                                                  " and " ..
                                                  vassal_b_key .. " like each other because they're both seduced.");
                                             end
                                             fv_apply_dilemma_diplomatic_bonus(vassal_a_key, vassal_b_key, 2);
                                        end
                                   end
                              end
                         end
                    end

                    if protector:is_human() then
                         if debug_mode then
                              out("FUDGINGVASSALS " ..
                              protector_key .. " is human, let's bump vassal allegiance and also share vision.");
                         end
                         for _, vassal_key in pairs(our_vassals) do
                              local vassal = cm:get_faction(vassal_key);
                              adjust_situation_by_attitude(protector, vassal);

                              --[[
						--only a human protector's vassals should get a buff.
						if vassal:has_faction_leader() and
						   vassal:faction_leader():has_military_force() and
						   not vassal:faction_leader():military_force():has_effect_bundle ("fv_vassal_leader_buff")
						then
							out ("FUDGINGVASSALS " .. vassal_key .. "'s leader gets a buff.");
							cm:apply_effect_bundle_to_characters_force ("fv_vassal_leader_buff", vassal:faction_leader():command_queue_index(), -1);
						end
--]]
                         end
                    end

                    fv_protect_owner_from_attrition(protector);
               end

               out("FUDGINGVASSALS fudging_vassals_wsr finished turn #" .. tostring(cm:model():turn_number()));
          end,
          function(err) out("FUDGINGVASSALS ERROR fudging_vassals_wsr: " .. tostring(err)); end
     );
     if not status then return false; else return details; end
end


--this used to be the entirety of the code,
--the big problem is the multiplayer "everyone goes at once" change in TW3.
local function fudging_vassals_fts(human_faction)
     status, details = xpcall(
          function()
               local human_faction_key = human_faction:name();
               fv_reset_pending_dilemma(human_faction_key);
               fv_check_dilemma_queue(human_faction_key);
          end,
          function(err) out("FUDGINGVASSALS ERROR fudging_vassals_fts: " .. tostring(err)); end
     );
     if not status then return false; else return details; end
end


--The main assumption here was that choice 0 == take action, and other choices can be ignored.
--Except that didn't take into account 3-choice dilemmas, so now we have callbacks for choice0 and choice1.
--EXCEPT that there's no such thing as 3-choice dilemmas, only 2 or 4.
local function setup_dilemma_handler(dilemma_key, execute_dilemma_choice0_callback, execute_dilemma_choice1_callback,
                                     execute_dilemma_choice2_callback, execute_dilemma_choice3_callback)
     core:add_listener(
          "fv_" .. dilemma_key .. "_DCME",
          "DilemmaChoiceMadeEvent",
          function(context)
               return context:dilemma() == dilemma_key
          end,
          function(context)
               local prefix = "FUDGINGVASSALS fv_" .. dilemma_key .. "_DCME: ";
               local choice = context:choice();
               local player_key = context:faction():name();
               local payload_string = fv_get_dilemma_payload(player_key);
               local ps_debug;
               if is_string(payload_string) then
                    ps_debug = payload_string;
               elseif is_table(payload_string) then
                    ps_debug = table.tostring(payload_string);
               else
                    ps_debug = "payload is unexpected type: " .. tostring(payload_string);
               end
               out(prefix ..
               player_key ..
               " selected " .. tostring(choice) .. " for " .. context:dilemma() .. " with payload " .. ps_debug);

               if 0 == choice and type(execute_dilemma_choice0_callback) == 'function' then
                    execute_dilemma_choice0_callback(player_key, payload_string);
                    if debug_mode then
                         out(prefix .. " execute_dilemma_choice0_callback ran successfully.");
                    end
               elseif 1 == choice and type(execute_dilemma_choice1_callback) == 'function' then
                    execute_dilemma_choice1_callback(player_key, payload_string);
                    if debug_mode then
                         out(prefix .. " execute_dilemma_choice1_callback ran successfully.");
                    end
               elseif 2 == choice and type(execute_dilemma_choice2_callback) == 'function' then
                    execute_dilemma_choice2_callback(player_key, payload_string);
                    if debug_mode then
                         out(prefix .. " execute_dilemma_choice2_callback ran successfully.");
                    end
               elseif 3 == choice and type(execute_dilemma_choice3_callback) == 'function' then
                    execute_dilemma_choice3_callback(player_key, payload_string);
                    if debug_mode then
                         out(prefix .. " execute_dilemma_choice3_callback ran successfully.");
                    end
               end

               fv_reset_pending_dilemma(player_key);
               fv_check_dilemma_queue(player_key);
          end,
          true
     );
end


function fudging_vassals()
     fv_fix_dilemma_queue_for_multiplayer();

     core:add_listener(
          "BetterBehavedAlliesCopy_fts",
          "ScriptEventHumanFactionTurnStart",
          true,
          function(context)
               fudging_vassals_fts(context:faction())
          end,
          true
     );

     core:add_listener(
          "fudgingvassals_wsr",
          "WorldStartRound",
          true,
          function(context)
               fudging_vassals_wsr(context:world())
          end,
          true
     );

     --If we subjugate a faction, do we return any regions in their home
     --province to get them back up to speed faster?
     core:add_listener(
          "fv_factionsubjugated",
          "FactionSubjugatesOtherFaction",
          true,
          function(context)
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_factionsubjugated faction: " ..
                    cm:campaign_obj_to_string(context:faction()));
                    out("FUDGINGVASSALS DEBUG fv_factionsubjugated other faction: " ..
                    cm:campaign_obj_to_string(context:other_faction()));
                    out("FUDGINGVASSALS DEBUG fv_factionsubjugated other faction's master: " ..
                    cm:campaign_obj_to_string(context:other_faction():master()));
               end

               local vassal = context:other_faction();
               local vassal_name = vassal:name();
               if not vassal:is_vassal() then
                    out("FUDGINGVASSALS fv_factionsubjugated " .. vassal_name .. " was subjugated but not vassalized.");
                    return;
               end

               local vassal_owner = vassal:master();
               local protector_key = vassal_owner:name();

               --let's do this testing up front before we try to determine what gets rearranged.
               if vassal_owner:subculture() == "wh_main_sc_chs_chaos" then
                    local vassal_has_non_dark_fortress_region = false;
                    local moveme = {};

                    for i, region in model_pairs(vassal:region_list()) do
                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG looking at vassal region #" ..
                              tostring(i) ..
                              ": " ..
                              region:name() ..
                              ", dark fortress? " ..
                              tostring(region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group")));
                         end
                         if region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group") then
                              table.insert(moveme, region:name());
                         else
                              vassal_has_non_dark_fortress_region = true;
                         end
                    end

                    if #moveme > 0 and not vassal_has_non_dark_fortress_region then
                         if debug_mode then
                              out(
                              "FUDGINGVASSALS DEBUG this vassal has multiple dark fortresses but no other regions?! Let them keep one.");
                         end
                         table.remove(moveme, 1);
                    end

                    for _, region_key in pairs(moveme) do
                         fv_transfer_dark_fortress_from_vassal_to_chaos_faction(region_key, protector_key);
                    end
               end

               local needs_new_protector = {};
               for _, met_faction in model_pairs(vassal:factions_met()) do
                    if met_faction:is_vassal_of(vassal) then
                         table.insert(needs_new_protector, met_faction:name());
                    end
               end
               for _, grandchild_key in pairs(needs_new_protector) do
                    out("FUDGINGVASSALS " .. protector_key .. " will assume full control of " .. grandchild_key);
                    cm:force_make_vassal(protector_key, grandchild_key);
               end

               if vassal_owner:is_human() then
                    --cheap diplomatic pop to reduce likelihood of AI attempting to break vassal.
                    --yeah we disabled AI's ability to break vassal, but when has that ever stopped them?
                    fv_apply_dilemma_diplomatic_bonus(vassal_name, protector_key, 6);

                    out("FUDGINGVASSALS " ..
                    vassal_name ..
                    " was subjugated by human player " ..
                    protector_key .. ".  Disabling diplomacy for vassal right now instead of waiting.");
                    disable_diplomacy_for_vassal(vassal_name);
                    disable_attrition_for_vassal(vassal);
                    stop_vassal_breakage(protector_key, vassal_name);

                    local owner_has_region_not_in_vassal_home_province = false;
                    local owner_has_region_in_vassal_home_province = false;
                    if vassal:has_home_region() then
                         for i, region in model_pairs(vassal_owner:region_list()) do
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG looking at vassal_owner region #" ..
                                   tostring(i) .. ": " .. region:name());
                              end
                              if region:province_name() == vassal:home_region():province_name() and
                                  not (region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group") and
                                       vassal_owner:subculture() == "wh_main_sc_chs_chaos")
                              then
                                   if debug_mode then
                                        out("FUDGINGVASSALS DEBUG vassal owner also owns a region " ..
                                        vassal_owner:region_list():item_at(i):name() ..
                                        " in vassal's province " .. vassal:home_region():province_name());
                                   end
                                   owner_has_region_in_vassal_home_province = true;
                                   break;
                              end
                         end
                         for i = 0, vassal_owner:region_list():num_items() - 1 do
                              if debug_mode then
                                   out("FUDGINGVASSALS DEBUG looking at vassal_owner region #" .. tostring(i));
                              end
                              if vassal_owner:region_list():item_at(i):province_name() ~= vassal:home_region():province_name() then
                                   if debug_mode then
                                        out("FUDGINGVASSALS DEBUG vassal owner also owns a region " ..
                                        vassal_owner:region_list():item_at(i):name() ..
                                        " outside of vassal's home province");
                                   end
                                   owner_has_region_not_in_vassal_home_province = true;
                                   break;
                              end
                         end
                    end

                    --TODO TW3 does the assumption that the vassal has a home region mean we're ignoring beastmen vassals??
                    if owner_has_region_in_vassal_home_province and owner_has_region_not_in_vassal_home_province then
                         --vassal owner can afford to give up regions to vassal
                         --AND vassal owner has regions *to* give to vassal.

                         local pcdt;
                         if vassal_manager:is_ok_to_confederate(vassal_owner, vassal) then
                              pcdt = {
                                   type = "subjugate_or_confederate",
                                   region_key = vassal:home_region():name(),
                                   faction_key = protector_key,
                                   vassal_key = vassal_name
                              };
                         else
                              pcdt = {
                                   type = "subjugation",
                                   region_key = vassal:home_region():name(),
                                   faction_key = protector_key,
                                   vassal_key = vassal_name
                              };
                         end

                         fv_enqueue_dilemma(pcdt);
                    elseif vassal:has_home_region() then
                         if vassal_manager:is_ok_to_confederate(vassal_owner, vassal) then
                              out("FUDGINGVASSALS same subculture, let's ask about confederation.");

                              local pcdt = {
                                   type = "confederation",
                                   region_key = vassal:home_region():name(),
                                   faction_key = protector_key,
                                   vassal_key = vassal_name
                              }

                              fv_enqueue_dilemma(pcdt);
                         end
                    end

                    --rearrange ownership as necessary:
                    --	Does the player own any regions in the vassal's home province?
                    --	Do the player's other vassals own regions in the vassal's home province?
                    --TODO TW3 do you see how chaining vassalage will screw you?
                    if vassal:has_home_region() then
                         local vassal_province_key = vassal:home_region():province_name();
                         for j = 0, vassal_owner:factions_met():num_items() - 1 do
                              if vassal_owner:factions_met():item_at(j):is_vassal_of(vassal_owner) then
                                   local other_vassal = vassal_owner:factions_met():item_at(j);
                                   if other_vassal:has_home_region() and other_vassal:home_region():province_name() ~= vassal_province_key then
                                        --other vassal's home province is not in new vassal's home province.
                                        --so check if new vassal has regions that could belong to other vassal.
                                        for i = 0, vassal:region_list():num_items() - 1 do
                                             local region = vassal:region_list():item_at(i);
                                             if vassal_province_key ~= region:province_name() and other_vassal:home_region():province_name() == region:province_name() then
                                                  out("FUDGINGVASSALS " ..
                                                  vassal_name ..
                                                  " owns " ..
                                                  region:name() ..
                                                  " which is in " .. other_vassal:name() .. "'s home province!");
                                                  local pcdt = {
                                                       type = "vassal capture",
                                                       region_key = region:name(),
                                                       faction_key = protector_key,
                                                       vassal_key = vassal_name
                                                  }

                                                  fv_enqueue_dilemma(pcdt);
                                             end
                                        end

                                        --now check if other vassal has regions that could belong to new vassal.
                                        for i = 0, other_vassal:region_list():num_items() - 1 do
                                             local region = other_vassal:region_list():item_at(i);
                                             if region:province_name() == vassal_province_key and other_vassal:home_region():province_name() ~= region:province_name() then
                                                  out("FUDGINGVASSALS " ..
                                                  other_vassal:name() ..
                                                  " owns " ..
                                                  region:name() .. " which is in " .. vassal_name .. "'s home province!");
                                                  local pcdt = {
                                                       type = "vassal capture",
                                                       region_key = region:name(),
                                                       faction_key = protector_key,
                                                       vassal_key = other_vassal:name()
                                                  }

                                                  fv_enqueue_dilemma(pcdt);
                                             end
                                        end
                                   end
                              end
                         end
                    end
               else
                    --an AI faction subjugated another... but is the protector *also* a vassal??
                    if vassal_owner:is_vassal() then
                         local grandpa_key = vassal_owner:master():name();
                         out("FUDGINGVASSALS but " ..
                         protector_key .. " is a vassal of " .. grandpa_key .. "!  Let's try to fix that");
                         cm:force_make_vassal(grandpa_key, vassal_name);
                    end
               end
          end,
          true
     );


     setup_dilemma_handler(
          "fudging_vassals_subjugation_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);

               local vassal = region:owning_faction();
               local province_name = region:province_name();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " ..
                    vassal:name() .. " subjugated in " .. region:name() .. " which is in " .. province_name);
               end

               local moveme = {};
               local human_faction = cm:get_faction(player_key);
               if human_faction:subculture() == "wh_main_sc_chs_chaos" then
                    --Chaos gets special treatment for Dark Fortresses!
                    for _, region in model_pairs(human_faction:region_list()) do
                         if region:province_name() == province_name and
                             not region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group")
                         then
                              --we don't want to modify a list that we're iterating over x_x
                              table.insert(moveme, region:name());
                         end
                    end
               else
                    for _, region in model_pairs(human_faction:region_list()) do
                         if region:province_name() == province_name then
                              table.insert(moveme, region:name());
                         end
                    end
               end

               for i = 1, #moveme do
                    fv_transfer_region_to_faction(moveme[i], vassal:name());
               end
          end
     );


     setup_dilemma_handler(
          "fudging_vassals_confederate_return_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);

               local vassal = region:owning_faction();
               local province_name = region:province_name();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " ..
                    vassal:name() .. " subjugated in " .. region:name() .. " which is in " .. province_name);
               end

               local moveme = {};
               local human_faction = cm:get_faction(player_key);
               if human_faction:subculture() == "wh_main_sc_chs_chaos" then
                    --Chaos gets special treatment for Dark Fortresses!
                    for _, region in model_pairs(human_faction:region_list()) do
                         if region:province_name() == province_name and
                             not region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group")
                         then
                              --we don't want to modify a list that we're iterating over x_x
                              table.insert(moveme, region:name());
                         end
                    end
               else
                    for _, region in model_pairs(human_faction:region_list()) do
                         if region:province_name() == province_name then
                              table.insert(moveme, region:name());
                         end
                    end
               end

               for i = 1, #moveme do
                    fv_transfer_region_to_faction(moveme[i], vassal:name());
               end
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);

               local vassal = region:owning_faction();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " .. player_key .. " will confederate " .. vassal:name());
               end
               cm:force_confederation(player_key, vassal:name());
          end
     );


     setup_dilemma_handler(
          "fudging_vassals_confederation_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);

               local vassal = region:owning_faction();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " .. player_key .. " will aserate " .. vassal:name());
               end
               cm:force_confederation(player_key, vassal:name());
          end
     );


     --If a human player liberates a faction, they *should* be liberated
     --as a vassal, so give the player that option, keeping in mind that
     --there are a ton of mods that do that as well.
     core:add_listener(
          "fv_factionliberated",
          "FactionLiberated",
          function(context)
               return context:liberating_character():faction():is_human();
          end,
          function(context)
               local liberator_key = context:liberating_character():faction():name();
               local last_liberated = context:faction():name();
               dilemma_workspace[liberator_key] = last_liberated;
               out("FUDGINGVASSALS " .. last_liberated .. " was liberated by " .. liberator_key);
               --the 1.5 second delay should guard against someone else's mod doing the same thing, I hope??
               cm:callback(function()
                    cm:make_diplomacy_available(liberator_key, last_liberated);
                    local liberator = cm:get_faction(liberator_key);
                    local liberated = cm:get_faction(last_liberated);
                    if not liberated:is_vassal_of(liberator) then
                         local pcdt = {
                              type = "liberate",
                              faction_key = liberator_key,
                              vassal_key = last_liberated,
                         };
                         fv_enqueue_dilemma(pcdt);
                    else
                         out("FUDGINGVASSALS " ..
                         last_liberated .. " is already " .. liberator_key .. "'s vassal, ignoring.");
                    end
               end, 1.5);
          end,
          true
     );

     setup_dilemma_handler(
          "fudging_vassals_liberate_dilemma",
          function(player_key, payload_str)
               local liberated_faction_key = payload_str;

               core:add_listener(
                    "fudging_vassals_liberate_dilemma" .. player_key .. liberated_faction_key,
                    "FactionSubjugatesOtherFaction",
                    function(context)
                         return context:faction():name() == player_key and
                         context:other_faction():name() == liberated_faction_key;
                    end,
                    function(context)
                         if context:other_faction():has_home_region() then
                              local region_cqi = context:other_faction():home_region():cqi();
                              cm:callback(function()
                                   cm:heal_garrison(region_cqi);
                                   out("FUDGINGVASSALS garrison should be healed now.");
                              end, 0.1);
                         else
                              out("FUDGINGVASSALS " .. context:other_faction():name() .. " doesn't have a home region!");
                         end
                    end,
                    false
               );

               cm:force_make_vassal(player_key, liberated_faction_key);
          end
     );


     setup_dilemma_handler(
          "fudging_vassals_empire_return_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);
               local vassal_key = region:owning_faction():name();
               local elector_key = get_elector_faction_from_region(region);
               local emp_faction_key = EMPIRE_ELECTOR_COUNTS[elector_key].faction_key;

               out("FUDGINGVASSALS transferring " .. region_key .. " from " .. vassal_key .. " to " .. emp_faction_key);
               fv_transfer_region_to_faction(region_key, emp_faction_key);
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction(region_key, player_key);
          end
     );


     setup_dilemma_handler(
          "fudging_vassals_region_capture_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction(region_key, player_key);
          end
     );


     setup_dilemma_handler(
          "fudging_vassals_region_capture_dilemma_chd",
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction_chd(region_key, player_key, "outpost");
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction_chd(region_key, player_key, "factory");
          end
     );


     --If a vassal captured a settlement, queue that for processing at the
     --vassal owner's turn start.
     core:add_listener(
          "fv_capture_rfce",
          "RegionFactionChangeEvent",
          function(context)
               local pf = context:previous_faction()
               local region = context:region();

               return (not region:is_abandoned()) and
                   region:owning_faction():is_vassal() and
                   ((not pf) or pf:is_null_interface() or (not region:owning_faction():is_vassal_of(pf)));
          end,
          function(context)
               local region = context:region();
               local region_key = region:name();

               local conquerer = region:owning_faction();
               local vassal_owner = false;

               local hf = cm:get_human_factions();
               for i = 1, #hf do
                    local fobj = cm:get_faction(hf[i]);
                    if conquerer:is_vassal_of(fobj) then
                         out("FUDGINGVASSALS fv_capture_rfce " .. conquerer:name() .. " is a vassal of " .. hf[i]);
                         vassal_owner = cm:get_faction(hf[i]);
                         break;
                    end
               end

               if not vassal_owner then
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG fv_capture_rfce vassal_owner isn't human, so we don't care.");
                    end
                    return false;
               end

               local vassal_key = conquerer:name();

               --is this region outside of the vassal's home region? if yes, then ask if we should keep it
               out("FUDGINGVASSALS fv_capture_rfce " ..
               conquerer:name() .. " home province " .. conquerer:home_region():province_name());
               out("FUDGINGVASSALS fv_capture_rfce " .. region_key .. " is in " .. region:province_name());
               if conquerer:home_region():province_name() ~= region:province_name() then
                    local pf_key = false;
                    if not context:previous_faction():is_null_interface() then
                         pf_key = context:previous_faction():name();
                    end
                    --ask about it next turn.
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG " ..
                         vassal_key ..
                         " captured " .. region_key .. " from " .. (pf_key or "no one") .. ", queued dilemma for later.");
                    end
                    local pcdt = {
                         type = "vassal capture",
                         region_key = region_key,
                         faction_key = vassal_owner:name(),
                         vassal_key = vassal_key,
                         previous_owner = pf_key,
                    };

                    fv_enqueue_dilemma(pcdt);
               end
          end,
          true
     );


     --Did a human player capture a region in an unsuitable climate?
     --If so, check if a nearby vassal can take it!
     core:add_listener(
          "fv_player_rfce",
          "RegionFactionChangeEvent",
          function(context)
               local region = context:region();
               local pf = context:previous_faction()
               return (not region:is_abandoned()) and
                   region:owning_faction():is_human() and
                   ((not pf) or pf:is_null_interface() or (not pf:is_vassal_of(region:owning_faction())));
          end,
          function(context)
               local region = context:region();
               local human_faction = region:owning_faction();

               if region:is_contained_in_region_group("wh3_dlc20_dark_fortress_region_group") and
                   human_faction:subculture() == "wh_main_sc_chs_chaos"
               then
                    out("FUDGINGVASSALS fv_player_rfce " ..
                    human_faction:name() ..
                    " captured " .. region:name() .. " but that's a Dark Fortress!  No vassal should get that!");
                    return;
               end

               local player_key = human_faction:name();

               local vassal_key = vassal_manager:find_best_for_region(region);
               if vassal_key then
                    local vassal_faction = cm:get_faction(vassal_key);
                    if debug_mode then
                         out("FUDGINGVASSALS DEBUG vassal_key = " ..
                         vassal_key ..
                         ", vassal has home region: " ..
                         tostring(vassal_faction:has_home_region()) ..
                         ", region province name: " ..
                         region:province_name() ..
                         ", player's climate suitability: " ..
                         human_faction:get_climate_suitability(region:settlement():get_climate()));
                    end

                    if vassal_faction and
                        vassal_faction:has_home_region() and
                        vassal_faction:home_region():province_name() == region:province_name()
                    then
                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG " ..
                              region:province_name() .. " is " .. vassal_key .. "'s home province.");
                         end
                         local pcdt = {
                              type = "home province",
                              region_key = region:name(),
                              faction_key = player_key,
                              vassal_key = vassal_key
                         }

                         fv_enqueue_dilemma(pcdt);
                    elseif human_faction:get_climate_suitability(region:settlement():get_climate()) ~= "suitability_good" then
                         if debug_mode then
                              out("FUDGINGVASSALS DEBUG " ..
                              region:name() .. " is an unsuitable climate for " .. player_key);
                         end
                         local pcdt = {
                              type = "climate mismatch",
                              region_key = region:name(),
                              faction_key = player_key,
                              vassal_key = vassal_key
                         }

                         fv_enqueue_dilemma(pcdt);
                    else
                         out("FUDGINGVASSALS couldn't justify offering " .. region:name() .. " to " .. vassal_key);
                    end
               end
          end,
          true
     );

     setup_dilemma_handler(
          "fudging_vassals_climate_dilemma",
          function(player_key, payload_t)
               if is_table(payload_t) then
                    fv_transfer_region_to_faction(payload_t[1], payload_t[2]);
               end
          end,
          function(player_key, payload_t)
               if is_table(payload_t) then
                    fv_transfer_region_to_faction(payload_t[1], payload_t[3]);
               end
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_climate_dilemma_single",
          function(player_key, payload_t)
               if is_table(payload_t) then
                    fv_transfer_region_to_faction(payload_t[1], payload_t[2]);
               end
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_home_province_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);
               if region then
                    local vassal_key = vassal_manager:find_best_for_region(region);
                    if vassal_key then
                         fv_transfer_region_to_faction(region_key, vassal_key);
                    end
               end
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_another_home_province_dilemma",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);
               if region then
                    local vassal_owner = cm:get_faction(player_key);

                    local other_vassal_key;
                    local other_vassals = vassal_manager:find_already_home_in_province(region, vassal_owner);
                    if #other_vassals == 1 then
                         other_vassal_key = other_vassals[1][1];
                    end

                    if other_vassal_key then
                         fv_transfer_region_to_faction(region_key, other_vassal_key);
                    end
               end
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);
               if region then
                    fv_transfer_region_to_faction(region_key, player_key);
               end
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_another_home_province_dilemma_chd",
          function(player_key, payload_str)
               local region_key = payload_str;
               local region = cm:get_region(region_key);
               local vassal_owner = cm:get_faction(player_key);

               local other_vassal_key;
               local other_vassals = vassal_manager:find_already_home_in_province(region, vassal_owner);
               if #other_vassals == 1 then
                    other_vassal_key = other_vassals[1][1];
               end

               if other_vassal_key then
                    fv_transfer_region_to_faction(region_key, other_vassal_key);
               end
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction_chd(region_key, player_key, "outpost");
          end,
          function(player_key, payload_str)
               local region_key = payload_str;
               fv_transfer_region_to_faction_chd(region_key, player_key, "factory");
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_another_home_province_multi_dilemma",
          function(player_key, payload_str)
               local guaranteed_desync = dilemma_workspace[player_key];
               local region = cm:get_region(guaranteed_desync.region_key);
               if region then
                    local vassal_owner = cm:get_faction(player_key);
                    local other_vassal = cm:get_faction(guaranteed_desync.vassal1);
                    if other_vassal:is_vassal_of(vassal_owner) then
                         fv_transfer_region_to_faction(region:name(), other_vassal:name());
                    end
               end
          end,
          function(player_key, payload_str)
               local guaranteed_desync = dilemma_workspace[player_key];
               local region = cm:get_region(guaranteed_desync.region_key);
               if region then
                    local vassal_owner = cm:get_faction(player_key);
                    local other_vassal = cm:get_faction(guaranteed_desync.vassal2);
                    if other_vassal:is_vassal_of(vassal_owner) then
                         fv_transfer_region_to_faction(region:name(), other_vassal:name());
                    end
               end
          end,
          function(player_key, payload_str)
               local region_key = dilemma_workspace[player_key].region_key;
               local region = cm:get_region(region_key);
               if region then
                    fv_transfer_region_to_faction(region_key, player_key);
               end
          end
     );

     setup_dilemma_handler(
          "fudging_vassals_another_home_province_multi_dilemma_chd",
          function(player_key, payload_str)
               local guaranteed_desync = dilemma_workspace[player_key];
               local region = cm:get_region(guaranteed_desync.region_key);
               if region then
                    local vassal_owner = cm:get_faction(player_key);
                    local other_vassal = cm:get_faction(guaranteed_desync.vassal1);
                    if other_vassal:is_vassal_of(vassal_owner) then
                         fv_transfer_region_to_faction(region:name(), other_vassal:name());
                    end
               end
          end,
          function(player_key, payload_str)
               local guaranteed_desync = dilemma_workspace[player_key];
               local region = cm:get_region(guaranteed_desync.region_key);
               if region then
                    local vassal_owner = cm:get_faction(player_key);
                    local other_vassal = cm:get_faction(guaranteed_desync.vassal2);
                    if other_vassal:is_vassal_of(vassal_owner) then
                         fv_transfer_region_to_faction(region:name(), other_vassal:name());
                    end
               end
          end,
          function(player_key, payload_str)
               local region_key = dilemma_workspace[player_key].region_key;
               fv_transfer_region_to_faction_chd(region_key, player_key, "outpost");
          end,
          function(player_key, payload_str)
               local region_key = dilemma_workspace[player_key].region_key;
               fv_transfer_region_to_faction_chd(region_key, player_key, "factory");
          end
     );

     -- handle the dragon emperors wrath compass ability
     core:add_listener(
          "emperors_wrath_activated",
          "WoMCompassUserActionTriggeredEvent",
          function(context)
               return context:action() == "apply_attrition_to_enemies_in_direction"
          end,
          function(context)
               local invoking_faction = context:faction();
               for _, current_faction in model_pairs(invoking_faction:vassals()) do
                    out("FUDGINGVASSALS " ..
                    current_faction:name() ..
                    " is " .. invoking_faction:name() .. "'s vassal, protect them from the Dragon Emperor's wrath!");
                    cm:apply_effect_bundle("realm_of_derp_attrition_immunity_compass_bundle", current_faction:name(), 3);
               end
          end,
          true
     );

     local ritual_x_attrition = {
          ["wh2_dlc09_ritual_tmb_khsar"] = { ["turns"] = 5, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_storm_standstorm" },
          ["wh2_dlc11_ritual_cst_sea_mist"] = { ["turns"] = 5, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_mist" },
          ["wh3_main_ritual_ksl_winter_dazh"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_dazh_upgraded"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_salyak"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_salyak_upgraded"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_tor"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_tor_upgraded"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_ursun"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh3_main_ritual_ksl_winter_ursun_upgraded"] = { ["turns"] = 10, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_kislev_winter" },
          ["wh2_dlc13_rituals_lzd_allegiance"] = { ["turns"] = 5, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_lizard_defenders" },
          ["wh2_main_ritual_lzd_sotek"] = { ["turns"] = 15, ["effect_bundle"] = "fv_ritual_attrition_immunity_eb_hostile_territory" },
     };

     core:add_listener(
          "fv_ritual_attrition_listener",
          "RitualCompletedEvent",
          function(context)
               return not not ritual_x_attrition[context:ritual():ritual_key()];
          end,
          function(context)
               local performing_faction = context:performing_faction();
               local owner = performing_faction;
               local ritual_key = context:ritual():ritual_key();
               local rxa = ritual_x_attrition[ritual_key];

               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_ritual_attrition_listener " ..
                    performing_faction:name() .. " completed " .. ritual_key);
               end

               if performing_faction:is_vassal() then
                    owner = performing_faction:master();
                    out("FUDGINGVASSALS " ..
                    owner:name() ..
                    " is " .. performing_faction:name() .. "'s owner, protect them from " .. ritual_key .. "!");
                    if owner:has_effect_bundle(rxa.effect_bundle) then
                         cm:remove_effect_bundle(rxa.effect_bundle, owner:name());
                    end
                    cm:apply_effect_bundle(rxa.effect_bundle, owner:name(), rxa.turns);
               end

               for _, current_faction in model_pairs(owner:vassals()) do
                    if not current_faction:is_faction(performing_faction) then
                         out("FUDGINGVASSALS " ..
                         current_faction:name() ..
                         " is " .. owner:name() .. "'s vassal, protect them from " .. ritual_key .. "!");
                         if current_faction:has_effect_bundle(rxa.effect_bundle) then
                              cm:remove_effect_bundle(rxa.effect_bundle, current_faction:name());
                         end
                         cm:apply_effect_bundle(rxa.effect_bundle, current_faction:name(), rxa.turns);
                    end
               end
          end,
          true
     );


     --TODO TW3 should we add Nakai's "gift to another faction" here? Or leave it alone?
     local gift_to_vassal = {
          ["563"] = true,
     }

     --Stop "Gift to Vassal" from triggering a vassal capture event.
     --CharacterPerformsSettlementOccupationDecision fires AFTER RegionFactionChangeEvent
     --so we can't stop a dilemma from being enqueued. Instead, we'll go fish it out.
     core:add_listener(
          "fv_cpsod",
          "CharacterPerformsSettlementOccupationDecision",
          function(context)
               --Gift to Vassal
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_cpsod " ..
                    cm:campaign_obj_to_string(context:character()) ..
                    " chose " ..
                    context:occupation_decision() ..
                    " (" ..
                    context:settlement_option() ..
                    " " .. context:occupation_decision_type() .. ") for " .. context:garrison_residence():region():name());
               end
               return context:character():faction():is_human() and gift_to_vassal[context:occupation_decision()];
          end,
          function(context)
               local region_key = context:garrison_residence():region():name();
               local player_key = context:character():faction():name();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_cpsod " ..
                    cm:campaign_obj_to_string(context:character()) .. " just gifted " .. region_key .. " to a vassal!");
               end

               fv_delete_vassal_capture(player_key, region_key);
          end,
          true
     );


     --We gotta handle dark fortress capture differently  because of the possibility
     --of a WoC vassal taking that Dark Fortress's Norscan vassal.
     core:add_listener(
          "fv_cpsod_vassal_vassal",
          "CharacterPerformsSettlementOccupationDecision",
          function(context)
               return context:character():faction():is_vassal();
          end,
          function(context)
               local vassal = context:character():faction();
               local vassal_key = vassal:name();
               local protector_key = vassal:master():name();
               local region = context:garrison_residence():region();
               local region_key = region:name();

               --whose fucking decision was it to make these fucking values strings instead of integers??
               if "618357381" == context:occupation_decision() then
                    if vassal_manager:dark_fortress_should_be_transferred_to_chaos_master(region, protector_key) then
                         fv_transfer_region_to_faction(region_key, protector_key);
                    end
               else
                    out("FUDGINGVASSALS " ..
                    vassal_key .. " didn't try to take over the Norscan faction associated with this Dark Fortress.");
                    --let the pre-existing mechanics handle this case.
               end
          end,
          true
     );


     core:add_listener(
          "fv_nde",
          "NegativeDiplomaticEvent",
          function(context)
               return context:was_vassalage() and not context:proposer_was_vassal();
          end,
          function(context)
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG " ..
                    context:recipient():name() .. " is no longer a vassal of " .. context:proposer():name());
               end

               enable_diplomacy_for_former_vassal(context:recipient():name());
               enable_attrition_for_former_vassal(context:recipient());
          end,
          true
     );


     core:add_listener(
          "fv_die",
          "DilemmaIssuedEvent",
          true,
          function(context)
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_die " ..
                    context:faction():name() .. " was issued dilemma " .. context:dilemma());
               end
               last_dilemma[context:faction():command_queue_index()] = context:dilemma();

               --this is not the right place to intercept wh2_dlc13_demand_return_ because by the time we get here the FV dilemma is already enqueued.
          end,
          true
     );


     core:add_listener(
          "fv_fte",
          "FactionTurnEnd",
          function(context)
               return context:faction():is_human();
          end,
          function(context)
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_fte clearing last_dilemma record for " .. context:faction():name());
               end
               last_dilemma[context:faction():command_queue_index()] = nil;
          end,
          true
     );


     local declared_war_on = {};
     core:add_listener(
          "fv_NegativeDiplomaticEvent",
          "NegativeDiplomaticEvent",
          function(context)
               return context:is_war();
          end,
          function(context)
               local p = context:proposer();
               local r = context:recipient();
               if debug_mode then
                    out("FUDGINGVASSALS DEBUG fv_NegativeDiplomaticEvent " .. p:name() .. " declared war on " .. r:name());
               end
               if not is_table(declared_war_on[r:name()]) then
                    declared_war_on[r:name()] = {};
               end
               declared_war_on[r:name()][p:name()] = cm:turn_number();
          end,
          true
     );

     core:add_listener(
          "fv_DiplomacyManipulationExecutedEvent",
          "DiplomacyManipulationExecutedEvent",
          true,
          function(context)
               local pf = context:performing_faction();
               local pf_key = context:performing_faction():name();
               local dmc = context:diplomacy_manipulation_category();
               local tf = context:diplomacy_target_faction();
               local tf_key = context:diplomacy_target_faction():name();
               --the categories should be in diplomatic_manipulation_categories_tables
               if "transfer_settlement" == dmc then
                    if pf:is_vassal() and
                        not pf:is_human() --surprise, it's possible for a player to be a vassal
                        and pf:master():is_human()
                    then
                         local player_faction_key = pf:master():name();
                         if player_capture_dilemma_queue[player_faction_key] == nil then
                              out(
                              "FUDGINGVASSALS ERROR fv_DiplomacyManipulationExecutedEvent HOW THE FUCK DID WE GET HERE?");
                              return;
                         else
                              local found_capture = false;
                              local region_key, po_key;
                              for _, pcdt in pairs(player_capture_dilemma_queue[player_faction_key]) do
                                   if "vassal capture" == pcdt.type and tf_key == pcdt.vassal_key and not not pcdt.previous_owner then
                                        found_capture = true;
                                        region_key = pcdt.region_key;
                                        po_key = pcdt.previous_owner;
                                        out("FUDGINGVASSALS " ..
                                        pf_key ..
                                        " (vassal of " ..
                                        player_faction_key ..
                                        ") diplomatically manipulated " ..
                                        region_key .. " away from " .. pcdt.previous_owner);
                                        break;
                                   end
                              end

                              if found_capture then
                                   local previous_owner = cm:get_faction(po_key);
                                   if previous_owner and not previous_owner:is_null_interface() then
                                        if (previous_owner:is_human() and not previous_owner:at_war_with(pf:master())) or
                                            (previous_owner:is_vassal() and previous_owner:master():is_human() and not previous_owner:master():at_war_with(pf:master()))
                                        then
                                             out("FUDGINGVASSALS previous owner was a player?  Apologize dammit!");

                                             local returned_region = cm:get_region(region_key);
                                             local incident_builder = cm:create_incident_builder(
                                             "fv_dm_transfer_settlement_incident")
                                             local pb = cm:create_payload();
                                             pb:region_transfer(returned_region, previous_owner);
                                             incident_builder:set_payload(pb)
                                             incident_builder:add_target("default", returned_region);
                                             incident_builder:add_target("mission_objective", pf);

                                             cm:disable_event_feed_events(true, "", "", "diplomacy_region_trade");
                                             cm:launch_custom_incident_from_builder(incident_builder, pf:master());
                                             cm:callback(function()
                                                  cm:disable_event_feed_events(false, "", "", "diplomacy_region_trade");
                                             end, 0.2);

                                             fv_delete_vassal_capture(player_faction_key, region_key);
                                        elseif previous_owner:is_vassal() and not previous_owner:master():at_war_with(pf:master()) then
                                             out("FUDGINGVASSALS previous owner was a vassal, putting it back.");
                                             cm:transfer_region_to_faction(region_key, po_key);
                                             fv_delete_vassal_capture(player_faction_key, region_key);
                                        end
                                   else
                                        out(
                                        "FUDGINGVASSALS ERROR fv_DiplomacyManipulationExecutedEvent HOW THE FUCK DID WE GET HERE??");
                                        return;
                                   end
                                   --if it's another vassal, delete it from the queue and return it
                                   --if it's another player, delete it from the queue and return it with an apology
                              else
                                   out("FUDGINGVASSALS this does not appear to concern us.");
                              end
                         end
                    else
                         out("FUDGINGVASSALS " ..
                         pf_key .. " diplomatically manipulated a settlement away from the previous owner.");
                    end
               elseif "force_war" == dmc then
                    if pf:is_vassal() and
                        not pf_is_human() and
                        pf:master():is_human()
                    then
                         local player_faction_key = pf:master():name();
                         local opponents = {};
                         local tf_opponents = declared_war_on[tf_key];
                         if is_table(tf_opponents) then
                              for opponent_key, tn in pairs(tf_opponents) do
                                   if cm:turn_number() == tn then
                                        table.insert(opponents, opponent_key);
                                   end
                              end
                              if #opponents > 0 then
                                   out("FUDGINGVASSALS " ..
                                   player_faction_key ..
                                   "'s vassal " ..
                                   pf_key ..
                                   " diplomatically manipulated " ..
                                   tf_key ..
                                   " into a war with {" .. table.concat(opponents, ", ") .. "}.  Should we care?");
                                   for _, opponent_key in pairs(opponents) do
                                        local opponent = cm:get_faction(opponent_key);
                                        if (tf:is_vassal() and tf:master():is_human()) or
                                            tf:is_human() or
                                            (opponent:is_vassal() and opponent:master():is_human()) or
                                            opponent:is_human()
                                        then
                                             out("FUDGINGVASSALS restoring peace between " ..
                                             tf_key .. " and " .. opponent_key);
                                             cm:force_make_peace(tf_key, opponent_key);

                                             local mf_key = 0;
                                             if opponent:military_force_list():num_items() > 0 then
                                                  mf_key = opponent:military_force_list():item_at(0):command_queue_index();
                                             end

                                             --this is definitely broken
                                             cm:trigger_incident_with_targets(
                                                  pf:master():command_queue_index(),
                                                  "fv_dm_force_war_incident",
                                                  tf:command_queue_index(),
                                                  0,
                                                  pf:faction_leader():command_queue_index(),
                                                  mf_key,
                                                  0,
                                                  0
                                             );
                                        else
                                             out("FUDGINGVASSALS " ..
                                             player_faction_key ..
                                             "'s vassal " ..
                                             pf_key ..
                                             " diplomatically manipulated " ..
                                             tf_key ..
                                             " into a war with " ..
                                             opponent_key .. ", none of which appears to be our business.");
                                        end
                                   end
                              else
                                   out("FUDGINGVASSALS " ..
                                   player_faction_key ..
                                   "'s vassal " ..
                                   pf_key ..
                                   " diplomatically manipulated " ..
                                   tf_key ..
                                   " into a war with some other faction, however our records are empty so we can't do anything.");
                              end
                         else
                              out("FUDGINGVASSALS " ..
                              player_faction_key ..
                              "'s vassal " ..
                              pf_key ..
                              " diplomatically manipulated " ..
                              tf_key ..
                              " into a war with some other faction, but we don't have a record of it so we can't do anything.");
                         end
                    else
                         out("FUDGINGVASSALS " ..
                         pf_key .. " diplomatically manipulated " .. tf_key .. " into a war with some other faction.");
                    end
               else
                    out("FUDGINGVASSALS " ..
                    pf_key .. " just did a manipulation (" .. dmc .. ") on " .. tf_key .. ": unhandled");
               end
          end,
          true
     );

     out("FUDGINGVASSALS if you see this all handlers loaded without incident [o]_O");
end;

if not cm then
     --shut up
     cm = {}
     cm.add_saving_game_callback = function() end
     cm.add_loading_game_callback = function() end
end


cm:add_saving_game_callback(
     function(context)
          cm:save_named_value("fv_diplomacy_adjusted", vassal_diplomacy_adjusted, context);
          if debug_mode then
               out("fv_diplomacy_adjusted = " .. table.tostring(vassal_diplomacy_adjusted));
          end
          cm:save_named_value("fv_player_capture_dilemma_queue", player_capture_dilemma_queue, context);
          if debug_mode then
               out("player_capture_dilemma_queue = " .. table.tostring(player_capture_dilemma_queue));
          end
     end
);


cm:add_loading_game_callback(
     function(context)
          vassal_diplomacy_adjusted = cm:load_named_value("fv_diplomacy_adjusted", {}, context);
          if debug_mode then
               out("fv_diplomacy_adjusted = " .. table.tostring(vassal_diplomacy_adjusted));
          end
          player_capture_dilemma_queue = cm:load_named_value("fv_player_capture_dilemma_queue", {}, context);
          if debug_mode then
               out("player_capture_dilemma_queue = " .. table.tostring(player_capture_dilemma_queue));
          end
     end
);