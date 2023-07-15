Alarielle = {
	Subtype_Key = "wh2_dlc10_hef_alarielle",
	Faction = nil,
	Faction_Key = "",
	Avelorn_Faction_Key = "wh2_main_hef_avelorn",
    Is_Leading_Avelorn = true,
	Verbose = true,
	Power_of_Nature = {
		Alarielle_Subtype_Key = "wh2_dlc10_hef_alarielle",
		Faction = nil,
		Faction_Key = nil,
		Avelorn_Faction_Key = "wh2_main_hef_avelorn",
		Effect_Bundle_Key = "wh2_dlc10_power_of_nature",
		Regions = {},
		["Cultures"] = {
			["wh2_main_hef_high_elves"] = true,
			["wh2_main_lzd_lizardmen"] = true,
			["wh3_main_cth_cathay"] = true,
			["wh3_main_ksl_kislev"] = true,
			["wh_dlc05_wef_wood_elves"] = true,
			["wh_main_brt_bretonnia"] = true,
			["wh_main_emp_empire"] = true,
			["wh_main_dwf_dwarfs"] = true,
			["ovn_albion"] = true,
		},
		Vfx = {
			Full = "scripted_effect7",
			Half = "scripted_effect8",
		},
		Verbose = false,
	},
	Defender_of_Ulthuan = {
		Faction = nil,
		Faction_Key = nil,
		Effect_Bundle_Key = "",
		Effects = {
			Inner = "wh2_dlc10_defender_of_ulthuan_inner",
			Outer = "wh2_dlc10_defender_of_ulthuan_outer",
			All = "wh2_dlc10_defender_of_ulthuan_all",
		},
		Level = 1,
		Ulthuan_Types = { "Inner", "Outer" },
		Ulthuan_Regions = {
			["Outer"] = {
				["wh3_main_combi_region_vauls_anvil_ulthuan"] = true,
				["wh3_main_combi_region_tor_sethai"] = true,
				["wh3_main_combi_region_whitepeak"] = true,
				["wh3_main_combi_region_tor_anroc"] = true,
				["wh3_main_combi_region_avethir"] = true,
				["wh3_main_combi_region_tor_dranil"] = true,
				["wh3_main_combi_region_tor_anlec"] = true,
				["wh3_main_combi_region_shrine_of_khaine"] = true,
				["wh3_main_combi_region_tor_achare"] = true,
				["wh3_main_combi_region_elisia"] = true,
				["wh3_main_combi_region_shrine_of_kurnous"] = true,
				["wh3_main_combi_region_mistnar"] = true,
				["wh3_main_combi_region_tor_koruali"] = true,
				["wh3_main_combi_region_tor_yvresse"] = true,
				["wh3_main_combi_region_elessaeli"] = true,
				["wh3_main_combi_region_tralinia"] = true,
				["wh3_main_combi_region_shrine_of_loec"] = true,
				["wh3_main_combi_region_cairn_thel"] = true,
			},
			["Inner"] = {
				["wh3_main_combi_region_lothern"] = true,
				["wh3_main_combi_region_tower_of_lysean"] = true,
				["wh3_main_combi_region_tor_elyr"] = true,
				["wh3_main_combi_region_eagle_gate"] = true,
				["wh3_main_combi_region_whitefire_tor"] = true,
				["wh3_main_combi_region_griffon_gate"] = true,
				["wh3_main_combi_region_evershale"] = true,
				["wh3_main_combi_region_unicorn_gate"] = true,
				["wh3_main_combi_region_phoenix_gate"] = true,
				["wh3_main_combi_region_tor_saroir"] = true,
				["wh3_main_combi_region_gaean_vale"] = true,
				["wh3_main_combi_region_tor_finu"] = true,
				["wh3_main_combi_region_white_tower_of_hoeth"] = true,
				["wh3_main_combi_region_port_elistor"] = true,
				["wh3_main_combi_region_angerrial"] = true,
				["wh3_main_combi_region_shrine_of_asuryan"] = true,
			},
			["Outer_Lost"] = 0,
			["Inner_Lost"] = 0,
		},
		["Cultures"] = {
			["wh2_main_hef_high_elves"] = true,
			["wh2_main_lzd_lizardmen"] = true,
			["wh3_main_cth_cathay"] = true,
			["wh3_main_ksl_kislev"] = true,
			["wh_dlc05_wef_wood_elves"] = true,
			["wh_main_brt_bretonnia"] = true,
			["wh_main_emp_empire"] = true,
			["wh_main_dwf_dwarfs"] = true,
            ["ovn_albion"] = true,
            ["mixer_teb_southern_realms"] = true
		},
		Verbose = true,
	},
	Mortal_Worlds_Torment = {
		Verbose = true,
	},
}
⁡⁢⁣⁢--[[
--Heya,
--If you're still wondering about that warning, use function Alarielle.Defender_of_Ulthuan.out(t)
--Alarielle.Defender_of_Ulthuan:out(t) implicitly passes the self argument to whatever function/method you're calling.
--https://cdn.discordapp.com/attachments/1009136110754074624/1110250572059263026/image.png
--Sh1ny
---@diagnostic disable-next-line: undefined-global
--]]⁡
function Alarielle:out(t)
	if self.Verbose then
		ModLog("Alarielle's Confederated Faction Effects: " .. tostring(t) .. ".")
	end
