-- Should require faction leader level 12
-- Requires 15,000 treasury.
cm:trigger_dilemma("wh2_main_hef_yvresse", "wh3_dlc23_neu_ulrika_choice")

-- *Spawn Yifan

cm:spawn_character_to_pool("wh2_main_hef_yvresse", "names_name_20210925",
                           "names_name_20210926", "", "", 18, true, "general",
                           "yifan", true, "");
