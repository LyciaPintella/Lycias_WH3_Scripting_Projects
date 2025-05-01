out("Loading phar_deeds.lua")

-- Each listener must take care to check if the character or faction involved is a ruler!

---------------------------
--------- WARFARE ---------
----- ACCOMPLISHMENTS -----
---------------------------
-- Bane of Faction
core:add_listener(
     "PharDeeds_BaneOfFaction",
     "BattleConflictFinished",
     true,
     function(context)
          local pending_battle = context:pending_battle()
          local attacker_faction_key = pending_battle:attacker():faction():name()
          local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(attacker_faction_key)
          if not legitimacy_path then
               return
          end
          local is_ruler = legitimacy_path.political_states_system:is_ruler(attacker_faction_key)
          if not is_ruler then
               return
          end

          local dynasty_key = legitimacy_path.config.dynasty_line_key
          local defender_faction = pending_battle:defender():faction()
          local defender_faction_key
          local param_type
          if defender_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
               defender_faction_key = pending_battle:defender():faction_key_if_rebel()
          else
               param_type = deed_param_types.faction
               defender_faction_key = pending_battle:defender():faction():name()
          end

          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               defender_faction_key,
               deeds_config.bane_of_faction)
     end,
     true
)

-- Conqueror of Realm
core:add_listener(
     "PharLocalDeities_ConquerRealm",
     "RegionFactionChangeEvent",
     function(context)
          local region = context:region()
          return cm:is_faction_ruler_of_dynasty(region:owning_faction())
     end,
     function(context)
          local region = context:region()
          local new_faction = region:owning_faction()
          local realm_key = phar_realms.get_realm_for_region(region:name())
          local realm_regions = phar_realms.get_regions_for_realm(realm_key)
          for _, region_key in ipairs(realm_regions) do
               local region = cm:get_region(region_key)
               local owning_faction = region:owning_faction()

               if owning_faction:is_null_interface()
                   or (owning_faction ~= new_faction and not new_faction:allied_with(owning_faction))
               then
                    return
               end
          end

          local _, realm_loc_key = get_localised_random_string_and_source(realm_key)
          local dynasty_key = cm:get_dynasty_ruled_by_faction(new_faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               realm_loc_key,
               deeds_config.conquer_realm)
     end,
     true
)

-- The Warmonger
core:add_listener(
     "PharDeeds_Warmonger",
     "NegativeDiplomaticEvent",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:character():faction())
     end,
     -- Callback
     function(context)
          if context:is_war() == false then
               return
          end

          local faction = context:character():faction()
          local recipient = context:recipient()
          local proposer = context:proposer()

          local param_type

          if recipient:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               proposer:name(),
               deeds_config.warmonger)
     end,
     -- Persistency
     true
)

-- Ruler of Province
core:add_listener(
     "PharDeeds_RulerOfProvince",
     "RegionFactionChangeEvent",
     -- Conditional trigger
     function(context)
          local region = context:region()
          return cm:is_faction_ruler_of_dynasty(region:owning_faction())
     end,
     -- Callback
     function(context)
          local region = context:region()
          local province = region:province()
          local regions_in_province = province:regions()
          local owning_faction = region:owning_faction()
          local is_whole_province_occupied = true

          for i = 0, regions_in_province:num_items() - 1 do
               local curr_province = regions_in_province:item_at(i)
               if owning_faction ~= curr_province:owning_faction() then
                    is_whole_province_occupied = false
                    break
               end
          end

          if is_whole_province_occupied == false then
               return
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(owning_faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.province,
               province:command_queue_index(),
               deeds_config.ruler_of_province)
     end,
     -- Persistency
     true
)

---------------------------
--------- WARFARE ---------
-------- SETBACKS ---------
---------------------------
-- Mourned Region (Except PoC)
core:add_listener(
     "PharDeeds_MournedRegion",
     "RegionFactionChangeEvent",
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:previous_faction())
     end,
     function(context)
          local region = context:region()
          local previous_owner = context:previous_faction()

          -- abandoned is the keyword used when a region is razed (rebels razing a region is another keyword)
          if context:reason() ~= "abandoned" then
               return
          end

          -- Check if the region is being razed because of PoC (Disasters, because if it is, we won't trigger the deed)
          local current_incident = pillars_civilization.get_current_incident()
          if current_incident then
               local incident_affected_region_keys = pillars_civilization.get_incident_affected_regions(current_incident)
               for _, region_key in ipairs(incident_affected_region_keys) do
                    if region_key == region:name() then
                         return
                    end
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(previous_owner)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.region,
               region:command_queue_index(),
               deeds_config.mourned_region)
     end,
     true
)

