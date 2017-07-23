--bitcoins by MilesDyson@DistroGeeks.com
--Modified by Krock
--License: WTFPL

-- Node definitions

local crystal_table = {'caverealms:glow_amethyst', 'caverealms:glow_ruby'
					   ,'caverealms:glow_crystal','caverealms:glow_emerald'}

minetest.register_craftitem("tc:crystal_coin", {
	description = "Crystal Coin from Caverealm",
	inventory_image = "crystal_coin.png",
    stack_max = 30000,
})

for _,v in pairs(crystal_table) do
	
	minetest.register_craft({
		output = 'tc:crystal_coin',
		recipe = {
			{v,v,v},
			{'', '',''},
			{'', '',''},
		}
	})
	
end
