
sel = 0;
prev = new vec2(-1, -1);
hovered = undefined;

// Tile type indexes
list = ds_list_create();
ds_list_add(list, {
	name: "Grass",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_grass,
	type: "grass"
})

#region Grass paths
	ds_list_add(list, {
		name: "Grass Path",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path,
		type: "grass_path",
		direction: "center"
	})
	ds_list_add(list, {
		name: "Grass Path ↖",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_nw,
		type: "grass_path",
		direction: "northwest"
	})
	ds_list_add(list, {
		name: "Grass Path ↑",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_n,
		type: "grass_path",
		direction: "north"
	})
	ds_list_add(list, {
		name: "Grass Path ↗",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_ne,
		type: "grass_path",
		direction: "northeast"
	})
	ds_list_add(list, {
		name: "Grass Path →",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_e,
		type: "grass_path",
		direction: "east"
	})
	ds_list_add(list, {
		name: "Grass Path ↘",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_se,
		type: "grass_path",
		direction: "southeast"
	})
	ds_list_add(list, {
		name: "Grass Path ↓",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_s,
		type: "grass_path",
		direction: "south"
	})
	ds_list_add(list, {
		name: "Grass Path ↙",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_sw,
		type: "grass_path",
		direction: "southwest"
	})
	ds_list_add(list, {
		name: "Grass Path ←",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_w,
		type: "grass_path",
		direction: "west"
	})
	ds_list_add(list, {
		name: "Grass Path ↗ (In)",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_c_ne,
		type: "grass_path",
		direction: "northeast_in"
	})
	ds_list_add(list, {
		name: "Grass Path ↘ (In)",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_c_se,
		type: "grass_path",
		direction: "southeast_in"
	})
	ds_list_add(list, {
		name: "Grass Path ↙ (In)",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_c_sw,
		type: "grass_path",
		direction: "southwest_in"
	})
	ds_list_add(list, {
		name: "Grass Path ↖ (In)",
		model: "plane",
		size: new vec2(1, 1),
		tex: tx_path_c_nw,
		type: "grass_path",
		direction: "northwest_in"
	})
#endregion

// Trees
ds_list_add(list, {
	name: "Pine Tree",
	model: "tree",
	size: new vec2(2, 2),
	tex: tx_tree_pine,
	type: "tree",
	height: 64
})
ds_list_add(list, {
	name: "Oak Tree",
	model: "tree",
	size: new vec2(2, 2),
	tex: tx_tree_oak,
	type: "tree",
	height: 64
})

// Tall Grass
ds_list_add(list, {
	name: "Tall Grass",
	model: "tall_grass_light",
	size: new vec2(1, 1),
	tex: tx_tall_grass,
	type: "tree"
})
ds_list_add(list, {
	name: "Tall Grass (Dark)",
	model: "tall_grass_dark",
	size: new vec2(1, 1),
	tex: tx_tall_grass_dark,
	type: "tree"
})

#region Cliff Small
	ds_list_add(list, {
		name: "Cliff ↑",
		model: "cliff",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff ←",
		model: "cliff",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff ↓",
		model: "cliff",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff →",
		model: "cliff",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff"
	})

	// Outer corners
	ds_list_add(list, {
		name: "Cliff ↖",
		model: "cliff_corner",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff ↙",
		model: "cliff_corner",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff ↘",
		model: "cliff_corner",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff ↗",
		model: "cliff_corner",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff"
	})

	// Inner corners
	ds_list_add(list, {
		name: "Cliff Inner ↖",
		model: "cliff_corner_in",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff Inner ↙",
		model: "cliff_corner_in",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff Inner ↘",
		model: "cliff_corner_in",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff"
	})
	ds_list_add(list, {
		name: "Cliff Inner ↗",
		model: "cliff_corner_in",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff"
	})
#endregion

#region Cliff Tall
	ds_list_add(list, {
		name: "Cliff Tall ↑",
		model: "cliff_tall",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall ←",
		model: "cliff_tall",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall ↓",
		model: "cliff_tall",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall →",
		model: "cliff_tall",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})

	// Outer corners
	ds_list_add(list, {
		name: "Cliff Tall ↖",
		model: "cliff_tall_corner",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall ↙",
		model: "cliff_tall_corner",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall ↘",
		model: "cliff_tall_corner",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall ↗",
		model: "cliff_tall_corner",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})

	// Inner corners
	ds_list_add(list, {
		name: "Cliff Tall Inner ↖",
		model: "cliff_tall_corner_in",
		size: new vec2(1, 1),
		rotation: 0,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall Inner ↙",
		model: "cliff_tall_corner_in",
		size: new vec2(1, 1),
		rotation: 90,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall Inner ↘",
		model: "cliff_tall_corner_in",
		size: new vec2(1, 1),
		rotation: 180,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
	ds_list_add(list, {
		name: "Cliff Tall Inner ↗",
		model: "cliff_tall_corner_in",
		size: new vec2(1, 1),
		rotation: 270,
		tex: tx_cliff,
		type: "cliff",
		height: 96
	})
#endregion

ds_list_add(list, {
	name: "Rock",
	model: "rock",
	size: new vec2(1, 1),
	tex: tx_rock,
	type: "rock"
})

// Add indexes to tile info
var tile_len = ds_list_size(list);
for ( var i = 0; i < tile_len; i ++ )
{
	list[| i].index = i;	
}

// Generate tile icons
tile_icons = array_create(tile_len, undefined);
var icon_surf = surface_create(32, 32);
surface_set_target(icon_surf);
	
gpu_set_fog(true, $332420, 16, 128);

for ( var i = 0; i < tile_len; i ++ )
{
	draw_clear_alpha(c_black, 0);
	var	sw = list[| i].size.x * 16,
			sh = list[| i].size.y * 16;
	
	var from_z = list[| i][$ "height"];
	from_z ??= 20;
	
	var proj_mat = matrix_build_projection_ortho(-sw, sh, 1, 16000);
	var view_mat = matrix_build_lookat(sw / 2, sh / 2, from_z, sw / 2, sh / 2, 0, 0, 1, 0);
	camera_set_view_mat(0, view_mat);
	camera_set_proj_mat(0, proj_mat);
		
	camera_apply(0);
		
	var tile_current = tile_compile(list[| i]);
	vertex_submit(tile_current, pr_trianglelist, sprite_get_texture(tx_grass, 0));
	
	tile_icons[i] = sprite_create_from_surface(icon_surf, 0, 0, 32, 32, false, false, 0, 0);
	vertex_delete_buffer(tile_current);
}

surface_reset_target();
surface_free(icon_surf);
gpu_set_fog(false, c_black, 0, 0);