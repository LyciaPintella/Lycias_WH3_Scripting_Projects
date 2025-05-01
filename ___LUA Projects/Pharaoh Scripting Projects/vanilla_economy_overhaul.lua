out("tp_food_script: INIT")
--table holds all buildings which will replenish in a given season. THe script takes a value that represents the buildings baseline "turn resource generation" and calcualtes the amount that needs to be restored for that buildings resource in tht buildings season turns.
--e.g. a grain_field_1 depletes the deposit by 100 a turn (essentially its food genration effect). [season_spring] = {["grain_field_1"] = 100}
--I do this so that the script does the maths, and not my fallible human brain
local season_to_building_junctions = {
     ["season_spring"] = {
          ["phar_main_all_landmark_food_zippalanda_1"] = 360,
          ["phar_main_irsu_resource_production_food_cattle_1"] = 140,
          ["phar_map_irsu_resource_production_food_cattle_mesopotamia_1"] = 195,
          ["phar_map_irsu_food_cattle_aegean_1"] = 140,
          ["phar_map_food_cattle_aegean_1"] = 140,
          ["phar_map_food_cattle_aegean_2"] = 195,
          ["phar_main_all_resource_production_food_cattle_canaan_1"] = 190,
          ["phar_main_all_resource_production_food_cattle_canaan_2"] = 235,
          ["phar_main_all_resource_production_food_cattle_hattusa_1"] = 230,
          ["phar_main_all_resource_production_food_cattle_hattusa_2"] = 325,
          ["phar_map_all_resource_production_food_cattle_mesopotamia_1"] = 200,
          ["phar_map_all_resource_production_food_cattle_mesopotamia_2"] = 245,
     }, --mostly livestock
     ["season_summer"] = {
          ["phar_main_all_landmark_food_port_ugarit_1"] = 475,
          ["phar_main_irsu_resource_production_food_fishery_nile_1"] = 175,
          ["phar_main_all_resource_production_food_fishery_nile_1"] = 175,
          ["phar_main_all_resource_production_food_fishery_nile_2"] = 235,
          ["phar_map_all_resource_production_food_fishery_tigris_euphrates_2"] = 175,
          ["phar_map_all_resource_production_food_fishery_tigris_euphrates_1"] = 235,
          ["phar_map_irsu_resource_production_food_fishery_tigris_euphrates_1"] = 175,
          ["phar_main_all_resource_production_port_coast_1"] = 70,
          ["phar_main_all_resource_production_port_coast_2"] = 140,
          ["phar_sea_peleset_resource_production_modifier_food_fish_1"] = 50,
          ["phar_sea_peleset_resource_production_modifier_food_fish_2"] = 100,
          ["phar_sea_sherden_resource_production_modifier_food_fish_1"] = 70,
          ["phar_sea_sherden_resource_production_modifier_food_fish_2"] = 140,
     }, --mostly fishing
     ["season_winter"] = {
          ["phar_main_all_landmark_food_bahariya_oasis_1"] = 215,
          ["phar_main_irsu_resource_production_food_farm_1"] = 215,
          ["phar_main_irsu_resource_production_food_farm_derivative_1"] = 170,
          ["phar_main_irsu_resource_production_food_farm_nile_type_a_1"] = 190,
          ["phar_main_irsu_resource_production_food_farm_nile_type_b_1"] = 190,
          ["phar_main_irsu_resource_production_food_farm_nile_type_c_1"] = 325,
          ["phar_main_irsu_resource_production_fruit_oasis_1"] = 140,
          ["phar_map_myc_resource_production_food_farm_minor_2"] = 170,
          ["phar_map_myc_resource_production_food_farm_minor_1"] = 90,
          ["phar_map_farm_achaea_derivative_1"] = 115,
          ["phar_map_farm_assuwa_derivative_1"] = 115,
          ["phar_map_farm_thrace_derivative_1"] = 115,
          ["phar_map_food_farm_aegean_2"] = 180,
          ["phar_map_food_farm_aegean_1"] = 125,
          ["phar_main_all_resource_production_food_farm_type_a_canaan_1"] = 215,
          ["phar_main_all_resource_production_food_farm_type_a_canaan_2"] = 305,
          ["phar_main_all_resource_production_food_farm_type_a_canaan_derivative_1"] = 170,
          ["phar_main_all_resource_production_food_farm_type_a_hattusa_1"] = 195,
          ["phar_main_all_resource_production_food_farm_type_a_hattusa_2"] = 225,
          ["phar_main_all_resource_production_food_farm_type_a_hattusa_derivative_1"] = 1, --bakery. does ad 125, but its not a producer of food. just processes
          ["phar_map_all_resource_production_food_farm_type_a_mesopotamia_1"] = 235,
          ["phar_map_all_resource_production_food_farm_type_a_mesopotamia_2"] = 325,
          ["phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative_1"] = 185,
          ["phar_main_all_resource_production_food_farm_type_a_nile_1"] = 190,
          ["phar_main_all_resource_production_food_farm_type_a_nile_2"] = 260,
          ["phar_map_all_resource_production_food_farm_type_b_mesopotamia_1"] = 205,
          ["phar_map_all_resource_production_food_farm_type_b_mesopotamia_2"] = 250,
          ["phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative_1"] = 185,
          ["phar_main_all_resource_production_food_farm_type_b_nile_1"] = 190,
          ["phar_main_all_resource_production_food_farm_type_b_nile_2"] = 230,
          ["phar_main_all_resource_production_food_farm_type_c_nile_1"] = 325,
          ["phar_main_all_resource_production_fruit_oasis_1"] = 140,
          ["phar_main_all_resource_production_fruit_oasis_2"] = 185,

     }, --mostly grains
}

