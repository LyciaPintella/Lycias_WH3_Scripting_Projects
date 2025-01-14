---@diagnostic disable: undefined-global

local function get_surplus_needed(current_level, max_level, surplus)
     -- Validate inputs
     if type(current_level) ~= "number" or type(max_level) ~= "number" or type(surplus) ~= "number" then
          out("Error: One or more inputs are not numbers")
          return 0
     end

     if current_level < 0 or max_level < 0 or surplus < 0 then
          out("Error: One or more inputs are negative")
          return 0
     end

     if current_level > max_level then
          out("Error: Current level is greater than max level")
          return 0
     end

     -- Initialize surplus needed
     local surplus_needed = 0

     -- If current level is already at or above max level, no surplus is needed
     if current_level >= max_level then
          return surplus_needed
     end

     -- Calculate the total surplus needed to reach max level
     for i = current_level, max_level - 1 do
          surplus_needed = surplus_needed + i
          if i >= 3 then
               surplus_needed = surplus_needed + 1
          end
     end

     -- Subtract the current surplus
     surplus_needed = surplus_needed - surplus

     -- Ensure surplus_needed is not negative
     if surplus_needed < 0 then
          surplus_needed = 0
     end

     return surplus_needed
end

local function get_growth_needed(current_level, max_level)
     -- Validate inputs
     if type(current_level) ~= "number" or type(max_level) ~= "number" then
          out("Error: One or more inputs are not numbers")
          return 0
     end

     if current_level < 0 or max_level < 0 then
          out("Error: One or more inputs are negative")
          return 0
     end

     if current_level > max_level then
          out("Error: Current level is greater than max level")
          return 0
     end

     -- local growth_per_surplus = { 125, 375, 750, 1250, 1875 }
     local growth_per_surplus_from_0 = { 125, 500, 1250, 2500, 4375 }
     local surplus_per_tier = { 0, 1, 2, 4, 5 }
     local surplus_per_tier_minor = { 0, 1, 2, 3, 5 }
     local growth_needed = 0

     -- If current level is already at or above max level, no growth is needed
     if current_level >= max_level then
          return growth_needed
     end

     -- Calculate the total growth needed to reach max level
     for i = current_level, max_level - 1 do
          local tier_index = surplus_per_tier[i + 1]
          if not tier_index then
               out("Error: Invalid tier index")
               return 0
          end

          local growth_for_surplus = growth_per_surplus_from_0[tier_index]
          if growth_for_surplus then
               growth_needed = growth_needed + growth_for_surplus
          else
               out("Error: Invalid growth for surplus")
               return 0
          end
     end

     return growth_needed
end

local function substract_surplus_and_growth(growth_needed, current_surplus, current_growth)
     -- Validate inputs
     if type(growth_needed) ~= "number" or type(current_surplus) ~= "number" or type(current_growth) ~= "number" then
          out("Error: One or more inputs are not numbers")
          return 0
     end

     if growth_needed < 0 or current_surplus < 0 or current_growth < 0 then
          out("Error: One or more inputs are negative")
          return 0
     end

     local growth_per_surplus_from_0 = { 125, 500, 1250, 2500, 4375 }
     local result = growth_needed
     local surplus = math.min(current_surplus, 5)

     if surplus > 0 then
          local growth_reduction = growth_per_surplus_from_0[surplus]
          if not growth_reduction then
               out("Error: Invalid surplus index")
               return 0
          end
          result = result - growth_reduction
     end

     result = result - current_growth
     if result < 0 then
          result = 0
     end

     return result
end

local function get_turns_for_surplus(current_growth, current_surplus, growth_per_turn)
     -- Validate inputs
     if type(current_growth) ~= "number" or type(current_surplus) ~= "number" or type(growth_per_turn) ~= "number" then
          out("Error: One or more inputs are not numbers")
          return 0
     end

     if current_growth < 0 or current_surplus < 0 or growth_per_turn <= 0 then
          out("Error: One or more inputs are negative or growth per turn is not positive")
          return 0
     end

     local growth_per_surplus = { 125, 375, 750, 1250, 1875 }
     local surplus_index = math.min(current_surplus + 1, 5)

     local growth_needed = growth_per_surplus[surplus_index]
     if not growth_needed then
          out("Error: Invalid surplus index")
          return 0
     end

     local turns_needed = math.ceil((growth_needed - current_growth) / growth_per_turn)
     if turns_needed < 0 then
          turns_needed = 0
     end

     return turns_needed
