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
