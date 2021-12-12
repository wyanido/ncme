/// -- @desc Interface

// Layers
var w = 664, h = 36, s = 72, sep = 8.5;
for ( var l = 0; l < 8; l ++ )
{
	draw_set_colour(0x111111);
	draw_rectangle(w + sep, h + (l * (s + sep)), w + sep + s, h + s + (l * (s + sep)), false);
				
	if !is_undefined(map_data.chunk[? chunk_get_key()].render_cache[l])
	{
		draw_sprite_ext(map_data.chunk[? chunk_get_key()].render_cache[l], 0, w + sep, h + (l * (s + sep)), 72 / 512 , 72 / 512, 0, c_white, 1);
	}
}
			
// -- Border
draw_set_colour(c_white);
draw_rectangle(w, h - sep, w + s + (sep * 2), h + (8 * (s + sep)), true);

// -- Layer Selection
draw_set_colour(0x000FFF);
draw_rectangle(w + sep, h + (selLayer * (s + sep)), w + sep + s, h + s + (selLayer * (s + sep)), true);

// Selected Cell
if cell_sel != -1 && !global.compiled_view
{ 
	var	xw = 50.5,
			yv = 85.5;
			
	var	mgrid_x = xw + floor((mouse_x) / 16) * 16,
			mgrid_y = yv + floor((mouse_y) / 16) * 16;
		
	var	cellsize_x = tiles[selTile].size.x * 16, 
			cellsize_y = tiles[selTile].size.y * 16;
			
	var	cell_onmap_x = mgrid_x / 16 + 32 * selChunk.x,
			cell_onmap_y = mgrid_y / 16 + 32 * selChunk.y;
	
	// Cell outline
	if mgrid_x + cellsize_x <= 512 && mgrid_y + cellsize_y <= 512
	{
		draw_set_colour(0x000FFF);
		draw_rectangle(mgrid_x + 2, mgrid_y + 2, mgrid_x + cellsize_x, mgrid_y + cellsize_y, true);
	}
	
	// Cell location
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_UI);
	draw_set_colour(c_white);
	
	draw_text(16, 691, "Within Chunk | X: " + string(mgrid_x / 16) + ", Y: " + string(mgrid_y / 16));
	draw_text(256, 691, "On Map | X: " + string(cell_onmap_x) + ", Y: " + string(cell_onmap_y));
}