/// -- @desc Draw layer list

var	pad = 10, 
		hh = (bbox_bottom - bbox_top - pad) / 8,
		ww = bbox_right - bbox_left - pad * 2;

gpu_set_tex_filter(true);
for ( var l = 0; l < 8; l ++ )
{
	draw_set_colour(0x111111);
	
	draw_rectangle(bbox_left + pad, bbox_top + pad + hh * l, bbox_right - pad, bbox_top + hh * (l + 1), false);
	
	var this_chunk = global.chunk[? chunk_get_key()];
	
	if !is_undefined(this_chunk) && !is_undefined(this_chunk.render_cache[l])
	{
		draw_sprite_stretched(this_chunk.render_cache[l], 0, bbox_left + pad, bbox_top + pad + hh * l, ww, hh - pad);
	}
}
gpu_set_tex_filter(false);

draw_set_colour(c_white);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

// Selection
draw_set_colour(0x000FFF);
draw_rectangle(bbox_left + pad, bbox_top + pad + hh * sel, bbox_right - pad - 1, bbox_top + hh * (sel + 1) - 1, true);