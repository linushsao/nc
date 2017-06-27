--all-recipe
--ncoin
minetest.register_craft({
	output = 'tc:nc_coin05 1',
	recipe = {
		{'tc:nc_coin','tc:nc_coin','tc:nc_coin'},
		{'tc:nc_coin','tc:nc_coin',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:nc_coin15 1',
	recipe = {
		{'tc:nc_coin05','tc:nc_coin05','tc:nc_coin05'},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:nc_coin30 1',
	recipe = {
		{'tc:nc_coin15','tc:nc_coin15',''},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:nc_coin60 1',
	recipe = {
		{'tc:nc_coin30','tc:nc_coin30',''},
		{'','',''},
		{'','',''},
	}
})

--tcoin
minetest.register_craft({
	output = 'tc:tcoin05 1',
	recipe = {
		{'tc:tcoin','tc:tcoin','tc:tcoin'},
		{'tc:tcoin','tc:tcoin',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:tcoin10 1',
	recipe = {
		{'tc:tcoin05','tc:tcoin05',''},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:tcoin50 1',
	recipe = {
		{'tc:tcoin10','tc:tcoin10','tc:tcoin10'},
		{'tc:tcoin10','tc:tcoin10',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:tcoin100 1',
	recipe = {
		{'tc:tcoin50','tc:tcoin50',''},
		{'','',''},
		{'','',''},
	}
})

--ibu-coin
minetest.register_craft({
	output = 'tc:ibu_coin05 1',
	recipe = {
		{'tc:ibu_coin','tc:ibu_coin','tc:ibu_coin'},
		{'tc:ibu_coin','tc:ibu_coin',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:ibu_coin10 1',
	recipe = {
		{'tc:ibu_coin05','tc:ibu_coin05',''},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:ibu_coin50 1',
	recipe = {
		{'tc:ibu_coin10','tc:ibu_coin10','tc:ibu_coin10'},
		{'tc:ibu_coin10','tc:ibu_coin10',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:ibu_coin100 1',
	recipe = {
		{'tc:ibu_coin50','tc:ibu_coin50',''},
		{'','',''},
		{'','',''},
	}
})

--picachu-coin
minetest.register_craft({
	output = 'tc:picachu_coin05 1',
	recipe = {
		{'tc:picachu_coin','tc:picachu_coin','tc:picachu_coin'},
		{'tc:picachu_coin','tc:picachu_coin',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:picachu_coin10 1',
	recipe = {
		{'tc:picachu_coin05','tc:picachu_coin05',''},
		{'','',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:picachu_coin50 1',
	recipe = {
		{'tc:picachu_coin10','tc:picachu_coin10','tc:picachu_coin10'},
		{'tc:picachu_coin10','tc:picachu_coin10',''},
		{'','',''},
	}
})

minetest.register_craft({
	output = 'tc:picachu_coin100 1',
	recipe = {
		{'tc:picachu_coin50','tc:picachu_coin50',''},
		{'','',''},
		{'','',''},
	}
})
