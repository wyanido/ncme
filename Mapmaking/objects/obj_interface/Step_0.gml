/// -- @desc UI control

var d = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
var click = mouse_check_button_pressed(mb_left), hold = mouse_check_button(mb_left);
var right = mouse_check_button(mb_right);
			
// --- Place TIle
if(!global.compiled_view)
{
	// -- Highlight Cell
	gridSel = (mouse_x > 0 && mouse_x < 512) && (mouse_y > 0 && mouse_y < 512) ? new vec2(mouse_x, mouse_y) : -1;
			
	if(gridSel != -1)
	{
		var mg = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
		if(right || !mouse_check_button(mb_left) || click) { preTile = new vec2(-5, -5); }
					
		if(abs(mg.x - preTile.x) >= tiles[selTile].size.x || abs(mg.y - preTile.y) >= tiles[selTile].size.y)
		{
			if(hold)
			{
				var tls = mapData.chunk[? chunk_get_key()].layers[| selLayer].tiles;
							
				ds_grid_set(tls, mg.x, mg.y, new ChunkTile(tiles[selTile].tile_type, selZ));
				updateMap = true;
							
				preTile = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
			}
					
			if(right)
			{
				var tls = mapData.chunk[? chunk_get_key()].layers[| selLayer].tiles;

				ds_grid_set(tls, mg.x, mg.y, new ChunkTile(tile.none, 15));
				updateMap = true;
							
				preTile = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
			}
		}
	}
}
		
// -- Height
if(d.x > 626 && d.x < 646) && (d.y > 28 && d.y < 679)
{
	window_set_cursor(cr_handpoint);
			
	if hold selZ = floor((d.y - 28) / 21);
}
			
// -- Select Tile
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
			
// -- Select Layer
if(d.x > 671.5 && d.x < 743.5) && (d.y > 36.5 && d.y < 670.5)
{
	window_set_cursor(cr_handpoint);
			
	if click selLayer = floor((d.y - 36.5) / 80.5);
}
