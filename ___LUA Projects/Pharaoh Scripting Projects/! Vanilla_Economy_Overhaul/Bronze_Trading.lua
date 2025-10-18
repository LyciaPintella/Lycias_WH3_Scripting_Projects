out("TP_bronze: init")

--stores the percentage chance for a trade route to initiate based on civilisation level.
local civ_start_modifier = {
     [1] = 0,   --collapse NO traders
     [2] = 60,  --crisis MOSTLY traders
     [3] = 100, --prosperity ALWAYS traders
}

local civ_amount_modifier = {
     [1] = 0, --although traders will not depart in collapse, some may still be in transit when it occurs. this is why we havea  value here!
     [2] = 20,
     [3] = 50,
}

--stores the current position the trade route is in effect. NEES SAVE/LOADING
local tp_trade_progress = {
     ["northern_route"] = 0,
     ["eastern route"] = 0,
     ["west_south_route"] = 4,
     ["west_east_route"] = 3,
}

--stores the region keys that get a deposit, based on the phase they are on the trade route.
local tp_trade_route_phases = {
     ["northern_route"] = {
          [1] = { "phar_map_tummanna_sandaraca", "phar_map_hapalla_arowanna", "phar_main_west_hatti_dorylaion" },
          [2] = { "phar_map_kuwaliya_ninoe", "phar_main_north_hatti_andrapa", "phar_main_purushanda_mokissos" },
          [3] = { "phar_map_rhodes_lindos", "phar_main_tuwana_cybistra" },
          [4] = { "phar_main_alashiya_alashiya", "phar_main_alashiya_paphos", "phar_main_alashiya_kition" },
     },
     ["eastern route"] = {
          [1] = { "phar_map_zabu_kilizi", "phar_map_aranzah_karana" },
          [2] = { "phar_map_ashnunnak_eshnunna", "phar_map_karduniash_ishtananu_larak", "phar_map_kadmuhu_kindari", "phar_map_azalzi_shudu" },
          [3] = { "phar_map_suhum_shaplu_idu", "phar_map_suhum_elu_anat", "phar_map_balihu_irridu" },
          [4] = { "phar_main_malidiya_tegarama", "phar_main_aleppo_alalah", "phar_map_ashtata_ashimon", "phar_main_kadesh_kadesh" },
          [5] = { "phar_main_shechem_ammon", "phar_main_alashiya_alashiya" },
     },
     ["west_south_route"] = {
          [1] = { "phar_map_cephallenia_hyrie", "phar_map_lacedaemon_pylos" },
          [2] = { "phar_main_amunia_ner_neb", "phar_main_faiyum_khem", "phar_main_north_sinai_nekhel" },
          [3] = { "phar_main_sinai_tchu_am", "phar_main_hardai_tep_aha", "phar_main_hermopolis_ti_ar", "phar_main_bahariya_oasis_mefka", "phar_main_farafra_oasis_aakh_sa", "phar_main_kadesh_kadesh" },
          [4] = { "phar_main_dakhla_oasis_tcham", "phar_main_kharga_oasis_shesp_net", "phar_main_dungul_oasis_utch", "phar_main_dungul_oasis_thes", "phar_main_kom_ombo_kha_sba", "phar_main_north_east_nubia_utcha_uas", "phar_main_shechem_ammon", "phar_main_alashiya_alashiya" },
          [5] = { "phar_main_kerma_mu_sh" },
     },
     ["west_east_route"] = {
          [1] = { "phar_map_cephallenia_hyrie", "phar_map_lacedaemon_pylos", "phar_map_kretes_phaestos" },
          [2] = { "phar_map_rhodes_lindos", "phar_map_cyclades_melos", "phar_map_mycenaeca_tiryns", "phar_map_macedonia_dolopeis" },
          [3] = { "phar_map_zerynthia_nesoi_myrina", "phar_map_latmos_samos", "phar_main_alashiya_alashiya", "phar_main_alashiya_paphos", "phar_main_alashiya_kition" },
          [4] = { "phar_main_aleppo_alalah" },
          [5] = { "phar_main_kadesh_kadesh", "phar_map_balihu_irridu", "phar_main_malidiya_tegarama" },
          [6] = { "phar_main_shechem_ammon" }
     },

}

--stores the baseline values each phase gets on a trade route, note the intentional declien the furhter along the reoute (an away from the source of tin)

