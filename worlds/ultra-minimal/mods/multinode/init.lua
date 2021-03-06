MN1 = {}
MN2 = {}
MN1CACHE = {}
MN2CACHE = {}
COPY = {}
COPYREF = {}
PASTEREF ={}
REPLACE = {}
WITH = {}

ACTIONNODE = function(nodeid, nodename,onplace,ondig)
	local params = {
		description = nodename,
		tile_images = {"multinode_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("multinode_"..nodeid..".png"),
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	}
	if onplace ~= nil then params.after_place_node = onplace end
	if ondig ~= nil then params.after_dig_node = ondig end
	minetest.register_node("multinode:"..nodeid, params)
end
ACTIONNODE('m1','Multinode Marker 1', function(pos,placer)
	local player = placer:get_player_name()-- or ""
	if player == '' then print('errorm1') end
	if MN1[player] == nil then MN1[player] = {} end
	table.insert(MN1[player], pos)
	minetest.chat_send_player(player, "marker 1 set")
end)
ACTIONNODE('m2','Multinode Marker 2', function(pos,placer)
	local player = placer:get_player_name()-- or ""
	if player == '' then print('errorm2') end
	if MN2[player] == nil then MN2[player] = {} end
	table.insert(MN2[player], pos)
	minetest.chat_send_player(player, "marker 2 set")
end)
ACTIONNODE('pasteref','Paste Reference Marker', function(pos,placer)
	local player = placer:get_player_name()-- or ""
	if player == '' then print('errorm2') end
	PASTEREF[player] = pos
	minetest.chat_send_player(player, "paste reference set")
end)

-- ***********************************************************************************
--		FUNCTIONS							**************************************************
-- ***********************************************************************************
compare = function(p1,p2)
	result = {}
	if p1 > p2 then
		result.high = p1
		result.low = p2
		result.diff = p1 - p2
	elseif p2 > p1 then
		result.high = p2
		result.low = p1
		result.diff = p2 - p1
	else
		result.high = p2
		result.low = p1
		result.diff = 0
	end
	if result.diff < 0 then 
		result.diff = -result.diff
		result.mul = -1
	else result.mul = 1 end
	return result
end

local fixlight = function(p)
    local no = minetest.env:get_node(p)
    no.param1 = 13
    minetest.env:add_node(p, no)
end
local fillnode = function(pos,param)
	if param == '-light' then
		fixlight(pos)
	else
		minetest.env:add_node(pos,{type="node",name=param})
	end
end
local removenode = function(pos,param)
	if param == '-a' then
		minetest.env:remove_node(pos)
	else
		local node = minetest.env:get_node_or_nil(pos)
		if node and node.name == param then minetest.env:remove_node(pos) end	
	end
end
local copynode = function(pos,param)
	local node = minetest.env:get_node_or_nil(pos)
	if node then table.insert(COPY[param],{pos=pos,name=node.name}) end
end
local replacenode = function(pos,param)
		local node = minetest.env:get_node_or_nil(pos)
		if node and node.name == REPLACE[param] then 	minetest.env:add_node(pos,{type="node",name=WITH[param]}) end	
end

local multinode = function(p1,p2,mutation,param)
	local xdif = compare(p1.x,p2.x)
	local ydif = compare(p1.y,p2.y)
	local zdif = compare(p1.z,p2.z)
	if mutation == copynode then COPYREF[param] = p1 end

	if xdif.diff > 0 then
		for q =0,xdif.diff,1 do
			mutation({x=xdif.high-q*xdif.mul,y=ydif.high,z=zdif.high},param)
			if ydif.diff > 0 then
				for m =0,ydif.diff,1 do
					mutation({x=xdif.high-q*xdif.mul,y=ydif.high-m*ydif.mul,z=zdif.high},param)
					if zdif.diff > 0 then
						for i =0,zdif.diff,1 do
							mutation({x=xdif.high-q*xdif.mul,y=ydif.high-m*ydif.mul,z=zdif.high-i*zdif.mul},param)
						end
					end
				end
			elseif zdif.diff > 0 then
				for i =0,zdif.diff,1 do
					mutation({x=xdif.high-q*xdif.mul,y=ydif.high,z=zdif.high-i*zdif.mul},param)
				end
			end

		end
	elseif ydif.diff > 0 then
		for m =0,ydif.diff,1 do
			mutation({x=xdif.high,y=ydif.high-m*ydif.mul,z=zdif.high},param)
			if zdif.diff > 0 then
				for i =0,zdif.diff,1 do
					mutation({x=xdif.high,y=ydif.high-m*ydif.mul,z=zdif.high-i*zdif.mul},param)
				end
			end
		end
	elseif zdif.diff > 0 then
		for i =0,zdif.diff,1 do
			mutation({x=xdif.high,y=ydif.high,z=zdif.high-i*zdif.mul},param)
		end
	else
		return false
	end
end

-- ***********************************************************************************
--		CHATCOMMANDS						**************************************************
-- ***********************************************************************************
minetest.register_chatcommand("reload", {
	params = "<none>",
	description = "restore last multinode list",
	privs = {server=true},
	func = function(name, param)
		MN1[name] = MN1CACHE[name]
		MN2[name] = MN2CACHE[name]
	end,
})
local clearmem = function(name) 
	COPY[name] = {}
	COPYREF[name] = {}
	PASTEREF[name] = {}
	REPLACE[name] = {}
	WITH[name] = {}
	MN1[name] = {}
	MN2[name] = {}
	minetest.chat_send_player(name, "clearmem called")
end
minetest.register_chatcommand("clear", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		clearmem(name)
	end,
})
minetest.register_chatcommand("p1", {
	params = "<X>,<Y>,<Z>",
	description = "first corner",
	privs = {server=true},
	func = function(name, param)
		if MN1[name] == nil then MN1[name] = {} end
		local p = {}
		p.x, p.y, p.z = string.match(param, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then
			table.insert(MN1[name], p)
			minetest.chat_send_player(name, "p1 set")
			return
		else 
			local target = minetest.env:get_player_by_name(name)
			if target then
				table.insert(MN1[name],target:getpos())
				minetest.chat_send_player(name, "p1 set")
				return
			end
		end
	end,
})
minetest.register_chatcommand("p2", {
	params = "<X>,<Y>,<Z>",
	description = "opposite corner",
	privs = {server=true},
	func = function(name, param)
		if MN2[name] == nil then MN2[name] = {} end
		local p = {}
		p.x, p.y, p.z = string.match(param, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then
			table.insert(MN2[name], p)
			minetest.chat_send_player(name, "p2 set")
			return
		else 
			local target = minetest.env:get_player_by_name(name)
			if target then
				table.insert(MN2[name], target:getpos())
				minetest.chat_send_player(name, "p2 set")
				return
			end
		end
	end,
})

minetest.register_chatcommand("fill", {
	params = "<nodename>",
	description = "fill with given node",
	privs = {server=true},
	func = function(name, param)
		if table.getn(MN1[name]) == 0 or table.getn(MN2[name]) == 0 or param == nil then 
		print('failed check 1')
		return end
		MN1CACHE[name] = MN1[name]--LASTFILL1 = FILL1
		MN2CACHE[name] = MN2[name]--LASTFILL2 = FILL2
		MN1[name] = {}
		MN2[name] = {}
		for a = 1,table.getn(MN1CACHE[name]),1 do
			if MN1CACHE[name][a] == nil or MN2CACHE[name][a] == nil then print('failed check 2') return end
			if multinode(MN1CACHE[name][a],MN2CACHE[name][a],fillnode,param) == false then minetest.chat_send_player(name, "there is no fill only zuul") end
		end
	end,
})
minetest.register_chatcommand("remove", {
	params = "<nodename>",
	description = "to remove specific node or use flag '-a'",
	privs = {server=true},
	func = function(name, param)
		if table.getn(MN1[name]) == 0 or table.getn(MN2[name]) == 0 or param == nil then 
		print('failed check 1')
		return end
		MN1CACHE[name] = MN1[name]--LASTFILL1 = FILL1
		MN2CACHE[name] = MN2[name]--LASTFILL2 = FILL2
		MN1[name] = {}
		MN2[name] = {}
		for a = 1,table.getn(MN1CACHE[name]),1 do
			if MN1CACHE[name][a] == nil or MN2CACHE[name][a] == nil then print('failed check 2') return end
			if multinode(MN1CACHE[name][a],MN2CACHE[name][a],removenode,param) == false then minetest.chat_send_player(name, "there is no remove only zuul") end
		end
	end,
})
minetest.register_chatcommand("copy", {
	params = "<none>",
	description = "copy",
	privs = {server=true},
	func = function(name, param)
		if MN1[name] == nil or MN2[name] == nil then  minetest.chat_send_player(name, "a klingon that kills without showing his face, has no honor") return end
		if table.getn(MN1[name]) == 0 or table.getn(MN2[name]) == 0 or param == nil then 
		print('failed check 1')
		return end
		MN1CACHE[name] = MN1[name]
		MN2CACHE[name] = MN2[name]
		MN1[name] = {}
		MN2[name] = {}
		if COPY[name] == nil then COPY[name] = {} end
			if COPYREF[name] == nil then COPYREF[name] = {} end
		for a = 1,table.getn(MN1CACHE[name]),1 do
			if MN1CACHE[name][a] == nil or MN2CACHE[name][a] == nil then print('failed check 2') return end
			if multinode(MN1CACHE[name][a],MN2CACHE[name][a],copynode,name) == false then minetest.chat_send_player(name, "there is no copy only zuul") end
		end
	end,
})
minetest.register_chatcommand("paste", {
	params = "<none>",
	description = "paste",
	privs = {server=true},
	func = function(name, param)
		if PASTEREF[name] then
			newpos = PASTEREF[name]		
		else
			local target = minetest.env:get_player_by_name(name)
			if target then 
				newpos = target:getpos()
			end
		end

		difx = COPYREF[name].x - newpos.x
		dify = COPYREF[name].y - newpos.y
		difz = COPYREF[name].z - newpos.z

		for a = 1,table.getn(COPY[name]),1 do
			if param ~= '+90' and param ~= '-90' and param ~= '+180' then
				pastepos = {x=COPY[name][a].pos.x-difx,y=COPY[name][a].pos.y-dify,z=COPY[name][a].pos.z-difz}
			else
				local x = COPY[name][a].pos.x -COPYREF[name].x
				local y = COPY[name][a].pos.y
				local z = COPY[name][a].pos.z -COPYREF[name].z
				local newx,newz = nil
				if param == '+90' then 
					newx = z
					newz = -(x)
				elseif param == '-90' then 
					newx = -(z)
					newz = x
				elseif param == '+180' then 
					newx = -(x)
					newz = -(z)
				else
					return
				end
				x = newx + COPYREF[name].x
				z = newz + COPYREF[name].z
				pastepos = {x=x-difx,y=y-dify,z=z-difz}
			end
			minetest.env:add_node(pastepos,{type="node",name=COPY[name][a].name})
		end
		PASTEREF[name] = nil
	end,
})
minetest.register_chatcommand("replace", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		REPLACE[name] = param
	end,
})
minetest.register_chatcommand("with", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		WITH[name] = param
	end,
})
minetest.register_chatcommand("doit", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		if table.getn(MN1[name]) == 0 or table.getn(MN2[name]) == 0 then 
		print('failed check 1')
		return end
		MN1CACHE[name] = MN1[name]
		MN2CACHE[name] = MN2[name]
		MN1[name] = {}
		MN2[name] = {}
		for a = 1,table.getn(MN1CACHE[name]),1 do
			if MN1CACHE[name][a] == nil or MN2CACHE[name][a] == nil then print('failed check 2') return end
			if multinode(MN1CACHE[name][a],MN2CACHE[name][a],replacenode,name) == false then minetest.chat_send_player(name, "there is no replace only zuul") end
		end
	REPLACE[name] = nil
	WITH[name] = nil
	end,
})
minetest.register_chatcommand("saveas", {
	params = "<bldname>",
	description = "paste",
	privs = {server=true},
	func = function(name, param)
		if COPY[name] == nil then  minetest.chat_send_player(name, "a klingon that kills without showing his face, has no honor") return end

		local output = ''						--	WRITE CHANGES TO FILE
		local f = io.open(minetest.get_modpath('multinode')..'/buildings/'..param..'.bld', "w")
		if f == nil then  minetest.chat_send_player(name, "a klingon that kills without showing his face, has no honor") return end
		for a = 1,table.getn(COPY[name]),1 do
			local x = COPY[name][a].pos.x -COPYREF[name].x
			local y = COPY[name][a].pos.y -COPYREF[name].y
			local z = COPY[name][a].pos.z -COPYREF[name].z
			output = output..COPY[name][a].name..'~'..x..','..y..','..z..';'
		end
    f:write(output)
    io.close(f)
    clearmem(name)
	minetest.chat_send_player(name, param.." saved")

	end,
})
minetest.register_chatcommand("load", {
	params = "<bldname>",
	description = "paste",
	privs = {server=true},
	func = function(name, param)
	local bldfile = io.open(minetest.get_modpath('multinode')..'/buildings/'..param..'.bld', "r")  
		if bldfile then
			COPY[name] = {}
			COPYREF[name] = {x=0,y=0,z=0}
			local contents = bldfile:read()
			io.close(bldfile)
			if contents ~= nil then 
				local entries = contents:split(";") 
				for i,entry in pairs(entries) do
					local nodename, coords = unpack(entry:split("~"))
					local p = {}
					p.x, p.y, p.z = string.match(coords, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
					if p.x and p.y and p.z then
						table.insert(COPY[name],{name = nodename, pos = {x = tonumber(p.x),y= tonumber(p.y),z = tonumber(p.z)}})
					end
				end
			end
		end
	end,
})

	-------------------------------------------------------
--------------		SPHERES & etc					---------------------------
		---------------------------------------------------------------
	  -----------------------------------------------------------
	-------------------------------------------------------
--------------		shape functions					---------------------------
		---------------------------------------------------------------

local SPHERE_SIZE = 12
local POINT_ZERO = nil
local HOLLOW_THICKNESS = 1

local function sphere(pos,nodename)
     pos.x = math.floor(pos.x+0.5)
     pos.y = math.floor(pos.y+0.5)
     pos.z = math.floor(pos.z+0.5)

     for x=-SPHERE_SIZE,SPHERE_SIZE do
     for y=-SPHERE_SIZE,SPHERE_SIZE do
     for z=-SPHERE_SIZE,SPHERE_SIZE do
         if x*x+y*y+z*z <= SPHERE_SIZE * SPHERE_SIZE + SPHERE_SIZE then
				minetest.env:add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z},{type="node",name=nodename})
         end
     end
     end
     end
