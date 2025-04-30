--setup below allows for a function to live in this script, minimising edits to the main pilalrs script.
out("TP_collapse: INIT")
tp_script_overwrite = {
     faction_mask = {
          "phar_main_bay_separatists",
          "phar_main_canaan_rebels",
          "phar_main_irsu_separatists",
          "phar_map_ahlamu_invaders",
          "phar_main_hittites_rebels",
          "phar_main_kaska",
          "phar_main_kurunta_separatists",
          "phar_main_suppiluliuma_separatists",
          "phar_main_al_khufu_invasion_kemet",
          "phar_main_amenmesse_separatists",
          "phar_main_egyptian_rebels",
          "phar_main_merneptah_separatists",
          "phar_main_ramesses_separatists",
          "phar_main_seti_separatists",
          "phar_main_setnakhte_separatists",
          "phar_main_tausret_separatists",
          "phar_main_al_khufu_invasion_nubians",
          "phar_main_al_khufu_invasion_libu",
          "phar_main_bahariya",
          "phar_main_dakhla",
          "phar_main_dungul",
          "phar_main_farafra",
          "phar_main_kharga",
          "phar_main_libu",
          "phar_main_libu_invaders",
          "phar_main_meshwesh",
          "phar_map_tehenou",
          "phar_sea_aegean_sea_raiders_rebels",
          "phar_sea_denyen",
          "phar_sea_ekwesh",
          "phar_sea_weshesh",
          "phar_main_denyen",
          "phar_main_ekwesh",
          "phar_main_weshesh",
          "phar_sea_peleset",
          "phar_sea_peleset_separatists",
          "phar_sea_sea_wanderers_rebels",
          "phar_sea_shekelesh",
          "phar_sea_teresh",
          "phar_sea_tjeker",
          "phar_main_al_khufu_invasion_sea_people",
          "phar_main_lukka",
          "phar_main_shekelesh",
          "phar_main_teresh",
          "phar_main_tjeker",
          "phar_sea_sherden",
          "phar_sea_sherden_separatists",
          "phar_sea_western_islanders_rebels",
          "phar_map_ninurta_separatists",
          "phar_map_babylon_separatists",
          "phar_map_mesopotamian_rebels",
          "phar_map_elamite_invaders",
          "phar_map_urartu_invaders",
     },

     check_faction = function(faction_name)
          out("TP_collapse: raider function call")
          for k, faction_to_check in dpairs(tp_script_overwrite.faction_mask) do
               if faction_name == faction_to_check then
                    out("TP_collapse: this faction is on our ban list!" .. faction_name)
                    return true
               end
          end
          out("TP_collapse: this faction is not on our ban list: " .. faction_name)
          return false
     end,

     civil_war_check = function(faction_name)
          out("TP_collapse: civil_war function call")
          local in_war = false
          local unlocked_legitimacy = legitimacy_choice:get_unlocked_legitimacy(faction_name)

          if unlocked_legitimacy and unlocked_legitimacy.political_states_system:political_state() == "legitimacy_war" then
               out("TP_collapse: faction is in a civil war: " .. faction_name)
               in_war = unlocked_legitimacy.political_states_system:is_ruler(faction_name)
          else
               out("TP_collapse: faction is NOT in a civil war: " .. faction_name)
          end
          out("TP_collapse: is faction participating in civil war: " .. tostring(in_war))
          return in_war
     end
}

-- This is intended to overwrite a function in the main pillars of civilization script, the purpose being, it will ignore any cult regions owned by the factions outlined above.
pillars_civilization.calculate_building_civilization_meter = function()
     out("TP_collapse: pillar_func_called")
     if not is_table(pillars_civilization.config) then
          script_error("For some reason pillars_civilization.config is not a table")
          return
     end

     if not is_table(pillars_civilization.config.regions) then
          script_error("For some reason pillars_civilization.config.regions is not a table")
          return
     end

     pillars_civilization.persistent.breakdown_cities_and_points_per_level = {}
     -- we don't use ipairs here because it misses the 0th element, which is important for ruins, and we don't need order of iteration
     for index, level in pairs(pillars_civilization.config.points_per_level) do
          pillars_civilization.persistent.breakdown_cities_and_points_per_level[index] = {
               cities_by_level = 0,
               points_by_level = 0
          }
     end

     local building_civilization_score = 0
     for _, pillar_region_key in ipairs(pillars_civilization.config.regions) do
          local building = pillars_civilization.get_main_building_of_region(pillar_region_key)

          --MOD ADDED LINES BELOW
          local region_interface = cm:get_region(pillar_region_key)
          local region_owner = region_interface:owning_faction():name()
          --MOD ADDED ABOVE

          if building and building:percent_health() == 100 and tp_script_overwrite.check_faction(region_owner) == false and tp_script_overwrite.civil_war_check(region_owner) == false --[[final argument here is MOD added]] then
               out("TP_collapse: checks passed faction is contributing to civilisation: " .. region_owner)
               local level = building:level()
               if level then
                    pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].cities_by_level =
                    pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].cities_by_level + 1
                    local new_points = pillars_civilization.config.points_per_level[level]
                    building_civilization_score = building_civilization_score + new_points
                    pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].points_by_level =
                    pillars_civilization.persistent.breakdown_cities_and_points_per_level[level].points_by_level +
                    new_points
               end
          end
     end

     return building_civilization_score
end
