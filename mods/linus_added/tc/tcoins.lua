--tcoins by linushsao@gmail.com
--License: WTFPL

minetest.register_craftitem("tc:tcoin", {
	description = "TCoin",
	inventory_image = "tc_tcoin.png",
    stack_max = 30000,
})
minetest.register_craftitem("tc:ibu_coin", {
	description = "EBuCoin",
	inventory_image = "tc_ibu.png",
    stack_max = 30000,
})
minetest.register_craftitem("tc:picachu_coin", {
	description = "PICACHUcoin",
	inventory_image = "tc_picachu.png",
    stack_max = 30000,
})

-- about nettime
function add_nccoin(node, desc, inv_image, amount)

	minetest.register_craftitem(node, {
    description = desc,
    inventory_image = inv_image,
    stack_max = 30000,

    on_use = function(itemstack, user, pointed_thing)

   	local file_path = "/home/linus/script/nc_"
   	local cmd_path = "/home/linus/script/nat-add-nc.sh"
  	local nettime = ""
   	local add_name = ""
    local name = user:get_player_name()
    local add_time = amount
    
		print("NAME: "..name)
		
  		if name == "rose" then
			add_name = "ROSE"
			elseif name == "austin" then
			add_name = "AUSTIN"
			elseif name == "linus" then
			add_name = "LINUS"
			print("DONE")
		end

		os.execute(cmd_path.." "..add_name.." "..add_time)
		-- Takes one item from the stack
		itemstack:take_item()
		return itemstack

	end,
	})

end

add_nccoin("tc:nc_coin","ADD 1 minutes","nc_coin.png",1) --node, desc, inv_image, amount
add_nccoin("tc:nc_coin05","ADD 5 minutes","nc_coin05.png",5)
add_nccoin("tc:nc_coin15","ADD 15 minutes","nc_coin15.png",15)
add_nccoin("tc:nc_coin30","ADD 30 minutes","nc_coin30.png",30)
add_nccoin("tc:nc_coin60","ADD 60 minutes","nc_coin60.png",60)

-- ALL COMMANDs
minetest.register_chatcommand("net", {

	params = "Usage:net {on/off/save}. on:start counting,off:stop counting,save:save time to NCoin",
	description = "setup,show nettime status or save time to coins",
	privs = {},

	func = function(name, param)
	
    local player = minetest.get_player_by_name(name)
   	local file_path = "/home/linus/script/switch_"
   	local nc_path = "/home/linus/script/nc_"
   	local script_path = "/home/linus/script/"
   	local net_flag = ""
   	local switch_path = ""
   	local add_name = ""
	local nettime = ""
	local check_time = os.date("%x %H:%M")
	local inv=player:get_inventory()
	
	--print("NAME: "..name)
	
	if name == "rose" then
		switch_path = file_path.."ROSE"
		add_name = "ROSE"
		elseif name == "austin" then
		switch_path = file_path.."AUSTIN"
		add_name = "AUSTIN"
		elseif name == "linus" then
		switch_path = file_path.."LINUS"
		add_name = "LINUS"
		print("DONE")
	end
	
	--print("SWITCH_PATH :"..switch_path)

 	local input = io.open(nc_path..add_name, "r")
	if input ~= nil then 
		nettime = input:read("*all")
		io.close(input)
 	end
	
	--compare the param
	if param == nil or param == "" then
		local input = io.open(switch_path, "r")
			if input == nil then net_flag = "OFF"
				else net_flag = "ON"
				io.close(input)
			end

		minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : "..net_flag)
    	minetest.chat_send_player(name, "CURRENT NETTIME AMOUNT : "..nettime)
		minetest.chat_send_player(name, "Usage:net {on/off/save}. on:start counting,off:stop counting,save:save time to NCoin")
		return
		elseif param == "on" then
			os.execute("touch "..switch_path)	
			os.execute("touch "..script_path.."minetest-launch")	
			os.execute("sudo "..script_path.."run-nat-filter.sh")	
			os.execute("rm "..script_path.."minetest-launch")	
			minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : ON")
			os.execute("echo "..check_time.." "..add_name.." SWITCH ON. >> /home/linus/log/switch.log")
			return
		elseif param == "off" then
			os.execute("rm "..switch_path)	
			minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : OFF")
			os.execute("echo "..check_time.." "..add_name.." SWITCH OFF. >> /home/linus/log/switch.log")
		elseif param == "save" then
			--count the current NC
			local input = io.open(nc_path..add_name, "r")
			if input ~= nil then 
			nettime = input:read("*all")
			io.close(input)
			inv:add_item("main","tc:nc_coin "..nettime)
			os.execute("echo 0 >"..nc_path..add_name)
			minetest.chat_send_player(name, "COLLECT NC_COIN AMOUNT : "..nettime)
			os.execute("echo "..check_time.." "..add_name.." SAVE "..nettime.." NCoin. >> /home/linus/log/switch.log")
			end

			
		else
			minetest.chat_send_player(name, "WRONG PARAM,Usage:net {on/off/save}. on:start counting,off:stop counting,save:save time to NCoin")
	end
	
 end,
})

minetest.register_chatcommand("spawn", {

	params = "Usage:bring player to spawn(player hall)",
	description = "spawn to player hall",
	privs = {},

	func = function(name, param)
    local caller = minetest.get_player_by_name(name)
    caller:setpos({x=475, y=7, z=-270}) 
    minetest.chat_send_player(name, "Spawn to player hall")
	   end
})

--recipe
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
