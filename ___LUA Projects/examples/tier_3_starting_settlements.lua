playable_factions = {
    "wh3_main_dae_daemon_prince", "wh3_main_kho_exiles_of_khorne", "wh3_main_nur_poxmakers_of_nurgle", "wh3_main_sla_seducers_of_slaanesh", "wh3_main_tze_oracles_of_tzeentch",
    "wh3_main_ksl_the_ice_court", "wh3_main_ksl_the_great_orthodoxy", "wh3_main_ksl_ursun_revivalists", "wh3_main_ogr_goldtooth", "wh3_main_ogr_disciples_of_the_maw", "wh3_dlc23_chd_astragoth",
    "wh3_dlc23_chd_legion_of_azgorh", "wh3_dlc23_chd_zhatan", "wh3_main_cth_the_northern_provinces", "wh3_main_cth_the_western_provinces", "wh2_main_hef_eataine", "wh2_main_hef_order_of_loremasters",
    "wh2_main_hef_avelorn", "wh2_main_hef_nagarythe", "wh2_main_hef_yvresse", "wh2_dlc15_hef_imrik", "wh2_dlc17_lzd_oxyotl", "wh2_main_lzd_hexoatl", "wh2_main_lzd_last_defenders",
    "wh2_dlc12_lzd_cult_of_sotek", "wh2_main_lzd_tlaqua", "wh2_dlc13_lzd_spirits_of_the_jungle", "wh2_main_lzd_itza", "wh2_main_def_naggarond", "wh2_main_def_cult_of_pleasure",
    "wh2_main_def_har_ganeth", "wh2_dlc11_def_the_blessed_dread", "wh2_main_def_hag_graef", "wh2_twa03_def_rakarth", "wh2_main_skv_clan_mors", "wh2_main_skv_clan_pestilens",
    "wh2_dlc09_skv_clan_rictus", "wh2_main_skv_clan_skryre", "wh2_main_skv_clan_moulder", "wh2_main_skv_clan_eshin", "wh2_dlc09_tmb_khemri", "wh2_dlc09_tmb_lybaras", "wh2_dlc09_tmb_exiles_of_nehek",
    "wh2_dlc09_tmb_followers_of_nagash", "wh2_dlc11_cst_vampire_coast", "wh2_dlc11_cst_noctilus", "wh2_dlc11_cst_the_drowned", "wh2_dlc11_cst_pirates_of_sartosa", "wh_main_emp_empire",
    "wh2_dlc13_emp_golden_order", "wh3_main_emp_cult_of_sigmar", "wh2_dlc13_emp_the_huntmarshals_expedition", "wh_main_dwf_dwarfs", "wh_main_dwf_karak_kadrin", "wh_main_dwf_karak_izor",
    "wh3_main_dwf_the_ancestral_throng", "wh2_dlc17_dwf_thorek_ironbrow", "wh_main_grn_greenskins", "wh_main_grn_crooked_moon", "wh2_dlc15_grn_bonerattlaz", "wh_main_grn_orcs_of_the_bloody_hand",
    "wh2_dlc15_grn_broken_axe", "wh_main_vmp_vampire_counts", "wh2_dlc11_vmp_the_barrow_legion", "wh3_main_vmp_caravan_of_blue_roses", "wh_main_vmp_schwartzhafen", "wh_main_chs_chaos",
    "wh3_dlc20_chs_kholek", "wh3_dlc20_chs_sigvald", "wh3_dlc20_chs_azazel", "wh3_dlc20_chs_festus", "wh3_dlc20_chs_valkia", "wh3_dlc20_chs_vilitch", "wh3_main_chs_shadow_legion",
    "wh_dlc03_bst_beastmen", "wh2_dlc17_bst_malagor", "wh_dlc05_bst_morghur_herd", "wh2_dlc17_bst_taurox", "wh_dlc05_wef_wood_elves", "wh_dlc05_wef_argwylon", "wh2_dlc16_wef_sisters_of_twilight",
    "wh2_dlc16_wef_drycha", "wh_main_brt_bretonnia", "wh_main_brt_carcassonne", "wh_main_brt_bordeleaux", "wh2_dlc14_brt_chevaliers_de_lyonesse", "wh_dlc08_nor_norsca", "wh_dlc08_nor_wintertooth"}
local out = function(t)
    ModLog("T3 Start: " .. tostring(t) .. ".")
end

local function upgrade_region(region, tier)
    local region_name = region:name()
    out("T4 Start: Upgrade_region called. Setting primary slot level in: " .. tostring(region_name) .. " to " .. tostring(tier) .. "")
    cm:instantly_set_settlement_primary_slot_level(region:settlement(), tier)
    local slot_list = region:settlement():slot_list()
    out("T4 Start: Slot list number of items: " .. tostring(slot_list:num_items()) .. "")

    if slot_list:num_items() > 1 then
        for j = 1, slot_list:num_items() - 1 do
            local slot = slot_list:item_at(j)
            out("T4 Start: slot:has_building: " .. tostring(slot:has_building()) .. "")

            if slot:has_building() then
                local building_key = slot:building():name()
                local upgrade_key = building_key
                local building_level_upgrades = #cm:get_building_level_upgrades(upgrade_key)

                out("T4 Start: There are " .. tostring(building_level_upgrades) .. " upggrades available for the structure " .. tostring(building_key) .. "")

                local building_tier = slot:building():building_level()

                while #cm:get_building_level_upgrades(upgrade_key) > 0 and building_tier < tier do
                    out("T4 Start: The next upgrade key is " .. tostring(upgrade_key) .. " and it is tier " .. tostring(building_tier) .. "")

                    building_tier = slot:building():building_level()

                    upgrade_key = cm:get_building_level_upgrades(upgrade_key)[1]
                    out("Instantly_upgrade_buildings activated, upgrade_key: " .. tostring(upgrade_key) .. "")
                end
                cm:instantly_upgrade_building_in_region(slot, upgrade_key)
            end
        end
    end
