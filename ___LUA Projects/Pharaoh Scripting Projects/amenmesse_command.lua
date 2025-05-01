out("tp_gold init")

--this segment overwrites amenmesse's command with the new gold prospecting data. This copies Tausrets command.
commands.config.effects.phar_main_amenmesse = {
     texts = {
          title = "phar_main_commands_holder_amenmesse_title",
          flavor = "phar_main_commands_holder_amenmesse_flavor",
     },
     activated = {
          cooldown = 4,
          duration = 1,
          texts = {
               name = "tp_amenmesse_command_dummy_title",
               description = "tp_amenmesse_command_dummy_desc",
               effect_condition = "phar_main_commands_use_condition_tausret",
          },
          effect_condition = "leader_is_in_own_or_vassal_province",

          effect_bundle = { bundle_key = "tp_amenmesse_command_dummy", duration = 1, target = "leaders_province" },
     },
     passive = {
          windup = 5,
          texts = {
               name = "phar_main_commands_shemsu_amenmesse_title",
               description = "phar_main_commands_shemsu_amenmesse_desc",
          },
          effect_bundle = { bundle_key = "phar_main_commands_amenmesse_shemsu_hor" },
     }
}

--this just lists regions in vanilla that are gold regions
local provinces_with_gold = {
     ["phar_main_buhen"] = true,
     ["phar_main_akhmim"] = true,
     ["phar_main_central_hatti"] = true,
     ["phar_main_damascus"] = true,
     ["phar_main_east_nubia"] = true,
     ["phar_main_east_sinai"] = true,
     ["phar_main_elephantine"] = true,
     ["phar_main_faiyum"] = true,
     ["phar_main_farafra_oasis"] = true,
     ["phar_main_hattusa"] = true,
     ["phar_main_kanesh"] = true,
     ["phar_main_kawa"] = true,
     ["phar_main_kharga_oasis"] = true,
     ["phar_main_megiddo"] = true,
     ["phar_main_north_east_nubia"] = true,
     ["phar_main_per_ramesses_meri_amon"] = true,
     ["phar_main_tuwana"] = true,
     ["phar_main_ugarit"] = true,
     ["phar_main_zippalanda"] = true,
     ["phar_map_aranzah"] = true,
     ["phar_map_cyclades"] = true,
     ["phar_map_kammanu"] = true,
     ["phar_map_karduniash_ishtananu"] = true,
     ["phar_map_lycia"] = true,
     ["phar_map_epirus"] = true,
     ["phar_map_mari"] = true,
     ["phar_map_achaea"] = true,
     ["phar_map_northern_elam"] = true,
     ["phar_map_qutu"] = true,
     ["phar_map_rhodes"] = true,
     ["phar_map_lazpa"] = true,
     ["phar_map_pala"] = true,
     ["phar_map_uruatri"] = true,
     ["phar_map_thrace"] = true,
     ["phar_map_tjehenu"] = true,
}
--listener detects for effect granted by command and replenishes deposit.
core:add_listener(
     "amenmesse_turn_end",
     "FactionTurnEnd",
     function(context)
          if context:faction():name() == "phar_main_amenmesse" then --script is assuming only Amenmesse has the ability to renew gold.
               out("tp_gold: Amenmesse turn end ")
               return true
          end
          return false
     end,
     function(context)
          local province_list = context:faction():province_list()
          out("tp_gold: go through provinces")

          for i = 0, province_list:num_items() - 1 do
               local this_province = province_list:item_at(i)
               out("tp_gold: eb check" .. this_province:name())

               if this_province:has_effect_bundle("tp_amenmesse_command_dummy", "phar_main_amenmesse") then
                    local this_prov_name = this_province:name()
                    out("tp_gold: eb found" .. this_prov_name)
                    if provinces_with_gold[this_prov_name] then
                         out("tp_gold: ading pooled resource")
                         local current_deposit = this_province:depletable_resource_remaining_amount_no_faction(
                         "troy_gold")
                         local value = current_deposit +
                         1600                            --1600 is about 5 turns of 1 settlment production with 56% increase rate.
                         cm:province_set_pooled_resource(this_province:name(), "troy_gold", value)
                    else
                         out("tp_gold: commanddone in invalid province. can we try and reset the timers.")
                         --here is where I'd try to reset the command cooldowns but tbh its too confusing for me.
                    end
               end
          end
     end,
     true
)
