local cmn = oz92_uitweaks_common
local mod_prefix = "lnh_tweak: "

local function _get_checkbox()
     return find_uicomponent(
          core:get_ui_root(),
          "hud_campaign",
          "radar_things",
          "dropdown_parent",
          "dropdown_units",
          "panel",
          "tx_title",
          cmn.opt_lords_n_heroes_checkbox_name
     )
end


local function set_checkbox_state(state)
     local checkbox = _get_checkbox()
     if checkbox then
          checkbox:SetState(state)
     end
end

local function cb_set_checkbox_state(state)
     cm:callback(function()
          set_checkbox_state(state)
     end, 0.1)
end

local function ensure_checkbox()
     cmn:out_start(mod_prefix .. "ensure_checkbox start")
     local title = find_uicomponent(
          core:get_ui_root(),
          "hud_campaign",
          "radar_things",
          "dropdown_parent",
          "dropdown_units",
          "panel",
          "tx_title"
     )
     if not title then
          return cmn:out_end("lords_and_heroes title not found")
     end
     local is_checkbox = find_uicomponent(title, cmn.opt_lords_n_heroes_checkbox_name)
     if is_checkbox then
          return cmn:out_end("checkbox exist")
     end
     local cb_name = cmn.opt_lords_n_heroes_checkbox_name
     local checkbox = find_uicomponent(title, cb_name)
     if checkbox then
          cmn:out_end("checkbox exist ?! Destroying")
          checkbox:Destroy();
     end
     cmn:outd("creating checkbox")
     checkbox = UIComponent(
          title:CreateComponent(cb_name, "ui/templates/checkbox_toggle")
     )
     checkbox:SetTooltipText("Enable to hide embedded heroes", true)
     checkbox:SetDockingPoint(3)
     checkbox:SetDockOffset(-20, 0)
     checkbox:PropagatePriority(title:Priority())
     checkbox:SetCanResizeHeight(true)
     checkbox:SetCanResizeWidth(true)
     checkbox:Resize(26, 26)
     local svr = ScriptedValueRegistry:new()
     local checkbox_state = svr:LoadString(cmn.var_lnh_checkbox_state_reg_name)
     cmn:outd("stored value = " .. checkbox_state)
     if not (string.len(checkbox_state) == 0) then
          if string.starts_with(checkbox_state, "selected") then
               cmn:outd("setting state = selected")
               checkbox:SetState("selected")
               cb_set_checkbox_state("selected")
          else
               cmn:outd("setting state = selected")
               checkbox:SetState(checkbox_state)
               cb_set_checkbox_state(checkbox_state)
          end
     end
     cmn:out_end()
end

local function _get_active_cqi()
     local porthole_mask = find_uicomponent(core:get_ui_root(), "hud_campaign", "info_panel_holder",
          "primary_info_panel_holder", "info_panel_background", "CharacterInfoPopup", "character_info_parent",
          "porthole_mask")
     if (not porthole_mask) or (not porthole_mask:Visible(true)) then
          cmn:outd("porthole_mask not found")
          return
     end
     local cco_char = cmn:get_cco_char(porthole_mask)
     if not cco_char then
          cmn:outd("CcoCampaignCharacter not found")
          return
     end
     if not cco_char:Call("IsPlayerCharacter") then
          cmn:outd("Not owned")
          return
     end
     local char_cqi = cco_char:Call("CQI")
     local hero_ctx = cmn:get_embedded_military_ctx(cco_char)
     if hero_ctx then
          local lord_cqi = hero_ctx:Call("CommandingCharacterContext.CQI")
          return char_cqi, lord_cqi -- char is embedded hero
     end
     return char_cqi, char_cqi      -- char is either a lord or lone hero
end

local function _scroll_to_char(uic_id)
     local cco_ui = cco("CcoComponent", "dropdown_units")
     if cco_ui then
          local cco_list = cco_ui:Call("ChildContext('sortable_list_units')")
          if cco_list then
               cco_list:Call("ScrollToComponent(ChildContext('" .. uic_id .. "'), false)")
          end
     end
end

local function _select(uic_char)
     uic_char:SetState("selected")
     if not uic_char:IsMouseOverChildren() then
          _scroll_to_char(uic_char:Id())
     end
end

