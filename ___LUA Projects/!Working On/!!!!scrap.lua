local glorfindel_turns_available = 30		-- Turns that glorfindel are available for the player after appearing
local glorfindel_turns_available_ai = 20	-- Turns that glorfindel are available for the AI after appearing
local glorfindel_cooldown_turns = 10		-- Turns before glorfindel appear for the AI after the player has them
local glorfindel_cooldown_turns_ai = 10		-- Turns before glorfindel appear for the player after the AI has them
local glorfindel_subculture_details = {
	["wh_main_sc_emp_empire"] = {"wh_main_emp_tavern_1"}, -- The buildings that can unlock the characters when playing as this subculture
	["wh_main_sc_brt_bretonnia"] = {"wh_main_brt_tavern_1"},
	["wh_main_sc_teb_teb"] = {"wh_main_emp_tavern_1"},
	["wh3_main_sc_ksl_kislev"] = {"wh3_main_ksl_growth_recruit_cost_2"},
	["wh2_main_sc_hef_high_elves"] = {"wh2_main_hef_order_2"},
	["wh_dlc05_sc_wef_wood_elves"] = {"wh_dlc05_wef_public_order_2"},
	["wh3_main_sc_cth_cathay"] = {"wh3_main_cth_growth_yin_2"}
}
local glorfindel_state = {
	building = 1,
	marker = 2,
	spawned = 3,
	spawned_ai = 4,
	cooldown = 5,
	cooldown_ai = 6
}
local glorfindel_details = {
	player_origin = false,
	owner = false,
	state = glorfindel_state.building,
	marker_pending = false,
	level = 1,
	cooldown = 0,
	spawn_turn = 0,
	glorfindel_cqi = 0,
	spawn_cqi = 0
}

function add_glorfindel_listeners()
	out("#### Adding glorfindel Listeners ####")

	if cm:is_new_game() then
		glorfindel_details.state = glorfindel_state.building
		glorfindel_details.cooldown = 0
		glorfindel_details.level = 1
		glorfindel_details.spawn_turn = 0
		glorfindel_details.glorfindel_cqi = 0
	end

	glorfindel_setup()
end

