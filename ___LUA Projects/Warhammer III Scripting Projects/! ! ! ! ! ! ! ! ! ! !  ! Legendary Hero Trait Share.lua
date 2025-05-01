local legendary_hero_list = {
     ["Prince Ograx"] = true,
     ["Kormak"] = true,
     ["Samuel Ludenhof"] = true,
     ["Henri le Massif"] = true,
     ["Gorduz Backstabber"] = true,
     ["Tom Phillipson"] = true,
     ["Hans Valhirsson"] = true,
     ["Dramar Hammerfist"] = true,
     ["Throni Ironbrow"] = true,
     ["King Lunn Ironhammer"] = true,
     ["Halkenhaf StoneBeard"] = true,
     ["Cavill"] = true,
     ["Lord Kroak"] = true,
     ["Oracle of the Sacred Plaques"] = true,
     ["Kihar the Tormentor"] = true,
     ["Killgore Slaymaim"] = true,
     ["Ghoritch"] = true,
     ["Hertwig Van Hal"] = true,
     ["Rodrik L'Anguille"] = true,
     ["Kalara"] = true,
     ["Jorek Grimm"] = true,
     ["Robert Barthelemy"] = true,
     ["Kevin von Lloydstein"] = true,
     ["Ariel"] = true,
     ["Coeddil"] = true,
     ["Ulrika Magdova"] = true,
     ["Harald Hammerstorm"] = true,
     ["Aekold Helbrass"] = true,
     ["The Blue Scribes"] = true,
     ["The Golden Knight Naryska Leysa"] = true,
     ["Saytang the Watcher"] = true,
     ["Garagrim Ironfist"] = true,
     ["Theodore Bruckner"] = true,
     ["Kayzk the Befouled"] = true,
     ["Khargan the Crazed"] = true,
     ["Ketzak Fimdirach"] = true,
     ["Mournhowl"] = true,
     ["Grukmur Three-Horn"] = true,
     ["Ezar Doombolt"] = true,
     ["Ilja of Murova"] = true, -- I started here
     ["Gerik"] = true,
     ["Naryaska Leysa"] = true,
     ["Anastasa Vilkova"] = true,
     ["Prince Commander"] = true,
     ["Prince Ivan Radinov"] = true,
     ["Chef Grogu"] = true,
     ["Lhunara"] = true,
     ["Arleth Vann"] = true,
     ["Hauclir"] = true,
     ["Whisper from Below"] = true,
     ["Udjo the Guardian"] = true,
     ["Simon the Knight Ranger"] = true,
     ["Alexander Joseph"] = true,
     ["Lord of the forest"] = true,
     ["Chenghuang, Colossus of Nan-Gau"] = true,
     ["Hor, the Hawkeye Avanger"] = true,
     ["Grena the Prophetess"] = true,
     ["Galrauch"] = true,
     ["Kerrinath"] = true,
     ["Twilight Kukulkan"] = true,
     ["Crouch the Eternal Watcher"] = true,
     ["Feanor the Silver Hand"] = true,
     ["Bi Fang"] = true,
     ["Tchzen"] = true,
     ["Bolragoth"] = true,
     ["Sslivox"] = true,
     ["Bifang"] = true,
     ["‘Silver Claw’ Chizhi"] = true,
     ["Karavox"] = true,
     ["‘Fester’ Bolagos"] = true,
     ["‘Magic Python’ Svox"] = true,
     ["Nukucca"] = true,

}

local function find_legendary_heroes(character, legendary_heroes)
     local proper_name = common.get_localised_string(character:get_forename());
     local proper_surname = common.get_localised_string(character:get_surname());
     local full_name = (proper_name ~= "" and proper_surname ~= "") and proper_name .. " " .. proper_surname or
     proper_name .. proper_surname;
     local subtype = character:character_subtype_key();
     local legendary_hero_mod = false;

     -- check to see if hero is from compatible hero mod
     if string.sub(subtype, 1, 4) == "qoo_" then
          legendary_hero_mod = true;
     end

     -- add hero to legendary hero list if in list or mod is compatible
     if legendary_hero_list[full_name] or legendary_hero_mod then
          table.insert(legendary_heroes, character);
     end
end

local function get_legendary_heroes_in_last_battle(character)
     local pb = cm:model():pending_battle();
     local legendary_heroes = {};
     local player_found = false;

     local num_attackers = cm:pending_battle_cache_num_attackers();
     local num_defenders = cm:pending_battle_cache_num_defenders();

     if pb:night_battle() == true or pb:ambush_battle() == true then
          num_attackers = 1;
          num_defenders = 1;
     end

     for i = 1, num_attackers do
          if player_found then
               break;
          end

          local char_cqi, attacker_force_cqi = cm:pending_battle_cache_get_attacker(i);

          if char_cqi == character:cqi() then
               player_found = true;

               local attacker_force = cm:get_military_force_by_cqi(attacker_force_cqi);
               for _, character in model_pairs(attacker_force:character_list()) do
                    find_legendary_heroes(character, legendary_heroes);
               end
          end
     end

     if player_found == false then
          for i = 1, num_defenders do
               if player_found then
                    break;
               end

               local char_cqi, defender_force_cqi = cm:pending_battle_cache_get_defender(i);

               if char_cqi == character:cqi() then
                    player_found = true;

                    local defender_force = cm:get_military_force_by_cqi(defender_force_cqi);
                    for _, character in model_pairs(defender_force:character_list()) do
                         find_legendary_heroes(character, legendary_heroes);
                    end
               end
          end
     end

     return legendary_heroes;
end

local function legendary_hero_traits()
     core:add_listener(
          "qoo_legendary_hero_battle_listener",
          "CharacterCompletedBattle",
          true,
          function(context)
               local character = context:character();

               if cm:char_is_general_with_army(character) and character:won_battle() then
                    local LL_enemies = campaign_traits:get_enemy_legendary_lords_in_last_battle(character);

                    if #LL_enemies > 0 then
                         local legendary_heroes = get_legendary_heroes_in_last_battle(character);

                         if #legendary_heroes > 0 then
                              for i = 1, #LL_enemies do
                                   local LL_trait = campaign_traits.legendary_lord_defeated_traits[LL_enemies[i]];

                                   if LL_trait ~= nil then
                                        for q = 1, #legendary_heroes do
                                             campaign_traits:give_trait(legendary_heroes[q], LL_trait);
                                        end
                                   end
                              end
                         end
                    end
               end
          end,
          true
     );
end

cm:add_first_tick_callback(
     function()
          legendary_hero_traits()
     end
);