end
local function hsphere(pos,nodename,hollow)
     pos.x = math.floor(pos.x+0.5)
     pos.y = math.floor(pos.y+0.5)
     pos.z = math.floor(pos.z+0.5)

     for x=-SPHERE_SIZE,SPHERE_SIZE do
     for y=-SPHERE_SIZE,SPHERE_SIZE do
     for z=-SPHERE_SIZE,SPHERE_SIZE do
			if x*x+y*y+z*z >= (SPHERE_SIZE-hollow) * (SPHERE_SIZE-hollow) + (SPHERE_SIZE-hollow) and x*x+y*y+z*z <= SPHERE_SIZE * SPHERE_SIZE + SPHERE_SIZE then
				minetest.env:add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z},{type="node",name=nodename})
         end
     end
     end
     end
end
--[[
local function roundframe(pos,nodename,hollow)
     pos.x = math.floor(pos.x+0.5)
     pos.y = math.floor(pos.y+0.5)
     pos.z = math.floor(pos.z+0.5)

     for x=-SPHERE_SIZE,SPHERE_SIZE do
     for y=-SPHERE_SIZE,SPHERE_SIZE do
     for z=-SPHERE_SIZE,SPHERE_SIZE do
			if x*x+y*y+z*z >= (SPHERE_SIZE-hollow) * (SPHERE_SIZE-hollow) + (SPHERE_SIZE-hollow) and x*x+y*y+z*z <= SPHERE_SIZE * SPHERE_SIZE + SPHERE_SIZE then
				minetest.env:add_node({x=pos.x+x,y=(pos.y+y)*4,z=pos.z+z},{type="node",name=nodename})
--				count = count + 1
--				print(math.floor(((count/operations)*100)+0.5)..'% complete')
         end
     end
     end
     end
end
]]--
local function hsaucer(pos,nodename,hollow)
     pos.x = math.floor(pos.x+0.5)
     pos.y = math.floor(pos.y+0.5)
     pos.z = math.floor(pos.z+0.5)

     for x=-SPHERE_SIZE,SPHERE_SIZE do
     for y=-(SPHERE_SIZE*4),(SPHERE_SIZE*4) do
     for z=-SPHERE_SIZE,SPHERE_SIZE do
			if x*x+(y*y)*4+z*z >= (SPHERE_SIZE-hollow) * (SPHERE_SIZE-hollow) + (SPHERE_SIZE-hollow) and x*x+(y*y)*4+z*z <= SPHERE_SIZE * SPHERE_SIZE + SPHERE_SIZE then
				minetest.env:add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z},{type="node",name=nodename})
         end
     end
     end
     end