end

function Alarielle.Power_of_Nature:out(t)
	if self.Verbose then
		ModLog("Alarielle's True Power of Nature: " .. tostring(t) .. ".")
	end
end

function Alarielle.Defender_of_Ulthuan:out(t)
	if self.Verbose then
		ModLog("Alarielle - Defender of Ulthuan: " .. tostring(t) .. ".")
	end
end

function Alarielle.Mortal_Worlds_Torment:out(t)
	if self.Verbose then
		ModLog("Alarielle - Mortal World's Torment: " .. tostring(t) .. ".")
	end
end




function Alarielle.Power_of_Nature:Start_Power_of_Nature_Listeners()
	cm:add_faction_turn_start_listener_by_name("Power_of_Nature", self.Faction_Key, function(context)
		local character = context:faction():faction_leader()

		if character:has_region() and not character:is_at_sea() then
			self.out("Alarielle wasn't at sea and she has a region." .. character:is_at_sea() .. "")

			self.Faction = cm:get_faction(character:faction():name())
			local region = character:region()
			local region_key = region:name()
			local region_owning_faction = region:owning_faction()
			local region_culture = region_owning_faction:culture()

			self.out("region's name is: " .. region:name() .. "")
			self.out("region's key is: " .. region_key .. "")
			self.out("region's owning faction's name: " .. region_owning_faction:name() .. "")
			self.out("region's culture is: " .. region_culture .. "")
			self.out("is region abandoned?: " .. region:is_abandoned() .. "")

			if
				not region:is_abandoned()
				and self.Faction:at_war_with(region_owning_faction) == false
				and self["Cultures"][region_culture] ~= nil
			then
				if region:has_effect_bundle(self.Effect_Bundle_Key) then
					cm:remove_effect_bundle_from_region(self.Effect_Bundle_Key, region_key)
				end

				self.out("Apply effect bundle key" .. self.Effect_Bundle_Key .. " to region: " .. region_key .. "")

				cm:apply_effect_bundle_to_region(self.Effect_Bundle_Key, region_key, 15)
				self.Regions[region_key] = 15

				cm:add_garrison_residence_Vfx(region:garrison_residence():command_queue_index(), self.Vfx.Full, false)
				core:trigger_event("ScriptEventPowerOfNatureTriggered")
			end
		end
	end, true)

	-- update the Vfx on each region each turn
	core:add_listener("Power_of_Nature_Region", "RegionTurnStart", function(context)
		return Alarielle.Power_of_Nature.regions[context:region():name()] ~= nil
	end, function(context)
		local region = context:region()
		local region_key = region:name()
		local garrison_residence = region:garrison_residence()
		local garrison_residence_cqi = garrison_residence:command_queue_index()
		local region_culture = region:owning_faction():culture()

		cm:remove_garrison_residence_Vfx(garrison_residence_cqi, self.Vfx.Full)
		cm:remove_garrison_residence_Vfx(garrison_residence_cqi, self.Vfx.Half)

		if region:is_abandoned() or self["Cultures"][region_culture] ~= true then
			cm:remove_effect_bundle_from_region(self.Effect_Bundle_Key, region_key)
		end

		local turns_remaining = self.Regions[region_key]
		turns_remaining = turns_remaining - 1

		if turns_remaining > 7 then
			-- display full Vfx
			cm:add_garrison_residence_Vfx(garrison_residence_cqi, self.Vfx.Full, false)
			self.Regions[region_key] = turns_remaining
		elseif turns_remaining > 0 then
			-- switch to half strength Vfx
			cm:add_garrison_residence_Vfx(garrison_residence_cqi, self.Vfx.Half, false)
			self.Regions[region_key] = turns_remaining
		else
			self.Regions[region_key] = nil
		end
	end, true)
