local debug_mode = false

local avelorn_units = {
	{ key = "wh2_dlc10_hef_inf_dryads_0", mu = 10, rcp = 20, start = 4 },
	{ key = "wh2_dlc10_hef_mon_treekin_0", mu = 6, rcp = 15, start = 2 },
	{ key = "wh2_dlc10_hef_mon_treeman_0", mu = 2, rcp = 10, start = 1 },
}

local nagarythe_units = {
	{ key = "wh2_dlc10_hef_inf_shadow_walkers_0", mu = 9, rcp = 20, start = 4 },
}

local yvresse_units = {
	{ key = "wh2_dlc15_hef_inf_mistwalkers_faithbearers_0", mu = 8, rcp = 20, start = 8 },
	{ key = "wh2_dlc15_hef_inf_mistwalkers_sentinels_0", mu = 6, rcp = 15, start = 6 },
	{ key = "wh2_dlc15_hef_inf_mistwalkers_skyhawks_0", mu = 6, rcp = 15, start = 6 },
	{ key = "wh2_dlc15_hef_inf_mistwalkers_spireguard_0", mu = 6, rcp = 15, start = 6 },
	{ key = "wh2_dlc15_hef_inf_mistwalkers_griffon_knights_0", mu = 4, rcp = 10, start = 4 },
}

local imrik_units = {
	{ key = "wh2_dlc15_hef_mon_black_dragon_imrik", mu = 1, rcp = 10, start = 1 },
	{ key = "wh2_dlc15_hef_mon_forest_dragon_imrik", mu = 1, rcp = 10, start = 1 },
	{ key = "wh2_dlc15_hef_mon_moon_dragon_imrik", mu = 1, rcp = 10, start = 1 },
	{ key = "wh2_dlc15_hef_mon_star_dragon_imrik", mu = 1, rcp = 10, start = 1 },
	{ key = "wh2_dlc15_hef_mon_sun_dragon_imrik", mu = 1, rcp = 10, start = 1 },
}

local stormrider_units = {
	{ key = "ovn_hef_cav_ellyrian_reavers_shore", mu = 1, rcp = 20, start = 1 },
	{ key = "ovn_hef_inf_archers_sea", mu = 1, rcp = 20, start = 1 },
	{ key = "ovn_hef_inf_archers_fire", mu = 1, rcp = 20, start = 1 },
	{ key = "ovn_hef_inf_archers_wind", mu = 1, rcp = 20, start = 1 },
	{ key = "ovn_hef_inf_spearmen_falcon", mu = 1, rcp = 20, start = 1 },
	{ key = "ovn_hef_inf_spearmen_sapphire", mu = 1, rcp = 20, start = 1 },
}

local function hufh_add_units(faction_obj, which_units)
	for i = 1, #which_units do
		local unit = which_units[i]
		out("HELFUNITS DEBUG Adding " .. unit.key .. " to " .. faction_obj:name())
		cm:add_unit_to_faction_mercenary_pool(
			faction_obj,
			unit.key,
			"renown",
			unit.start, --count
			unit.rcp, --replenishment_chance_percentage
			unit.mu, --max_units
			1, --max_units_replenished_per_turn
			"", --faction restriction
			"", --subculture restriction
			"", --tech restriction
			true,
			"hufh_" .. unit.key
		)
	end
end

local function character_subtype_count(faction_obj)
	local subtype_counts = {}

	local character_list = faction_obj:character_list()

	for i = 0, character_list:num_items() - 1 do
		local subtype_key = character_list:item_at(i):character_subtype_key()
		if subtype_counts[subtype_key] then
			subtype_counts[subtype_key] = subtype_counts[subtype_key] + 1
		else
			subtype_counts[subtype_key] = 1
		end
	end

	return subtype_counts
end