-- Fled battle of region
core:add_listener(
     "PharDeeds_FledBattleOfRegion",
     "CharacterWithdrewFromBattle",
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:character():faction())
     end,
     function(context)
          local character = context:character()
          local region = character:region()

          local param_type
          local param_key
          if not region:is_null_interface() then
               param_key = region:command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = character:region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(character:faction())
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               param_key,
               deeds_config.fled_battle_of_region)
     end,
     true
)

-- The butcher
core:add_listener(
     "PharDeeds_TheButcher",
     "BattleConflictFinished",
     true,
     function(context)
          local pending_battle = context:pending_battle()
          local sl_faction
          local sl_army
          local is_sl_attacker = false

          -- Check where is the dynasty ruler and set locals according to the result.
          if cm:is_faction_ruler_of_dynasty(pending_battle:attacker_faction()) == true then
               sl_faction = pending_battle:attacker_faction()
               sl_army = pending_battle:attacker():military_force()
               is_sl_attacker = true
          elseif cm:is_faction_ruler_of_dynasty(pending_battle:defender_faction()) then
               sl_faction = pending_battle:defender_faction()
               sl_army = pending_battle:defender():military_force()
          end

          if sl_faction == nil or sl_army == nil then
               return
          end

          -- Is this army even the leader ?
          local legitimacy_path = legitimacy_choice:get_unlocked_legitimacy(sl_faction:name())
          if not legitimacy_path then
               return
          end
          local is_ruler = legitimacy_path.political_states_system:is_ruler(sl_faction:name())
          if not is_ruler then
               return
          end

          -- Did we lost at least 50% of our forces ?
          if is_sl_attacker then
               if pending_battle:percentage_of_attacker_killed() < 0.50 then
                    return
               end
          else
               if pending_battle:percentage_of_defender_killed() < 0.50 then
                    return
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(sl_faction)

          local param_type
          local param_key
          if pending_battle:has_region() then
               param_key = pending_battle:region():command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = pending_battle:region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          if param_type then
               cm:notify_deed_progress(
                    dynasty_key,
                    param_type,
                    param_key,
                    deeds_config.the_butcher)
          else
               script_error("ERROR: PharDeeds_TheReckless couldn't find region_data, how can this be?")
          end
     end,
     true
)

-- Betrayer of region
core:add_listener(
     "PharDeeds_BetrayerOfRegion",
     "CharacterTurnEnd",
     function(context)
          local region = context:character():region()
          if region:is_null_interface() then
               return false
          else
               return cm:is_faction_ruler_of_dynasty(context:character():region():owning_faction())
          end
     end,
     function(context)
          -- If no military force, then no stance can be adopted
          if context:character():has_military_force() == false then
               return
          end

          -- If we raid our own region, we dont trigger the deed
          local region = context:character():region()
          if context:character():faction() == region:owning_faction() then
               return
          end

          local faction = region:owning_faction()
          local force = context:character():military_force()
          local stance = force:active_stance()

          -- Raiding on land stance is 3
          if stance ~= "MILITARY_FORCE_ACTIVE_STANCE_TYPE_LAND_RAID" then
               return
          end

          local param_type
          local param_key
          if not region:is_null_interface() then
               param_key = region:command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = character:region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               param_key,
               deeds_config.betrayer_of_region)
     end,
     true
)

---------------------------
------ STATESMANSHIP ------
----- ACCOMPLISHMENTS -----
---------------------------
-- Loved by [Province]
core:add_listener(
     "PharDeeds_LovedByProvince",
     "FactionTurnStart",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     -- Callback
     function(context)
          local faction = context:faction()
          local province_list = faction:province_list()
          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:faction())

          for i = 0, province_list:num_items() - 1 do
               local curr_province = province_list:item_at(i)

               -- We need to get the capital, as province:public_order() always yield 0 for some reasons ?
               local capital_of_province

               for j = 0, curr_province:regions():num_items() - 1 do
                    local curr_region = curr_province:regions():item_at(j)
                    if curr_region:is_province_capital() == true then
                         capital_of_province = curr_region
                         break
                    end
               end

               local current_happiness = capital_of_province:public_order(faction)
               if current_happiness >= deeds_config.loved_by_province.target_value then
                    cm:notify_deed_progress(
                         dynasty_key,
                         deed_param_types.province,
                         curr_province:command_queue_index(),
                         deeds_config.loved_by_province)
               end
          end
     end,
     -- Persistency
     true
)

-- Extensive trade with [Faction]
-- Theres 2 events for this one, the first notify the deed that we started an agreement, and sets the count to 0
-- Then the other will tick on every turn and actually increment the target_count
core:add_listener(
     "PharDeeds_ExtensiveTradeWithFaction",
     "PositiveDiplomaticEvent",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:character():faction())
     end,
     -- Callback
     function(context)
          local recipient = context:recipient()
          local param_type

          -- Usual rebel faction check
          if recipient:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               recipient:name(),
               deeds_config.extensive_trade_with_faction)
     end,
     -- Persistency
     true
)