end

function Alarielle.Defender_of_Ulthuan:Initialize(new_game)
	-- populate a lookup table of all relevant regions
	self.Ulthuan_Regions["All"] = {}

	for i = 1, #self.Ulthuan_Types do
		for region_key, value in pairs(self.Ulthuan_Regions[self.Ulthuan_Types[i]]) do
			self.Ulthuan_Regions["All"][region_key] = true
			local region = cm:get_region(region_key)
			local region_owning_faction = region:owning_faction()
			local region_culture = region_owning_faction:culture()

			--self['Cultures'][region_culture] == nil
			if
				region
				and (
					region:is_abandoned()
					or self["Cultures"][region_culture] == nil
					or self.Faction:at_war_with(region_owning_faction) == false
				)
			then
				self.Ulthuan_Regions[self.Ulthuan_Types[i]][region_key] = false
				self.Ulthuan_Regions[self.Ulthuan_Types[i] .. "_lost"] = self.Ulthuan_Regions[self.Ulthuan_Types[i] .. "_lost"]
					+ 1
			end
		end
	end

	self:Remove_Effects()

	if new_game then
		self.Level = 1
	end

	if self.Ulthuan_Regions["Inner_Lost"] > 0 then
		self.Effect = self.Effects.Inner
	elseif self.Ulthuan_Regions["Outer_Lost"] > 0 then
		self.Effect = self.Effects.Outer
	else
		self.Effect = self.Effects.All
	end
	cm:apply_effect_bundle(self.Effect .. "_" .. self.Level, self.Faction_Key, 0)
end

function Alarielle.Defender_of_Ulthuan:Remove_Effects()
	self.Faction = cm:get_faction(self.Faction_Key)

	for i = 1, 10 do
		for j = 1, #self.Effects do
			self.Effect_Bundle_Key = "wh2_dlc10_defender_of_ulthuan_" .. self.Effects[j] .. "_" .. i

			if self.Faction:has_effect_bundle(self.Effect_Bundle_Key) then
				cm:remove_effect_bundle(self.Effect_Bundle_Key, self.Faction_Key)
			end
		end
	end
end

function Alarielle.Defender_of_Ulthuan:Show_Event(region, event_type)
	if event_type == "united" then
		cm:show_message_event(
			self.Faction_Key,
			"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
			"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_primary_detail",
			"event_feed_strings_text_wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_united_secondary_detail",
			false,
			1012
		)
	else
		local settlement = region:settlement()

		cm:show_message_event_located(
			self.Faction_Key,
			"event_feed_strings_text_" .. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_title",
			"event_feed_strings_text_"
				.. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_"
				.. event_type
				.. "_primary_detail",
			"event_feed_strings_text_"
				.. "wh2_dlc10_event_feed_string_scripted_event_defender_of_ulthuan_"
				.. event_type
				.. "_secondary_detail",
			settlement:logical_position_x(),
			settlement:logical_position_y(),
			false,
			1013
		)
	end
