/// -- @desc UI control

var click = mouse_check_button_pressed(mb_left), hold = mouse_check_button(mb_left);

// Toggle orthographic view
if keyboard_check_pressed(vk_space)
{
	global.compiled_view = !global.compiled_view;
	
	if global.compiled_view
		window_mouse_set(308, 360);
}

// Place Tile
var	mx = window_mouse_get_x(),
		my = window_mouse_get_x();

if !global.compiled_view && point_in_rectangle(mx, my, 0, 0, viewport_w, 720)
{
	var	mgrid_x = floor(mouse_x / 16) mod 32,
			mgrid_y = floor(mouse_y / 16) mod 32;
	
	while mgrid_x < 0 mgrid_x += 32;
	while mgrid_y < 0 mgrid_y += 32;
	
	var	chunkgrid_x = floor(mouse_x / 512), 
			chunkgrid_y = floor(mouse_y / 512);
	
	if mouse_check_button_pressed(mb_right) || !mouse_check_button(mb_left) || click 
		tile_previous = undefined;
	
	var place_valid = true;
	if tile_previous != undefined
	{
		var	pre_space_x = abs(mgrid_x - tile_previous.x),
				pre_space_y = abs(mgrid_y - tile_previous.y);
		
		// Test if new placement intersects with previous tile
		var place_valid = pre_space_x >= obj_tiles.list[| obj_tiles.sel].size.x || pre_space_y >= obj_tiles.list[| obj_tiles.sel].size.y;
	}
	
	if place_valid
	{
		var set_tile = undefined;
		
		if hold 
			set_tile = new ChunkTile(obj_tiles.sel, 15 - z_selected);
		else if mouse_check_button(mb_right)
			set_tile = new ChunkTile(undefined, -1);
		
		if hold || mouse_check_button(mb_right)
		{
			chunk_selected = new vec2(chunkgrid_x, chunkgrid_y);
			
			if !ds_map_exists(global.chunk, chunk_get_key())
					global.chunk[? chunk_get_key()] = new Chunk(chunkgrid_x, chunkgrid_y);
			
			var this_layer = global.chunk[? chunk_get_key()].layers[| obj_layers.sel].tiles;
			
			if set_tile != undefined && !(set_tile.type == undefined && this_layer[# mgrid_x, mgrid_y].type == undefined) && !(this_layer[# mgrid_x, mgrid_y].type == set_tile.type && 15 - z_selected == this_layer[# mgrid_x, mgrid_y].z)
			{
				ds_grid_set(this_layer, mgrid_x, mgrid_y, set_tile);
				
				tile_previous = new vec2(mgrid_x, mgrid_y);	
			
				// Rebuild chunk mesh
				chunk_compile(chunk_get_key());
			}
		}
	}
}