core:add_listener(
     "PharDeeds_ExtensiveTradeWithFaction",
     "FactionBarterAgreementTicked",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     -- Callback
     function(context)
          local faction = context:faction()
          local other_faction = context:other_faction()
          local param_type

          -- Usual rebel faction check
          if other_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               other_faction:name(),
               deeds_config.extensive_trade_with_faction)
     end,
     -- Persistency
     true
)

-- Made 2 Factions your allies [Military or Defensive] or Vassals
core:add_listener(
     "PharDeeds_MakeTwoFactionsYourAlliesOrVassals",
     "PositiveDiplomaticEvent",
     -- Conditional trigger
     function(context)
          if context:is_alliance() or context:is_military_alliance() or context:is_defensive_alliance() or context:is_subjugation() then
               return cm:is_faction_ruler_of_dynasty(context:character():faction())
          else
               return false
          end
     end,
     -- Callback
     function(context)
          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.faction,
               context:character():faction():name(),
               deeds_config.make_two_factions_your_allies_or_vassals)
     end,
     -- Persistency
     true
)

-- Make peace with a faction
core:add_listener(
     "PharDeeds_MakePeaceWithFaction",
     "PositiveDiplomaticEvent",
     -- Conditional trigger
     function(context)
          if context:is_peace_treaty() then
               return cm:is_faction_ruler_of_dynasty(context:character():faction())
          else
               return false
          end
     end,
     -- Callback
     function(context)
          local recipient_faction = context:recipient()
          local recipient_faction_key
          local param_type

          if recipient_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
               recipient_faction_key = recipient_faction:faction_key_if_rebel()
          else
               param_type = deed_param_types.faction
               recipient_faction_key = recipient_faction:name()
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.faction,
               recipient_faction_key,
               deeds_config.make_peace_with_faction)
     end,
     -- Persistency
     true
)

---------------------------
------ STATESMANSHIP ------
-------- SETBACKS ---------
---------------------------
-- Region Rebelled
core:add_listener(
     "PharDeeds_RegionRebelled",
     "RegionRebels",
     function(context)
          local region = context:region()
          return cm:is_faction_ruler_of_dynasty(region:owning_faction())
     end,
     function(context)
          local region = context:region()
          local dynasty_key = cm:get_dynasty_ruled_by_faction(region:owning_faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.region,
               region:command_queue_index(),
               deeds_config.region_rebelled)
     end,
     true
)

-- Low Province Influence
core:add_listener(
     "PharDeeds_LowProvinceInfluence",
     "FactionTurnStart",
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     function(context)
          local faction = context:faction()
          local province_list = faction:province_list()
          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:faction())

          local owner_influence_type = faction:state_religion()
          for i = 0, province_list:num_items() - 1 do
               local curr_province = province_list:item_at(i)
               local owner_influence_proportion = curr_province:religion_proportion(owner_influence_type)
               if owner_influence_proportion <= deeds_config.low_province_influence.target_value / 100 then
                    cm:notify_deed_progress(
                         dynasty_key,
                         deed_param_types.province,
                         curr_province:command_queue_index(),
                         deeds_config.low_province_influence)
               end
          end
     end,
     true
)

----------------------------
--------- NOBILITY ---------
----- ACCOMPLISHMENTS ------
----------------------------
-- Children count of a character can increase when children are born or after marriage,
-- so there are 2 listeners for this deed
-- Have n children
core:add_listener(
     "PharDeeds_HaveNChildren_Newborn",
     "CharacterHasChild",
     function(context)
          local character = context:character()
          return cm:is_character_ruler_of_dynasty(character)
     end,
     function(context)
          local family_member = context:character():family_member()
          local children_count = family_member:all_children_in_marriage():num_items()
          -- >= if we ever decided to have twins being born
          if children_count >= deeds_config.have_n_children.target_value then
               local dynasty_key = cm:get_dynasty_ruled_by_character(context:character())
               cm:notify_deed_progress(
                    dynasty_key,
                    deed_param_types.family_member,
                    family_member:command_queue_index(),
                    deeds_config.have_n_children)
          end
     end,
     true
)

core:add_listener(
     "PharDeeds_HaveNChildren_Marriage",
     "FamilyMembersMarriage",
     true,
     function(context)
          local family_member1 = context:family_member1()
          local family_member2 = context:family_member2()
          local children_count = family_member1:all_children_in_marriage():num_items()
          local character
          if cm:is_character_ruler_of_dynasty(family_member1:character()) then
               character = family_member1:character()
          elseif cm:is_character_ruler_of_dynasty(family_member2:character()) then
               character = family_member2:character()
          else
               return
          end
          if children_count >= deeds_config.have_n_children.target_value then
               local dynasty_key = cm:get_dynasty_ruled_by_character(character)
               cm:notify_deed_progress(
                    dynasty_key,
                    deed_param_types.family_member,
                    character:family_member():command_queue_index(),
                    deeds_config.have_n_children)
          end
     end,
     true
)

