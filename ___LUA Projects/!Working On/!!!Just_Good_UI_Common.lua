---@class oz92_common
local M = {
     _last_tested_on = "4.0.6",
     _is_debug = true,
     _mod_prefix = "UITWEAKS_oz92_",
     _author = "Deo (Steam Deogo032 76561198016424641)",
     char_select_embedded = "oz92_embedded_heroes",
     upgrade_icon_opacity = 100,
     opt_dup_list_x = 25,
     opt_dup_list_y = 155,
     opt_dup_list_height = 145,
     var_lnh_checkbox_state_reg_name = "UITWEAKS_oz92_lnh_checkbox_state",
     var_toggle_unassigned_state_reg_name = "UITWEAKS_oz92_toggle_unassigned_state"
}

M.listener_upgrade_icon = M._mod_prefix .. "listener_upgrade_icon"
M.listener_char_details = M._mod_prefix .. "listener_char_details"
M.listener_lords_n_heroes = M._mod_prefix .. "listener_lords_n_heroes"
M.listener_misc = M._mod_prefix .. "misc_tweaks"
M.opt_lords_n_heroes_checkbox_name = M._mod_prefix .. "hide_embedded_heroes"


function M:out_sep()
     return self._is_debug and out("=================================")
end

function M:outd(data)
     return self._is_debug and out(data)
end

function M:out_end(data)
     if self._is_debug then
          if data then self:outd(data) end
          self:out_sep()
     end
end

function M:out_start(data)
     if self._is_debug then
          self:out_sep()
          self:outd(data)
     end
end

function M:is_auto_managing(ui_component)
     local cco_unit = ui_component:GetContextObject("CcoCampaignUnit")
     if cco_unit then
          if cco_unit:Call("IsCharacter") then
               return cco_unit:Call("CharacterContext.AutoManagementContext.IsAutoManaging")
          end
          return false
     else
          local cco_char = ui_component:GetContextObject("CcoCampaignCharacter")
          if not cco_char then
               self:outd("failed to get CcoCampaignUnit or CcoCampaignCharacter from " .. ui_component:Id())
               return false
          end
          return cco_char:Call("AutoManagementContext.IsAutoManaging")
     end
end

function M:delete_components(uic, names)
     for i, name in pairs(names) do
          local child = find_uicomponent(uic, name)
          if child then
               child:Destroy()
          end
     end
end

function M:set_components_visible(uic, names, visible)
     names = type(names) == "table" and names or { names }
     for i, name in pairs(names) do
          local child = find_uicomponent(uic, name)
          if child then
               child:SetVisible(visible)
          end
     end
end

-- accepts CcoCampaignCharacter
function M:get_general_military_ctx(ctx)
     if ctx then
          return ctx:Call("MilitaryForceContext")
     end
end

-- accepts CcoCampaignCharacter
function M:get_embedded_military_ctx(ctx)
     if ctx then
          return ctx:Call("TransportedInMilitaryForceContext")
     end
end

function M:get_cco_char(uic)
     if uic then
          return uic:GetContextObject("CcoCampaignCharacter")
     end
end

function M:is_char_transported(uic)
     return self:get_embedded_military_ctx(self:get_cco_char(uic))
end

function M:is_patrol_army(uic)
     local ctx = self:get_general_military_ctx(self:get_cco_char(uic))
     if ctx then
          return ctx:Call("ForceType") == "PATROL_ARMY"
     end
end

function M:for_each(uic, func)
     for i = 0, uic:ChildCount() - 1 do
          local next_elem = UIComponent(uic:Find(i))
          if next_elem then
               func(i, next_elem)
          end
     end
end

function oz92_common()
     return M
end