end

-- this doesn't cover custom subfactions or mixu's unlocker.
local function upgrade_all_playable_capitals()
    local region_list = cm:model():world():region_manager():region_list()
    if cm:is_new_game() then
        out("T4 Start: Its a new game, doing our thing")
        for i = 0, region_list:num_items() - 1 do
            local region = region_list:item_at(i)
            if not region:is_abandoned() then
                local region_name = region:name()
                local owning_faction = region:owning_faction()
                out("T4 Start: Checking region_name " .. tostring(region_name) .. "")
                out("T4 Start: owning_faction is: " .. tostring(owning_faction:name()) .. "")

                for j = 1, #playable_factions do
                    if owning_faction:name() == playable_factions[j] then
                        out("T4 Start: owning_faction is a playable_faction. Is region a province capital?: " .. tostring(region:is_province_capital()) .. "")
                        if not region:is_province_capital() then
                            upgrade_region(region, 4) -- If they start with a minor settlement, give them a tier four one.
                        else
                            upgrade_region(region, 3)
                        end
                    end
                end
            end
        end
    end
end

local function initialize_playable_faction_building_upgrades()
    local turn_number = cm:model():turn_number()
    cm:callback(function()
        if (turn_number == 1) then
            upgrade_all_playable_capitals()
        end
    end, 2.0)

end
cm:add_first_tick_callback_new(function()
    initialize_playable_faction_building_upgrades()
end);

-- this covers custom subfactions and mixu's unlocker.
local function upgrade_all_player_capitals()
    local region_list = cm:model():world():region_manager():region_list()
    out("its a new game, doing our thing")
    for i = 0, region_list:num_items() - 1 do
        local region = region_list:item_at(i)
        if not region:is_abandoned() then
            local owning_faction = region:owning_faction()
            local is_owning_faction_human = cm:is_faction_human(owning_faction:name())

            out("Checking region: " .. region:name() .. " owned by " .. tostring(owning_faction:name()) .. "")
            out("is_owning_faction_human: " .. tostring(is_owning_faction_human) .. ".")
            if is_owning_faction_human then
                out("Is region a province capital?: " .. tostring(region:is_province_capital()) .. "")
                if not region:is_province_capital() then
                    upgrade_region(region, 3)
                else
                    upgrade_region(region, 3)
                end
            end
        end
    end
end
cm:add_first_tick_callback_new(function()
    upgrade_all_player_capitals()
end);

local function turn_one_capture()
    if cm:model():turn_number() < 2 then
        core:add_listener("CharacterPerformsSettlementOccupationDecisionT3Start", "CharacterPerformsSettlementOccupationDecision", function(context)
            return true
        end, function(context)
            local region = context:garrison_residence():region()
            local owning_faction = region:owning_faction()

            out("T4 Start: Checking region_name " .. tostring(region:name()) .. "")
            out("T4 Start: owning_faction is: " .. tostring(owning_faction:name()) .. "")

            for j = 1, #playable_factions do
                if owning_faction:name() == playable_factions[j] then
                    out("T4 Start: owning_faction is a playable_faction. Is region a province capital?: " .. tostring(region:is_province_capital()) .. "")
                    if not region:is_province_capital() then
                        cm:callback(function()
                            upgrade_region(region, 3)
                        end, 0.1)
                    else
                        cm:callback(function()
                            upgrade_region(region, 3)
                        end, 0.1)
                    end
                end
            end
        end, true)
    end
end
cm:add_first_tick_callback_new(function()
    turn_one_capture()
end);

local function turns_2_5_capture()
    core:add_listener("CharacterPerformsSettlementOccupationDecisionT3Continued", "CharacterPerformsSettlementOccupationDecision", function(context)
        return true
    end, function(context)
        local region = context:garrison_residence():region()
        local owning_faction = region:owning_faction()

        out("T4 Start: Checking region_name " .. tostring(region:name()) .. "")
        out("T4 Start: owning_faction is: " .. tostring(owning_faction:name()) .. "")

        for j = 1, #playable_factions do
            if owning_faction:name() == playable_factions[j] then
                out("T4 Start: owning_faction is a playable_faction. Is region a province capital?: " .. tostring(region:is_province_capital()) .. "")
                if not region:is_province_capital() then
                    cm:callback(function()
                        upgrade_region(region, 3)
                    end, 0.1)
                else
                    cm:callback(function()
                        upgrade_region(region, 3)
                    end, 0.1)
                end
            end
        end
    end, true)
end
cm:add_first_tick_callback(function()
    turns_2_5_capture()
end);

local function give_750_gold_to_all_playable()
    local faction_list = cm:model():world():faction_list()
    for i = 0, faction_list:num_items() - 1 do
        local faction = faction_list:item_at(i)
        if faction:can_be_human() then
            cm:treasury_mod(faction:name(), 750)
        end
    end
end
cm:add_first_tick_callback_new(function()
    give_750_gold_to_all_playable()
end);

local function nerf_saphery()
    local region_key = "wh3_main_combi_region_white_tower_of_hoeth"
    local region = cm:get_region(region_key)
    local tier = 2
    cm:instantly_set_settlement_primary_slot_level(region:settlement(), tier)
end
cm:add_first_tick_callback_new(function()
    nerf_saphery()
end);