-- Has Strong Generals
core:add_listener(
     "PharDeeds_HasStrongGenerals",
     "CharacterRankUp",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:character():faction())
     end,
     -- Callback
     function(context)
          local character = context:character()
          local faction = character:faction()

          if character:rank() < deeds_config.has_strong_generals.target_value then
               return
          end

          -- Usual rebel faction check
          if faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.faction,
               faction:name(),
               deeds_config.has_strong_generals)
     end,
     -- Persistency
     true
)

-- Marry four people in the Dynasty
core:add_listener(
     "PharDeeds_MarryFourPeopleInDynasty",
     "FamilyMembersMarriage",
     -- Conditional trigger
     function(context)
          local char1 = context:family_member1():character()
          local char2 = context:family_member2():character()

          return cm:is_character_ruler_of_dynasty(char1) or cm:is_character_ruler_of_dynasty(char2)
     end,
     -- Callback
     function(context)
          local fm1 = context:family_member1()
          local fm2 = context:family_member2()
          local leader

          if cm:is_character_ruler_of_dynasty(fm1:character()) then
               leader = fm1
          else
               leader = fm2
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(leader:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               leader:command_queue_index(),
               deeds_config.marry_four_people_in_dynasty)
     end,
     -- Persistency
     true
)

--Supreme leader reaches X rank
core:add_listener(
     "PharDeeds_SupremeLeaderReachesXRank",
     "CharacterRankUp",
     -- Conditional trigger
     function(context)
          if cm:is_character_ruler_of_dynasty(context:character()) then
               return context:character():rank() >= deeds_config.supreme_leader_reaches_x_rank.target_value
          end
     end,
     -- Callback
     function(context)
          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               context:character():family_member():command_queue_index(),
               deeds_config.supreme_leader_reaches_x_rank)
     end,
     -- Persistency
     true
)

----------------------------
-------- NOBILITY ----------
-------- SETBACKS ----------
----------------------------
-- Divorce a character
core:add_listener(
     "PharDeeds_DivorceACharacter",
     "FamilyMembersDivorce",
     -- Conditional trigger
     function(context)
          return true
     end,
     -- Callback
     function(context)
          local fm1 = context:family_member1()
          local fm2 = context:family_member2()
          local ruler
          local divorced_character

          -- Character death also triggers a divorce
          if not fm1:is_alive() or not fm2:is_alive() then
               return
          end

          if cm:is_character_ruler_of_dynasty(fm1:character()) == true then
               ruler = fm1
               divorced_character = fm2
          elseif cm:is_character_ruler_of_dynasty(fm2:character()) == true then
               ruler = fm2
               divorced_character = fm1
          else
               return
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(ruler:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               divorced_character:command_queue_index(),
               deeds_config.divorce_character)
     end,
     -- Persistency
     true
)

-- Scion Character Died
core:add_listener(
     "PharDeeds_ScionCharacterDied",
     "FactionCharacterDiedOrWounded",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     -- Callback
     function(context)
          local family_member = context:family_member()
          if family_member:is_alive() then
               return
          end

          local character = family_member:character()
          local faction = character:faction()

          if is_null(faction:faction_heir()) then
               return
          end

          local is_scion = faction:faction_heir():character()

          if character ~= is_scion then
               return
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               family_member:command_queue_index(),
               deeds_config.lost_his_scion_character)
     end,
     -- Persistency
     true
)

----------------------------
--------- PIETY ------------
----- ACCOMPLISHMENTS ------
----------------------------
-- Build n Temples
core:add_listener(
     "PharDeeds_BuildTemples",
     "ScriptEventTempleCountChanged",
     true,
     function(context)
          local faction_key = context.stored_table.faction_key
          local faction = cm:get_faction(faction_key)
          if not cm:is_faction_ruler_of_dynasty(faction) then
               return
          end
          if (context.stored_table.count >= deeds_config.build_n_temples.target_value) then
               local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
               local god_name_loc_key = deities.get_localised_text(context.stored_table.god_key).name_source
               cm:notify_deed_progress(
                    dynasty_key,
                    deed_param_types.string,
                    god_name_loc_key,
                    deeds_config.build_n_temples)
          end
     end,
     true
)

-- Character interacts with shrines n times
core:add_listener(
     "PharDeeds_CharacterInteractsWithShrineNTimes",
     "ScriptEventPrayerMade",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context.stored_table.faction)
     end,
     -- Callback
     function(context)
          local character = context.stored_table.force:general_character()

          local dynasty_key = cm:get_dynasty_ruled_by_faction(context.stored_table.faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               character:family_member():command_queue_index(),
               deeds_config.character_interact_with_shrines_n_times)
     end,
     -- Persistency
     true
)

