--AAA_Theak_Patron_Gods.pack

local prefix = "Theak_Nurgle_Patron"


cm:add_first_tick_callback(
	function()
		if cm:get_saved_value("theak_units_set_up") == nil then
			cm:add_faction_turn_start_listener_by_subculture(
				prefix.."_custom_nurgle_unit_listener",
				"wh3_main_sc_nur_nurgle",
				function(context)
					if cm:get_saved_value("theak_units_set_up") == nil then
						local faction = context:faction()

                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_marauders_nurgle_throw_axes", "nurgle_buildings", 0, 0, 4, 0, "", "", "", false,"theak_marauders_nurgle_throw_axes")
                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_chosen_nurgle_scythe", "nurgle_buildings", 0, 0, 2, 0, "", "", "", false,"theak_chosen_nurgle_scythe")
                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_chaos_warriors_nurgle_scythe", "nurgle_buildings", 0, 0, 3, 0, "", "", "", false,"theak_chaos_warriors_nurgle_scythe")

                        --cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, source, unit_count, rcp, munits, murpt, frr, srr, trr, replen, merc_unit_group);

                        cm:set_saved_value("theak_units_set_up", true);
					end
				end,
				true
			)
		end
	end
)

		if cm:get_saved_value("theak_units_set_up") == nil then
			cm:add_faction_turn_start_listener_by_subculture(
				prefix.."_custom_nurgle_unit_listener",
				"wh3_dlc25_nur_tamurkhan",
				function(context)
					if cm:get_saved_value("theak_units_set_up") == nil then
						local faction = context:faction()

                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_marauders_nurgle_throw_axes", "nurgle_buildings", 0, 0, 4, 0, "", "", "", false,"theak_marauders_nurgle_throw_axes")
                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_chosen_nurgle_scythe", "nurgle_buildings", 0, 0, 2, 0, "", "", "", false,"theak_chosen_nurgle_scythe")
                        cm:add_unit_to_faction_mercenary_pool(faction, "theak_chaos_warriors_nurgle_scythe", "nurgle_buildings", 0, 0, 3, 0, "", "", "", false,"theak_chaos_warriors_nurgle_scythe")

                        --cm:add_unit_to_faction_mercenary_pool(faction_obj, unit_key, source, unit_count, rcp, munits, murpt, frr, srr, trr, replen, merc_unit_group);

                        cm:set_saved_value("theak_units_set_up", true);
					end
				end,
				true
			)
		end