end

local function safely_find_uicomponent(parent, ...)
     if not parent then
          out("Error: Parent component is nil")
          return nil
     end

     local component = find_uicomponent(parent, ...)
     if not component then
          out("Error: Component not found for path: " .. table.concat({ ... }, " -> "))
     end

     return component
end

local function main()
     local growth_needed, current_growth, growth_per_turn, current_surplus = 0, 0, 0, 0
     local root = core:get_ui_root()
     if root then
          local settlement_list = safely_find_uicomponent(root, "settlement_panel", "settlement_list")
          if settlement_list then
               local settlement_list_child_count = settlement_list:ChildCount()
               if settlement_list_child_count then
                    for j = 0, settlement_list_child_count - 1 do
                         local settlement_component = UIComponent(settlement_list:Find(j))
                         if settlement_component then
                              local default_slots_list = safely_find_uicomponent(settlement_component, "settlement_view",
                                   "default_view", "default_slots_list")
                              if default_slots_list then
                                   local building_slot = UIComponent(default_slots_list:Find(1))
                                   if building_slot and building_slot:Id() and building_slot:Id() ~= "template_entry" then
                                        local building_level = safely_find_uicomponent(building_slot, "slot_entry",
                                             "known_parent", "building_level")
                                        local square_building_button = safely_find_uicomponent(building_slot,
                                             "slot_entry", "square_building_button")
                                        if building_level and square_building_button then
                                             local cco_building_slot_id = square_building_button:GetContextObjectId(
                                             "CcoCampaignBuildingSlot")
                                             if cco_building_slot_id then
                                                  local is_player_faction = common.get_context_value(
                                                  "CcoCampaignBuildingSlot", cco_building_slot_id, "IsPlayerFaction")
                                                  local available_development_points = common.get_context_value(
                                                  "CcoCampaignBuildingSlot", cco_building_slot_id,
                                                       "AvailableDevelopmentPoints")
                                                  if is_player_faction and available_development_points and available_development_points > current_surplus then
                                                       current_surplus = available_development_points
                                                  end
                                                  local cc_building_level_record = building_level:GetContextObjectId(
                                                  "CcoBuildingLevelRecord")
                                                  if cc_building_level_record then
                                                       local current_building_level = common.get_context_value(
                                                       "CcoBuildingLevelRecord", cc_building_level_record, "Level")
                                                       local max_level = 5
                                                       local cco_building_id = square_building_button:GetContextObjectId(
                                                       "CcoBuildingCultureVariantRecord")
                                                       if cco_building_id then
                                                            if string.find(cco_building_id, "minor") then max_level = 4 end
                                                            if current_building_level and max_level then
                                                                 growth_needed = growth_needed +
                                                                 get_growth_needed(current_building_level, max_level)
                                                            else
                                                                 out("Error: Invalid building level or max level")
                                                            end
                                                       else
                                                            out("Error: CcoBuildingCultureVariantRecord ID not found")
                                                       end
                                                  else
                                                       out("Error: CcoBuildingLevelRecord ID not found")
                                                  end
                                             else
                                                  out("Error: CcoCampaignBuildingSlot ID not found")
                                             end
                                        else
                                             out("Error: Building level or square building button not found")
                                        end
                                   else
                                        out("Error: Invalid building slot")
                                   end
                              else
                                   out("Error: Default slots list not found")
                              end
                         else
                              out("Error: Settlement component not found")
                         end
                    end
               else
                    out("Error: Settlement list child count is nil")
               end
          else
               out("Error: Settlement list not found")
          end

          local ProvinceInfoPopup = safely_find_uicomponent(root, "hud_campaign", "info_panel_holder",
               "primary_info_panel_holder", "info_panel_background", "ProvinceInfoPopup")
          if ProvinceInfoPopup then
               local region_name = ProvinceInfoPopup:GetContextObjectId("CcoCampaignSettlement")
               if cm and region_name then
                    local region = cm:get_region(region_name)
                    if region then
                         current_growth = region:faction_province_growth()
                         growth_per_turn = region:faction_province_growth_per_turn()
                         local row_holder = safely_find_uicomponent(ProvinceInfoPopup, "script_hider_parent", "panel",
                              "frame_growth", "row_holder")
                         if row_holder then
                              local dy_turns = safely_find_uicomponent(row_holder, "dy_turns")
                              local link_arrow = safely_find_uicomponent(row_holder, "link_arrow")
                              local surplus_parent = safely_find_uicomponent(row_holder, "surplus_parent")
                              if dy_turns and link_arrow and surplus_parent then
                                   local image_opacity = link_arrow:GetCurrentStateImageOpacity(0)
                                   if image_opacity and image_opacity > 0 then
                                        local arrow_x, arrow_y = link_arrow:Position()
                                        local surplus_x, surplus_y = surplus_parent:Position()
                                        local dy_turns_x, dy_turns_y = dy_turns:Position()
                                        if arrow_x and arrow_y and surplus_x and surplus_y and dy_turns_x and dy_turns_y then
                                             surplus_parent:MoveTo(arrow_x, surplus_y)
                                             dy_turns:MoveTo(surplus_x, dy_turns_y)
                                             link_arrow:SetCurrentStateImageOpacity(0, 0)
                                        else
                                             out("Error: Unable to retrieve positions")
                                        end
                                   end
                                   growth_needed = substract_surplus_and_growth(growth_needed, current_surplus,
                                        current_growth)
                                   local turns_until_max_growth = math.ceil(growth_needed / growth_per_turn)
                                   if turns_until_max_growth < 0 or turns_until_max_growth == math.huge then turns_until_max_growth = 0 end
                                   local turns_until_next_surplus = get_turns_for_surplus(current_growth, current_surplus,
                                        growth_per_turn)
                                   if turns_until_next_surplus < 1 then turns_until_next_surplus = 1 end
                                   local text = turns_until_next_surplus .. " / " .. turns_until_max_growth
                                   local text_width, text_height = dy_turns:TextDimensionsForText(text)
                                   if text_width and text_height then
                                        dy_turns:SetCanResizeHeight(true)
                                        dy_turns:SetCanResizeWidth(true)
                                        dy_turns:Resize(text_width + 10, text_height + 10)
                                        dy_turns:SetText(text)
                                   else
                                        out("Error: Unable to get text dimensions")
                                   end
                              else
                                   out("Error: Required UI components (dy_turns, link_arrow, surplus_parent) not found")
                              end
                         else
                              out("Error: Row holder not found")
                         end
                    else
                         out("Error: Region not found")
                    end
               else
                    out("Error: CM object or region name is nil")
               end
          else
               out("Error: ProvinceInfoPopup not found")
          end
     end
