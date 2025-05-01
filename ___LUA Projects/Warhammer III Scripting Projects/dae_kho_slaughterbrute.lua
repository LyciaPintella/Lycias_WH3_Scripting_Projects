-- Set Nurgle merc units to less than full health


---list of all nurgle units and associated bonus value
local nurgle_units_to_starting_health_bonus_values = {
     dae_vor_nur == "recruit_hp_1dae_vor_nur"
};

local base_start_hp = 0.4
local generic_start_hp_bonus_value = "recruit_hp_all_units"

core:add_listener(
     "daemon_princes_NurgleUnitHealth",
     "UnitTrained",
     function(context)
          return context:unit():faction():subculture() == "wh3_main_sc_nur_nurgle";
     end,
     function(context)
          local unit = context:unit()
          if nurgle_units_to_starting_health_bonus_values[unit:unit_key()] then
               local force = unit:military_force()
               local global_bonus = get_force_bonus_value(force, generic_start_hp_bonus_value) / 100
               local unit_bonus = get_force_bonus_value(force,
                    nurgle_units_to_starting_health_bonus_values[unit:unit_key()]) / 100
               cm:set_unit_hp_to_unary_of_maximum(unit, math.clamp(base_start_hp + global_bonus + unit_bonus, 0.01, 1));
          end
     end,
     true
);