--Not sure what to do about smugglers bays. Leaving them be, so they don't use deposits.
--phar_main_irsu_resource_production_port_coast_derivative_type_a_1
--phar_main_all_resource_production_port_coast_derivative_type_a_1
--phar_main_bay_resource_production_port_coast_derivative_type_a_2
--phar_main_bay_resource_production_port_coast_derivative_type_a_1

-- table stores all effect bundles related to disasters/blessings. and the buildings they apply their multiplier too.
local incident_building_juncitons = {
     ["phar_map_effect_bundle_incident_blessing_weather"] = {
          "phar_main_all_landmark_food_bahariya_oasis_1",
          "phar_main_irsu_resource_production_food_farm_1",
          "phar_main_irsu_resource_production_food_farm_derivative_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_a_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_b_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_c_1",
          "phar_main_irsu_resource_production_fruit_oasis_1",
          "phar_map_myc_resource_production_food_farm_minor_2",
          "phar_map_myc_resource_production_food_farm_minor_1",
          "phar_map_farm_achaea_derivative_1",
          "phar_map_farm_assuwa_derivative_1",
          "phar_map_farm_thrace_derivative_1",
          "phar_map_food_farm_aegean_2",
          "phar_map_food_farm_aegean_1",
          "phar_main_all_resource_production_food_farm_type_a_canaan_1",
          "phar_main_all_resource_production_food_farm_type_a_canaan_2",
          "phar_main_all_resource_production_food_farm_type_a_canaan_derivative_1",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_1",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_2",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_derivative_1",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_1",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_2",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative_1",
          "phar_main_all_resource_production_food_farm_type_a_nile_1",
          "phar_main_all_resource_production_food_farm_type_a_nile_2",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_1",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_2",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative_1",
          "phar_main_all_resource_production_food_farm_type_b_nile_1",
          "phar_main_all_resource_production_food_farm_type_b_nile_2",
          "phar_main_all_resource_production_food_farm_type_c_nile_1",
          "phar_main_all_resource_production_fruit_oasis_1",
          "phar_main_all_resource_production_fruit_oasis_2",
     }, --plant buff
     ["phar_main_effect_bundle_incident_blessing_fertility"] = {
          "phar_main_all_landmark_food_zippalanda_1",
          "phar_main_irsu_resource_production_food_cattle_1",
          "phar_map_food_cattle_aegean_1",
          "phar_map_food_cattle_aegean_2",
          "phar_main_all_resource_production_food_cattle_canaan_1",
          "phar_main_all_resource_production_food_cattle_canaan_2",
          "phar_main_all_resource_production_food_cattle_hattusa_1",
          "phar_main_all_resource_production_food_cattle_hattusa_2",
          "phar_map_all_resource_production_food_cattle_mesopotamia_1",
          "phar_map_all_resource_production_food_cattle_mesopotamia_2",
     }, --flesh buff
     ["phar_main_effect_bundle_incident_blessing_natures_bounty"] = {
          "phar_main_all_landmark_food_port_ugarit_1",
          "phar_main_irsu_resource_production_food_fishery_nile_1",
          "phar_main_all_resource_production_food_fishery_nile_1",
          "phar_main_all_resource_production_food_fishery_nile_2",
          "phar_map_all_resource_production_food_fishery_tigris_euphrates_2",
          "phar_map_all_resource_production_food_fishery_tigris_euphrates_1",
          "phar_main_all_resource_production_port_coast_1",
          "phar_main_all_resource_production_port_coast_2",
          "phar_sea_peleset_resource_production_modifier_food_fish_1",
          "phar_sea_peleset_resource_production_modifier_food_fish_2",
          "phar_sea_sherden_resource_production_modifier_food_fish_1",
          "phar_sea_sherden_resource_production_modifier_food_fish_2",
     }, --fish buff
     ["phar_main_effect_bundle_incident_disaster_drought_food_production"] = {
          "phar_main_all_landmark_food_bahariya_oasis_1",
          "phar_main_irsu_resource_production_food_farm_1",
          "phar_main_irsu_resource_production_food_farm_derivative_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_a_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_b_1",
          "phar_main_irsu_resource_production_food_farm_nile_type_c_1",
          "phar_main_irsu_resource_production_fruit_oasis_1",
          "phar_map_myc_resource_production_food_farm_minor_2",
          "phar_map_myc_resource_production_food_farm_minor_1",
          "phar_map_farm_achaea_derivative_1",
          "phar_map_farm_assuwa_derivative_1",
          "phar_map_farm_thrace_derivative_1",
          "phar_map_food_farm_aegean_2",
          "phar_map_food_farm_aegean_1",
          "phar_main_all_resource_production_food_farm_type_a_canaan_1",
          "phar_main_all_resource_production_food_farm_type_a_canaan_2",
          "phar_main_all_resource_production_food_farm_type_a_canaan_derivative_1",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_1",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_2",
          "phar_main_all_resource_production_food_farm_type_a_hattusa_derivative_1",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_1",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_2",
          "phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative_1",
          "phar_main_all_resource_production_food_farm_type_a_nile_1",
          "phar_main_all_resource_production_food_farm_type_a_nile_2",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_1",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_2",
          "phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative_1",
          "phar_main_all_resource_production_food_farm_type_b_nile_1",
          "phar_main_all_resource_production_food_farm_type_b_nile_2",
          "phar_main_all_resource_production_food_farm_type_c_nile_1",
          "phar_main_all_resource_production_fruit_oasis_1",
          "phar_main_all_resource_production_fruit_oasis_2",
     }, --plant nerf
     --[[["phar_main_effect_bundle_incident_disaster_drought_growth"] = {
        "phar_main_all_landmark_food_bahariya_oasis_1",
        "phar_main_irsu_resource_production_food_farm_1",
        "phar_main_irsu_resource_production_food_farm_derivative_1",
        "phar_main_irsu_resource_production_food_farm_nile_type_a_1",
        "phar_main_irsu_resource_production_food_farm_nile_type_b_1",
        "phar_main_irsu_resource_production_food_farm_nile_type_c_1",
        "phar_main_irsu_resource_production_fruit_oasis_1",
        "phar_map_myc_resource_production_food_farm_minor_2",
        "phar_map_myc_resource_production_food_farm_minor_1",
        "phar_map_farm_achaea_derivative_1",
        "phar_map_farm_assuwa_derivative_1",
        "phar_map_farm_thrace_derivative_1",
        "phar_map_food_farm_aegean_2",
        "phar_map_food_farm_aegean_1",
        "phar_main_all_resource_production_food_farm_type_a_canaan_1",
        "phar_main_all_resource_production_food_farm_type_a_canaan_2",
        "phar_main_all_resource_production_food_farm_type_a_canaan_derivative_1",
        "phar_main_all_resource_production_food_farm_type_a_hattusa_1",
        "phar_main_all_resource_production_food_farm_type_a_hattusa_2",
        "phar_main_all_resource_production_food_farm_type_a_hattusa_derivative_1",
        "phar_map_all_resource_production_food_farm_type_a_mesopotamia_1",
        "phar_map_all_resource_production_food_farm_type_a_mesopotamia_2",
        "phar_map_all_resource_production_food_farm_type_a_mesopotamia_derivative_1",
        "phar_main_all_resource_production_food_farm_type_a_nile_1",
        "phar_main_all_resource_production_food_farm_type_a_nile_2",
        "phar_map_all_resource_production_food_farm_type_b_mesopotamia_1",
        "phar_map_all_resource_production_food_farm_type_b_mesopotamia_2",
        "phar_map_all_resource_production_food_farm_type_b_mesopotamia_derivative_1",
        "phar_main_all_resource_production_food_farm_type_b_nile_1",
        "phar_main_all_resource_production_food_farm_type_b_nile_2",
        "phar_main_all_resource_production_food_farm_type_c_nile_1",
        "phar_main_all_resource_production_fruit_oasis_1",
        "phar_main_all_resource_production_fruit_oasis_2",
    },]] --not neeed? think both eb's are applie at the same time.
     --["phar_main_effect_bundle_incident_disaster_earthquake"] = {}, --not needed, damaged buildings will not replenish until fixed.
     ["phar_main_effect_bundle_incident_disaster_flood"] = {
          "phar_main_all_landmark_food_port_ugarit_1",
          "phar_main_irsu_resource_production_food_fishery_nile_1",
          "phar_main_all_resource_production_food_fishery_nile_1",
          "phar_main_all_resource_production_food_fishery_nile_2",
          "phar_map_all_resource_production_food_fishery_tigris_euphrates_2",
          "phar_map_all_resource_production_food_fishery_tigris_euphrates_1",
          "phar_main_all_resource_production_port_coast_1",
          "phar_main_all_resource_production_port_coast_2",
          "phar_sea_peleset_resource_production_modifier_food_fish_1",
          "phar_sea_peleset_resource_production_modifier_food_fish_2",
          "phar_sea_sherden_resource_production_modifier_food_fish_1",
          "phar_sea_sherden_resource_production_modifier_food_fish_2",
     }, --fish nerf
     ["phar_main_effect_bundle_incident_disaster_plague_growth"] = {
          "phar_main_all_landmark_food_zippalanda_1",
          "phar_main_irsu_resource_production_food_cattle_1",
          "phar_map_food_cattle_aegean_1",
          "phar_map_food_cattle_aegean_2",
          "phar_main_all_resource_production_food_cattle_canaan_1",
          "phar_main_all_resource_production_food_cattle_canaan_2",
          "phar_main_all_resource_production_food_cattle_hattusa_1",
          "phar_main_all_resource_production_food_cattle_hattusa_2",
          "phar_map_all_resource_production_food_cattle_mesopotamia_1",
          "phar_map_all_resource_production_food_cattle_mesopotamia_2",
     }, --flesh nerf
     --[[["phar_main_effect_bundle_incident_disaster_plague_recruitment_slots"] = {
        "phar_main_all_landmark_food_zippalanda_1",
        "phar_main_irsu_resource_production_food_cattle_1",
        "phar_map_food_cattle_aegean_1",
        "phar_map_food_cattle_aegean_2",
        "phar_main_all_resource_production_food_cattle_canaan_1",
        "phar_main_all_resource_production_food_cattle_canaan_2",
        "phar_main_all_resource_production_food_cattle_hattusa_1",
        "phar_main_all_resource_production_food_cattle_hattusa_2",
        "phar_map_all_resource_production_food_cattle_mesopotamia_1",
        "phar_map_all_resource_production_food_cattle_mesopotamia_2",
    },]] --not neeed i think.
}
--table stores modifiers that an incidnet has on its building.
local incident_multiplier_juncitons = {
     ["phar_main_effect_bundle_incident_blessing_fertility"] = 1.5,
     ["phar_main_effect_bundle_incident_blessing_natures_bounty"] = 1.5,
     ["phar_map_effect_bundle_incident_blessing_weather"] = 1.5,
     ["phar_main_effect_bundle_incident_disaster_drought_food_production"] = 0,
     --["phar_main_effect_bundle_incident_disaster_drought_growth"] = 0,
     --["phar_main_effect_bundle_incident_disaster_earthquake"] = 0, --not needed, damaged buildings will not replenish until fixed.
     ["phar_main_effect_bundle_incident_disaster_flood"] = 0,
     ["phar_main_effect_bundle_incident_disaster_plague_growth"] = 0,
     --["phar_main_effect_bundle_incident_disaster_plague_recruitment_slots"] = 0,
}