--[[
Lycia Bookmark. The values in the comment are the original mod values.
local tp_trade_phase_values = {
    ["northern_route"] = {
        [1] = 800,
        [2] = 500,
        [3] = 200,
        [4] = 100,
    },
    ["eastern route"] = {
        [1] = 1500,
        [2] = 1000,
        [3] = 800,
        [4] = 500,
        [5] = 200,
    },
    ["west_south_route"] = {
        [1] = 1000,
        [2] = 1000,
        [3] = 800,
        [4] = 500,
        [5] = 200,
    },
    ["west_east_route"] = {
        [1] = 1500,
        [2] = 1000,
        [3] = 800,
        [4] = 500,
        [5] = 200,
        [6] = 100,
    },
}
--Lycia modded values below.
]] --
local tp_trade_phase_values = {
     ["northern_route"] = {
          [1] = 800,
          [2] = 600,
          [3] = 400,
          [4] = 200,
     },
     ["eastern route"] = {
          [1] = 1500,
          [2] = 1300,
          [3] = 1100,
          [4] = 700,
          [5] = 300,
     },
     ["west_south_route"] = {
          [1] = 1000,
          [2] = 1000,
          [3] = 700,
          [4] = 400,
          [5] = 300,
     },
     ["west_east_route"] = {
          [1] = 1500,
          [2] = 1200,
          [3] = 900,
          [4] = 600,
          [5] = 400,
          [6] = 200,
     },
}

core:add_listener(
     "bronze_trade_round_start",
     "RoundStart",
     true,
     function(context)
          cm:callback(function()
               out("tp_bronze_script: TEST 2")
               progress_routes()
          end, 0.2)
     end,
     true
)

function progress_routes()
     out("TP_bronze: Round Start")
     for route, phase in dpairs(tp_trade_progress) do
          if phase ~= 0 and tp_trade_route_phases[route] ~= nil then
               out("TP_bronze: " .. route .. " is ready to progress.")
               local civ_level_index = pillars_civilization.current_level_index
               replenish_deposits(route, phase, civ_level_index)
               tp_trade_progress[route] = phase + 1
          end

          --next, lets get any routes that are waiting to start
          if phase == 0 then
               out("TP_bronze: " .. route .. " is waiting to start, rolling dice")
               local civ_level_index = pillars_civilization.current_level_index
               local modifier = civ_start_modifier[civ_level_index]

               if cm:model():random_percent(modifier) then
                    out("TP_bronze: dice roll passes, setting route for next phase.")
                    tp_trade_progress[route] = 1
               end
          end

          --finish up by resetting any errant phases
          if route == "northern_route" and phase > 4 then
               out("TP_bronze: " .. route .. " had a phase above 4, setting to 0")
               tp_trade_progress[route] = 0
          end
          if route == "eastern" and phase > 5 then
               out("TP_bronze: " .. route .. " had a phase above 5, setting to 0")
               tp_trade_progress[route] = 0
          end
          if route == "west_south_route" and phase > 5 then
               out("TP_bronze: " .. route .. " had a phase above 5, setting to 0")
               tp_trade_progress[route] = 0
          end
          if route == "west_east_route" and phase > 6 then
               out("TP_bronze: " .. route .. " had a phase above 6, setting to 0")
               tp_trade_progress[route] = 0
          end
     end
end

--function does the maths to replenish deposits in regions for given route and phase.
function replenish_deposits(route, phase, civ_index)
     local route_region_config = tp_trade_route_phases[route]
     local region_key_list = route_region_config[phase]

     for i = 1, #region_key_list do
          local this_key = region_key_list[i]
          local region_int = cm:get_region(this_key)
          out("TP_bronze: Checking region " .. this_key)

          if not region_int:is_null_interface() and not region_int:is_abandoned() then
               local province = region_int:province()
               local route_value_config = tp_trade_phase_values[route]
               local replenishment_base_value = route_value_config[phase]
               local current_bronze = province:depletable_resource_remaining_amount_no_faction("troy_bronze")
               local civ_modifier = civ_amount_modifier[civ_index]
               local deposit_new_amount = (replenishment_base_value * civ_modifier / 100) + replenishment_base_value +
                   current_bronze
               out("TP_bronze: Region " .. this_key .. " is rgetting deposit replenished by " .. deposit_new_amount)
               cm:province_set_pooled_resource(province:name(), "troy_bronze", deposit_new_amount)

               cm:show_message_event(
                    region_int:owning_faction():name(),
                    "tp_tin_visit_title",
                    "tp_tin_visit_subtitle",
                    "tp_tin_visit_desc",
                    false,
                    2133
               )
          else
               out("TP_bronze: Region " .. this_key .. " is returning nul interface or is abandoned. Skipping deposit.")
          end
     end
end

--saving trackers
cm:add_saving_game_callback(function(context)
     cm:save_named_value("tp_trade_progress", tp_trade_progress, context)
end)
cm:add_loading_game_callback(function(context)
     tp_trade_progress = cm:load_named_value("tp_trade_progress", tp_trade_progress, context)
end)
