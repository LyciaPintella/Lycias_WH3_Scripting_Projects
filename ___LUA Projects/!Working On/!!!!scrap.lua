core:add_ui_created_callback(
     function(context)
          --Mixer stuff
          mixer_enable_custom_faction("884528132")

          mixer_add_starting_unit_list_for_faction("ovn_vmp_blood_dragons",
               { "wh_main_vmp_inf_skeleton_warriors_0", "blood_knight_aspirants_dual",
                    "wh_dlc02_vmp_cav_blood_knights_0", "blood_dragon_vanguard" })

          mixer_add_faction_to_major_faction_list("ovn_vmp_blood_dragons")
     end
)