end

local function is_frame_growth_available()
     local ui_root = core:get_ui_root()
     if not ui_root then
          out("Error: UI root not found")
          return false
     end

     local frame_growth = find_uicomponent(
          ui_root,
          "hud_campaign",
          "info_panel_holder",
          "primary_info_panel_holder",
          "info_panel_background",
          "ProvinceInfoPopup",
          "script_hider_parent",
          "panel",
          "frame_growth"
     )

     if not frame_growth then
          out("Error: frame_growth component not found")
          return false
     end

     return is_uicomponent(frame_growth)
end

core:add_listener(
     "growth_extended_component_l_click_up_listener",
     "ComponentLClickUp",
     is_frame_growth_available,
     function()
          core:get_tm():real_callback(
               function()
                    out("component_l_click_up_listener triggered")
                    main()
               end,
               100
          )
     end,
     true
)

core:add_listener(
     "growth_extended_panel_opened_listener",
     "PanelOpenedCampaign",
     is_frame_growth_available,
     function()
          core:get_tm():real_callback(
               function()
                    out("panel_opened_listener triggered")
                    main()
               end,
               100
          )
     end,
     true
)

core:add_listener(
     "growth_extended_settlement_selected_listener",
     "SettlementSelected",
     is_frame_growth_available,
     function()
          core:get_tm():real_callback(
               function()
                    out("settlement_selected_listener triggered")
                    main()
               end,
               25
          )
     end,
     true
)

core:add_listener(
     "growth_extended_building_construction_issued_listener",
     "BuildingConstructionIssuedByPlayer",
     is_frame_growth_available,
     function()
          core:get_tm():real_callback(
               function()
                    out("building_construction_issued_listener triggered")
                    main()
               end,
               100
          )
     end,
     true
)

core:add_listener(
     "growth_extended_region_building_cancelled_listener",
     "RegionBuildingCancelled",
     is_frame_growth_available,
     function()
          core:get_tm():real_callback(
               function()
                    out("region_building_cancelled_listener triggered")
                    main()
               end,
               100
          )
     end,
     true
)
