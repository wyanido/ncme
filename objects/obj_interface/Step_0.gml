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

// Place TIle
if !global.compiled_view
{
	var	mgrid_x = floor(mouse_x / 16),
			mgrid_y = floor(mouse_y / 16);
		
	var	chunkgrid_x = floor(mouse_x / 512), 
			chunkgrid_y = floor(mouse_y / 512);
				
	if right || !mouse_check_button(mb_left) || click 
		preTile = new vec2(-1, -1);
					
	if(abs(mgrid_x - preTile.x) >= tiles[selTile].size.x || abs(mgrid_y - preTile.y) >= tiles[selTile].size.y)
	{
		var chunk_key = string(chunkgrid_x) + "," + string(chunkgrid_y);
		var set_tile = undefined;
			
		if hold 
			set_tile = new ChunkTile(tiles[selTile].tile_type, selZ);
		else if right
			set_tile = new ChunkTile(tile.none, 15);
			
		if hold || right
		{
			if !ds_map_exists(map_data.chunk, chunk_key)
				map_data.chunk[? chunk_key] = new Chunk(chunkgrid_x, chunkgrid_y);
			
			var this_layer = map_data.chunk[? chunk_key].layers[| selLayer].tiles;
			ds_grid_set(this_layer, mgrid_x, mgrid_y, set_tile);
			
			preTile = new vec2(mgrid_x, mgrid_y);	
			refresh_layer = true
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

	hoverTile = (sel < array_length(tiles)) ? tiles[sel] : noone;
				
	if(click && sel < array_length(tiles))  selTile = sel; 
				
} else {
	hoverTile = noone;	
}
			
// Select Layer
if(d.x > 671.5 && d.x < 743.5) && (d.y > 36.5 && d.y < 670.5)
{
	window_set_cursor(cr_handpoint);
			
	if click selLayer = floor((d.y - 36.5) / 80.5);
}
