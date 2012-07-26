--		** dye

minetest.register_craft({	type = "cooking",	output = "madblocks:dye_black",	recipe = "default:coal_lump", })
minetest.register_craft({	output = 'node "madblocks:dye_blue" 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_black',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:dye_green" 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_blue',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:dye_yellow" 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_green',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:dye_red" 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_yellow',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:dye_black" 3',	recipe = {		-- back to black when stuck w/ dif colors
		{'','madblocks:dye_red',''},
		{'','madblocks:dye_yellow',''},
		{'','madblocks:dye_blue',''},
	}})

--		** bricks

minetest.register_craft({	output = 'node "madblocks:greenbrick" 1',	recipe = {
		{'','node "madblocks:dye_green"',''},
		{'','node "brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:blackbrick" 1',	recipe = {
		{'','node "madblocks:dye_black"',''},
		{'','node "brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:bluebrick" 1',	recipe = {
		{'','node "madblocks:dye_blue"',''},
		{'','node "brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:yellowbrick" 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','node "brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:brownbrick" 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','node "brick"',''},
		{'','madblocks:dye_black',''},
	}})

minetest.register_craft({	output = 'node "madblocks:oddbrick" 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','node "brick"',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'node "madblocks:asphalte" 1',	recipe = {
		{'','',''},
		{'','craft "lump_of_coal"',''},
		{'','node "cobble"',''},
	}})
minetest.register_craft({	output = 'node "madblocks:mossystonebrick" 1',	recipe = {
		{'','node "default:leaves"',''},
		{'','node "default:cobble"',''},
		{'','node "madblocks:dye_yellow"',''},
	}})
minetest.register_craft({	output = 'node "madblocks:culturedstone" 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','node "default:cobble"',''},
		{'','node "madblocks:dye_red"',''},
	}})
minetest.register_craft({	output = 'node "madblocks:marblestonebrick" 1',	recipe = {
		{'','node "madblocks:dye_green"',''},
		{'','node "default:cobble"',''},
		{'','node "madblocks:dye_black"',''},
	}})
minetest.register_craft({	output = 'node "madblocks:shinystonebrick" 1',	recipe = {
		{'','node "default:sand"',''},
		{'','node "default:cobble"',''},
		{'','node "madblocks:dye_red"',''},
	}})
minetest.register_craft({	output = 'node "madblocks:roundstonebrick" 5',	recipe = {
	{'','default:cobble',''},
	{'default:cobble','madblocks:cement','default:cobble'},
	{'','default:cobble',''},
}})
minetest.register_craft({	output = 'node "madblocks:slimstonebrick" 3',	recipe = {
		{'','default:cobble',''},
		{'','madblocks:cement',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'node "madblocks:greystonebrick" 2',	recipe = {
		{'','madblocks:dye_black',''},
		{'','default:cobble',''},
		{'','madblocks:cement',''},
	}})
minetest.register_craft({	output = 'node "madblocks:medistonebrick" 3',	recipe = {
		{'','',''},
		{'madblocks:dye_blue','','madblocks:dye_yellow'},
		{'default:cobble','madblocks:cement','default:cobble'},
	}})
minetest.register_craft({	output = 'node "madblocks:whitestonebrick" 3',	recipe = {
		{'','default:clay',''},
		{'','default:cobble',''},
		{'','madblocks:cement',''},
	}})
minetest.register_craft({	output = 'node "madblocks:countrystonebrick" 2',	recipe = {
		{'','',''},
		{'','madblocks:cement',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'node "madblocks:blackstonebrick" 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_black',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'node "madblocks:cement" 2',	recipe = {
		{'','',''},
		{'','default:sand',''},
		{'','default:gravel',''},
	}})
minetest.register_craft({	output = 'node "madblocks:cinderblock" 9',	recipe = {
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:cobble','default:cobble'},
	}})
minetest.register_craft({	output = 'node "madblocks:cinderblock_planter" 2',	recipe = {
		{'','',''},
		{'','default:dirt',''},
		{'','madblocks:cinderblock',''},
	}})

--		** woods

minetest.register_craft({	output = 'node "madblocks:woodshingles" 8',	recipe = {
		{'node "default:wood"','node "default:wood"'},
		{'node "default:wood"','node "default:wood"'},
	}})

minetest.register_craft({	output = 'node "madblocks:bluewood" 1',	recipe = {
		{'','node "madblocks:dye_blue"',''},
		{'','node "default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:blackwood" 1',	recipe = {
		{'','node "madblocks:dye_black"',''},
		{'','node "default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:yellowwood" 1',	recipe = {
		{'','node "madblocks:dye_yellow"',''},
		{'','node "default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:greenwood" 1',	recipe = {
		{'','node "madblocks:dye_green"',''},
		{'','node "default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:redwood" 1',	recipe = {
		{'','node "madblocks:dye_red"',''},
		{'','node "default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:redwood_fence" 1',	recipe = {
		{'','node "madblocks:dye_red"',''},
		{'','node "default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:blackwood_fence" 1',	recipe = {
		{'','node "madblocks:dye_black"',''},
		{'','node "default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:greenwood_fence" 1',	recipe = {
		{'','node "madblocks:dye_green"',''},
		{'','node "default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:yellowwood_fence" 1',	recipe = {
		{'','node "madblocks:dye_yellow"',''},
		{'','node "default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:bluewood_fence" 1',	recipe = {
		{'','node "madblocks:dye_blue"',''},
		{'','node "default:fence_wood"',''},
		{'','',''},
	}})


--		** lights
minetest.register_craft({	output = 'node "madblocks:glowyellow" 1',	recipe = {
		{'','torch',''},
		{'','glass',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'node "madblocks:glowgreen" 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_green',''},
}})
minetest.register_craft({	output = 'node "madblocks:glowred" 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_red',''},
}})
minetest.register_craft({	output = 'node "madblocks:glowblue" 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_blue',''},
}})
minetest.register_craft({	output = 'node "madblocks:spotlight" 1',	recipe = {
	{'','',''},
	{'','madblocks:glowyellow',''},
	{'','madblocks:sheetmetal',''},
}})
minetest.register_craft({	output = 'node "madblocks:searchlight" 1',	recipe = {
	{'','madblocks:spotlight',''},
	{'madblocks:spotlight','madblocks:sheetmetal','madblocks:spotlight'},
	{'','madblocks:spotlight',''},
}})
minetest.register_craft({	output = 'node "madblocks:fancylamp" 1',	recipe = {
	{'','madblocks:dye_black',''},
	{'','madblocks:sheetmetal',''},
	{'','madblocks:glowyellow',''},
}})
minetest.register_craft({	output = 'madblocks:lampling 1',	recipe = {
	{'','madblocks:glowyellow',''},
	{'','default:stick',''},
	{'','default:stick',''},
}})

--		** sound nodes

minetest.register_craft({	output = 'node "madblocks:bigben" 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','madblocks:sheetmetal',''},
		{'','default:wood',''},
	}})
minetest.register_craft({	output = 'node "madblocks:siren" 1',	recipe = {
		{'','',''},
		{'madblocks:sheetmetal','madblocks:dye_red','madblocks:sheetmetal'},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:churchbells" 1',	recipe = {
		{'','',''},
		{'','madblocks:sheetmetal',''},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
--		** decorative

minetest.register_craft({	output = 'node "madblocks:hangingflowers" 1',	recipe = {
		{'','',''},
		{'default:stick','madblocks:rosebush','default:stick'},
		{'','default:stick',''},
	}})
minetest.register_craft({	output = 'node "madblocks:gnome" 1',	recipe = {
		{'default:clay_lump','madblocks:dye_red','default:clay_lump'},
		{'','default:clay_lump','madblocks:dye_green'},
		{'default:clay_lump','','default:clay_lump'},
	}})
minetest.register_craft({	output = 'node "madblocks:statue" 1',	recipe = {
		{'','default:clay_lump',''},
		{'','default:clay_lump',''},
		{'','default:clay_lump',''},
	}})
minetest.register_craft({	output = 'node "madblocks:gargoyle" 1',	recipe = {
		{'','',''},
		{'default:clay_lump','madblocks:dye_black','default:clay_lump'},
		{'','default:clay_lump',''},
	}})
minetest.register_craft({	output = 'node "madblocks:awning" 2',	recipe = {
		{'','',''},
		{'','','default:junglegrass'},
		{'','default:junglegrass','madblocks:dye_red'},
	}})

minetest.register_craft({	output = 'node "madblocks:stool" 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','madblocks:sheetmetal',''},
		{'default:stick','','default:stick'},
	}})

--[[				fix me
minetest.register_craft({	output = 'node "madblocks:flowers2" 2',	recipe = {
		{'','',''},
		{'madblocks:hydroponics_yellowflower','madblocks:hydroponics_magentaflower',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:flowers1" 2',	recipe = {
		{'','',''},
		{'madblocks:hydroponics_magentaflower','madblocks:hydroponics_cyanflower',''},
		{'','',''},
	}})
]]--

--		** signs

minetest.register_craft({	output = 'madblocks:signs_cafe 1',	recipe = {
		{'','madblocks:coffeecup',''},
		{'','default:sign_wall',''},
		{'','default:torch',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_drpepper 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_enjoycoke 1',	recipe = {
		{'','madblocks:sheetmetal',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_hucksfoodfuel 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_dangermines 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_black',''},
	}})

--		** metallic & misc. items

minetest.register_craft({	output = 'madblocks:sheetmetal 4',	recipe = {
		{'default:steel_ingot'},
	}})
minetest.register_craft({	output = 'node "madblocks:pylon" 5',	recipe = {
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
		{'','madblocks:sheetmetal',''},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'node "madblocks:safetyladder" 7',	recipe = {
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
		{'madblocks:sheetmetal','madblocks:sheetmetal','madblocks:sheetmetal'},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'node "madblocks:fancybracket" 4',	recipe = {
		{'','','madblocks:sheetmetal'},
		{'','','madblocks:sheetmetal'},
		{'','madblocks:sheetmetal','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'madblocks:street 1',	recipe = {
		{'','',''},
		{'','',''},
		{'default:mese','default:mese','default:mese'},
	}})

