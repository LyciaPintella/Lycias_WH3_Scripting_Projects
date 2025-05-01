local zz_unique_character_subtypes = {
     "phar_hero_can_bay_bay",
     "phar_hero_can_irs_irsu",
     "phar_hero_egy_ame_amenmesse",
     "phar_hero_egy_mer_merneptah",
     "phar_hero_egy_ram_ramesses",
     "phar_hero_egy_set_seti",
     "phar_hero_egy_setn_setnakhte",
     "phar_hero_egy_tau_tausret",
     "phar_hero_hit_hat_suppiluliuma",
     "phar_hero_hit_tarh_kurunta",
     "phar_map_hero_ach_achilles",
     "phar_map_hero_ach_agamemnon",
     "phar_map_hero_ach_ajax",
     "phar_map_hero_ach_diomedes",
     "phar_map_hero_ach_menelaus",
     "phar_map_hero_ach_odysseus",
     "phar_map_hero_ash_ninurta",
     "phar_map_hero_bab_adad",
     "phar_map_hero_egy_memnon",
     "phar_map_hero_thr_rhesus",
     "phar_map_hero_tro_aeneas",
     "phar_map_hero_tro_hector",
     "phar_map_hero_tro_paris",
     "phar_map_hero_tro_priam",
     "phar_map_hero_tro_sarpedon",
     "phar_sea_hero_iol_iolaos",
     "phar_sea_hero_wal_walwetes",
};

local function z_unique_character_join()
     core:add_listener(
          "z_unique_character_join_listener",
          "FactionDestroysOtherFaction",
          true,
          function(context)
               local faction_name = context:faction():name()
               local destroyed_faction = context:other_faction()
               local character_list = destroyed_faction:character_list()
               for j = 0, character_list:num_items() - 1 do
                    local character = character_list:item_at(j)
                    local character_subtype = character:character_subtype_key()
                    if character:is_immortal() or table_contains(zz_unique_character_subtypes, character_subtype) then
                         local character_lookup_string = "character_cqi:" .. tostring(character:command_queue_index())
                         cm:reassign_character_to_faction(character_lookup_string, faction_name)
                    end
               end
          end,
          true
     )
end


cm:add_first_tick_callback( --FirstTickAfterWorldCreated
     function(context)
          z_unique_character_join();
     end
)
