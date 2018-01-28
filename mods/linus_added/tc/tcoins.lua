--tcoins by linushsao@gmail.com
--License: WTFPL
--austin 11.3535 
--rose 0.99

local user_table = {
	["linus"]={["name"]="LINUS",["ratio"]=1,["tclog"]={},["nclog"]={},["switchlog"]={}},
	["rose"]={["name"]="ROSE",["ratio"]=0.99,["tclog"]={},["nclog"]={},["switchlog"]={}},
	["austin"]={["name"]="AUSTIN",["ratio"]=11.35,["tclog"]={},["nclog"]={},["switchlog"]={}},
	["yfan"]={["name"]="YFAN",["ratio"]=1,["tclog"]={},["nclog"]={},["switchlog"]={}},
	}
local all_path = {
	["log"]="/home/linus/log/",
	["tmp"]="/home/linus/tmp/",
	["script"]="/home/linus/script/",
	["tc"] = "/home/linus/log/tc_",
	["nc"] = "/home/linus/log/nc_",
	}
local all_point = {
	["spawn"]= {x=475, y=7, z=-270},
	}

local tmp_table = {},tmp_msg


--read all param ,seprated by " "
function read_params(p)
    local sep = "%s"
    local t = {};i = 1
    
		for str in string.gmatch(p, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
    end
    
	return t
	
end

function get_name(playname)

	if playname == nil then return " " end

		for i, v in pairs(user_table) do 
			if i == playname then return v.name end 
		end

end

function get_ratio(playname)

	if playname == nil then return " " end
	
		for i, v in pairs(user_table) do 
			if i == playname then return v.ratio end 
		end
	
end

function bank_check(bank_path,mode)

	--count the current TC of reciver
	--bank_path = all_path["tc"]..get_name(name)
	
	local all_result
	local input = io.open(bank_path, "r")
	
		if input ~= nil then 
			all_result = input:read("*all")
			io.close(input)
			else 
			os.execute("echo 0 > "..bank_path)
			all_result = 0
		end

	return tonumber(all_result)
	
end


--save ncworld_config
function save_ncworld_log(data_table,kind,name)

	if (data_table == nil) then return end

		for i, v in pairs(data_table) do 

			if kind == "nc" and v ~= nil then
					os.execute("echo "..v.." >> "..all_path.log.."ncc.log")
					os.execute("echo "..v.." >> "..all_path.log.."ncc-"..get_name(name)..".log")
					print("NCLOG")
			elseif kind == "tc" and v ~= nil then
					os.execute("echo "..v.." >> "..all_path.log.."tc.log")
					os.execute("echo "..v.." >> "..all_path.log.."tc-"..get_name(name)..".log")
					print("TCLOG")
			elseif kind == "switch" and v~= nil then
					os.execute("echo "..v.." >> "..all_path.log.."switch.log")
					os.execute("echo "..v.." >> "..all_path.log.."switch-"..get_name(name)..".log")
					print("SWITCHLOG")
			end
	
		
		end
	
	minetest.log("action","ncworld_config saved.")
	
end

-- about tcoin
function add_tcoin(node, desc, inv_image, amount)

	minetest.register_craftitem(node, {
    description = desc,
    inventory_image = inv_image,
    stack_max = 30000,

    on_use = function(itemstack, user, pointed_thing)

		local cmd_path = all_path.script.."nat-add-tc.sh"
		local name = user:get_player_name()
		local add_time = amount
		local check_time = os.date("%x %H:%M")
		local bank_path = all_path["tc"]..get_name(name)

		os.execute(cmd_path.." "..get_name(name).." "..add_time)

		tmp_msg = check_time.." "..get_name(name).." save "..add_time.." tc in bank ,and has totally : "..bank_check(all_path.tc..get_name(name)).." tc in bank "
		table.insert(user_table[name].tclog,tmp_msg)
		print(dump(user_table[name].tclog))

		-- Takes one item from the stack
		itemstack:take_item()
		return itemstack

	end,
	})

end

-- about nettime
function add_nccoin(node, desc, inv_image, amount)

	minetest.register_craftitem(node, {
    description = desc,
    inventory_image = inv_image,
    stack_max = 30000,

    on_use = function(itemstack, user, pointed_thing)

   	local cmd_path = all_path.script.."nat-add-nc.sh"
  	local nettime = ""
    local name = user:get_player_name()
    local add_time = amount
 	local check_time = os.date("%x %H:%M")
 	local nc_mark_file_path = "/home/linus/log/"
	local input = io.open(nc_mark_file_path.."mark_"..string.upper(name), "r")

		if (os.date("%w") == "6" or os.date("%w") == "0") or input ~= nil then 
			os.execute(cmd_path.." "..get_name(name).." "..add_time)
			print("GG:"..cmd_path.." "..get_name(name).." "..add_time)
			tmp_msg = check_time.." "..get_name(name).." save "..add_time.." nc in bank ,and has totally : "..bank_check(all_path.nc..get_name(name)).." nc in bank "
			table.insert(user_table[name].nclog,tmp_msg)
			print(dump(user_table[name].nclog))
			-- Takes one item from the stack
			itemstack:take_item()
			return itemstack
		else
			minetest.chat_send_player(name, "NCoin could be used Only at Saturday or Sunday or discussing with dear ma or dad")
		end

	end,
	})

end

--nc
add_nccoin("tc:nc_coin","ADD 1 minutes","nc_coin.png",1) --node, desc, inv_image, amount
add_nccoin("tc:nc_coin05","ADD 5 minutes","nc_coin05.png",5)
add_nccoin("tc:nc_coin15","ADD 15 minutes","nc_coin15.png",15)
add_nccoin("tc:nc_coin30","ADD 30 minutes","nc_coin30.png",30)
add_nccoin("tc:nc_coin60","ADD 60 minutes","nc_coin60.png",60)

--tc
add_tcoin("tc:tcoin","COINs of TC","tc_tcoin.png",1) --node, desc, inv_image, amount
add_tcoin("tc:tcoin05","5 COINs of TC","tc_tcoin05.png",5) 
add_tcoin("tc:tcoin10","10 COINs of TC","tc_tcoin10.png",10) 
add_tcoin("tc:tcoin50","50 COINs of TC","tc_tcoin50.png",50) 
add_tcoin("tc:tcoin100","100 COINs of TC","tc_tcoin100.png",100) 

--tc of ROSE
add_tcoin("tc:ibu_coin","COINs of ROSE","tc_ibu.png",get_ratio("rose")) --node, desc, inv_image, amount
add_tcoin("tc:ibu_coin05","5 COINs of ROSE","tc_ibu05.png",get_ratio("rose")*5)
add_tcoin("tc:ibu_coin10","10 COINs of ROSE","tc_ibu10.png",get_ratio("rose")*10)
add_tcoin("tc:ibu_coin50","50 COINs of ROSE","tc_ibu50.png",get_ratio("rose")*50)
add_tcoin("tc:ibu_coin100","100 COINs of ROSE","tc_ibu100.png",get_ratio("rose")*100)
--tc of AUSTIN
add_tcoin("tc:picachu_coin","COINs of AUSTIN","tc_picachu.png",get_ratio("austin")) 
add_tcoin("tc:picachu_coin05","5 COINs of AUSTIN","tc_picachu05.png",get_ratio("austin")*5) 
add_tcoin("tc:picachu_coin10","10 COINs of AUSTIN","tc_picachu10.png",get_ratio("austin")*10) 
add_tcoin("tc:picachu_coin50","50 COINs of AUSTIN","tc_picachu50.png",get_ratio("austin")*50) 
add_tcoin("tc:picachu_coin100","100 COINs of AUSTIN","tc_picachu100.png",get_ratio("austin")*100) 

-- ALL COMMANDs
minetest.register_chatcommand("net", {

	params = "Usage:net {on/off/save/auto-off <MINUTEs>/auto-on <MINUTEs>}. on:start counting,off:stop counting,save:save time to NCoin, auto-off:auto switch off after MINUTEs, auto-on:auto switch on after MINUTEs",
	description = "setup,show nettime status or save time to coins",
	privs = {},

	func = function(name, param)
	
    local player = minetest.get_player_by_name(name)
   	local file_path = all_path.log.."switch_"
   	local switch_path,add_name,net_flag,nettime
	local check_time = os.date("%x %H:%M")
	local inv=player:get_inventory()
	local usage_desc = "Usage:net {on/off/save/list/auto-off <MINUTEs>/auto-on <MINUTEs>}. on:start counting,off:stop counting,save:save time to NCoin, list:show nc records, auto-off:auto switch off after MINUTEs, auto-on:auto switch on after MINUTEs"

    tmp_table = read_params(param)
    
    local p1 = tmp_table[1]
    local p2 = tmp_table[2]
	
	switch_path = file_path..get_name(name)
	add_name = get_name(name)
	
 	local input = io.open(all_path["nc"]..add_name, "r")
	if input ~= nil then 
		nettime = input:read("*all")
		io.close(input)
		else nettime = "0"
 	end
	
	--compare the param
	if p1 == nil or p1 == "" then
		local input = io.open(switch_path, "r")
			if input == nil then net_flag = "OFF"
				else net_flag = "ON"
				io.close(input)
			end
			minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : "..net_flag)
			minetest.chat_send_player(name, "CURRENT NETTIME AMOUNT : "..nettime)
			minetest.chat_send_player(name, usage_desc)
		return
		
		elseif p1 == "on" then
			os.execute("touch "..switch_path)	
			os.execute("touch "..all_path.log.."minetest-launch")	
			os.execute("sudo  "..all_path.script.."run-nat-filter.sh")	
			os.execute("rm    "..all_path.log.."minetest-launch")	
			minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : ON")
			tmp_msg = check_time.." "..add_name.." SWITCH ON"
			table.insert(user_table[name].switchlog,tmp_msg)
			os.execute("echo "..tmp_msg.." >> "..all_path.log.."switch.log")	
			return
			
		elseif p1 == "off" then
			os.execute("rm "..switch_path)	
			minetest.chat_send_player(name, "CURRENT NETTIME SWITCH : OFF")
			tmp_msg = check_time.." "..add_name.." SWITCH OFF"
			table.insert(user_table[name].switchlog,tmp_msg)
			os.execute("echo "..tmp_msg.." >> "..all_path.log.."switch.log")	
			
		elseif p1 == "auto-off" and p2 ~= nil and tonumber(p2) > 0 then
			os.execute("echo rm "..switch_path.." > "..all_path.tmp.."tmp"..name..".sh")	
			os.execute("at now +"..math.floor(p2).."minutes -f "..all_path.tmp.."tmp"..name..".sh" )	
			tmp_msg = check_time.." auto-off after "..math.floor(p2).." minutes"
			table.insert(user_table[name].switchlog,tmp_msg)
			minetest.chat_send_player(name, "Hi, PLAYER "..name.." ,NETTIME SWITCH WILL AUTO-OFF after "..p2.." minutes")
			os.execute("echo "..tmp_msg.." >> "..all_path.log.."switch.log")	
			
		elseif p1 == "auto-on" and p2 ~= nil and tonumber(p2) > 0 then
			os.execute("echo touch "..switch_path.." > "..all_path.tmp.."tmp"..name..".sh")	
			os.execute("at now +"..math.floor(p2).."minutes -f "..all_path.tmp.."tmp"..name..".sh" )	
			tmp_msg = check_time.." auto-on after "..math.floor(p2).." minutes"
			table.insert(user_table[name].switchlog,tmp_msg)
			minetest.chat_send_player(name, "Hi, PLAYER "..name.." ,NETTIME SWITCH WILL AUTO-ON after "..p2.." minutes")
			os.execute("echo "..tmp_msg.." >> "..all_path.log.."switch.log")	

		elseif p1 == "save" then
			--count the current NC
			local input = io.open(all_path["nc"]..add_name, "r")
			if input ~= nil then 
				nettime = tonumber(input:read("*all"))
				io.close(input)
				inv:add_item("main","tc:nc_coin "..nettime)
				os.execute("echo 0 >"..all_path["nc"]..add_name)
				minetest.chat_send_player(name, "COLLECT NC_COIN AMOUNT : "..nettime)
				tmp_msg = check_time.." "..get_name(name).." save all "..nettime.." NCoins in hand ,and 0 in bank"
				table.insert(user_table[name].nclog,tmp_msg)
				print(dump(user_table[name].nclog))
			end

		elseif p1 == "list" then

				save_ncworld_log(user_table[name].nclog,"nc",name)
				user_table[name].nclog = {}

				local input = io.open(all_path.log.."ncc-"..get_name(name)..".log", "rb")
				if input ~= nil then 
					user_table[name].nclog = {}
					minetest.chat_send_player(name, "=====NC RECORDS of "..name.."=====")
					for line in io.lines(all_path.log.."ncc-"..get_name(name)..".log") do 
						minetest.chat_send_player(name, line)
					end
					minetest.chat_send_player(name, "=====END of RECORDS")
					input:close()
					else
					minetest.chat_send_player(name, "=====HAVE NO RECORDS of "..name.."=====")
				end

		elseif p1 == "list-switch" then

				save_ncworld_log(user_table[name].switchlog,"switch")
				user_table[name].switchlog = {}

				local input = io.open(all_path.log.."switch-"..get_name(name)..".log", "rb")
				if input ~= nil then 
					user_table[name].switchlog = {}
					minetest.chat_send_player(name, "=====SWITCH RECORDS of "..name.."=====")
					for line in io.lines(all_path.log.."switch-"..get_name(name)..".log") do 
						minetest.chat_send_player(name, line)
					end
					minetest.chat_send_player(name, "=====END of RECORDS")
					input:close()
					else
					minetest.chat_send_player(name, "=====HAVE NO RECORDS of "..name.."=====")
				end
		

			
		else
			minetest.chat_send_player(name, "WRONG PARAM : "..param.." , "..usage_desc)
	end
	
 end,
})

minetest.register_chatcommand("tc", {

	params = "Usage:/tc {save/list/<NAME> <AMOUNT>}. save:collect tc to TCOINs, list:show your records of account, <NAME><AMOUNT>:give NAME AMOUNT tcoins from bank",
	description = "setup,show tcoins status or save time to coins",
	privs = {},

	func = function(name, param)
	
    local player = minetest.get_player_by_name(name)
   	local check_flag = "FALSE"
   	local add_name = ""
	local nettime
	local check_time = os.date("%x %H:%M")
	local inv=player:get_inventory()
	local tc_from,tc_to,tc_record_table={}
	local usage_desc = "Usage:/tc {save/list/<NAME> <AMOUNT>}. save:collect tc in bank to TCOINs, list:show your records of account, <NAME><AMOUNT>:give NAME AMOUNT tcoins from bank"
	
    tmp_table = read_params(param)
    
    local p1 = tmp_table[1]
    local p2 = tmp_table[2]
	
	--compare the param
	if p1 == nil or p1 == "" then

		local input = io.open(all_path["tc"]..get_name(name), "r")
			if input ~= nil then 
				nettime = input:read("*all")
				io.close(input)
				else nettime = "0"
			end
 
			minetest.chat_send_player(name, "CURRENT TCoin AMOUNT of "..name.." in bank: "..nettime)
			minetest.chat_send_player(name, "EXCHANGE RATIO of "..name.." is: "..get_ratio(name))
			minetest.chat_send_player(name, usage_desc)

		return
		
		elseif p1 == "save" then
			--count the current TC
			local input = io.open(all_path["tc"]..get_name(name), "r")
			
			if input ~= nil then 
				nettime = input:read("*all")
				io.close(input)
				local abs_v = math.floor(tonumber(nettime))
				local after_count = (nettime*10-abs_v*10)/10
				inv:add_item("main","tc:tcoin "..abs_v) --transfer tc from bank to TCOIN in hand.
				os.execute("echo "..(tonumber(nettime)-abs_v).." >"..all_path["tc"]..get_name(name)) --TCOIN in bank
				minetest.chat_send_player(name, "TCOIN in bank : "..after_count)
				tmp_msg = check_time.." "..get_name(name).." save "..abs_v.." TCoins in hand and has totally : "..after_count.." tc in bank"
				table.insert(user_table[name].tclog,tmp_msg)
			end
			
		elseif p1 == "list" then

				save_ncworld_log(user_table[name].tclog,"tc",name)
				user_table[name].tclog = {}
				
				local input = io.open(all_path.log.."tc-"..get_name(name)..".log", "rb")
				if input ~= nil then 
					user_table[name].tclog = {}
					minetest.chat_send_player(name, "=====TC ACCOUNT RECORDS of "..name.."=====")
					for line in io.lines(all_path.log.."tc-"..get_name(name)..".log") do 
						minetest.chat_send_player(name, line)
					end
					minetest.chat_send_player(name, "=====END of RECORDS")
					input:close()
					else
					minetest.chat_send_player(name, "=====HAVE NO RECORDS of "..name.."=====")
				end
		
		else
		
			for i, v in pairs(user_table) do --give tc to players,first check if player exist
				if i == p1 then check_flag = "TRUE" end --find playername matched.
			end

			if check_flag == "TRUE" and tonumber(p2) ~= nil then --p2 should be numberic
			
				--count the current TC of giver
				local input = io.open(all_path["tc"]..get_name(name), "r")
				if input ~= nil then 
					tc_from = input:read("*all")
					io.close(input)
					else 
					os.execute("echo 0 > "..all_path["tc"]..get_name(name))
					tc_from = 0
				end

				--count the current TC of reciver
				local input = io.open(all_path["tc"]..get_name(p1), "r")
				if input ~= nil then 
					tc_to = input:read("*all")
					io.close(input)
					else 
					os.execute("echo 0 > "..all_path["tc"]..get_name(p1))
					tc_to = 0
				end

				if tonumber(p2) > tonumber(tc_from) then 
				minetest.chat_send_player(name, "You dont have enought tc.")
				minetest.chat_send_player(name, "PLAYER "..name.." has totally "..tc_from.." tc in bank. ")
				return 
				end

				local after_give = tonumber(tc_from) - tonumber(p2)

				minetest.chat_send_player(name, "PLAYER "..name.." give "..p2.." tc to "..p1)
				minetest.chat_send_player(name, "PLAYER "..name.." has totally "..after_give.." tc in bank. ")
				os.execute("echo "..after_give.." >"..all_path["tc"]..get_name(name))
				os.execute("echo "..(tonumber(tc_to)+tonumber(p2)).." >"..all_path["tc"]..get_name(p1))
				tmp_msg = check_time.." "..get_name(name).." give "..p2.." tc to "..p1.." and has totally "..after_give.." tc in bank. "
				table.insert(user_table[name].tclog,tmp_msg)

			else
				minetest.chat_send_player(name, "WRONG PARAM : "..param.." , "..usage_desc)
				minetest.chat_send_player(name, usage_desc)
				
			end
		end
	
 end,
})


minetest.register_chatcommand("spawn", {

	params = "Usage:bring player to spawn(ORIGIONAL)",
	description = "spawn to ORIGIONAL",
	privs = {},

	func = function(name, param)
    local caller = minetest.get_player_by_name(name)
    caller:setpos({x=all_point.spawn.x, y=all_point.spawn.y, z=all_point.spawn.z}) 
    minetest.chat_send_player(name, "Spawn to ORIGIONAL")
	end
})

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

minetest.register_on_shutdown(function()
	for i,v in ipairs(user_table) do
		save_ncworld_log(user_table[i].tclog,"tc",i)
		save_ncworld_log(user_table[i].nclog,"nc",i)
		save_ncworld_log(user_table[i].switchlog,"switch",i)
	end
	
end)
