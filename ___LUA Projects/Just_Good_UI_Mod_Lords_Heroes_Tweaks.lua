--starts at line 192

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
        if char then
            if cmn:is_char_transported(char) then
                char:SetVisible(set_visible)
            elseif cmn:is_patrol_army(char) then -- hides armies spawned by Hertz Province Patrols mod
                char:SetVisible(false)
            end
        end
    end
    callback_sync_selection()
    cmn:out_end()
end
