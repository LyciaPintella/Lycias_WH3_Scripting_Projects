--!scm_marienburg.pack
--rhox_dauphine_skill_mission.lua
local skill_to_pirate_faction_key =
{
     "wh2_dlc11_cst_rogue_tyrants_of_the_black_ocean",
     "wh2_dlc11_cst_rogue_bleak_coast_buccaneers",
     "wh2_dlc11_cst_rogue_boyz_of_the_forbidden_coast",
     "wh2_dlc11_cst_rogue_freebooters_of_port_royale",
     "wh2_dlc11_cst_rogue_grey_point_scuttlers",
     "wh2_dlc11_cst_rogue_terrors_of_the_dark_straights",
     "wh2_dlc11_cst_rogue_the_churning_gulf_raiders",
     "wh2_dlc11_cst_harpoon_the_sunken_land_corsairs"
}

local effect_bundle_rewards_prefix = "rhox_dauphine_blue_pirate_rewards_"
local dilemma_prefix = "rhox_dauphine_blue_pirate_"


local function rhox_mar_dauphine_give_rewardsor_trigger_dilemma(faction, id, character)
     local target_faction_key = skill_to_pirate_faction_key[id + 1] --id starts with 0, so should +1
     out("Rhox Dauphine: Target pirate faction: " .. target_faction_key)
     if not target_faction_key then
          return false
     end
     local target_faction = cm:get_faction(target_faction_key)
     if target_faction:is_dead() then
          out("Rhox Dauphine: This faction is already dead")
          cm:apply_effect_bundle(effect_bundle_rewards_prefix .. id, faction:name(), 0)
     else
          out("Rhox Dauphine: Triggering dilemma " .. dilemma_prefix .. id)
          --trigger dilemma
          local dilemma_builder = cm:create_dilemma_builder(dilemma_prefix .. id);
          local payload_builder = cm:create_payload();


          payload_builder:text_display(dilemma_prefix .. "first_" .. id)
          out("Rhox Dauphine: Text payload: " .. dilemma_prefix .. "first_" .. id)

          payload_builder:treasury_adjustment(1500);

          local faction_bundle = cm:create_new_custom_effect_bundle("rhox_dauphine_blue_pirate_coop");
          faction_bundle:set_duration(10);

          payload_builder:effect_bundle_to_faction(faction_bundle);



          dilemma_builder:add_choice_payload("FIRST", payload_builder);
          payload_builder:clear();

          payload_builder:text_display(dilemma_prefix .. "second_" .. id)
          dilemma_builder:add_choice_payload("SECOND", payload_builder);

          dilemma_builder:add_target("default", character);

          out.design("Triggering dilemma:" .. dilemma_prefix .. id)
          cm:launch_custom_dilemma_from_builder(dilemma_builder, faction);
     end
end

core:add_listener(
     "rhox_mar_dauphine_special_2_0_CharacterSkillPointAllocated",
     "CharacterSkillPointAllocated",
     function(context)
          local character = context:character()
          local faction = character:faction()
          local skill = context:skill_point_spent_on()
          return skill:starts_with("hkrul_dauphine_special_2_") and faction:is_human()
     end,
     function(context)
          local character = context:character()
          local faction = character:faction()
          local skill = context:skill_point_spent_on()
          local id = string.gsub(skill, "hkrul_dauphine_special_2_", "")
          rhox_mar_dauphine_give_rewardsor_trigger_dilemma(faction, id, character)
     end,
     true
)

local mission_prefix = "rhox_mar_dauphine_2_"

core:add_listener(
     "rhox_mundvard_DilemmaChoiceMadeEvent",
     "DilemmaChoiceMadeEvent",
     function(context)
          return context:dilemma():starts_with(dilemma_prefix)
     end,
     function(context)
          local faction = context:faction()
          local dilemma_name = context:dilemma()
          local choice = context:choice();
          local id = string.gsub(dilemma_name, dilemma_prefix, "")
          local faction_key = skill_to_pirate_faction_key[id + 1]
          if choice == 0 then --bribe
               cm:kill_all_armies_for_faction(cm:get_faction(faction_key))
          else --mission
               local mm = mission_manager:new(faction:name(), mission_prefix .. id)
               local target_cqi = cm:get_faction(faction_key):faction_leader():military_force():command_queue_index()
               mm:add_new_objective("ENGAGE_FORCE")
               mm:add_condition("cqi " .. target_cqi)
               mm:add_condition("requires_victory")
               --mm:add_new_objective("DESTROY_FACTION");
               --mm:add_condition("faction " .. faction_key);
               mm:add_payload("effect_bundle{bundle_key " .. effect_bundle_rewards_prefix .. id .. ";turns 0;}");
               mm:trigger()
          end
     end,
     true
);


core:add_listener(
     "hkrul_dauphine_special_0_2_CharacterSkillPointAllocated",
     "CharacterSkillPointAllocated",
     function(context)
          local skill = context:skill_point_spent_on()
          return skill == "hkrul_dauphine_special_0_2"
     end,
     function(context)
          local character = context:character()
          local faction = character:faction()
          local faction_name = faction:name()
          local reikland_interface = cm:get_faction("wh_main_emp_empire")

          if faction_name == "wh_main_emp_empire" then
               return --don't do anything if Dauphine is under the Reikland
          end

          if faction and faction:is_human() and reikland_interface and not reikland_interface:is_dead() then
               cm:force_alliance(faction_name, "wh_main_emp_empire", true)
          end
     end,
     true
)

