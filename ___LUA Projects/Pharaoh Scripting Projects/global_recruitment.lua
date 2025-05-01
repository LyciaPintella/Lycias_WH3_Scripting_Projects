		local faction = cm:get_faction(faction_key)
		if (not faction) or faction:is_null_interface() then
			script_error("imagine just not having global recruitment" .. tostring(faction_key))
			return
		end

		self.persistent.active_faction = faction_key

		-- Can recruit units available in any province of the faction anywhere in its territory
		cm:faction_override_campaign_feature(faction_key, "factionwide_recruitment", true)

		-- Can recruit units available to allies and vassals
		--cm:faction_override_campaign_feature(faction_key, "factionwide_shared_recruitment", true)

		-- Apply the background global recruitment penalties
		cm:apply_effect_bundle("phar_map_al_perseus_global_recruitment_penalties", faction_key, -1)

		-- Apply the unity effect bundle for the current tier
		self:update_unity()

		--[[
           Give the initial ancillaries to the faction to allow hosting the games immediately
		for _, ancillary in ipairs(self.config.host_games.games_initial_prizes) do
			cm:add_ancillary_to_faction(faction_key, ancillary, true)
		end
          ]]--

		-- Activate the button in the UI
		local local_faction = cm:get_local_faction_name(true)
		if (faction_key == local_faction) then
			egypt_political_states:activate_button(self.ui.config.legacy_panel_button_id, true)
		end
	end,