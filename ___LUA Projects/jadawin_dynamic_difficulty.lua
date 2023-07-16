JadLogFile_Made = false
JadLogging_Enabled = true
Jadlog_Filename = "Dynamic_Difficulty_Log.txt"
Has_Logged = false

local function out(t) ModLog("#### Dynamic Difficulty " .. tostring(t) .. " ####") end

local function JADSESSIONLOG()
     if not JadLogging_Enabled then return end

     local logTimeStamp = os.date("%d, %m %Y %X")
     local popLog = io.open(Jadlog_Filename, "a+")

     out("JadLogFile_Made is " .. tostring(JadLogFile_Made) .. "")

     if not JadLogFile_Made then
          out("popLog is " .. tostring(popLog) .. " JadLogFile_Made is " .. tostring(JadLogFile_Made) .. "")
     else
          out("popLog is " .. tostring(popLog) .. " JadLogFile_Made is " .. tostring(JadLogFile_Made) .. "")
     end

     JadLogFile_Made = true

     if popLog then
          popLog:write("Welcome back! It's: [" .. logTimeStamp .. "] \n")
          popLog:flush()
          popLog:close()
     else
          script_error("WARNING: JADSESSIONLOG() could not open " .. Jadlog_Filename .. ". popLog is " .. tostring(popLog) ..
                            ". Line 26. No mod log will be created past this point")
          JadLogging_Enabled = false
     end
end
JADSESSIONLOG()

local function JADLOG(text)
     out("JADLOG(text): JadLogFile_Made is " .. tostring(JadLogFile_Made) .. " . JadLogging_Enabled is " .. tostring(JadLogging_Enabled) .. " ####")

     if not JadLogging_Enabled then return end

     local logTimeStamp = os.date("%d, %m %Y %X")
     local logText = tostring(text)
     local popLog = io.open(Jadlog_Filename, "a+")

     out("JADLOG(text): " .. "Jadlog_Filename is " .. Jadlog_Filename .. " . popLog is " .. tostring(popLog) .. " ####")

     if popLog then
          popLog:write("Dynamic Difficulty: " .. logText .. " [" .. logTimeStamp .. "] \n")
          popLog:flush()
     else
          script_error("Dynamic Difficulty: WARNING: JADLOG() could not open " .. Jadlog_Filename .. ", no mod log will be created past this point")
          JadLogging_Enabled = false
     end
end

local function jlog(text) JADLOG(tostring(text)) end

local function read_mct_values(ignore_setting_lock)
     -- use values set in MCT, if available
     if mct_jdyndif then
          local mct_mymod = mct_jdyndif:get_mod_by_key("jadawin_dynamic_difficulty")
          if ignore_setting_lock or not (mct_mymod:get_option_by_key("settings_locked"):get_finalized_setting()) then
               cm:set_saved_value("jdyndif_enable_replenishment", mct_mymod:get_option_by_key("enable_replenishment"):get_finalized_setting())
               cm:set_saved_value("jdyndif_enable_recruitment", mct_mymod:get_option_by_key("enable_recruitment"):get_finalized_setting())
               cm:set_saved_value("jdyndif_extra_difficulty", mct_mymod:get_option_by_key("extra_difficulty"):get_finalized_setting())
               cm:set_saved_value("jdyndif_mct_values_exist", true)
          end
     else
          -- default values if MCT not used
          cm:set_saved_value("jdyndif_enable_replenishment", false)
          cm:set_saved_value("jdyndif_enable_recruitment", false)
          cm:set_saved_value("jdyndif_extra_difficulty", 0)
          cm:set_saved_value("jdyndif_mct_values_exist", true)
     end
end

