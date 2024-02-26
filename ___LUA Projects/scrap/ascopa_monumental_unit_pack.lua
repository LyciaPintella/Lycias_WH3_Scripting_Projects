--[[
	Script by Ascopa
	Adds custom Regiments of Renown to specified factions
]]
--Edited to function with total war warhammer 3, by All is Dust

local function mon_asc_ror()

	-- Checking whether the script has already run for saved games and if it has then the script doesn't need to run again
	if cm:get_saved_value("custom_ror_enabled_mon") == nil then

		-- Table for faction, unit key and parameters for add_unit_to_faction_mercenary_pool. Every entry must have a "," at the end except the last
		local cror_list = {
        --Slanesh und Chaos
            {faction_key = "wh3_main_sla_seducers_of_slaanesh", unit = "Tdv", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Tdv"},
            {faction_key = "wh3_main_dae_daemon_prince", unit = "Tdv", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Tdv"},
            {faction_key = "wh2_main_def_cult_of_pleasure", unit = "Tdv", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1},
            {faction_key = "wh2_main_def_hag_graef", unit = "Tdv", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1},
        --Cathai
            {faction_key = "wh3_main_cth_the_northern_provinces", unit = "Drachenbanner", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Drachenbanner"},
            {faction_key = "wh3_main_cth_the_northern_provinces", unit = "ror_cth_feuerrep", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_cth_feuerrep"},
            {faction_key = "wh3_main_cth_the_western_provinces", unit = "Drachenbanner", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Drachenbanner"},
            {faction_key = "wh3_main_cth_the_western_provinces", unit = "ror_cth_feuerrep", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_cth_feuerrep"},
        --Echsenmenschen
            {faction_key = "wh2_dlc12_lzd_cult_of_sotek", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_dlc13_lzd_spirits_of_the_jungle", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_dlc17_lzd_oxyotl", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_main_lzd_hexoatl", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_main_lzd_itza", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_main_lzd_last_defenders", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_main_lzd_lizardmen", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
            {faction_key = "wh2_main_lzd_tlaqua", unit = "lzd_evocati", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "lzd_evocati"},
        --Dunkelelfen
            {faction_key = "wh2_dlc11_def_the_blessed_dread", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_main_def_cult_of_pleasure", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_main_def_hag_graef", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_main_def_har_ganeth", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_main_def_naggarond", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_twa03_def_rakarth", unit = "Shadow_assassins_0", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "Shadow_assassins_0"},
            {faction_key = "wh2_dlc11_def_the_blessed_dread", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
            {faction_key = "wh2_main_def_cult_of_pleasure", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
            {faction_key = "wh2_main_def_hag_graef", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
            {faction_key = "wh2_main_def_har_ganeth", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
            {faction_key = "wh2_main_def_naggarond", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
            {faction_key = "wh2_twa03_def_rakarth", unit = "asc_claw_magic", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "asc_claw_magic"},
        --Hochelfen
            {faction_key = "wh2_dlc15_hef_imrik", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
            {faction_key = "wh2_main_hef_avelorn", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
            {faction_key = "wh2_main_hef_eataine", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
            {faction_key = "wh2_main_hef_nagarythe", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
            {faction_key = "wh2_main_hef_order_of_loremasters", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
            {faction_key = "wh2_main_hef_yvresse", unit = "hugh_arm_crossbows", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1,
            xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "hugh_arm_crossbows"},
         --Waldelfen
            {faction_key = "wh2_dlc16_wef_drycha", unit = "ror_we_daughters", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_daughters"},
            {faction_key = "wh2_dlc16_wef_sisters_of_twilight", unit = "ror_we_daughters", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_daughters"},
            {faction_key = "wh_dlc05_wef_argwylon", unit = "ror_we_daughters", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_daughters"},
            {faction_key = "wh_dlc05_wef_wood_elves", unit = "ror_we_daughters", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_daughters"},
            {faction_key = "wh2_dlc16_wef_drycha", unit = "ror_we_taroc", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_taroc"},
            {faction_key = "wh2_dlc16_wef_sisters_of_twilight", unit = "ror_we_taroc", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_taroc"},
            {faction_key = "wh_dlc05_wef_argwylon", unit = "ror_we_taroc", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_taroc"},
            {faction_key = "wh_dlc05_wef_wood_elves", unit = "ror_we_taroc", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "ror_we_taroc"},
          --Vampire
            {faction_key = "wh2_dlc11_vmp_the_barrow_legion", unit = "wh_main_vmp_cav_hellsteeds", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "wh_main_vmp_cav_hellsteeds"},
            {faction_key = "wh3_main_vmp_caravan_of_blue_roses", unit = "wh_main_vmp_cav_hellsteeds", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "wh_main_vmp_cav_hellsteeds"},
            {faction_key = "wh_main_vmp_schwartzhafen", unit = "wh_main_vmp_cav_hellsteeds", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "wh_main_vmp_cav_hellsteeds"},
            {faction_key = "wh_main_vmp_vampire_counts", unit = "wh_main_vmp_cav_hellsteeds", merc_pool = "renown", count = 1, rcp = 100, munits = 10, murpt = 0.1, xplevel = 0, frr = "", srr = "", trr = "", replen = true, merc_group = "wh_main_vmp_cav_hellsteeds"}
		};

		-- Loop for the table above
		for i = 1, #cror_list do
			local faction_name = cror_list[i].faction_key;	-- Faction whose pool the unit(s) should be added to
			local faction = cm:get_faction(faction_name);	-- FACTION_SCRIPT_INTERFACE
			local unit_key = cror_list[i].unit;				-- Key of unit to add to the mercenary pool, from the main_units table
            local pool = cror_list[i].merc_pool;            --NEW, found in "ui_mercenary_recruitment_infos_tables" table, or in "mercenary_pools_tables" beneath UI recruitment info
			local unit_count = cror_list[i].count;			-- Number of units to add to the mercenary pool
			local rcp = cror_list[i].rcp;					-- Replenishment chance, as a percentage
			local munits = cror_list[i].munits;				-- The maximum number of units of the supplied type that the pool is allowed to contain.
			local murpt = cror_list[i].murpt;				-- The maximum number of units of the supplied type that may be added by replenishment per-turn
			local xplevel = cror_list[i].xplevel;			-- The experience level of the units when recruited
			local frr = cror_list[i].frr;					-- (may be empty) The key of the faction who can actually recruit the units, from the factions database table
			local srr = cror_list[i].srr;					-- (may be empty) The key of the subculture who can actually recruit the units, from the cultures_subcultures database table
			local trr = cror_list[i].trr;					-- (may be empty) The key of a technology that must be researched in order to recruit the units, from the technologies database table
			local replen = cror_list[i].replen;				-- Allow replenishment of partial units
            local merc_grup_key = cror_list[i].merc_group; 	--NEW, key used in mercenary_unit_groups_tables can most of the time be the same has main_unit key

			-- Adding the listed unit to the listed faction in the above table
			cm:add_unit_to_faction_mercenary_pool(faction, unit_key, pool, unit_count, rcp, munits, murpt, frr, srr, trr, replen, merc_grup_key);

			-- Debug message for log
			out("CROR: adding the custom ror unit " .. unit_key .. " to " .. faction_name);
		end;

		-- Setting saved value, so that the script doesn't run again when reloaded from a saved game
		cm:set_saved_value("custom_ror_enabled_mon", true);
	end;
end;


cm:add_first_tick_callback(function() mon_asc_ror() end);