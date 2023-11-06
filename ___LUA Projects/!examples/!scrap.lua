local function merge_tables(main_table, mod_table)
     local merged_table = main_table;
     for k, v in pairs(mod_table) do
          if merged_table[k] then
               local to_merge = {};
               if is_table(v) then
                    for j, c in pairs(v) do
                         local exists
                         for l, b in pairs(merged_table[k]) do
                              if b == c then
                                   exists = true;
                              end;
                         end;

                         if not exists then
                              table.insert(to_merge, c);
                         end;
                    end;
               else
                    out("MarthVariantSelector error: key" .. k .. " has non table value while merging, skipping");
               end;
               table.sort(to_merge);
               for i = 1, #to_merge do
                    table.insert(merged_table[k], to_merge[i]);
               end;
          else
               merged_table[k] = v;
          end;
     end;
     return merged_table;
end;

local function get_variant_tables()
     local main_variants_table = {};

     local load_main_file, main_file_error = loadfile("marthvs/main/mvsmain.lua");
     if not main_file_error then
          main_variants_table = load_main_file();
     else
          out("MarthVariantSelector error: Couldn't find the main table! Error is: " .. main_file_error);
     end;


     local files = core:get_scripts_in_directory("marthvs/mod", true);

     if #files == 0 then
          out("MarthVariantSelector warning: couldn't find any mod tables, skipping merge");
          return main_variants_table;
     else
          for i = 1, #files do
               local load_current_mod_file, current_error = loadfile(files[i]);
               if not current_error then
                    current_mod_table = load_current_mod_file();
                    if is_table(current_mod_table) then
                         main_variants_table = merge_tables(main_variants_table, current_mod_table);
                    else
                         out("MarthVariantSelector error: File: " .. files[i] .. " is not a proper table, skipping");
                    end;
               else
                    out("MarthVariantSelector error: couldn't load " .. files[i] .. " error is " .. current_error);
               end;
          end;
          return main_variants_table;
     end;
end;


local variants_table = get_variant_tables();
local character_variant_index = {};
marthvs = {};
------GLOBAL FUNCTIONS-------------
----Beware of UI actions affecting game state, will cause desyncs in MP, use appropriate triggers-----

--- @function get_subtype_variants
--- @desc Returns a table of the registered character variants for the given character subtype key.
--- @p @string character subtype key.
--- @r @table or @nil character variants
function marthvs:get_subtype_variants(character_subtype_key)
     if variants_table[character_subtype_key] then
          return variants_table[character_subtype_key];
     else
          return nil;
     end;
end;

--- @function set_subtype_variants
--- @desc Sets the registered variants for the given character subtype key to the given table.
--- @p @string character subtype key.
--- @p @table character variants
function marthvs:set_subtype_variants(character_subtype_key, art_set_ids)
     if is_string(character_subtype_key) then
          if is_table_of_strings(art_set_ids) then
               variants_table[character_subtype_key] = art_set_ids;
          else
               out(
               "MarthVariantSelector error: set_subtype_variants called but the provided art_set_id is not a table of strings");
          end;
     else
          out(
          "MarthVariantSelector error: set_subtype_variants called but the provided character_subtype_key is not a string");
     end;
end;

--- @function get_character_variant_index
--- @desc Returns the current variant index for the character with the given CQI
--- @p @number CQI
--- @r @number Character Variant index
function marthvs:get_character_variant_index(character_cqi)
     return character_variant_index[tostring(character_cqi)]
end;

--- @function set_character_variant_index
--- @desc Sets the current variant index for the character with the given CQI to the given number
--- @p @number CQI
--- @p @number Character Variant index
function marthvs:set_character_variant_index(character_cqi, variant_index)
     character_variant_index[tostring(character_cqi)] = variant_index;
end;

-------------------------------------------------------------------------------------------------------------------------------------------------

local function get_cqi_from_ui_context()
     local context_parent = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent");
     if context_parent then
          local character_cqi = context_parent:GetContextObjectId("CcoCampaignCharacter");
          return character_cqi;
     else
          return false;
     end;
end;


local function create_selector_button()
     local parent = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
          "tab_panels", "character_details_subpanel");
     if parent then
          local selector_button = UIComponent(parent:CreateComponent("selector_button", "ui/templates/round_small_button"));
          local reset_cam_button = find_uicomponent(core:get_ui_root(), "character_details_panel",
               "character_context_parent", "tab_panels", "character_details_subpanel", "button_reset");
          local x, y = reset_cam_button:Position();

          selector_button:MoveTo(x + 850, y + 38);
          selector_button:SetImagePath("ui/skins/default/icon_ai_turn_settings_player.png");
          selector_button:SetTooltipText("Change Character variant", true);

          return selector_button;
     end;
end;