end
local hspheremap = function(pos,thickness,sphere_size)
	local hpshere_map = {}
		if not thickness then thickness = 1 end
		if not sphere_size then sphere_size = SPHERE_SIZE end
     pos.x = math.floor(pos.x+0.5)
     pos.y = math.floor(pos.y+0.5)
     pos.z = math.floor(pos.z+0.5)
     for y=-sphere_size,sphere_size do
     for z=-sphere_size,sphere_size do
     for x=-sphere_size,sphere_size do
--		fix thickness

			if x*x+y*y+z*z >= (sphere_size-thickness) * (sphere_size-thickness) + (sphere_size-thickness) and x*x+y*y+z*z <= sphere_size * sphere_size + sphere_size then
				table.insert(hpshere_map,{x=pos.x+x,y=pos.y+y,z=pos.z+z})
         end
     end
     end
     end
     return hpshere_map
end
local hspherespawn = function(nodename,hsphere_map)
	for a = 1,table.getn(hsphere_map),1 do
		minetest.env:add_node(hsphere_map[a],{type="node",name=nodename})
		if a == table.getn(hsphere_map) then return true end
	end
end

	-------------------------------------------------------
--------------		chat commands					---------------------------
		---------------------------------------------------------------

minetest.register_chatcommand("p0", {
	params = "<none>",
	description = "spawn a sphere",
	privs = {server=true},
	func = function(name, param)
		POINT_ZERO = minetest.env:get_player_by_name(name):getpos()
		minetest.chat_send_player(name, "p0 set")
	end,		})
