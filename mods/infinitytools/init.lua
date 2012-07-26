--[[
	InfinityTools
	Author: Vortexlabs (mrtux)
	Licencing info:
		Code: GPLv3
		Graphics: WTFPL
]]--

-- Register nodes and tools

-- Infinity Block (used to make tools)
minetest.register_node("infinitytools:infinityblock", {
	description = "Infinity Block",
	tile_images = {"infinityblock.png"},
	is_ground_content = true,
	groups = {snappy=1,choppy=2,cracky=2},
})

-- Pickaxe
minetest.register_tool("infinitytools:pickaxe", {
	description = "Infinity Pickaxe",
	inventory_image = "infinity_pick.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})

-- Shovel
minetest.register_tool("infinitytools:shovel", {
	description = "Infinity Shovel",
	inventory_image = "infinity_shovel.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})

-- Axe
minetest.register_tool("infinitytools:axe", {
	description = "Infinity Axe",
	inventory_image = "infinity_axe.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})

-- Sword
minetest.register_tool("infinitytools:sword", {
	description = "Infinity Sword",
	inventory_image = "infinity_sword.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
})


-- Register crafting recipies

-- Infinity Block
minetest.register_craft({
	output = 'infinitytools:infinityblock',
	recipe = {
		{'default:mese', 'default:steel_ingot', ''},
	}
})
-- Infinity Pickaxe
minetest.register_craft({
	output = 'infinitytools:pickaxe',
	recipe = {
		{'infinitytools:infinityblock', 'infinitytools:infinityblock', 'infinitytools:infinityblock'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

-- Infinity Shovel
minetest.register_craft({
	output = 'infinitytools:shovel',
	recipe = {
		{'', 'infinitytools:infinityblock', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

-- Infinity Axe
minetest.register_craft({
	output = 'infinitytools:axe',
	recipe = {
		{'infinitytools:infinityblock', 'infinitytools:infinityblock', ''},
		{'infinitytools:infinityblock', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

-- Infinity Sword
minetest.register_craft({
	output = 'infinitytools:sword',
	recipe = {
		{'', 'infinitytools:infinityblock', ''},
		{'', 'infinitytools:infinityblock', ''},
		{'', 'default:stick', ''},
	}
})


-- Mod loaded message
print("[InfinityTools] Mod loaded!")
