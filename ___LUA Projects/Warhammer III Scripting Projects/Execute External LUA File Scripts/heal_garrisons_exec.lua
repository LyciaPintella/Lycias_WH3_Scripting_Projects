local out = function(t)
	ModLog("Instantly Heal Garrisons Worldwide With Button Press: " .. tostring(t) .. ".")
end
local function heal_garrisons_worldwide()
	out("Let's heal some garrisons!")
	local region_list = cm:model():world():region_manager():region_list()
	for r = 0, region_list:num_items() - 1 do
		out("Healing garrison at region " .. tostring(region_list:item_at(r):name()) .. "")
		cm:callback(function()
			cm:heal_garrison(region_list:item_at(r):cqi())
		end, 0.1)
	end
end
heal_garrisons_worldwide()