end

-- DEFENDER OF ULTHUAN
function Alarielle.Defender_of_Ulthuan:Start_Defender_of_Ulthuan_Listeners()
	if cm:get_faction(Alarielle.Faction_Key):is_human() then
		core:add_listener("Defender_of_Ulthuan_Region_Update", "RegionFactionChangeEvent", function(context)
			return self.Ulthuan_Regions["All"] and self.Ulthuan_Regions["All"][context:region():name()]
		end, function(context)
			local region = context:region()

			if not region:is_null_interface() then
				local region_key = region:name()
				self.out("Defender of Ulthuan Region Update: " .. region_key)
				local ulthuan_type = nil

				if self.Ulthuan_Regions["Outer"][region_key] ~= nil then
					ulthuan_type = "outer"
				elseif self.Ulthuan_Regions["Inner"][region_key] ~= nil then
					ulthuan_type = "inner"
				end

				if ulthuan_type ~= nil then
					if
						self.Ulthuan_Regions[ulthuan_type][region_key] and region:is_abandoned()
						or region:owning_faction():culture() ~= "wh2_main_hef_high_elves"
					then
						self.Ulthuan_Regions[ulthuan_type][region_key] = false
						self.Ulthuan_Regions[ulthuan_type .. "_lost"] = self.Ulthuan_Regions[ulthuan_type .. "_lost"]
							+ 1
						out(
							"\tRegion was true and is now false - Value "
								.. ulthuan_type
								.. "_lost count is "
								.. tostring(self.Ulthuan_Regions[ulthuan_type .. "_lost"])
								.. " (+1)"
						)
					elseif
						not self.Ulthuan_Regions[ulthuan_type][region_key]
						and not region:is_abandoned()
						and region:owning_faction():culture() == "wh2_main_hef_high_elves"
					then
						self.Ulthuan_Regions[ulthuan_type][region_key] = true
						self.Ulthuan_Regions[ulthuan_type .. "_lost"] = self.Ulthuan_Regions[ulthuan_type .. "_lost"]
							- 1
						out(
							"\tRegion was false and is now true - Value "
								.. ulthuan_type
								.. "_lost count is "
								.. tostring(self.Ulthuan_Regions[ulthuan_type .. "_lost"])
								.. " (-1)"
						)
					else
						out("\tNo changes made")
					end

					self:Remove_Effects()

					if self.Ulthuan_Regions["Inner_Lost"] > 0 then
						if self.Effect_Bundle_Key == self.Effect.All or self.Effect_Bundle_Key == self.Effect.Outer then
							self.show_event(region, "inner_lost")
							core:trigger_event("ScriptEventDefenderOfUlthuanInnerLost")
						end

						self.Effect_Bundle_Key = self.Effect.Inner
					elseif self.Ulthuan_Regions["Outer_Lost"] > 0 then
						if self.Effect_Bundle_Key == self.Effect.All then
							self.show_event(region, "outer_lost")
							core:trigger_event("ScriptEventDefenderOfUlthuanOuterLost")
						elseif self.Effect_Bundle_Key == self.Effect.Inner then
							core:trigger_event("ScriptEventDefenderOfUlthuanInnerRegained")
						end

						self.Effect_Bundle_Key = self.Effect.Outer
					else
						if
							self.Effect_Bundle_Key == self.Effect.Outer
							or self.Effect_Bundle_Key == self.Effect.Inner
						then
							self.show_event(region, "united")
							core:trigger_event("ScriptEventDefenderOfUlthuanUnited")
							cm:complete_scripted_mission_objective(
								Alarielle.Faction_Key,
								"wh_main_short_victory",
								"ulthuan_controlled",
								true
							)
						end

						self.Effect_Bundle_Key = self.Effect.All
					end

					self.Level = 1
					cm:apply_effect_bundle(self.Effect_Bundle_Key .. "_" .. self.Level, Alarielle.Faction_Key, 0)
				end
			end
		end, true)

		cm:add_faction_turn_start_listener_by_name(
			"Defender_of_Ulthuan_Region_Update",
			Alarielle.Faction_Key,
			function()
				if self.Level < 10 then
					self.Level = self.Level + 1
				end

				self.Remove_Effects()
				cm:apply_effect_bundle(self.Effect_Bundle_Key .. "_" .. self.Level, Alarielle.Faction_Key, 0)
			end,
			true
		)

		if cm:is_new_game() then
			self.initialize(true)
			-- prevents growth in the phoenix gate province for the first owner
			cm:apply_effect_bundle_to_region(
				"wh2_dlc10_dark_elf_fortress_gate",
				"wh3_main_combi_region_phoenix_gate",
				0
			)
		else
			self.initialize(false)
		end

		cm:add_faction_turn_start_listener_by_name("Defender_of_Ulthuan_Update", Alarielle.Faction_Key, function()
			if self.Level < 10 then
				self.Level = self.Level + 1
			end

			self.Remove_Effects()
			cm:apply_effect_bundle(self.Effect .. "_" .. self.Level, Alarielle.Faction_Key, 0)
		end, true)
	end