local season_eb_modifier = {
     ["phar_map_effect_bundle_season_spring_extreme"]  = 0.3,
     ["phar_map_effect_bundle_season_spring_ideal"]    = 1.5,
     ["phar_map_effect_bundle_season_spring_mild"]     = 1.3,
     ["phar_map_effect_bundle_season_spring_moderate"] = 1,
     ["phar_map_effect_bundle_season_spring_severe"]   = 0.5,
     ["phar_map_effect_bundle_season_summer_extreme"]  = 0.3,
     ["phar_map_effect_bundle_season_summer_ideal"]    = 1.5,
     ["phar_map_effect_bundle_season_summer_mild"]     = 1.3,
     ["phar_map_effect_bundle_season_summer_moderate"] = 1,
     ["phar_map_effect_bundle_season_summer_severe"]   = 0.5,
     ["phar_map_effect_bundle_season_winter_extreme"]  = 0.3,
     ["phar_map_effect_bundle_season_winter_ideal"]    = 1.5,
     ["phar_map_effect_bundle_season_winter_mild"]     = 1.3,
     ["phar_map_effect_bundle_season_winter_moderate"] = 1,
     ["phar_map_effect_bundle_season_winter_severe"]   = 0.5
}

core:add_listener(
     "food_replenish",
     "RoundStart",
     true,
     function(context)
          out("tp_food_script: TEST ")
          cm:callback(function()
               out("tp_food_script: TEST 2")
               province_check()
          end, 0.2)
     end,
     true
)