local function add_alastar_listener_if_needed(faction_key)
	if not cm:get_saved_value("hufh_alastar_has_lion_pelt") then
		out("HELFUNITS It isn't clear if Alastar has his lion's pelt, so we'll add a listener.")
		core:add_lookup_listener_callback(
			"helfunits_character_turn_start_faction_name",
			"hufh_alastar",
			faction_key,
			function(context)
				--out ("HELFUNITS CharacterTurnStart hufh_alastar");
				local character = context:character()

				if
					character:character_subtype("wh2_main_hef_prince_alastar")
					and character:faction():name() ~= "wh2_main_hef_eataine"
				then
					if not character:has_ancillary("wh2_main_anc_armour_lions_pelt") then
						cm:force_add_ancillary(
							character,
							"wh2_main_anc_armour_lions_pelt",
							true, --yes, equip right now
							false --do not suppress, instead announce it
						)
					end
					cm:set_saved_value("hufh_alastar_has_lion_pelt", true)
					core:remove_lookup_listener_callback("helfunits_character_turn_start_faction_name", "hufh_alastar")
				end
			end,
			true
		)
	else
		out("HELFUNITS Alastar already has lion's pelt.")
	end
end

local function is_faction_human(faction_key)
	local faction_obj = cm:get_faction(faction_key)
	return faction_obj and (not faction_obj:is_null_interface()) and faction_obj:is_human()
end

