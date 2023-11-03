----------------------------------------------------------------
-- Returns all owned region in the supplied province_key string
----------------------------------------------------------------
function hertz_get_province_owned_regions(province_key, faction_key, return_owns_entire_province)
     out("Province name = " .. province_key)
     out("faction = " .. faction_key);
     if return_owns_entire_province == nil then
          return_owns_entire_province = false;
     end
     local regions_table = {};
     local regions_added = false;
     local faction_script_interface = cm:get_faction(faction_key)
     local faction_region_list = faction_script_interface:region_list();

     for i = 0, faction_region_list:num_items() - 1 do
          local target_region = faction_region_list:item_at(i);
          if target_region:province_name() == province_key then
               if not table.contains(regions_table, target_region) and not table.contains(region_exclusion, target_region:name()) and target_region:owning_faction():name() == faction_key then
                    regions_added = true;
                    table.insert(regions_table, target_region:name());
                    out("Region inserted [" .. target_region:name() .. "] for [" .. faction_key .. "]");
               end;
          end;
     end;
     out("Regions inserted [" .. table.maxn(regions_table) .. "]");

     for i = 1, table.maxn(regions_table) do
          out("Region inserted [" .. regions_table[i] .. "]");
     end;

     if regions_added then
          if return_owns_entire_province then
               if faction_script_interface:holds_entire_province(province_key, true) then
                    out("Regions adding complete");
                    return regions_table;
               else
                    out("Regions adding failed. faction does not hold entire province.");
                    return {};
               end;
          else
               out("Regions adding complete");
               return regions_table;
          end;
     else
          out("Regions adding failed");
          return {};
     end;
end;
