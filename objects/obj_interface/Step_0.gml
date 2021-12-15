/// -- @desc UI control

var d = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
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

if !global.compiled_view && point_in_rectangle(mx, my, 0, 0, 616, 720)
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
		var place_valid = pre_space_x >= tile_list[| tile_selected].size.x || pre_space_y >= tile_list[| tile_selected].size.y;
	}
	
	if place_valid
	{
		var set_tile = undefined;
		
		if hold 
			set_tile = new ChunkTile(tile_selected, 15 - z_selected);
		else if mouse_check_button(mb_right)
			set_tile = new ChunkTile(undefined, -1);
		
		if hold || mouse_check_button(mb_right)
		{
			chunk_selected = new vec2(chunkgrid_x, chunkgrid_y);
			
			if !ds_map_exists(chunk, chunk_get_key())
					chunk[? chunk_get_key()] = new Chunk(chunkgrid_x, chunkgrid_y);
			
			var this_layer = chunk[? chunk_get_key()].layers[| layer_selected].tiles;
			
			if set_tile != undefined && this_layer[# mgrid_x, mgrid_y].type != set_tile.type
			{
				ds_grid_set(this_layer, mgrid_x, mgrid_y, set_tile);
			
				tile_previous = new vec2(mgrid_x, mgrid_y);	
			
				// Rebuild chunk mesh
				chunk_compile(chunk_get_key());
			}
		}
	}
}
			
// Select Tile
if(d.x > 768 && d.x < 960) && (d.y > 28 && d.y < 670.5)
{
	
	var pos = new vec2(floor((d.x - 768) / 32), floor((d.y - 28) / 32));
	var checkPos = new vec2(0, 0);
	var sel = 0;
					
	while(pos.x != checkPos.x || pos.y != checkPos.y)
	{
		sel ++;
		checkPos = new vec2(floor(sel mod 6), floor(sel / 6));
	}
	
	if sel < ds_list_size(tile_list)
	{
		tile_hovered = tile_list[| sel];
		window_set_cursor(cr_handpoint);
	}
	else
	{
		tile_hovered = undefined;
		window_set_cursor(cr_default);
	}
	
	if(click && sel < ds_list_size(tile_list))  tile_selected = sel; 
				
} else {
	tile_hovered = undefined;	
}
			
// Select Layer
if(d.x > 671.5 && d.x < 743.5) && (d.y > 36.5 && d.y < 670.5)
{
	window_set_cursor(cr_handpoint);
			
	if click layer_selected = floor((d.y - 36.5) / 80.5);
}