--main function
function province_check()
     out("tp_food_script: Round start, checking province: ")
     local province_list = cm:model():world():province_manager():province_list()
     local season_key = cm:model():current_season_key()
     local building_list = season_to_building_junctions[season_key]
     out("tp_food_script: Round start, season is: " .. season_key)

     for i = 0, province_list:num_items() - 1 do
          local tracking_building_list = {}
          local this_province = province_list:item_at(i)
          out("tp_food_script: Round start, checking province: " .. this_province:name())
          local region_list = this_province:regions()
          local faction_in_province = "" --for the effect bundle bit, it needs a faction.

          --checking regions in province for building
          for j = 0, region_list:num_items() - 1 do
               local this_region = region_list:item_at(j)
               out("tp_food_script: Round start, checking region: " .. this_region:name())
               local slot_list = this_region:slot_list()
               --this bit is jsut to get a faction name that we can use to get effectbndles later, doesn;t amtter if we overrite the faction, so long as we get one.
               local faction = this_region:owning_faction()
               if not faction:is_null_interface() then
                    faction_in_province = faction:name()
                    for k = 0, slot_list:num_items() - 1 do
                         --out("tp_food_script: checking region slots")
                         local this_slot = slot_list:item_at(k)
                         if this_slot:is_null_interface() == false and this_slot:has_building() and this_slot:building():percent_health() == 100 then
                              local this_building = this_slot:building():name()

                              if building_list[this_building] then
                                   out("tp_food_script: Identified building for replenish: " .. this_building)
                                   table.insert(tracking_building_list, this_building)
                              end
                         end
                    end
               end
          end
          --tracking building list should have a list of building strings for each present building, will be indexed with calues.
          out("tp_food_script: building list complete for province: " ..
          tostring(tracking_building_list) .. faction_in_province)
          local provincial_deposit_value = 0
          local provice_ebs = this_province:effect_bundles(faction_in_province)
          for k, building in dpairs(tracking_building_list) do
               local building_value = calculate_deposit_replen(building, provice_ebs)
               provincial_deposit_value = provincial_deposit_value + building_value
          end

          --quickly get season effect bundle
          local season_eb = return_season_eb(provice_ebs)
          local season_modifier = 1
          if season_eb ~= "nope" then
               out("tp_food_script: modify season modifier based on " .. season_eb)
               season_modifier = season_eb_modifier[season_eb]
          end
          --out("tp_food_script: season modifier: "..season_modifier)
          local food_deposit_for_province = provincial_deposit_value * season_modifier

          out("tp_food_script: setting food deposit for province: " .. this_province:name())
          local old_deposit = this_province:depletable_resource_remaining_amount_no_faction("troy_food")
          local deposit_new_amount = food_deposit_for_province + old_deposit
          out("tp_food_script: Old deposit amount: " .. old_deposit)
          out("tp_food_script: Season modifier: " .. season_modifier)
          out("tp_food_script: Total Building value: " .. provincial_deposit_value)

          cm:province_set_pooled_resource(this_province:name(), "troy_food", deposit_new_amount)
     end