local function get_empire_score_player()
     local empire_score = 0
     local human_faction_key = cm:get_human_factions()[1]
     local human_faction = cm:model():world():faction_by_key(human_faction_key)
     local subculture = human_faction:subculture()
     -- pure hordes: every new horde counts like 8 settlements
     if subculture == "wh_dlc03_sc_bst_beastmen" then
          -- Nakai: Every horde counts like 4 settlements, regions owned by vassal count half
          -- jlog("Player is pure horde faction, every horde counts for 80 points (first one is free).")
          local characters = human_faction:character_list()
          for i = 0, characters:num_items() - 1 do
               if cm:char_is_mobile_general_with_army(characters:item_at(i)) then
                    empire_score = empire_score + 80
                    -- jlog("Horde found!")
               end
          end
          empire_score = empire_score - 80
     elseif human_faction_key == "wh2_dlc13_lzd_spirits_of_the_jungle" then
          -- Vampire Coast
          -- jlog("Player is Nakai, every horde counts for 40 points (first one is free). Every region owned by the vassal counts for 5 points.")
          local characters = human_faction:character_list()
          for i = 0, characters:num_items() - 1 do
               if cm:char_is_mobile_general_with_army(characters:item_at(i)) then
                    empire_score = empire_score + 40
                    -- jlog("Horde found!")
               end
          end
          local vassal_regions = cm:model():world():faction_by_key("wh2_dlc13_lzd_defenders_of_the_great_plan"):region_list()
          empire_score = empire_score + (vassal_regions:num_items() * 5)
          -- jlog("Vassal has " .. (vassal_regions:num_items()) .. " regions.")
          empire_score = empire_score - 40
     elseif subculture == "wh2_dlc11_sc_cst_vampire_coast" then
          -- Skaven
          -- jlog("Player is Vampire Coast, every horde (not normal armies) counts for 20 points (first one is free). Every region owned counts for 7 points. Every Pirate Cove counts for 5 points.")
          local characters = human_faction:character_list()
          for i = 0, characters:num_items() - 1 do
               if cm:char_is_mobile_general_with_army(characters:item_at(i)) then
                    local mf = characters:item_at(i):military_force()
                    -- jlog("Military force found of type: " .. (mf:force_type():key()))
                    if mf:force_type():key() == "CHARACTER_BOUND_HORDE" then empire_score = empire_score + 20 end
               end
          end
          local owned_regions = human_faction:region_list()
          empire_score = empire_score + (owned_regions:num_items() * 7)
          -- jlog("Player owns " .. (owned_regions:num_items()) .. " regions.")
          local pirate_coves = human_faction:foreign_slot_managers()
          for i = 0, pirate_coves:num_items() - 1 do
               local cove = pirate_coves:item_at(i)
               -- jlog("Cove found at: " .. cove:region():name())
          end
          empire_score = empire_score + (pirate_coves:num_items() * 5)
          -- jlog("Player has " .. (pirate_coves:num_items()) .. " pirate coves.")
          empire_score = empire_score - 20
     elseif subculture == "wh2_main_sc_skv_skaven" then
          -- jlog("Player has " .. (undercities:num_items()) .. " Skaven Undercities.")
          -- Norsca: Norscan regions count half due to low value. Every army counts for 20 points. Every region outside Norsca counts for the normal 10 points.
          -- jlog("Player is Skaven, settlements count normal 10 points and Skaven Undercities count as 5.")
          local owned_regions = human_faction:region_list()
          empire_score = empire_score + (owned_regions:num_items() * 10)
          -- jlog("Player owns " .. (owned_regions:num_items()) .. " regions.")
          local undercities = human_faction:foreign_slot_managers()
          for i = 0, undercities:num_items() - 1 do
               local undercity = undercities:item_at(i)
               -- jlog("Undercity found at: " .. undercity:region():name())
          end
          empire_score = empire_score + (undercities:num_items() * 5)
     elseif subculture == "wh_main_sc_nor_norsca" then
          local characters = human_faction:character_list()
          for i = 0, characters:num_items() - 1 do
               if cm:char_is_mobile_general_with_army(characters:item_at(i)) then
                    empire_score = empire_score + 20
                    -- jlog("Army found!")
               end
          end
          local owned_regions = human_faction:region_list()
          for i = 0, owned_regions:num_items() - 1 do
               local region = owned_regions:item_at(i)
               if region:province_name() == "wh3_main_combi_province_albion" or region:province_name() == "wh3_main_combi_province_vanaheim_mountains" or
                    region:province_name() == "wh3_main_combi_province_helspire_mountains" or region:province_name() == "wh3_main_combi_province_ice_tooth_mountains" or
                    region:province_name() == "wh3_main_combi_province_mountains_of_naglfari" or region:province_name() ==
                    "wh3_main_combi_province_trollheim_mountains" or region:province_name() == "wh3_main_combi_province_mountains_of_hel" or region:province_name() ==
                    "wh3_main_combi_province_gianthome_mountains" or region:province_name() == "wh3_main_combi_province_goromadny_mountains" then
                    -- jlog("Region in Norsca found.")
                    empire_score = empire_score + 5
               else
                    -- jlog("Region outside Norsca found.")
                    empire_score = empire_score + 10
               end
          end
          empire_score = empire_score - 20
     elseif subculture == "wh_dlc05_sc_wef_wood_elves" then
          -- WEF: Core settlements count triple, outposts only half
          local owned_regions = human_faction:region_list()
          for i = 0, owned_regions:num_items() - 1 do
               local region = owned_regions:item_at(i)
               if region:name() == "wh3_main_combi_region_kings_glade" or region:name() == "wh3_main_combi_region_vauls_anvil_loren" or region:name() ==
                    "wh3_main_combi_region_waterfall_palace" or region:name() == "wh3_main_combi_region_crag_halls_of_findol" or region:name() ==
                    "wh3_main_combi_region_the_witchwood" or region:name() == "wh3_main_combi_region_gaean_vale" or region:name() ==
                    "wh3_main_combi_region_laurelorn_forest" or region:name() == "wh3_main_combi_region_gryphon_wood" or region:name() ==
                    "wh3_main_combi_region_forest_of_gloom" or region:name() == "wh3_main_combi_region_oreons_camp" or region:name() ==
                    "wh3_main_combi_region_the_haunted_forest" or region:name() == "wh3_main_combi_region_jungles_of_chian" or region:name() ==
                    "wh3_main_combi_region_the_sacred_pools" then
                    -- jlog("WEF region found.")
                    empire_score = empire_score + 30
               else
                    -- jlog("Regular region found.")
                    empire_score = empire_score + 5
               end
          end
          empire_score = empire_score - 20
     elseif subculture == "wh_main_sc_chs_chaos" then
          -- WoC faction: Every owned region counts for 10 points, regions owned by vassals 6 points
          local owned_regions = human_faction:region_list()
          empire_score = empire_score + (owned_regions:num_items() * 10)
          -- find vassals' regions
          local factions = cm:model():world():faction_list()
          local vassals_region_count = 0
          for i = 0, factions:num_items() - 1 do
               if factions:item_at(i):is_vassal_of(human_faction) then
                    vassals_region_count = vassals_region_count + factions:item_at(i):region_list():num_items()
               end
          end
          -- jlog("Player's vassals number of regions owned: "..(vassals_region_count))
          empire_score = empire_score + (vassals_region_count * 6)
     else
          -- normal settling factions: Every region counts for 10 points
          local owned_regions = human_faction:region_list()
          empire_score = empire_score + (owned_regions:num_items() * 10)
     end
     -- jlog("Raw Empire Score: " .. empire_score)
     empire_score = math.floor((empire_score / 50))
     -- jlog("Final Empire Score: " .. empire_score)
     return empire_score