minetest.register_chatcommand("radius", {
	params = "<radius>",
	description = "set radius of sphere, default 12",
	privs = {server=true},
	func = function(name, param)
		SPHERE_SIZE = param
		minetest.chat_send_player(name, "radius set")
	end,		})
minetest.register_chatcommand("thickness", {
	params = "<hollow sphere thickness>",
	description = "set thickness of hollow spheres, default 1",
	privs = {server=true},
	func = function(name, param)
		HOLLOW_THICKNESS = param
		minetest.chat_send_player(name, "thickness set")
	end,		})
minetest.register_chatcommand("sphere", {
	params = "<nodename>",
	description = "spawn a sphere",
	privs = {server=true},
	func = function(name, param)
		if POINT_ZERO == nil then minetest.chat_send_player(name, "there is no p0 only zuul") return end
		minetest.chat_send_player(name, "spawning...larger spheres = more time, may need to retry if partial spawn")
		sphere(POINT_ZERO, param)
	end,		})
minetest.register_chatcommand("hollowsphere", {
	params = "<nodename>",
	description = "spawn a hollow sphere",
	privs = {server=true},
	func = function(name, param)
		if POINT_ZERO == nil then minetest.chat_send_player(name, "there is no p0 only zuul") return end
		minetest.chat_send_player(name, "spawning...larger spheres = more time, may need to retry if partial spawn")
		hsphere(POINT_ZERO, param, HOLLOW_THICKNESS)
	end,		})