end

--functrion takes a buildings defined per turn resource generation, returns the per turn season replenishment amount (before season strength modifier.)
function calculate_deposit_replen(building_name, provice_ebs)
     out("tp_food_script: calcualting deposit modifier value for: " .. building_name)

     --this bit will detect if there is an incident eb on the provice, if so will get the relevant multiplier for this building.
     local incident_eb = return_incident_eb(provice_ebs)
     local incident_multiplier = 1
     if incident_building_juncitons[incident_eb] then
          for k, building in dpairs(incident_building_juncitons[incident_eb]) do
               if building == building_name then
                    incident_multiplier = incident_multiplier_juncitons[incident_eb]
               end
          end
     end
     out("tp_food_script: Incident modifier is: " .. incident_multiplier)

     --grabbing the buuilding default value
     local season_key = cm:model():current_season_key()
     local building_list = season_to_building_junctions[season_key]
     local building_value = building_list[building_name]
     out("tp_food_script: Building default value is: " .. building_value)
     --grabbing tpy for final calculation
     local tpy = cm:model():rounds_per_year()
     out("tp_food_script: tpy multiplier is: " .. tpy)
     --calcualting!
     local value = (building_value * tpy) / (tpy / 3) * incident_multiplier
     out("tp_food_script: returning total value to replenish this turn: " .. value)
     return value
