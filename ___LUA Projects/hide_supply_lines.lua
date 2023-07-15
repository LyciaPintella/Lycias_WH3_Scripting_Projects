function apply_upkeep_penalty(faction)
	local difficulty = cm:model():combined_difficulty_level();
	local upkeep_penalty_effect_bundle_key = "wh3_main_bundle_force_additional_army_upkeep";

	local effect_bundle = cm:create_new_custom_effect_bundle(upkeep_penalty_effect_bundle_key);
	effect_bundle:set_duration(0);
	local upkeep_value = 1 -- easy
	if cm:model():campaign_name_key() == "wh3_main_chaos" then
		if difficulty == 0 then
			upkeep_value = 1 -- normal
		elseif difficulty == -1 then
			upkeep_value = 2 -- hard
		elseif difficulty == -2 then
			upkeep_value = 4 -- very hard
		elseif difficulty == -3 then
			upkeep_value = 4 -- legendary
		end;
	else
		-- Non-chaos campaigns (Immortal Empires)
		if difficulty == 0 then
			upkeep_value = 1 -- normal
		elseif difficulty == -1 then
			upkeep_value = 2 -- hard
		elseif difficulty == -2 then
			upkeep_value = 4 -- very hard
		elseif difficulty == -3 then
			upkeep_value = 4 -- legendary
		end;
	end

	effect_bundle:add_effect("wh_main_effect_force_all_campaign_upkeep_hidden", "force_to_force_own_factionwide", upkeep_value);
	common.set_context_value("supply_lines_upkeep_value", upkeep_value)

	local mf_list = faction:military_force_list();
	local army_list = {};

	for i = 0, mf_list:num_items() - 1 do
		local current_mf = mf_list:item_at(i);
		local force_type = current_mf:force_type():key()

		if current_mf:has_effect_bundle(upkeep_penalty_effect_bundle_key) then
			cm:remove_effect_bundle_from_force(upkeep_penalty_effect_bundle_key, current_mf:command_queue_index());
		end

		if not current_mf:is_armed_citizenry() and current_mf:has_general() and not current_mf:is_set_piece_battle_army() and not forcetype_upkeep_exclusions[force_type] and leader_subtype_upkeep_exclusions[current_mf:general_character():character_subtype_key()] == nil then
			table.insert(army_list, current_mf);
		end
	end

	-- if there is more than one army, apply the effect bundle to the second army onwards
	if #army_list > 1 then
		for i = 2, #army_list do
			local current_mf = army_list[i];

			if not current_mf:has_effect_bundle(upkeep_penalty_effect_bundle_key) then
				cm:apply_custom_effect_bundle_to_force(effect_bundle, current_mf);
			end
		end
	end
end