--each listener is sufficiently different from the other than there is no joy
--whatsoever in attempting to abstract it.  Don't bother when you have more
--important things to do.
local function install_listeners_for_asur_faction(faction_key)
	if not is_faction_human("wh2_main_hef_avelorn") then
		if not cm:get_saved_value("hufh_alarielle_units_added") then
			out("HELFUNITS Haven't confederated Alarielle yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_alarielle",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_alarielle");
					if
						context:character():character_subtype("wh2_dlc10_hef_alarielle")
						and context:character():faction():name() ~= "wh2_main_hef_avelorn"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found Alarielle and she isn't with Avelorn!")
						hufh_add_units(faction, avelorn_units)
						cm:set_saved_value("hufh_alarielle_units_added", true)
						cm:set_saved_value("hufh_not_wood_elfs", true)

						cm:callback(function()
							cm:show_message_event_located(
								faction:name(),
								"event_feed_strings_text_hufh_primary_detail",
								"event_feed_strings_text_hufh_secondary_detail",
								"event_feed_strings_text_hufh_avelorn_flavour_text",
								faction:home_region():settlement():logical_position_x(),
								faction:home_region():settlement():logical_position_y(),
								true,
								31306
							)
						end, 1)

						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_alarielle"
						)
					end
				end,
				true
			)
		end
	else
		out("HELFUNITS Alarielle is human, no listeners needed!")
	end

	if not is_faction_human("wh2_main_hef_nagarythe") then
		if not cm:get_saved_value("hufh_alithanar_units_added") then
			out("HELFUNITS Haven't confederated ALEAF ANAR yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_alithanar",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_alithanar");
					if
						context:character():character_subtype("wh2_dlc10_hef_alith_anar")
						and context:character():faction():name() ~= "wh2_main_hef_nagarythe"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found ALEAF ANAR and he isn't with Nagarythe!")
						hufh_add_units(faction, nagarythe_units)
						cm:set_saved_value("hufh_alithanar_units_added", true)

						cm:callback(function()
							cm:show_message_event_located(
								faction:name(),
								"event_feed_strings_text_hufh_primary_detail",
								"event_feed_strings_text_hufh_secondary_detail",
								"event_feed_strings_text_hufh_nagarythe_flavour_text",
								faction:home_region():settlement():logical_position_x(),
								faction:home_region():settlement():logical_position_y(),
								true,
								31307
							)
						end, 1)
						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_alithanar"
						)
					end
				end,
				true
			)
		else
			out("HELFUNITS Already confederated ALEAF ANAR.")
		end
	else
		out("HELFUNITS ALEAF ANAR is human, no listeners needed!")
	end

	if not is_faction_human("wh2_dlc15_hef_imrik") then
		if not cm:get_saved_value("hufh_imrik_units_added") then
			out("HELFUNITS Haven't confederated Imrik yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_imrik",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_imrik");
					if
						context:character():character_subtype("wh2_dlc15_hef_imrik")
						and context:character():faction():name() ~= "wh2_dlc15_hef_imrik"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found Imrik and he isn't with Knights of Caledor!")
						hufh_add_units(faction, imrik_units)
						cm:set_saved_value("hufh_imrik_units_added", true)

						cm:callback(function()
							cm:show_message_event_located(
								faction:name(),
								"event_feed_strings_text_hufh_primary_detail",
								"event_feed_strings_text_hufh_secondary_detail",
								"event_feed_strings_text_hufh_imrik_flavour_text",
								faction:home_region():settlement():logical_position_x(),
								faction:home_region():settlement():logical_position_y(),
								true,
								31310
							)
						end, 1)
						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_imrik"
						)
					end
					--out ("HELFUNITS CharacterTurnStart hufh_imrik complete");
				end,
				true
			)
		else
			out("HELFUNITS Already confederated Imrik.")
		end
	else
		out("HELFUNITS Imrik is human, no listeners needed!")
	end

	if not is_faction_human("wh2_main_hef_yvresse") then
		if not cm:get_saved_value("hufh_eltharion_units_added") then
			out("HELFUNITS Haven't confederated Eltharion yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_eltharion",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_eltharion");
					if
						context:character():character_subtype("wh2_dlc15_hef_eltharion")
						and context:character():faction():name() ~= "wh2_main_hef_yvresse"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found Eltharion and he isn't with Yvresse!")

						cm:apply_effect_bundle("hufh_mistwalker_time", faction:name(), -1)
						hufh_add_units(faction, yvresse_units)
						cm:set_saved_value("hufh_eltharion_units_added", true)

						cm:callback(function()
							cm:show_message_event_located(
								faction:name(),
								"event_feed_strings_text_hufh_primary_detail",
								"event_feed_strings_text_hufh_secondary_detail",
								"event_feed_strings_text_hufh_yvresse_flavour_text",
								faction:home_region():settlement():logical_position_x(),
								faction:home_region():settlement():logical_position_y(),
								true,
								31308
							)
						end, 1)
						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_eltharion"
						)
					end
				end,
				true
			)
		else
			out("HELFUNITS Already confederated Eltharion.")
		end
	else
		out("HELFUNITS Eltharion is human, no listeners needed!")
	end

	if not is_faction_human("wh2_main_hef_eataine") then
		if not cm:get_saved_value("hufh_tyrion_units_added") then
			out("HELFUNITS Haven't confederated Tyrion yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_tyrion",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_tyrion");
					if
						context:character():character_subtype("wh2_main_hef_tyrion")
						and context:character():faction():name() ~= "wh2_main_hef_eataine"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found Tyrion and he isn't with Eataine.  Yay.")

						local csc = character_subtype_count(faction)
						if csc["wh2_main_hef_prince_alastar"] then
							out(
								"HELFUNITS Tyrion already recruited Alastar.  Nice to know Tyrion wasn't completely useless!"
							)
							cm:callback(function()
								cm:show_message_event_located(
									faction:name(),
									"event_feed_strings_text_hufh_primary_detail",
									"event_feed_strings_text_hufh_secondary_detail",
									"event_feed_strings_text_hufh_eataine_got_alastar",
									faction:home_region():settlement():logical_position_x(),
									faction:home_region():settlement():logical_position_y(),
									true,
									31309
								)
							end, 1)
						else
							--this should prevent us from duplicating Alastar if Legendary Confederations is enabled.
							if cm:get_saved_value("v_wh2_main_hef_prince_alastar_LL_unlocked") then
								--Legendary Confederations already handles this.
								out(
									"HELFUNITS Legendary Confederations mod is active, so Alastar should already be available."
								)
								cm:set_saved_value("hufh_alastar_has_lion_pelt", true)
							else
								out("HELFUNITS adding Alastar to recruitable pool.")
								cm:spawn_character_to_pool(
									faction:name(),
									"names_name_2147360555",
									"names_name_2147360560",
									"",
									"",
									18,
									true,
									"general",
									"wh2_main_hef_prince_alastar",
									true,
									""
								)
							end

							cm:callback(function()
								cm:show_message_event_located(
									faction:name(),
									"event_feed_strings_text_hufh_primary_detail",
									"event_feed_strings_text_hufh_secondary_detail",
									"event_feed_strings_text_hufh_eataine_flavour_text",
									faction:home_region():settlement():logical_position_x(),
									faction:home_region():settlement():logical_position_y(),
									true,
									31309
								)
							end, 1)
						end

						cm:set_saved_value("hufh_tyrion_units_added", true)
						add_alastar_listener_if_needed(context:character():faction():name())
						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_tyrion"
						)
					end
					--out ("HELFUNITS CharacterTurnStart hufh_tyrion complete");
				end,
				true
			)
		else
			out("HELFUNITS Already confederated Tyrion.")
			add_alastar_listener_if_needed()
		end
	else
		out("HELFUNITS Tyrion is human, no listeners needed!")
	end

	if core:is_mod_loaded("ovn_cod_naval_defender") and not is_faction_human("wh2_main_hef_citadel_of_dusk") then
		if not cm:get_saved_value("hufh_stormrider_units_added") then
			out("HELFUNITS Haven't confederated Althran Stormrider yet, so adding HUFH listener.")
			core:add_lookup_listener_callback(
				"helfunits_character_turn_start_faction_name",
				"hufh_stormrider",
				faction_key,
				function(context)
					--out ("HELFUNITS CharacterTurnStart hufh_stormrider");
					if
						context:character():character_subtype("ovn_stormrider")
						and context:character():faction():name() ~= "wh2_main_hef_citadel_of_dusk"
					then
						local faction = context:character():faction()
						out("HELFUNITS We found Althran Stormrider and he isn't with Citadel of Dusk!")

						hufh_add_units(faction, stormrider_units)
						cm:set_saved_value("hufh_stormrider_units_added", true)

						cm:callback(function()
							cm:show_message_event_located(
								faction:name(),
								"event_feed_strings_text_hufh_primary_detail",
								"event_feed_strings_text_hufh_secondary_detail",
								"event_feed_strings_text_hufh_stormrider_flavour_text",
								faction:home_region():settlement():logical_position_x(),
								faction:home_region():settlement():logical_position_y(),
								true,
								31326
							)
						end, 1)
						core:remove_lookup_listener_callback(
							"helfunits_character_turn_start_faction_name",
							"hufh_stormrider"
						)
					end
				end,
				true
			)
		else
			out("HELFUNITS Already confederated Althran Stormrider.")
		end
	else
		out("HELFUNITS Either Althran Stormrider is human or OvN isn't loaded. Either way, no listeners needed.")
	end
end

function helf_units_for_helfs()
	core:declare_lookup_listener("helfunits_character_turn_start_faction_name", "CharacterTurnStart", function(context)
		return context:character():faction():name()
	end)

	local hf = cm:get_human_factions()
	local player_is_helf = false
	for ii = 1, #hf do
		local faction_key = hf[ii]
		local faction = cm:get_faction(faction_key)
		if "wh2_main_sc_hef_high_elves" == faction:subculture() then
			out("HELFUNITS " .. faction_key .. " is human.")
			player_is_helf = true
			install_listeners_for_asur_faction(faction_key)
		end
	end

	if not player_is_helf then
		out("HELFUNITS no human players are elfs, so we're not installing listeners.")
		return
	end
end