end

-- Function gets the season effect bundle key - this allows us to know the severity of the season.
function return_season_eb(eb_list)
     --out("tp_food_script: searching for season effect bundle")
     if eb_list == nil then
          out("tp_food_script: ERROR eb list was nil")
          return "nope"
     end
     for j = 0, eb_list:num_items() - 1 do
          this_eb = eb_list:item_at(j)
          --out("tp_food_script: sthis eb is: "..this_eb:key())
          if string.find(this_eb:key(), "effect_bundle_season") then
               --out("tp_food_script: returning: "..this_eb:key())
               return this_eb:key()
          end
     end
     out("tp_food_script: ERROR no season eb found. Something is wrong")
     return "nope"
end

function return_incident_eb(eb_list)
     --out("tp_food_script: searching for incident effect bundle")
     if eb_list == nil then
          out("tp_food_script: ERROR eb list was nil")
          return "nope"
     end
     for j = 0, eb_list:num_items() - 1 do
          this_eb = eb_list:item_at(j)
          if string.find(this_eb:key(), "incident_blessing") or string.find(this_eb:key(), "incident_disaster") then
               --out("tp_food_script: returning: "..this_eb:key())
               return this_eb:key()
          end
     end
     out("tp_food_script: There is no incident effect on this province.")
     return "nope"
end