-- Build 2 Shrines in a Province
core:add_listener(
     "PharDeeds_Build2ShrinesInAProvince",
     "BuildingCompleted",
     -- Conditional trigger
     function(context)
          local slot = context:building():slot()
          if not slot:is_infrastructure_slot() then
               return
          else
               return cm:is_faction_ruler_of_dynasty(context:building():region():owning_faction())
          end
     end,
     -- Callback
     function(context)
          local faction = context:building():region():owning_faction()
          local building = context:building()
          local province = context:building():region():province()

          if not building:belongs_to_building_set("phar_main_religious_ers") then
               return
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.province,
               province:command_queue_index(),
               deeds_config.build_two_shrine_in_province)
     end,
     -- Persistency
     true
)

-- Discover a new god
core:add_listener(
     "PharDeeds_DiscoverANewGod",
     "ScriptedEventNewLocalDeityDiscovered",
     -- Conditional trigger
     function(context)
          local deities_unlock_turn = feature_unlock.get_feature_unlock_turn_for_faction(
               context.stored_table.faction_key, feature_ids_config.local_deities)
          local current_turn = cm:turn_number()

          if current_turn < deities_unlock_turn or context.stored_table.is_initial_god == true then
               return
          else
               return cm:is_faction_ruler_of_dynasty(cm:get_faction(context.stored_table.faction_key))
          end
     end,
     -- Callback
     function(context)
          local faction = cm:get_faction(context.stored_table.faction_key)
          local god_key = context.stored_table.god_loc_key

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               god_key,
               deeds_config.discover_a_god)
     end,
     -- Persistency
     true
)

-- Defender of Settlement
core:add_listener(
     "PharDeeds_DefenderOfSettlement",
     "BuildingCompleted",
     -- Conditional trigger
     function(context)
          -- Is this settlement a cult center ?
          if deities.find_cult_centre_god_for_region(context:building():region():name()) then
               local gar_res = context:garrison_residence()
               local settlement = gar_res:settlement_interface()

               if settlement:is_null_interface() then
                    return false
               end

               local primary_slot = settlement:primary_slot():building()

               if primary_slot:is_null_interface() then
                    return false
               end

               if primary_slot == context:building() then
                    if primary_slot:level() < 5 then
                         return false
                    else
                         return cm:is_faction_ruler_of_dynasty(context:building():faction())
                    end
               end
          end
     end,
     -- Callback
     function(context)
          local region = context:building():region()
          local faction = region:owning_faction()

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.region,
               region:command_queue_index(),
               deeds_config.defender_of_settlement)
     end,
     -- Persistency
     true
)

----------------------------
--------- PIETY ------------
-------- SETBACKS ----------
----------------------------
-- Own Cult center is razed
-- CharacterPerformsSettlementOccupationDecision
-- When razing a settlement, a rebel faction is set as occupiers, hence we need to access the previous owning faction.
core:add_listener(
     "PharDeeds_OwnCultCenterIsRazed",
     "CharacterPerformsSettlementOccupationDecision",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:prior_faction())
     end,
     -- Callback
     function(context)
          if context:garrison_residence():is_settlement() == false then
               return
          end
          if context:occupation_decision_option() ~= "occupation_decision_raze_without_occupy" then
               return
          end

          local owning_faction = context:prior_faction()
          local region = context:garrison_residence():region()
          local settlement = context:garrison_residence():settlement_interface()

          -- Is this settlement a cult center ?
          if not deities.find_cult_centre_god_for_region(region:name()) then
               return
          end

          local param_type
          local param_key
          if not region:is_null_interface() then
               param_key = region:command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = context:character():region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(owning_faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               param_key,
               deeds_config.settlement_was_bespoiled)
     end,
     -- Persistency
     true
)