minetest.register_chatcommand("hsaucer", {
	params = "<nodename>",
	description = "spawn a hollow sphere",
	privs = {server=true},
	func = function(name, param)
		if POINT_ZERO == nil then minetest.chat_send_player(name, "there is no p0 only zuul") return end
		minetest.chat_send_player(name, "spawning...larger spheres = more time, may need to retry if partial spawn")
		hsaucer(POINT_ZERO, param, HOLLOW_THICKNESS)
	end,		})
minetest.register_chatcommand("hsmap", {
	params = "<nodename>",
	description = "map a hollow sphere",
	privs = {server=true},
	func = function(name, param)
		if POINT_ZERO == nil then minetest.chat_send_player(name, "there is no p0 only zuul") return end
		minetest.chat_send_player(name, "mapping...")
		local map = hspheremap(POINT_ZERO, HOLLOW_THICKNESS)
		minetest.chat_send_player(name, "done. rendering...")
		while hspherespawn(param,map) ~= true do
		minetest.chat_send_player(name, "rendering...")
		end
		minetest.chat_send_player(name, "supposed to be finished")
	end,		})
minetest.register_chatcommand("hsnode", {
	params = "<none>",
	description = "spawn a sphere",
	privs = {server=true},
	func = function(name, param)
		local pos = minetest.env:get_player_by_name(name):getpos()
		minetest.env:add_node(pos,{type="node",name="multinode:hsmap"})

	end,		})
	
	-------------------------------------------------------
--------------		node sphere gen					---------------------------
		---------------------------------------------------------------
--[[
local function has_linkingbook_privilege(meta, player)
	if meta:get_string("owner") == '' then
		meta:set_string("owner", player:get_player_name())
	elseif meta:get_string("owner") ~= player:get_player_name() then
		return false
	end
	return true
end
]]--

