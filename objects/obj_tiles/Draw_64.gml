
var hcount = 6;
var w = (bbox_right - bbox_left) / hcount, h = 20, i = 0;
	
draw_set_colour(0x111111);
draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, false);
draw_set_colour(c_white);
draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, true);

// Draw tiles
var tile_count = ds_list_size(list)
for(var _y = 0; _y < h && i < tile_count; _y ++)
{
	for(var _x = 0; _x < hcount && _x < w && i < tile_count; _x ++)
	{
		draw_sprite_stretched(tile_icons[i], 0, x + (_x * w), y + (_y * w), w, w);
		i ++;
	}
}

var	cell_x = (sel mod hcount) * w,
		cell_y = floor(sel / hcount) * w;

draw_set_colour(0x000FFF);
draw_rectangle(x + cell_x + 1, y + cell_y + 1, x + cell_x + w - 1, y + cell_y + w - 1, true);

// Tile selection
if hovered != undefined
{
	var	mx = window_mouse_get_x(), 
			my = window_mouse_get_y();
	
	var	cell_x = (hovered.index mod hcount) * w,
			cell_y = floor(hovered.index / hcount) * w;
	var p = 4;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_UI);
	draw_set_alpha(abs(sin(get_timer() / 300000)) * 0.5);
	draw_set_colour(c_white);
	draw_rectangle(x + cell_x, y + cell_y, x + cell_x + w - 1, y + cell_y + w - 1, false);
	
	// -- Cell Name
	draw_set_alpha(0.75);
	draw_set_colour(c_black);
	draw_rectangle(mx + 16 - p, my + 12 - p, mx + 16 + string_width(hovered.name) + p, my + 12 + string_height(hovered.name) + p, false);
				
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_text(mx + 16, my + 13, hovered.name);
}