local function get_selector_button(create)
     local selector_button = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
          "tab_panels", "character_details_subpanel", "selector_button");

     if selector_button then
          return selector_button;
     elseif create then
          selector_button = create_selector_button();
          return selector_button;
     else
          return false;
     end;
end;

local function populate_selector_panel(panel)
     local cqi = get_cqi_from_ui_context();
     local character = cm:get_character_by_cqi(cqi);
     local character_key = character:character_subtype_key();
     local variants = marthvs:get_subtype_variants(character_key);
     local entries = #variants;
     local ox, oy = panel:Position();

     ---Move the panel to the LEFT a LOT.
     ox = ox - 850;
     panel:MoveTo(ox, oy);

     ---- I can't even ----

     local x = ox + 10;
     local y = oy + 10;
     local x0 = x;
     local y0 = y;
     local sizex = 56;
     local sizey = 56;
     local holder = find_uicomponent(panel, "colour_button_holder");

     for i = 1, entries do
          local current_button = UIComponent(holder:CreateComponent("selector_variant_" .. i,
               "ui/marthui/marth_daniel_colour_button_toggle.twui.xml"));
          local button_text = find_uicomponent(current_button, "dy_text");

          current_button:SetImagePath("ui/marthui/selector_variants/selector_" .. i .. ".png");
          button_text:SetStateText(i);
          current_button:SetTooltipText("Character Variant " .. i, true);

          sizex, sizey = current_button:Dimensions();
          if i ~= 1 and (i - 1) % 5 == 0 then ----- number of buttons in each row
               y = y + sizey
               x = x0
          end;

          if i == character_variant_index[tostring(cqi)] then
               current_button:SetState("selected");
          end;

          current_button:MoveTo(x, y);
          x = x + sizex;
     end;

     -------Panel Resize--------
     local panelx = 5 * sizex + 20;

     if entries >= 3 and entries < 5 then
          panelx = entries * sizex + 20;
     elseif entries <= 2 then
          panelx = 2 * sizex + 20;
     end;

     local panely = (math.ceil(entries / 5 + 1)) * sizey + 30; ----entries/number of buttons in each row + 1 for aesthetics
     panel:Resize(panelx, panely, false);

     ------Extra buttons--------
     local button_selector_ok = UIComponent(panel:CreateComponent("button_selector_ok", "ui/templates/round_small_button"));


     button_selector_ok:MoveTo(x0 + (panelx / 2) - 20 - 9, y0 + panely - 38 - 20);
     button_selector_ok:SetImagePath("ui/skins/default/icon_check.png");
     button_selector_ok:SetTooltipText("Close this panel", true);

     -------Subtitle-----

     local selector_subtitle = UIComponent(panel:CreateComponent("selector_subtitle",
          "ui/marthui/marth_daniel_colour_title"));
     local selector_subtitle_text_holder = find_uicomponent(selector_subtitle, "dy_subtype");
     selector_subtitle_text_holder:SetStateText("Select a variant");

     local dx, dy = selector_subtitle:Dimensions();
     oy = oy - dy / 2 - 12;
     ox = ox + panelx / 2 - dx / 2;
     selector_subtitle:MoveTo(ox, oy);
end;

local function toggle_equipment_holder(hide)
     local equipment_holder = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
          "tab_panels", "character_details_subpanel", "equipment_holder");
     local selector_panel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
          "tab_panels", "character_details_subpanel", "selector_button", "selector_panel");

     if selector_panel then
          if equipment_holder:Visible(true) or selector_panel:Visible(true) or hide then
               equipment_holder:SetVisible(false);
          end;
     elseif hide then
          equipment_holder:SetVisible(false);
     else
          equipment_holder:SetVisible(true);
     end;
end;



local function create_selector_panel()
     local parent = get_selector_button();
     if parent then
          local selector_panel = UIComponent(parent:CreateComponent("selector_panel", "ui/marthui/marth_daniel_panel"));
          local x, y = selector_panel:Position();
          local dx, dy = selector_panel:Dimensions();
          selector_panel:MoveTo(x + dx / 4, y);

          populate_selector_panel(selector_panel);
          toggle_equipment_holder();

          return selector_panel;
     end;
end;


local function get_selector_panel(create)
     local selector_panel = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
          "tab_panels", "character_details_subpanel", "selector_button", "selector_panel");

     if selector_panel then
          return selector_panel;
     elseif create then
          selector_panel = create_selector_panel();
          return selector_panel;
     else
          return false;
     end;
end;

local function reset_active_buttons(cqi)
     local character = cm:get_character_by_cqi(cqi);
     local character_key = character:character_subtype_key();
     local variants = marthvs:get_subtype_variants(character_key);
     local entries = #variants;

     for i = 1, entries do
          local current_button = find_uicomponent(core:get_ui_root(), "character_details_panel",
               "character_context_parent", "tab_panels", "character_details_subpanel", "selector_button",
               "selector_panel", "colour_button_holder", "selector_variant_" .. i);
          if character_variant_index[tostring(cqi)] == i then
               current_button:SetState("selected");
          else
               current_button:SetState("active");
          end;
     end;
