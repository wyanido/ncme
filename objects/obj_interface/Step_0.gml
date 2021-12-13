/// -- @desc UI control

var d = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
var click = mouse_check_button_pressed(mb_left), hold = mouse_check_button(mb_left);
var right = mouse_check_button(mb_right);

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
				
	if right || !mouse_check_button(mb_left) || click 
		tile_previous = new vec2(-1, -1);
	
	if(abs(mgrid_x - tile_previous.x) >= tile_list[| tile_selected].size.x || abs(mgrid_y - tile_previous.y) >= tile_list[| tile_selected].size.y)
	{
		var chunk_key = string(chunkgrid_x) + "," + string(chunkgrid_y);
		var set_tile = undefined;
		
		if hold 
			set_tile = new ChunkTile(tile_selected, 15 - z_selected);
		else if right
			set_tile = new ChunkTile(undefined, -1);
		
		if hold || right
		{
			if !ds_map_exists(chunk, chunk_key)
				chunk[? chunk_key] = new Chunk(chunkgrid_x, chunkgrid_y);
			
			var this_layer = chunk[? chunk_key].layers[| layer_selected].tiles;
			ds_grid_set(this_layer, mgrid_x, mgrid_y, set_tile);
			
			tile_previous = new vec2(mgrid_x, mgrid_y);	
			
			// Rebuild chunk mesh
			chunk_compile(chunk_key);
		}
	}
}
			
// Select Tile
if(d.x > 768 && d.x < 960) && (d.y > 28 && d.y < 670.5)
{
	window_set_cursor(cr_handpoint);
				
	var pos = new vec2(floor((d.x - 768) / 32), floor((d.y - 28) / 32));
	var checkPos = new vec2(0, 0);
	var sel = 0;
					
	while(pos.x != checkPos.x || pos.y != checkPos.y)
	{
		sel ++;
		checkPos = new vec2(floor(sel mod 6), floor(sel / 6));
	}

	tile_hovered = (sel < ds_list_size(tile_list)) ? tile_list[| sel] : undefined;
				
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