end

core:add_listener("MCT_JDYNDIF", "MctInitialized", true, function(context) mct_jdyndif = context:mct() end, true)

-- Listener for when the MCT settings screen was opened and settings changed
core:add_listener("MCT_CHANGED_JDYNDIF", "MctFinalized", true, function(context)
     -- re-read settings into the saved values
     read_mct_values(false)
end, true)

-- Listener for when the MCT settings screen was opened
core:add_listener("MCT_PANEL_OPENED_JDYNDIF", "MctPanelOpened", true, function(context)
     -- make all options read-only if the campaign was started with the settings lock enabled
     local mct_mymod = mct_jdyndif:get_mod_by_key("jadawin_dynamic_difficulty")
     if mct_mymod:get_option_by_key("settings_locked"):get_finalized_setting() then
          mct_mymod:get_option_by_key("jdyndif_enable_replenishment"):set_read_only(true)
          mct_mymod:get_option_by_key("jdyndif_enable_recruitment"):set_read_only(true)
     end
end, true)

-- event player starts turn
core:add_listener("JDYNDIF_TURNSTART", "FactionTurnStart", function(context) return (context:faction():is_human()) end, function(context)
     local turn_number = cm:model():turn_number()
     cm:callback(function() if turn_number == 1 or not (cm:get_saved_value("jdyndif_mct_values_exist")) then read_mct_values(true) end end, 0.2)
end, true)