end

function add_alarielle_listeners()
	out("Adding Alarielle Listeners")
	-- POWER OF NATURE
	Alarielle.Power_of_Nature:Start_Power_of_Nature_Listeners()

	-- MORTAL WORLDS TORMENT
	Alarielle.Mortal_Worlds_Torment:Start_Mortal_Worlds_Torment_Listener()

	-- DEFENDER OF ULTHUAN
	Alarielle.Defender_of_Ulthuan:Start_Defender_of_Ulthuan_Listeners()

	if cm:is_new_game() then
		Alarielle.Defender_of_Ulthuan:initialize(true)
		-- prevents growth in the phoenix gate province for the first owner
		cm:apply_effect_bundle_to_region("wh2_dlc10_dark_elf_fortress_gate", "wh3_main_combi_region_phoenix_gate", 0)
	else
		Alarielle.Defender_of_Ulthuan:initialize(false)
	end
end

function Alarielle.Mortal_Worlds_Torment:Start_Mortal_Worlds_Torment_Listener()
	cm:add_faction_turn_start_listener_by_name("mortal_worlds_torment", Alarielle.Faction_Key, function(context)
		local faction = context:faction()
		local alarielle = faction:faction_leader()

		local highest_average_corruption = 0
		local average_chaos_corruption = 0
		local average_khorne_corruption = 0
		local average_nurgle_corruption = 0
		local average_slaanesh_corruption = 0
		local average_tzeentch_corruption = 0

		local province_list = faction:provinces()
		local num_provinces = province_list:num_items()

		if num_provinces > 0 then
			for i = 0, num_provinces - 1 do
				local current_province = province_list:item_at(i):province()

				average_chaos_corruption = average_chaos_corruption
					+ cm:get_corruption_value_in_province(current_province, "wh3_main_corruption_chaos")
				average_khorne_corruption = average_khorne_corruption
					+ cm:get_corruption_value_in_province(current_province, "wh3_main_corruption_khorne")
				average_nurgle_corruption = average_nurgle_corruption
					+ cm:get_corruption_value_in_province(current_province, "wh3_main_corruption_nurgle")
				average_slaanesh_corruption = average_slaanesh_corruption
					+ cm:get_corruption_value_in_province(current_province, "wh3_main_corruption_slaanesh")
				average_tzeentch_corruption = average_tzeentch_corruption
					+ cm:get_corruption_value_in_province(current_province, "wh3_main_corruption_tzeentch")
			end

			average_chaos_corruption = math.round(average_chaos_corruption / num_provinces)
			average_khorne_corruption = math.round(average_khorne_corruption / num_provinces)
			average_nurgle_corruption = math.round(average_nurgle_corruption / num_provinces)
			average_slaanesh_corruption = math.round(average_slaanesh_corruption / num_provinces)
			average_tzeentch_corruption = math.round(average_tzeentch_corruption / num_provinces)

			highest_average_corruption = math.max(
				average_chaos_corruption,
				average_khorne_corruption,
				average_nurgle_corruption,
				average_slaanesh_corruption,
				average_tzeentch_corruption
			)
		end

		if faction:has_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0") then
			cm:remove_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0", Alarielle.Faction_Key)
		end

		local effect_bundle = cm:create_new_custom_effect_bundle("wh2_dlc10_bundle_alarielle_corruption_0")
		effect_bundle:set_duration(0)

		if highest_average_corruption == 0 then
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_good",
				"faction_to_faction_own_unseen",
				highest_average_corruption
			)
		else
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount",
				"faction_to_faction_own_unseen",
				highest_average_corruption
			)
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_chaos",
				"faction_to_faction_own_unseen",
				average_chaos_corruption
			)
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_khorne",
				"faction_to_faction_own_unseen",
				average_khorne_corruption
			)
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_nurgle",
				"faction_to_faction_own_unseen",
				average_nurgle_corruption
			)
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_slaanesh",
				"faction_to_faction_own_unseen",
				average_slaanesh_corruption
			)
			effect_bundle:add_effect(
				"wh2_dlc10_effect_alarielle_corruption_amount_tzeentch",
				"faction_to_faction_own_unseen",
				average_tzeentch_corruption
			)
		end

		cm:apply_custom_effect_bundle_to_faction(effect_bundle, faction)

		cm:disable_event_feed_events(true, "wh_event_category_traits_ancillaries", "", "")

		local trait_level = alarielle:trait_points("wh2_dlc10_trait_alarielle_chaos")
		trait_level = trait_level - alarielle:trait_points("wh2_dlc10_trait_alarielle_chaos_none")

		local char_str = cm:char_lookup_str(alarielle)
		cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos")
		cm:force_remove_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none")

		if highest_average_corruption > 75 then
			cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 3)
			core:trigger_event("ScriptEventMortalWorldsTorment4")

			if trait_level < 3 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_increase",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			end
		elseif highest_average_corruption > 50 then
			cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false, 2)
			core:trigger_event("ScriptEventMortalWorldsTorment3")

			if trait_level < 2 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_increase",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			elseif trait_level > 2 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_decrease",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			end
		elseif highest_average_corruption > 25 then
			cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos", false)
			core:trigger_event("ScriptEventMortalWorldsTorment2")

			if trait_level < 1 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_increase",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			elseif trait_level > 1 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_decrease",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			end
		else
			cm:force_add_trait(char_str, "wh2_dlc10_trait_alarielle_chaos_none", false)
			core:trigger_event("ScriptEventMortalWorldsTorment1")

			if trait_level > -1 then
				cm:trigger_incident_with_targets(
					faction:command_queue_index(),
					"wh2_dlc10_incident_hef_alarielle_torment_decrease",
					0,
					0,
					alarielle:command_queue_index(),
					0,
					0,
					0
				)
			end
		end

		cm:callback(function()
			cm:disable_event_feed_events(false, "wh_event_category_traits_ancillaries", "", "")
		end, 0.5)
	end, true)
end

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(function(context)
	cm:save_named_value("Defender_of_Ulthuan_Level", Alarielle.Defender_of_Ulthuan.Level, context)
	cm:save_named_value("Power_of_Nature_Regions", Alarielle.Power_of_Nature.regions, context)
end)

cm:add_loading_game_callback(function(context)
	Alarielle.Defender_of_Ulthuan.Level = cm:load_named_value("Defender_of_Ulthuan_Level", 1, context)
	Alarielle.Power_of_Nature.regions = cm:load_named_value("Power_of_Nature_Regions", {}, context)
end)