-- Raze or Sack a Settlement with a temple in it
-- We do need two event to handle that deed
-- CharacterSackedSettlement + CharacterRazedSettlement
core:add_listener(
     "PharDeeds_RazeOrSackSettlementWithATempleInIt",
     "CharacterSackedSettlement",
     -- Conditional trigger
     function(context)
          return cm:is_character_ruler_of_dynasty(context:character())
     end,
     -- Callback
     function(context)
          if context:garrison_residence():is_settlement() == false then
               return
          end

          local region = context:garrison_residence():region()
          local settlement_slots = region:settlement():slot_list()

          if not settlement_slots then
               return
          end

          -- Do we sack a cult center ? if yes, by the end of this check we should have the building superChainKey and the god key,
          -- only thing left to check is if the Grand temple is built, or in construction
          local cult_center_god_key
          local cult_center_chain_key
          cult_center_god_key = deities.find_cult_centre_god_for_region(region:name())
          if cult_center_god_key then
               cult_center_chain_key = deities.get_god_cult_centre_chain(cult_center_god_key)
          end

          local temple
          for i = 0, settlement_slots:num_items() - 1 do
               local curr = settlement_slots:item_at(i)
               if not curr:building():is_null_interface() then
                    if curr:building():superchain() == "phar_main_religion_temple" or curr:building():superchain() == cult_center_chain_key then
                         temple = curr:building():chain()
                         break
                    end
               end
               if curr:is_there_construction() then
                    if curr:construction_building_chain_superchain() == "phar_main_religion_temple" or curr:construction_building_chain_superchain() == cult_center_chain_key then
                         temple = curr:construction_building_chain_key()
                         break
                    end
               end
          end

          local god_key

          if not cult_center_god_key and temple then
               god_key = table_find(deities.gods, function(e) return temple == e.temple_chain end).key
          elseif cult_center_god_key then
               god_key = cult_center_god_key
          else
               return
          end

          god_key = deities.get_localised_text(god_key).name_source

          local faction = context:character():faction()
          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               god_key,
               deeds_config.damaged_temple_of_deity)
     end,
     -- Persistency
     true
)

core:add_listener(
     "PharDeeds_RazeOrSackSettlementWithATempleInIt",
     "CharacterPerformsSettlementOccupationDecisionBeforeOutcomeApplication",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:character():faction())
     end,
     -- Callback
     function(context)
          if context:garrison_residence():is_settlement() == false then
               return
          end
          if context:occupation_decision_option() ~= "occupation_decision_raze_without_occupy" then
               return
          end

          local region = context:garrison_residence():region()
          local settlement_slots = region:settlement():slot_list()

          if not settlement_slots then
               return
          end

          -- Do we raze a cult center ? if yes, by the end of this check we should have the building superChainKey and the god key,
          -- only thing left to check is if the Grand temple is built, or in construction
          local cult_center_god_key
          local cult_center_chain_key
          cult_center_god_key = deities.find_cult_centre_god_for_region(region:name())
          if cult_center_god_key then
               cult_center_chain_key = deities.get_god_cult_centre_chain(cult_center_god_key)
          end

          local temple
          for i = 0, settlement_slots:num_items() - 1 do
               local curr = settlement_slots:item_at(i)
               if not curr:building():is_null_interface() then
                    if curr:building():superchain() == "phar_main_religion_temple" or curr:building():superchain() == cult_center_chain_key then
                         temple = curr:building():chain()
                         break
                    end
               end
               if curr:is_there_construction() then
                    if curr:construction_building_chain_superchain() == "phar_main_religion_temple" or curr:construction_building_chain_superchain() == cult_center_chain_key then
                         temple = curr:construction_building_chain_key()
                         break
                    end
               end
          end

          local god_key

          if not cult_center_god_key and temple then
               god_key = table_find(deities.gods, function(e) return temple == e.temple_chain end).key
          elseif cult_center_god_key then
               god_key = cult_center_god_key
          else
               return
          end

          god_key = deities.get_localised_text(god_key).name_source

          local faction = context:character():faction()
          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               god_key,
               deeds_config.damaged_temple_of_deity)
     end,
     -- Persistency
     true
)

-- World goes into crisis
core:add_listener(
     "PharDeeds_WorldGoesIntoCrisis",
     "FactionTurnStart",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     -- Callback
     function(context)
          local faction = context:faction()

          if (pillars_civilization.get_current_civilization_level().name == "crisis") then
               local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
               cm:notify_deed_progress(
                    dynasty_key,
                    deed_param_types.string,
                    faction:name(),
                    deeds_config.world_goes_into_crisis)
          end
     end,
     -- Persistency
     true
)

-- World goes into collapse
core:add_listener(
     "PharDeeds_WorldGoesIntoCollapse",
     "FactionTurnStart",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction())
     end,
     -- Callback
     function(context)
          local faction = context:faction()

          if (pillars_civilization.get_current_civilization_level().name == "collapse") then
               local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
               cm:notify_deed_progress(
                    dynasty_key,
                    deed_param_types.string,
                    faction:name(),
                    deeds_config.world_goes_into_collapse)
          end
     end,
     -- Persistency
     true
)

-- Raze Cult Center
core:add_listener(
     "PharDeeds_RazeCultCenter",
     "CharacterPerformsSettlementOccupationDecisionBeforeOutcomeApplication",
     -- Conditional trigger
     function(context)
          if context:garrison_residence():is_settlement() == false then
               return
          elseif context:occupation_decision_option() ~= "occupation_decision_raze_without_occupy" then
               return
          else
               return cm:is_faction_ruler_of_dynasty(context:character():faction())
          end
     end,
     -- Callback
     function(context)
          local region = context:garrison_residence():region()
          local settlement = region:settlement()

          local cult_center_god_key = deities.find_cult_centre_god_for_region(region:name())
          if not cult_center_god_key then
               return
          end

          local param_type
          local param_key
          if not region:is_null_interface() then
               param_key = region:command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = context:character():region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               param_key,
               deeds_config.raze_cult_center)
     end,
     -- Persistency
     true
)

