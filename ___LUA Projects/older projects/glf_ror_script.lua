--[[
	This script is based on the template by Aexrael Dex and All is Dust. Thanks a lot to them for leaving instructions about what goes where <3
	Adds custom Regiments of Renown to specified factions
]] local function glf_unit_expansion_ror_adds_custom()

    -- Checking whether the script has already run for saved games and if it has then the script doesn't need to run again
    if cm:get_saved_value("glf_unit_expansion_ror_enabled") == nil then

        -- Table for faction, unit key and parameters for add_unit_to_faction_mercenary_pool
        local cror_list = {

            ---------------------------------------------------------------------------------------------------------------
            -- 帝国--
            ---------------------------------------------------------------------------------------------------------------

            -- 黄金学院
            {
                faction_key = "wh2_dlc13_emp_golden_order",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 猎人远征队
            {
                faction_key = "wh2_dlc13_emp_the_huntmarshals_expedition",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 西格玛教会
            {
                faction_key = "wh3_main_emp_cult_of_sigmar",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 艾维领
            {
                faction_key = "wh_main_emp_averland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 帝国
            {
                faction_key = "wh_main_emp_empire",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 霍克领
            {
                faction_key = "wh_main_emp_hochland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 玛丽恩堡
            {
                faction_key = "wh_main_emp_marienburg",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 米登领
            {
                faction_key = "wh_main_emp_middenland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 诺德领
            {
                faction_key = "wh_main_emp_nordland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 奥斯特马克
            {
                faction_key = "wh_main_emp_ostermark",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 奥斯特领
            {
                faction_key = "wh_main_emp_ostland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 斯提尔领
            {
                faction_key = "wh_main_emp_stirland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 塔拉贝克领
            {
                faction_key = "wh_main_emp_talabecland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, -- 威森领
            {
                faction_key = "wh_main_emp_wissenland",
                unit = "glf_emp_knights_of_the_vengeful_sun_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_emp_knights_of_the_vengeful_sun_ror"
            }, ---------------------------------------------------------------------------------------------------------------
            -- 巴托尼亚--
            ---------------------------------------------------------------------------------------------------------------
            -- 里昂尼斯骑士团
            {
                faction_key = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                unit = "glf_brt_rene_de_cartes_spearmen_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_rene_de_cartes_spearmen_ror"
            }, {
                faction_key = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                unit = "glf_brt_jean_claude_sartre_bowmen_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_jean_claude_sartre_bowmen_ror"
            }, {
                faction_key = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh2_dlc14_brt_chevaliers_de_lyonesse",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 欧瑞格骑士
            {
                faction_key = "wh2_main_brt_knights_of_origo",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh2_main_brt_knights_of_origo",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh2_main_brt_knights_of_origo",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 阿图瓦
            {
                faction_key = "wh_main_brt_artois",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_artois",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_artois",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 巴斯托涅
            {
                faction_key = "wh_main_brt_bastonne",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_bastonne",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_bastonne",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 波尔德罗长征军
            {
                faction_key = "wh_main_brt_bordeleaux",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_bordeleaux",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_bordeleaux",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 巴托尼亚
            {
                faction_key = "wh_main_brt_bretonnia",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_bretonnia",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_bretonnia",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 卡尔卡松
            {
                faction_key = "wh_main_brt_carcassonne",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_carcassonne",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_carcassonne",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 里昂尼斯
            {
                faction_key = "wh_main_brt_lyonesse",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_lyonesse",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_lyonesse",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, -- 帕拉翁
            {
                faction_key = "wh_main_brt_parravon",
                unit = "glf_brt_errant_brigade_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_errant_brigade_ror"
            }, {
                faction_key = "wh_main_brt_parravon",
                unit = "glf_brt_hippogryph_subspecies_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_hippogryph_subspecies_knights_ror"
            }, {
                faction_key = "wh_main_brt_parravon",
                unit = "glf_brt_fastrics_skylance_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_brt_fastrics_skylance_ror"
            }, ---------------------------------------------------------------------------------------------------------------
            -- 高等精灵--
            ---------------------------------------------------------------------------------------------------------------
            -- 卡勒多骑士
            {
                faction_key = "wh2_dlc15_hef_imrik",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_dlc15_hef_imrik",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 阿瓦隆
            {
                faction_key = "wh2_main_hef_avelorn",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_avelorn",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 卡勒多
            {
                faction_key = "wh2_main_hef_caledor",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_caledor",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 查瑞斯
            {
                faction_key = "wh2_main_hef_chrace",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_chrace",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 暮光要塞
            {
                faction_key = "wh2_main_hef_citadel_of_dusk",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_citadel_of_dusk",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 柯思奎
            {
                faction_key = "wh2_main_hef_cothique",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_cothique",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 伊泰恩
            {
                faction_key = "wh2_main_hef_eataine",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_eataine",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 艾里昂
            {
                faction_key = "wh2_main_hef_ellyrion",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_ellyrion",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 黎明要塞
            {
                faction_key = "wh2_main_hef_fortress_of_dawn",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_fortress_of_dawn",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 高等精灵
            {
                faction_key = "wh2_main_hef_high_elves",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_high_elves",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 纳迦瑞斯
            {
                faction_key = "wh2_main_hef_nagarythe",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_nagarythe",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 魔剑士议会
            {
                faction_key = "wh2_main_hef_order_of_loremasters",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_order_of_loremasters",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 萨芙睿
            {
                faction_key = "wh2_main_hef_saphery",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_saphery",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 泰伦洛克
            {
                faction_key = "wh2_main_hef_tiranoc",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_tiranoc",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 塔尔·艾拉逊
            {
                faction_key = "wh2_main_hef_tor_elasor",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_tor_elasor",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, -- 伊瑞斯
            {
                faction_key = "wh2_main_hef_yvresse",
                unit = "glf_hef_spears_of_dabbarloc_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_spears_of_dabbarloc_ror"
            }, {
                faction_key = "wh2_main_hef_yvresse",
                unit = "glf_hef_sword_of_hoeth_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_hef_sword_of_hoeth_ror"
            }, ---------------------------------------------------------------------------------------------------------------
            -- 黑暗精灵--
            ---------------------------------------------------------------------------------------------------------------
            -- 神佑恶党
            {
                faction_key = "wh2_dlc11_def_the_blessed_dread",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_dlc11_def_the_blessed_dread",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_dlc11_def_the_blessed_dread",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 欢愉教派
            {
                faction_key = "wh2_main_def_cult_of_pleasure",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_main_def_cult_of_pleasure",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_main_def_cult_of_pleasure",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 黑暗精灵
            {
                faction_key = "wh2_main_def_dark_elves",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_main_def_dark_elves",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_main_def_dark_elves",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 海格·格雷夫
            {
                faction_key = "wh2_main_def_hag_graef",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_main_def_hag_graef",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_main_def_hag_graef",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 哈尔·冈西
            {
                faction_key = "wh2_main_def_har_ganeth",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_main_def_har_ganeth",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_main_def_har_ganeth",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 纳迦隆德
            {
                faction_key = "wh2_main_def_naggarond",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_main_def_naggarond",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_main_def_naggarond",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, -- 千噬
            {
                faction_key = "wh2_twa03_def_rakarth",
                unit = "glf_def_rimeshards_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_rimeshards_ror"
            }, {
                faction_key = "wh2_twa03_def_rakarth",
                unit = "glf_def_the_voiceless_ones_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_the_voiceless_ones_ror"
            }, {
                faction_key = "wh2_twa03_def_rakarth",
                unit = "glf_def_dread_knights_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_def_dread_knights_ror"
            }, ---------------------------------------------------------------------------------------------------------------
            -- 古墓王--
            ---------------------------------------------------------------------------------------------------------------
            -- 葬仪教团
            {
                faction_key = "wh2_dlc09_tmb_exiles_of_nehek",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_exiles_of_nehek",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 纳迦什信徒
            {
                faction_key = "wh2_dlc09_tmb_followers_of_nagash",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_followers_of_nagash",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 喀穆里
            {
                faction_key = "wh2_dlc09_tmb_khemri",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_khemri",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 莱巴拉斯
            {
                faction_key = "wh2_dlc09_tmb_lybaras",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_lybaras",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 努玛斯
            {
                faction_key = "wh2_dlc09_tmb_numas",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_numas",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 前哨站
            {
                faction_key = "wh2_dlc09_tmb_the_sentinels",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_the_sentinels",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }, -- 古墓王
            {
                faction_key = "wh2_dlc09_tmb_tomb_kings",
                unit = "glf_tmb_blessed_arrow_of_ptra_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_blessed_arrow_of_ptra_ror"
            }, {
                faction_key = "wh2_dlc09_tmb_tomb_kings",
                unit = "glf_tmb_lion_head_ushabti_ror",
                merc_pool = "renown",
                count = 1,
                rcp = 100,
                munits = 10,
                murpt = 0.1,
                frr = "",
                srr = "",
                trr = "",
                replen = true,
                merc_group = "glf_tmb_lion_head_ushabti_ror"
            }};

        -- Loop for the table above
        for i = 1, #cror_list do
            local faction_name = cror_list[i].faction_key; -- Faction whose pool the unit(s) should be added to
            local faction = cm:get_faction(faction_name); -- FACTION_SCRIPT_INTERFACE
            local unit_key = cror_list[i].unit; -- Key of unit to add to the mercenary pool, from the main_units table
            local pool = cror_list[i].merc_pool; -- NEW found in "ui_mercenary_recruitment_infos_tables" table, or in "mercenary_pools_tables" beneath UI recruitment info 
            local unit_count = cror_list[i].count; -- Number of units to add to the mercenary pool
            local rcp = cror_list[i].rcp; -- Replenishment chance, as a percentage
            local munits = cror_list[i].munits; -- The maximum number of units of the supplied type that the pool is allowed to contain.
            local murpt = cror_list[i].murpt; -- The maximum number of units of the supplied type that may be added by replenishment per-turn
            local frr = cror_list[i].frr; -- (may be empty) The key of the faction who can actually recruit the units, from the factions database table
            local srr = cror_list[i].srr; -- (may be empty) The key of the subculture who can actually recruit the units, from the cultures_subcultures database table
            local trr = cror_list[i].trr; -- (may be empty) The key of a technology that must be researched in order to recruit the units, from the technologies database table
            local replen = cror_list[i].replen; -- Allow replenishment of partial units
            local merc_group_key = cror_list[i].merc_group; -- key used in mercenary_unit_groups_tables can most of the time be the same has main_unit key
            -- Adding the listed unit to the listed faction in the above table
            cm:add_unit_to_faction_mercenary_pool(faction, unit_key, pool, unit_count, rcp, munits, murpt, frr, srr, trr, replen, merc_group_key);

            -- Debug message for log
            out("CROR: adding the custom ror unit " .. unit_key .. " to " .. faction_name);
        end

        -- Setting saved value, so that the script doesn't run again when reloaded from a saved game
        cm:set_saved_value("glf_unit_expansion_ror_enabled", true);
    end
end

cm:add_first_tick_callback(function()
    glf_unit_expansion_ror_adds_custom()
end);