-- add event
core:add_listener("JDYNDIF_EFFECT", "FactionTurnStart", function(context) return not (context:faction()):is_human() end, function(context)
     local turn_number = (cm:model()):turn_number()
     local current_faction = context:faction()
     local current_faction_name = current_faction:name()
     local human_faction_key = (cm:get_human_factions())[1]
     local human_faction = ((cm:model()):world()):faction_by_key(human_faction_key)

     if current_faction_name ~= "rebels" then
          cm:callback(function()

               local player_score = get_empire_score_player()
               local player_difficulty = "normal"
               local mod_construction = 1
               local mod_recruit_cost = 1
               local mod_tax_rate = 1
               local mod_growth = 1
               local mod_battle_loot = 1
               local combined_difficulty = cm:model():combined_difficulty_level()

               if combined_difficulty == -1 then -- Hard
                    player_difficulty = "hard"
                    mod_construction = 2.0
                    mod_recruit_cost = 2.0
                    mod_tax_rate = 2.0
                    mod_growth = 2.0
                    mod_battle_loot = 2.0
               elseif combined_difficulty == -2 then -- Very Hard
                    player_difficulty = "vhard"
                    mod_construction = 2.25
                    mod_recruit_cost = 2.25
                    mod_tax_rate = 2.25
                    mod_growth = 2.25
                    mod_battle_loot = 2.25
               elseif combined_difficulty == -3 then -- Legendary
                    player_difficulty = "legendary"
                    mod_construction = 2.5
                    mod_recruit_cost = 2.5
                    mod_tax_rate = 2.5
                    mod_growth = 2.5
                    mod_battle_loot = 2.5
               elseif combined_difficulty == 1 then -- Easy
                    player_difficulty = "easy"
                    mod_construction = -0.5
                    mod_recruit_cost = 0.5
                    mod_tax_rate = 0.5
                    mod_growth = 0.5
                    mod_battle_loot = 0.5
               end

               local xp_gain_per_turn = 0
               local recruit_rank = 0
               local recruit_points_bonus = 0
               local replenishment_bonus = 0
               local ai_buff_level = player_score

               if current_faction:is_vassal_of(human_faction) == true or current_faction:allied_with(human_faction) == true then
                    ai_buff_level = ai_buff_level / 1.10
               end

               if ai_buff_level >= 12 and combined_difficulty < 0 then
                    xp_gain_per_turn = 100 * math.abs(combined_difficulty)
                    recruit_rank = 2 * math.abs(combined_difficulty)
                    recruit_points_bonus = 3
                    replenishment_bonus = 5
               elseif ai_buff_level >= 9 and combined_difficulty < 0 then
                    xp_gain_per_turn = 100 * math.abs(combined_difficulty)
                    recruit_rank = 2 * math.abs(combined_difficulty)
                    recruit_points_bonus = 3
                    replenishment_bonus = 4
               elseif ai_buff_level >= 6 and combined_difficulty < 0 then
                    xp_gain_per_turn = 75 * math.abs(combined_difficulty)
                    recruit_rank = math.ceil(0 * math.abs(combined_difficulty))
                    recruit_points_bonus = 2
                    replenishment_bonus = 2
               elseif ai_buff_level >= 3 and combined_difficulty < 0 then
                    xp_gain_per_turn = 50 * math.abs(combined_difficulty)
                    recruit_rank = math.abs(combined_difficulty)
                    recruit_points_bonus = 1
                    replenishment_bonus = 1
               end

               local mod_extra_difficulty = 1
               if cm:get_saved_value("jdyndif_extra_difficulty") > 0 then
                    mod_extra_difficulty = cm:get_saved_value("jdyndif_extra_difficulty") * 0.05 + 1
               end

               local effect_strength_tax_rate = math.ceil(ai_buff_level * 4 * mod_tax_rate * mod_extra_difficulty + 5)
               if effect_strength_tax_rate > 175 then effect_strength_tax_rate = 175 end

               local effect_strength_battle_loot = math.ceil(ai_buff_level * 4 * mod_battle_loot * mod_extra_difficulty + 10)
               if effect_strength_battle_loot > 175 then effect_strength_battle_loot = 175 end

               local effect_strength_growth = math.ceil(ai_buff_level * 4 * mod_growth * mod_extra_difficulty + 12)
               if effect_strength_growth > 75 then effect_strength_growth = 75 end

               local effect_strength_construction = math.ceil(ai_buff_level * -3 * mod_construction * mod_extra_difficulty - 9)

               if effect_strength_construction < -75 then effect_strength_construction = -75 end

               local effect_strength_recruit_cost = math.ceil(ai_buff_level * -2 * mod_recruit_cost * mod_extra_difficulty - 5)
               if effect_strength_recruit_cost < -75 then effect_strength_recruit_cost = -75 end

               local effect_bundle_government = cm:create_new_custom_effect_bundle("Dynamic_Difficulty_Government")

               effect_bundle_government:add_effect("wh_main_effect_economy_gdp_mod_all", "faction_to_region_own", effect_strength_tax_rate)
               effect_bundle_government:add_effect("wh_main_effect_building_construction_cost_mod", "faction_to_region_own", effect_strength_construction)
               effect_bundle_government:add_effect("wh_main_effect_province_growth_other", "faction_to_province_own", effect_strength_growth)
               effect_bundle_government:set_duration(1)
               cm:apply_custom_effect_bundle_to_faction(effect_bundle_government, current_faction)

               local effect_bundle_armies = cm:create_new_custom_effect_bundle("Dynamic_Difficulty_Armies")

               effect_bundle_armies:add_effect("wh_main_effect_force_all_campaign_recruitment_cost_all", "faction_to_force_own", effect_strength_recruit_cost)
               effect_bundle_armies:add_effect("wh_main_effect_agent_action_outcome_parent_army_xp_gain_factionwide", "faction_to_force_own", xp_gain_per_turn)
               effect_bundle_armies:add_effect("wh_main_effect_force_all_campaign_experience_base_all", "faction_to_force_own", recruit_rank)
               effect_bundle_armies:add_effect("wh_main_effect_force_all_campaign_post_battle_loot_mod", "faction_to_faction_own", effect_strength_battle_loot)

               if cm:get_saved_value("jdyndif_enable_replenishment") then
                    effect_bundle_armies:add_effect("wh2_main_effect_replenishment_characters", "faction_to_force_own", replenishment_bonus)
                    effect_bundle_armies:add_effect("wh_main_effect_force_all_campaign_replenishment_rate", "faction_to_force_own", replenishment_bonus)
               end

               if cm:get_saved_value("jdyndif_enable_recruitment") then
                    effect_bundle_armies:add_effect("wh_main_effect_unit_recruitment_points", "faction_to_province_own", recruit_points_bonus)
               end

               effect_bundle_armies:set_duration(1)
               cm:apply_custom_effect_bundle_to_faction(effect_bundle_armies, current_faction)

               if current_faction_name == "wh_main_emp_empire" then
                    jlog("Turn: # " .. turn_number .. " |  Difficulty: " .. player_difficulty .. " | Player Score: " .. player_score .. "| AI Buff Level: " .. ai_buff_level .. " | Income: " .. "+" .. effect_strength_tax_rate .. "%" .. " | Growth: " .. "+" .. effect_strength_growth .. " | Construction Cost: " .. effect_strength_construction .. "%" .. " | Recruit Cost: " .. effect_strength_recruit_cost .. " | Loot: " .. "+" .. effect_strength_battle_loot .. "%" .. " | Rank: " .. "+" .. recruit_rank .. " | Unit XP Per Turn: " .. "+" .. xp_gain_per_turn .. " | Replenishment: " .. "+" .. replenishment_bonus .. "% | Recruitment Slots: " .. "+" .. recruit_points_bonus)
               end
          end, 0)
     end
end, true)