-- Raze or sack a shrine of a deity
core:add_listener(
     "PharDeeds_RazeOrSackShrineOfADeity",
     "CharacterPerformsRegionSlotOccupationDecisionBeforeOutcomeApplication",
     -- Conditional trigger
     function(context)
          local slot = context:region_slot()

          if not context:occupation_decision_option() == "occupation_decision_ers_sack" or not context:occupation_decision_option() == "occupation_decision_ers_raze_without_occupy" then
               return
          elseif not slot:has_building() or not slot:is_infrastructure_slot() then
               return
          else
               return cm:is_faction_ruler_of_dynasty(context:character():faction())
          end
     end,
     -- Callback
     function(context)
          local slot = context:region_slot()
          local shrine
          if slot:is_there_construction() then
               if slot:construction_building_chain_superchain() == "phar_main_ers_shrine" then
                    shrine = slot:construction_building_chain_key()
               end
          elseif slot:building():superchain() == "phar_main_ers_shrine" then
               shrine = slot:building():chain()
          else
               return
          end

          local god_key
          if not shrine then
               return
          else
               god_key = deities.get_god_data_for_shrine_chain(shrine).key
               god_key = deities.get_localised_text(god_key).name_source
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               god_key,
               deeds_config.raze_or_sack_shrine_of_deity)
     end,
     -- Persistency
     true
)

----------------------------
--------- GUILE ------------
---- ACCOMPLISHMENTS -------
----------------------------
-- Faction is vassalized
core:add_listener(
     "PharDeeds_VassalizeFaction",
     "FactionBecomesSubject",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context:faction():get_sovereign())
     end,
     -- Callback
     function(context)
          local vassalized_faction = context:faction()
          local sovereign_faction = vassalized_faction:get_sovereign()
          local param_type

          if vassalized_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(sovereign_faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               vassalized_faction:name(),
               deeds_config.vassalize_faction)
     end,
     -- Persistency
     true
)

-- Annexation power used
core:add_listener(
     "PharDeeds_AnnexedFaction",
     "ScriptEventForceAnnexationUsed",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(context.stored_table.faction)
     end,
     -- Callback
     function(context)
          local faction = context.stored_table.faction
          local annexed_faction = cm:get_faction(context.stored_table.annexed_faction_key)
          local param_type

          if annexed_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               annexed_faction:name(),
               deeds_config.use_annexation_power_on_faction)
     end,
     -- Persistency
     true
)

-- Assassinate a character
core:add_listener(
     "PharDeeds_AssassinateCharacter",
     "ScriptEventCourtPlotSucceeded",
     -- Conditional trigger
     function(context)
          if context.stored_table.plot_persistent_data.plot_key == "assassinate" then
               return cm:is_faction_ruler_of_dynasty(cm:get_faction(context.stored_table.plot_persistent_data
                    .plotting_faction))
          end
     end,
     -- Callback
     function(context)
          local faction_key = context.stored_table.plot_persistent_data.plotting_faction
          local faction = cm:get_faction(faction_key)
          local fm = context.stored_table.plot_persistent_data.targeted_character_family_cqi

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               fm,
               deeds_config.assassinate_character)
     end,
     -- Persistency
     true
)

-- Counter X plots
core:add_listener(
     "PharDeeds_CounterXPlots",
     "ScriptEventCourtIntrigueUsed",
     -- Conditional trigger
     function(context)
          if context.stored_table.intrigue_name == "counter" then
               return cm:is_faction_ruler_of_dynasty(context.stored_table.faction)
          end
     end,
     -- Callback
     function(context)
          local faction = context.stored_table.faction
          local fm = faction:faction_leader():family_member():command_queue_index()

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               fm,
               deeds_config.counter_x_plots)
     end,
     -- Persistency
     true
)

-- Mentor of character
core:add_listener(
     "PharDeeds_MentorOfCharacter",
     "CharacterSkillPointAllocated",
     -- Conditional trigger
     function(context)
          if cm:is_character_ruler_of_dynasty(context:character()) then
               return false
          elseif context:is_faction_skill_point() == true then
               return cm:is_faction_ruler_of_dynasty(context:character():faction())
          end
     end,
     -- Callback
     function(context)
          local faction = context:character():faction()
          local fm = context:character():family_member()

          local dynasty_key = cm:get_dynasty_ruled_by_faction(context:character():faction())
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.family_member,
               fm:command_queue_index(),
               deeds_config.mentor_of_character)
     end,
     -- Persistency
     true
)