minetest.register_node("multinode:hsmap", {
	description = "sphere gen",
	tile_images = {"default_mese.png"},
	inventory_image = "default_mese.png",
	wield_image = "default_mese.png",
	paramtype = "light",
	groups = {choppy=2,dig_immediate=2},
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local player = puncher:get_player_name()-- or ""
		local meta = minetest.env:get_meta(pos)
		local stringpos = meta:get_string("location")
		local p = {}
		p.x, p.y, p.z = string.match(stringpos, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then

			telepomultinodee = minetest.env:get_player_by_name(player)
			linkingbook_sound(pos)
			telepomultinodee:setpos(p)
			linkingbook_sound(p)
		end
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[5,4;]"..
			"field[0.256,0.5;5,1;radius;Radius:;]"..
			"field[0.256,1.5;5,1;thickness;Thickness:;]"..
			"field[0.256,2.5;5,1;nodename;mod:modename:;]"..
			"button_exit[3.3,3.5;2,1;button;Set]")
--		meta:set_string("infotext", "Linking Book")
--		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

--		if not has_linkingbook_privilege(meta, sender) then
--			minetest.chat_send_player(sender_name, "You cannot edit other people's books")
--		return end

		meta:set_string("radius", fields.radius)
		meta:set_string("thickness", fields.thickness)
		meta:set_string("nodename", fields.nodename)
	end,	
	
--	after_place_node = function(pos, placer)
--		local meta = minetest.env:get_meta(pos)
--		meta:set_string("owner", placer:get_player_name() or "")
--	end,
	
--	can_dig = function(pos,player)
--		meta = minetest.env:get_meta(pos)
--		return has_linkingbook_privilege(meta, player)
--	end,
	
})
minetest.register_abm({
	nodenames = {"multinode:hsmap"},
--	neighbors = {"group:igniter"},
	interval = 180,
	chance = 1,
	action = function(pos, node, _, _)
		local meta = minetest.env:get_meta(pos)
		local radius = tonumber(meta:get_string("radius"))
		local thickness = tonumber(meta:get_string("thickness"))
		local nodename = meta:get_string("nodename")
		
		if not radius or not thickness or not nodename then return end
		local map = hspheremap(pos, thickness, radius)
		hspherespawn(nodename,map)
	end,
})
--[[
	-------------------------------------------------------
--------------		water levelling					---------------------------
		---------------------------------------------------------------

minetest.register_abm({
	nodenames = {"multinode:pump"},
	interval = 20,
	chance = 1,
	action = function(pos, node, _, _)
		local nodes = {{x=pos.x,y=pos.y+1,z=pos.z}, {x=pos.x+1,y=pos.y,z=pos.z}, {x=pos.x-1,y=pos.y,z=pos.z}, {x=pos.x,y=pos.y,z=pos.z+1}, {x=pos.x,y=pos.y,z=pos.z+1}}

		for i,po in pairs(nodes) do
			local node = minetest.env:get_node(po)
			if node.name == 'riventest:water_source' or node.name == 'riventest:water_flowing' or node.name == 'default:water_source' or node.name == 'default:water_flowing' then
				minetest.env:add_node(po,{type="node",name='multinode:pump'})
			end
		
		end

	end,
})

minetest.register_abm({
	nodenames = {"multinode:pump"},
	interval = 45,
	chance = 1,
	action = function(pos, node, _, _)
		local nodes = {{x=pos.x,y=pos.y+1,z=pos.z}, {x=pos.x+1,y=pos.y,z=pos.z}, {x=pos.x-1,y=pos.y,z=pos.z}, {x=pos.x,y=pos.y,z=pos.z+1}, {x=pos.x,y=pos.y,z=pos.z+1}}
		local found_something = false
		for i,po in pairs(nodes) do
			local node = minetest.env:get_node(po)
			if node.name == 'riventest:water_source' or node.name == 'riventest:water_flowing' or node.name == 'default:water_source' or node.name == 'default:water_flowing' then
				found_something = true end
		end
		if found_something == false then minetest.env:remove_node(pos) end
	end,
})
minetest.register_node("multinode:pump", {
	description = "pump",

	tile_images = {"default_cobble.png"},
	inventory_image = "default_cobble.png",
	wield_image = "default_cobble.png",
	paramtype = "light",
	groups = {choppy=2,dig_immediate=2},
	sounds = default.node_sound_defaults(),
})]]--