function glorfindel_find_available_ai_faction()
	local faction_list = cm:model():world():faction_list()
	local possible_factions = {}

	for i = 0, faction_list:num_items() - 1 do
		local faction = faction_list:item_at(i)

		if not faction:is_human() and not faction:is_quest_battle_faction() and not faction:is_dead() then
			local faction_key = faction:name()

			if glorfindel_subculture_details[faction:subculture()] then
				table.insert(possible_factions, faction_key)
			end
		end
	end

	return possible_factions[cm:random_number(#possible_factions)]
end

function glorfindel_setup()
	-- Building Completed
	core:add_listener(
		"glorfindel_BuildingCompleted",
		"BuildingCompleted",
		function(context)
            if not cm:get_saved_value("glf_glorfindel_building") then
                cm:set_saved_value("glf_glorfindel_building", true)
                return false
            end
			return glorfindel_details.state == glorfindel_state.building and context:building():faction():is_human()
		end,
		function(context)
			local building = context:building()
			local faction = building:faction()
			local buildings = glorfindel_subculture_details[faction:subculture()]

			if buildings then
				for i = 1, #buildings do
					if buildings[i] == building:name() then
						local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(faction:name(), building:region():name(), false, true, 15)

						if pos_x > -1 then
							cm:add_interactable_campaign_marker("glorfindel_marker", "glorfindel_marker", pos_x, pos_y, 2)
							glorfindel_details.state = glorfindel_state.marker

							local function show_glorfindel_appear_event(event_faction, x, y)
								cm:show_message_event_located(
									event_faction:name(),
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_title",
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_appear_primary_detail",
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_appear_secondary_detail",
									x,
									y,
									false,
									810
								)
							end

							local team_mates = faction:team_mates()

							for j = 0, team_mates:num_items() - 1 do
								local current_team_mate = team_mates:item_at(j)

								if glorfindel_subculture_details[current_team_mate:subculture()] then
									show_glorfindel_appear_event(current_team_mate, pos_x, pos_y)
								end
							end

							show_glorfindel_appear_event(faction, pos_x, pos_y)

							core:trigger_event("ScriptEventglorfindelPubBuilt")
						end
						break
					end
				end
			end
		end,
		true
	)

	-- Marker Entered
	core:add_listener(
		"glorfindel_AreaEntered",
		"AreaEntered",
		function(context)
			return context:area_key() == "glorfindel_marker"
		end,
		function(context)
			local character = context:family_member():character()

			if not character:is_null_interface() then
				local faction = character:faction()

				if faction:is_human() and glorfindel_subculture_details[faction:subculture()] then
					glorfindel_details.spawn_cqi = character:command_queue_index()
					glorfindel_details.marker_pending = glorfindel_details.marker_pending or false

					if not glorfindel_details.marker_pending then
						glorfindel_details.marker_pending = true
						cm:trigger_dilemma(faction:name(), "glf_glorfindel_dilemma")
					end
				end
			end
		end,
		true
	)

	-- Dilemma Choice
	core:add_listener(
		"glorfindel_DilemmaChoiceMadeEvent",
		"DilemmaChoiceMadeEvent",
		function(context)
			return context:dilemma() == "glf_glorfindel_dilemma"
		end,
		function(context)
			glorfindel_details.marker_pending = false

			if context:choice() == 0 then
				local faction = context:faction()
				local faction_name = faction:name()
				glorfindel_details.player_origin = faction_name
				glorfindel_details.owner = faction_name
				local character = cm:get_character_by_cqi(glorfindel_details.spawn_cqi)

				if character then
					local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_character(faction_name, cm:char_lookup_str(character), true, 2)

					if pos_x > 1 then
						local function spawn_glorfindel_post_dilemma(intervention)
							-- Spawn glorfindel
							cm:create_force_with_general(
								faction_name,
								"",
								character:region():name(),
								pos_x,
								pos_y,
								"general",
								"glf_hef_glorfindel",
								"names_name_7486124633",
								"",
								"",
								"",
								false
							)

							glorfindel_details.state = glorfindel_state.spawned
							glorfindel_details.level = glorfindel_details.level + 1
							glorfindel_details.cooldown = glorfindel_turns_available
							if glf_LC_settings["glf_hef_glorfindel_duration"] == "longer" then
                                glorfindel_details.cooldown = 60
                                local incident_payload = cm:create_payload()
                                local effect_bundle = cm:create_new_custom_effect_bundle("glf_glorfindel_cooldown")
                                effect_bundle:set_duration(60)
                                incident_payload:effect_bundle_to_faction(effect_bundle)
                                cm:trigger_custom_incident(faction_name, "glf_glorfindel_incident_neu_unlocking", true, incident_payload)
                            elseif glf_LC_settings["glf_hef_glorfindel_duration"] == "permanent" then
                                glorfindel_details.cooldown = 100
                            else
                                glorfindel_details.cooldown = glorfindel_turns_available
                                local incident_payload = cm:create_payload()
                                local effect_bundle = cm:create_new_custom_effect_bundle("glf_glorfindel_cooldown")
                                effect_bundle:set_duration(glorfindel_turns_available)
                                incident_payload:effect_bundle_to_faction(effect_bundle)
                                cm:trigger_custom_incident(faction_name, "glf_glorfindel_incident_neu_unlocking", true, incident_payload)
                            end
							trigger_glorfindel_cutscene("glorfindel_arrival", glorfindel_details.spawn_cqi, {pos_x, pos_y}, false, intervention)
						end

						if cm:is_multiplayer() then
							spawn_glorfindel_post_dilemma()
						else
							cm:trigger_transient_intervention(
								"g_g_spawn_on_dilemma",
								function(intervention)
									spawn_glorfindel_post_dilemma(intervention)
								end,
								BOOL_INTERVENTIONS_DEBUG,
								function(intervention)
									-- allow transient scripted event to be shown while intervention is active
									intervention:whitelist_events("faction_event_incidentevent_feed_target_incident_faction")
									intervention:whitelist_events("faction_event_character_incidentevent_feed_target_incident_faction")
									intervention:whitelist_events("faction_event_region_incidentevent_feed_target_incident_faction")
								end
							)
						end

						cm:remove_interactable_campaign_marker("glorfindel_marker")
					end
				end
			end
		end,
		true
	)

	-- Set Character CQI's
	core:add_listener(
		"glorfindel_created",
		"CharacterCreated",
		function(context)
			local character = context:character()
			return character:character_subtype("glf_hef_glorfindel")
		end,
		function(context)
			local character = context:character()
			local char_lookup_str = cm:char_lookup_str(character)
			local char_cqi = character:command_queue_index()

			cm:callback(
				function()
					cm:replenish_action_points(char_lookup_str)
					cm:set_character_immortality(char_lookup_str, true)
				end,
				0.5
			)

			if character:character_subtype("glf_hef_glorfindel") then
				-- glorfindel has spawned
				glorfindel_details.glorfindel_cqi = char_cqi

				cm:callback(
					function()
						local glorfindel_char = cm:get_character_by_cqi(glorfindel_details.glorfindel_cqi)

						if glorfindel_char and not glorfindel_char:has_ancillary("glf_anc_armour_glf_hef_glorfindel_helm") then
							cm:force_add_ancillary(glorfindel_char, "glf_anc_armour_glf_hef_glorfindel_helm", true, true)
						end
						if glorfindel_char and not glorfindel_char:has_ancillary("glf_anc_weapon_glf_hef_glorfindel_sword") then
							cm:force_add_ancillary(glorfindel_char, "glf_anc_weapon_glf_hef_glorfindel_sword", true, true)
						end
					end,
					0.5
				)

			end
		end,
		true
	)

	-- Turns Available
	core:add_listener(
		"glorfindel_FactionBeginTurnPhaseNormal",
		"FactionBeginTurnPhaseNormal",
		function(context)
			return glorfindel_details.owner and context:faction():name() == glorfindel_details.owner and (glorfindel_details.state == glorfindel_state.spawned or glorfindel_details.state == glorfindel_state.spawned_ai) and glorfindel_details.cooldown > 0 and not glf_LC_settings["glf_hef_glorfindel_duration"]
		end,
		function(context)
			glorfindel_details.cooldown = glorfindel_details.cooldown - 1

			if glorfindel_details.cooldown == 0 then
				local glorfindel_char = cm:get_character_by_cqi(glorfindel_details.glorfindel_cqi)
				local glorfindel_owner_is_human = cm:get_faction(glorfindel_details.owner):is_human()

				if not glorfindel_owner_is_human or not glorfindel_char then
					kill_glorfindel_characters()
					return
				end

				local function destroy_glorfindel_post_cooldown(intervention)
					-- verify that glorfindel exists on the map before proceeding
					if not glorfindel_char then
						kill_glorfindel_characters()
						intervention:complete()
						return
					end

					cm:show_message_event(
						glorfindel_details.owner,
						"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_title",
						"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_leave_primary_detail",
						"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_leave_secondary_detail",
						false,
						1309
					)

					if glorfindel_owner_is_human then
						core:trigger_event("ScriptEventglorfindelDepart")
					end

					trigger_glorfindel_cutscene("glorfindel_departure", glorfindel_details.glorfindel_cqi, {glorfindel_char:logical_position_x(), glorfindel_char:logical_position_y()}, true, intervention)
				end

				if cm:is_multiplayer() then
					destroy_glorfindel_post_cooldown()
				else
					-- wrap G + F leaving in an intervention, as it shows a cutscene
					cm:trigger_transient_intervention(
						"g_g_leave_faction_turn_start",
						function(intervention)
							destroy_glorfindel_post_cooldown(intervention)
						end,
						BOOL_INTERVENTIONS_DEBUG,
						function(intervention)
							-- allow transient scripted event to be shown while intervention is active
							intervention:whitelist_events("scripted_transient_eventevent_feed_target_faction")
						end
					)
				end
			end
		end,
		true
	)

	-- Owner faction died
	core:add_listener(
		"glorfindel_FactionBeginTurnPhaseNormalDead",
		"WorldStartRound",
		function()
			if glorfindel_details.owner then
				local owner = cm:get_faction(glorfindel_details.owner)

				return glorfindel_details.state == glorfindel_state.spawned_ai and owner and (owner:is_null_interface() or owner:is_dead())
			end
		end,
		function()
			kill_glorfindel_characters()
		end,
		true
	)

	-- Respawn after cooldown
	core:add_listener(
		"glorfindel_FactionBeginTurnPhaseNormal",
		"WorldStartRound",
		function()
			return glorfindel_details.cooldown > 0 and (glorfindel_details.state == glorfindel_state.cooldown or glorfindel_details.state == glorfindel_state.cooldown_ai)
		end,
		function()
			glorfindel_details.cooldown = glorfindel_details.cooldown - 1

			if glorfindel_details.cooldown == 0 then
				if glorfindel_details.state == glorfindel_state.cooldown then
					local faction = false

					if glorfindel_details.owner then
						faction = cm:get_faction(glorfindel_details.owner)
					end

					if not faction or not faction:is_human() or faction:is_dead() then
						faction = cm:get_faction(glorfindel_find_available_ai_faction())
					end

					glorfindel_details.owner = faction:name()

					-- Spawn them for the AI
					if faction:has_home_region() then
						local region_key = faction:home_region():name()
						local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(glorfindel_details.owner, region_key, false, true, 8)

						if pos_x > 1 then
							-- Spawn glorfindel
							cm:create_force_with_general(
								glorfindel_details.owner,
								"",
								region_key,
								pos_x,
								pos_y,
								"general",
								"glf_hef_glorfindel",
								"names_name_7486124633",
								"",
								"",
								"",
								false
							)

						end

						glorfindel_details.state = glorfindel_state.spawned_ai
						glorfindel_details.cooldown = glorfindel_turns_available_ai
					end
				elseif glorfindel_details.state == glorfindel_state.cooldown_ai then
					-- Spawn them for the player
					local faction = cm:get_faction(glorfindel_details.player_origin)
					local region_list = faction:region_list()
					local possible_regions = {}

					-- build a list of regions that have adjacent regions at war
					for i = 0, region_list:num_items() - 1 do
						local current_region = region_list:item_at(i)
						local adjacent_regions = current_region:adjacent_region_list()

						for j = 1, adjacent_regions:num_items() - 1 do
							local adj_region = adjacent_regions:item_at(j)

							if not adj_region:is_abandoned() and adj_region:owning_faction():at_war_with(faction) then
								table.insert(possible_regions, current_region)
								break
							end
						end
					end

					-- if no regions were found, use the capital
					if #possible_regions == 0 and faction:has_home_region() then
						table.insert(possible_regions, faction:home_region())
					end

					if #possible_regions > 0 then
						-- Spawn the marker
						local region = possible_regions[cm:random_number(#possible_regions)]
						local pos_x, pos_y = cm:find_valid_spawn_location_for_character_from_settlement(faction:name(), region:name(), false, true, 15)

						if pos_x > -1 then
							cm:add_interactable_campaign_marker("glorfindel_marker", "glorfindel_marker", pos_x, pos_y, 2)
							glorfindel_details.state = glorfindel_state.marker

							local function show_glorfindel_reappear_event(event_faction, x, y)

								cm:show_message_event_located(
									event_faction:name(),
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_title",
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_reappear_misc_primary_detail",
									"event_feed_strings_text_glf_event_feed_string_scripted_event_glorfindel_reappear_misc_secondary_detail",
									x,
									y,
									false,
									810
								)
							end

							local team_mates = faction:team_mates()

							for j = 0, team_mates:num_items() - 1 do
								local current_team_mate = team_mates:item_at(j)

								if glorfindel_subculture_details[current_team_mate:subculture()] then
									show_glorfindel_reappear_event(current_team_mate, pos_x, pos_y)
								end
							end

							show_glorfindel_reappear_event(faction, pos_x, pos_y)
						end
					else
						glorfindel_details.state = glorfindel_state.cooldown
						glorfindel_details.cooldown = glorfindel_cooldown_turns
					end
				end
			end
		end,
		true
	)
end

function kill_glorfindel_characters()
	if not (glorfindel_details.state == glorfindel_state.spawned or glorfindel_details.state == glorfindel_state.spawned_ai) then
		return
	end

	local character_killed = false

	cm:disable_event_feed_events(true, "wh_event_category_character", "", "")

	-- remove their ancillaries from the faction
	local faction = cm:get_faction(glorfindel_details.owner)
	if faction then
		cm:force_remove_ancillary_from_faction(faction, "glf_anc_armour_glf_hef_glorfindel_helm")
		cm:force_remove_ancillary_from_faction(faction, "glf_anc_weapon_glf_hef_glorfindel_sword")
	end

	local glorfindel_char = cm:get_character_by_cqi(glorfindel_details.glorfindel_cqi)

	if glorfindel_char and not glorfindel_char:is_null_interface() and glorfindel_char:character_subtype("glf_hef_glorfindel") then
		-- Kill glorfindel
		cm:set_character_immortality(cm:char_lookup_str(glorfindel_details.glorfindel_cqi), false)
		cm:kill_character(glorfindel_details.glorfindel_cqi, false)

		character_killed = true
	end


	cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_character", "", "") end, 0.2)

	if character_killed then
		if glorfindel_details.state == glorfindel_state.spawned then
			-- A.I's turn to have them!
			glorfindel_details.owner =  glorfindel_find_available_ai_faction()
			glorfindel_details.state = glorfindel_state.cooldown
			glorfindel_details.cooldown = glorfindel_cooldown_turns
		elseif glorfindel_details.state == glorfindel_state.spawned_ai then
			-- The Player's turn to have them!
			glorfindel_details.owner = glorfindel_details.player_origin
			glorfindel_details.state = glorfindel_state.cooldown_ai
			glorfindel_details.cooldown = glorfindel_cooldown_turns_ai
		end
	end
end

function trigger_glorfindel_cutscene(key, cqi, loc, kill, intervention)
	local glorfindel = cm:get_character_by_cqi(cqi)

	if glorfindel and not glorfindel:faction():is_human() then
		if kill then
			kill_glorfindel_characters()
		end

		if intervention then
			intervention:complete()
		end

		return
	end

	-- multiplayer, don't play the cutscene
	if not intervention then
		if kill then
			kill_glorfindel_characters()
		end

		return
	end

	local length = 20
	cm:trigger_campaign_vo(key, cm:char_lookup_str(cqi), 3)

	local cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h = cm:get_camera_position()
	cm:take_shroud_snapshot()

	local glorfindel_cutscene = campaign_cutscene:new(
		"glorfindel_cutscene",
		length,
		function()
			cm:modify_advice(true)
			cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h)
			cm:restore_shroud_from_snapshot()
			cm:fade_scene(1, 1)

			-- complete supplied intervention
			if intervention then
				cm:callback(function() intervention:complete() end, 1)
			end
		end
	)

	glorfindel_cutscene:set_skippable(true, function() glorfindel_cutscene_skipped(kill) end)
	glorfindel_cutscene:set_skip_camera(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h)
	glorfindel_cutscene:set_disable_settlement_labels(false)
	glorfindel_cutscene:set_dismiss_advice_on_end(true)

	glorfindel_cutscene:action(
		function()
			cm:fade_scene(0, 2)
			cm:clear_infotext()
		end,
		0
	)

	glorfindel_cutscene:action(
		function()
			cm:show_shroud(false)

			local x_pos, y_pos = cm:log_to_dis(loc[1], loc[2])
			cm:set_camera_position(x_pos, y_pos, cam_skip_d, cam_skip_b, cam_skip_h)
			cm:fade_scene(1, 2)
		end,
		2
	)

	glorfindel_cutscene:action(
		function()
			cm:fade_scene(0, 1)
		end,
		length - 1
	)

	glorfindel_cutscene:action(
		function()
			cm:set_camera_position(cam_skip_x, cam_skip_y, cam_skip_d, cam_skip_b, cam_skip_h)
			cm:fade_scene(1, 1)
			if kill then
				kill_glorfindel_characters()
			end
		end,
		length
	)

	glorfindel_cutscene:start()

	core:add_listener(
		"gskip_camera_after_vo_ended",
		"ScriptTriggeredVOFinished",
		true,
		function()
			glorfindel_cutscene:skip(false)
		end,
		true
	)
end

function glorfindel_cutscene_skipped(kill)
	cm:override_ui("disable_advice_audio", true)

	common.clear_advice_session_history()

	cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5)
	cm:restore_shroud_from_snapshot()
	if kill then
		kill_glorfindel_characters()
	end
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("glorfindel_details", glorfindel_details, context)
	end
)

cm:add_loading_game_callback(
	function(context)
		glorfindel_details = cm:load_named_value("glorfindel_details", {}, context)
	end
)

cm:add_first_tick_callback(function()
    if glf_LC_settings["glf_hef_glorfindel"] then
        add_glorfindel_listeners()
    end
end);