local function sync_selection()
     cmn:out_start(mod_prefix .. "sync_selection start")
     local panel = find_uicomponent(
          core:get_ui_root(),
          "hud_campaign",
          "radar_things",
          "dropdown_parent",
          "dropdown_units",
          "panel")
     if not panel then
          return cmn:out_end("panel not found")
     end
     if not panel:Visible() then
          return cmn:out_end("panel is not visible")
     end
     local chars = find_uicomponent(
          panel,
          "panel_clip",
          "sortable_list_units",
          "list_clip",
          "list_box"
     )
     if not chars then
          return cmn:out_end("lords_and_heroes list not found")
     end
     local hero_cqi, lord_cqi = _get_active_cqi()
     if not hero_cqi then
          return cmn:out_end("no cqi to look for")
     end
     cmn:outd("looking for cqi hero = " .. tostring(hero_cqi) .. " lord = " .. tostring(lord_cqi))
     local heros_lord = nil
     local hero_found = nil
     for i = 0, chars:ChildCount() - 1 do
          local char = UIComponent(chars:Find(i))
          if char then
               local cco_char = cmn:get_cco_char(char)
               if cco_char then
                    local char_cqi = cco_char:Call("CQI")
                    if char_cqi == hero_cqi then
                         if char:Visible() then
                              hero_found = true
                              _select(char)
                         end
                    elseif char_cqi == lord_cqi then
                         heros_lord = char
                    else
                         char:SetState("unselected")
                    end
               end
          end
     end
     if not hero_found then
          if heros_lord then
               _select(heros_lord)
          end
     end
     cmn:out_end()
end

local function callback_sync_selection()
     local name = "callback_2100dsfk49"
     cm:remove_callback(name)
     cm:callback(sync_selection, 0.1, name)
end


local function hide_or_show_embedded_heroes()
     cmn:out_start(mod_prefix .. "hide_or_show_embedded_heroes start")
     local panel = find_uicomponent(
          core:get_ui_root(),
          "hud_campaign",
          "radar_things",
          "dropdown_parent",
          "dropdown_units",
          "panel")
     if not panel then
          return cmn:out_end("panel not found")
     end
     if not panel:Visible() then
          return cmn:out_end("panel is not visible")
     end
     local checkbox = find_uicomponent(panel, "tx_title", cmn.opt_lords_n_heroes_checkbox_name)
     if not checkbox then
          return cmn:out_end("checkbox does not exist")
     end
     local chars = find_uicomponent(
          panel,
          "panel_clip",
          "sortable_list_units",
          "list_clip",
          "list_box"
     )
     if not chars then
          cmn:out_end("lords_and_heroes_panel not found")
          return
     end
     local checkbox_state = checkbox:CurrentState()
     cmn:outd("checkbox state = " .. checkbox_state)
     local set_visible = not string.starts_with(checkbox_state, "selected")
     for i = 0, chars:ChildCount() - 1 do
          local char = UIComponent(chars:Find(i))
          local rank = find_uicomponent(char, "rank")
          local forces_icon = find_uicomponent(char, "forces_icon")
          local is_transported = cmn:is_char_transported(char)
          if char then --Jess Bookmark.
               cmn:outd("Lycia: Just Good UI found a character. Are they transported?: " ..
                    tostring(is_transported) .. ".")
               if cmn:is_char_transported(char) then
                    char:SetVisible(set_visible)
               elseif ((not rank) or (not rank:Visible())) and forces_icon:Visible() then
                    cmn:outd("Lycia: Just Good UI found a character with no rank and an army banner in the side panel!")
                    char:SetVisible(false)
               end
          end
     end
     callback_sync_selection()
     cmn:out_end()
end

local function callback_hide_or_show_embedded_heroes()
     local name = "callback_032jggdkf423"
     cm:remove_callback(name)
     cm:callback(hide_or_show_embedded_heroes, 0.1, name)
end

local function save_button_state()
     local checkbox = find_uicomponent(
          core:get_ui_root(),
          "hud_campaign",
          "radar_things",
          "dropdown_parent",
          "dropdown_units",
          "panel", "tx_title", cmn.opt_lords_n_heroes_checkbox_name)
     if checkbox then
          local svr = ScriptedValueRegistry:new()
          cmn:outd("saving value = " .. checkbox:CurrentState())
          svr:SaveString(cmn.var_lnh_checkbox_state_reg_name, checkbox:CurrentState())
     end
end

local function mod_callbacks()
     local listener_name = cmn.listener_lords_n_heroes
     core:remove_listener(listener_name)

     core:add_listener(listener_name, "ComponentLClickUp",
          function(context)
               return context.string == "tab_units"
          end,
          function()
               ensure_checkbox()
               callback_hide_or_show_embedded_heroes()
          end,
          true
     )

     core:add_listener(listener_name, "ComponentLClickUp",
          function(context)
               return context.string == cmn.opt_lords_n_heroes_checkbox_name
          end,
          function()
               cm:callback(save_button_state, 0.2)
               callback_hide_or_show_embedded_heroes()
          end,
          true
     )

     core:add_listener(listener_name, "CharacterSelected", true,
          callback_hide_or_show_embedded_heroes, true)

     core:add_listener(listener_name, "ComponentLClickUp",
          function(context)
               local parent = UIComponent(context.component):Parent()
               if parent then
                    return UIComponent(parent):Id() == "units"
               end
               return false
          end,
          callback_hide_or_show_embedded_heroes,
          true
     )


     core:add_listener(listener_name, "PanelClosedCampaign",
          true,
          callback_hide_or_show_embedded_heroes,
          true
     )
end

cm:add_first_tick_callback(mod_callbacks)
