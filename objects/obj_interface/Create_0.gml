/// -- @desc Initialise UI
// Globals
global.compiled_view = false;

vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();

global.vformat = vertex_format_end();
global.model_cache = ds_map_create();
	
// Chunk data
layer_selected = 0;
z_selected = 15;

chunk = ds_map_create();
chunk[? "0,0"] = new Chunk(0, 0);
chunk_selected = new vec2(0, 0);
chunk_mesh = ds_map_create();

tile_selected = 0;
tile_previous = new vec2(-1, -1);
tile_hovered = undefined;

refresh_map = false;

// Config
gpu_set_ztestenable(true);
gpu_set_tex_repeat(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

// Placable tile type index
tile_list = ds_list_create();
ds_list_add(tile_list, {
	name: "Grass",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_grass,
	type: "grass"
})

// Grass paths
ds_list_add(tile_list, {
	name: "Grass Path",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path,
	type: "grass_path",
	direction: "center"
})
ds_list_add(tile_list, {
	name: "Grass Path ↖",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_nw,
	type: "grass_path",
	direction: "northwest"
})
ds_list_add(tile_list, {
	name: "Grass Path ↑",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_n,
	type: "grass_path",
	direction: "north"
})
ds_list_add(tile_list, {
	name: "Grass Path ↗",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_ne,
	type: "grass_path",
	direction: "northeast"
})
ds_list_add(tile_list, {
	name: "Grass Path →",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_e,
	type: "grass_path",
	direction: "east"
})
ds_list_add(tile_list, {
	name: "Grass Path ↘",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_se,
	type: "grass_path",
	direction: "southeast"
})
ds_list_add(tile_list, {
	name: "Grass Path ↓",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_s,
	type: "grass_path",
	direction: "south"
})
ds_list_add(tile_list, {
	name: "Grass Path ↙",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_sw,
	type: "grass_path",
	direction: "southwest"
})
ds_list_add(tile_list, {
	name: "Grass Path ←",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_w,
	type: "grass_path",
	direction: "west"
})
ds_list_add(tile_list, {
	name: "Grass Path ↗ (In)",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_c_ne,
	type: "grass_path",
	direction: "northeast_in"
})
ds_list_add(tile_list, {
	name: "Grass Path ↘ (In)",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_c_se,
	type: "grass_path",
	direction: "southeast_in"
})
ds_list_add(tile_list, {
	name: "Grass Path ↙ (In)",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_c_sw,
	type: "grass_path",
	direction: "southwest_in"
})
ds_list_add(tile_list, {
	name: "Grass Path ↖ (In)",
	model: "plane",
	size: new vec2(1, 1),
	tex: tx_path_c_nw,
	type: "grass_path",
	direction: "northwest_in"
})

ds_list_add(tile_list, {
	name: "Pine Tree",
	model: "tree_pine",
	size: new vec2(2, 2),
	tex: tx_tree_pine,
	type: "tree"
})

var tile_len = ds_list_size(tile_list);
for ( var i = 0; i < tile_len; i ++ )
{
	tile_list[| i].index = i;	
}