end;

local function switch_selector_variant(character_cqi, index)
     ---MP Event----
     CampaignUI.TriggerCampaignScriptEvent(tonumber(character_cqi), "marthvs_variant_index:" .. index);
     ----MP Event----
     common.call_context_command("CcoCampaignCharacter", character_cqi, "Select(false)");
     toggle_equipment_holder();
     character_variant_index[tostring(character_cqi)] = index;
end;


--------MP  Event-----
core:add_listener(
     "VSelectorSwitchVariant_MP",
     "UITrigger",
     function(context)
          return string.find(context:trigger(), "marthvs_variant_index:")
     end,
     function(context)
          local character_cqi = context:faction_cqi();
          local index = string.gsub(context:trigger(), "marthvs_variant_index:", "")
          index = tonumber(index);
          local character = cm:get_character_by_cqi(character_cqi);
          local character_key = character:character_subtype_key();
          local variants = marthvs:get_subtype_variants(character_key)

          if variants then
               cm:add_unit_model_overrides("character_cqi:" .. character_cqi, variants[index]);
          else
               out("Marth VariantSelector switch variants called but variants is empty, how can this be?");
          end;
     end, true);

----MP Event----









core:add_listener(
     "VSelectorCharacterSelected",
     "CharacterSelected",
     true,
     function(context)
          cm:callback(function()
               local cqi = get_cqi_from_ui_context();

               if cqi then
                    local character = cm:get_character_by_cqi(cqi);
                    local selector_button = get_selector_button(true);
                    local character_key = character:character_subtype_key();

                    if marthvs:get_subtype_variants(character_key) then
                         selector_button:SetVisible(true);
                         if get_selector_panel() then
                              selector_button:DestroyChildren();
                              get_selector_panel(true);
                         end;
                    else
                         selector_button:SetVisible(false);
                         selector_button:DestroyChildren();
                    end;
               end;
          end, 0.1);
     end, true);


core:add_listener(
     "VSelectorPanelOpened",
     "PanelOpenedCampaign",
     function(context)
          return context.string == "character_details_panel"
     end,
     function(context)
          local selector_button = get_selector_button();
          if selector_button then
               selector_button:DestroyChildren();
          end;

          local cqi = get_cqi_from_ui_context();
          if cqi then
               local character = cm:get_character_by_cqi(cqi);
               local selector_button = get_selector_button(true);
               local character_key = character:character_subtype_key();


               if marthvs:get_subtype_variants(character_key) then
                    selector_button:SetVisible(true);
               else
                    selector_button:SetVisible(false);
               end;
          end;
     end, true);


--------------------BUTTONS---------------------------------------------------
core:add_listener(
     "VSelectorButtonClicked",
     "ComponentLClickUp",
     function(context)
          return context.string == "selector_button"
     end,
     function(context)
          local selector_panel = get_selector_panel(true);
     end, true);


core:add_listener(
     "VSelectorOkClicked",
     "ComponentLClickUp",
     function(context)
          return context.string == "button_selector_ok"
     end,
     function(context)
          local selector_button = get_selector_button();
          selector_button:DestroyChildren();
          toggle_equipment_holder();
     end, true);



core:add_listener(
     "VSelectorVariantClicked",
     "ComponentLClickUp",
     function(context)
          if string.find(context.string, "selector_variant_") then
               return true;
          end;
     end,
     function(context)
          local selected = find_uicomponent(core:get_ui_root(), "character_details_panel", "character_context_parent",
               "tab_panels", "character_details_subpanel", "selector_button", "selector_panel", context.string);
          local variant_index = tonumber(context.string:match("_(%d+)"));
          local cqi = get_cqi_from_ui_context();
          if cqi then
               switch_selector_variant(cqi, variant_index);

               if selected:CurrentState() == "selected" or selected:CurrentState() == "selected_hover" or selected:CurrentState() == "down" then
                    reset_active_buttons(cqi);
               else
                    selected:SetState("selected");
               end;
          end;
     end, true);

core:add_listener(
     "VSelectorDanielButtonClicked",
     "ComponentLClickUp",
     function(context)
          return context.string == "daniel_button"
     end,
     function(context)
          local selector_button = get_selector_button();
          selector_button:DestroyChildren();
     end, true);






-------------------SAVING/LOADING----------------------------
cm:add_saving_game_callback(
     function(context)
          for k, v in pairs(character_variant_index) do
               if not cm:get_character_by_cqi(tonumber(k)) then
                    character_variant_index[k] = nil;
               end;
          end;
          cm:save_named_value("marthvs_cvi", character_variant_index, context);
     end);

cm:add_loading_game_callback(
     function(context)
          character_variant_index = cm:load_named_value("marthvs_cvi", character_variant_index, context);
     end);