----------------------------
--------- GUILE ------------
-------- SETBACKS ----------
----------------------------
-- Be supreme leader during legitimacy war
core:add_listener(
     "PharDeeds_BeSupremeLeaderDuringLegitimacyWar",
     "ScriptEventLegitimacyWarStart",
     -- Conditional trigger
     function(context)
          return cm:is_faction_ruler_of_dynasty(cm:get_faction(context.stored_table.previous_ruling_faction_key))
     end,
     -- Callback
     function(context)
          if context.stored_table.previous_ruling_faction_key == nil then
               return
          end

          local faction = cm:get_faction(context.stored_table.previous_ruling_faction_key)

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               deed_param_types.string,
               faction:name(),
               deeds_config.be_supreme_leader_during_legitimacy_war)
     end,
     -- Persistency
     true
)

-- Lose a vassal
-- We need 2 events for this one, the first one might occur through Diplomacy, the other one if the vassal faction is destroyed
core:add_listener(
     "PharDeeds_LoseAVassal_Diplomacy",
     "NegativeDiplomaticEvent",
     -- Conditional trigger
     true,
     -- Callback
     function(context)
          if context:was_subjugation() == false then
               return
          end

          local former_sovereign
          local former_vassal

          if context:proposer_was_subject() == true then
               former_sovereign = context:recipient()
               former_vassal = context:proposer()
          else
               former_sovereign = context:proposer()
               former_vassal = context:recipient()
          end

          if cm:is_faction_ruler_of_dynasty(former_sovereign) == false then
               return
          end

          local param_type
          if former_vassal:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(former_sovereign)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               former_vassal:name(),
               deeds_config.lose_a_vassal)
     end,
     -- Persistency
     true
)

core:add_listener(
     "PharDeeds_LoseAVassal_FactionDestroyed",
     "FactionDestroyed",
     -- Conditional trigger
     true,
     -- Callback
     function(context)
          local destroyed_faction = context:faction()
          local sovereign = destroyed_faction:get_sovereign()

          if cm:is_faction_ruler_of_dynasty(sovereign) == false then
               return
          end

          local param_type
          if destroyed_faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(former_sovereign)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               destroyed_faction:name(),
               deeds_config.lose_a_vassal)
     end,
     -- Persistency
     true
)

-- Do not use court action for 4 consecutive turns
core:add_listener(
     "PharDeeds_DoNotUseCourtActionFor4Turns",
     "FactionTurnEnd",
     -- Conditional trigger
     function(context)
          local court_unlock_turn = feature_unlock.get_feature_unlock_turn_for_faction(context:faction():name(),
               feature_ids_config.court)
          local current_turn = cm:turn_number()

          if current_turn < court_unlock_turn then
               return
          else
               return cm:is_faction_ruler_of_dynasty(context:faction())
          end
     end,
     -- Callback
     function(context)
          local faction = context:faction()

          if court.util_functions.get_court_actions_used_this_turn(faction:name()) > 0 then
               return
          end

          local param_type
          -- Usual rebel faction check
          if faction:is_rebel() then
               param_type = deed_param_types.rebel_faction
          else
               param_type = deed_param_types.faction
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               faction:name(),
               deeds_config.dont_use_court_action_for_four_turns)
     end,
     -- Persistency
     true
)

-- Have one of your monument razed
core:add_listener(
     "PharDeeds_HaveAMonumentRazed",
     "CharacterPerformsRegionSlotOccupationDecisionBeforeOutcomeApplication",
     -- Conditional trigger
     function(context)
          if context:occupation_decision_option() ~= "occupation_decision_ers_raze_without_occupy" then
               return
          else
               return cm:is_faction_ruler_of_dynasty(context:character():region():owning_faction())
          end
     end,
     -- Callback
     function(context)
          local owning_faction = context:character():region():owning_faction()
          local region = context:character():region()
          local decision = context:occupation_decision_option()

          -- Monuments cant be in settlements, were only looking for ERS
          local slot = context:region_slot()

          if slot:building() then
               if slot:building():superchain() ~= "phar_main_ers_monument" then
                    return
               end
          elseif slot:is_there_construction() then
               if slot:construction_building_chain_superchain() ~= "phar_main_ers_monument" then
                    return
               end
          end

          local param_type
          local param_key
          if not region:is_null_interface() then
               param_key = region:command_queue_index()
               param_type = deed_param_types.region
          else
               local region_data = character:region_data()
               if region_data and not region_data:is_null_interface() then
                    param_key = region_data:key()
                    param_type = deed_param_types.region_data
               end
          end

          local dynasty_key = cm:get_dynasty_ruled_by_faction(owning_faction)
          cm:notify_deed_progress(
               dynasty_key,
               param_type,
               param_key,
               deeds_config.have_a_monument_razed)
     end,
     -- Persistency
     true
)
