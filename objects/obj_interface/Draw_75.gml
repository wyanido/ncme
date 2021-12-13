
var xx = 768, w = 6, h = 20, i = 0;
	
draw_set_colour(0x111111);
draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), false);
			
draw_set_colour(c_white);
draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), true);

// Draw tiles
var tile_count = ds_list_size(tile_list)
for(var _y = 0; _y < h && i < tile_count; _y ++)
{
	for(var _x = 0; _x < 8 && _x < w && i < tile_count; _x ++)
	{
		draw_sprite_stretched(tile_list[| i].tex, i, xx + (_x * 32), 28 + (_y * 32), 32, 32);
		i ++;
	}
}

var pos = new vec2(tile_selected mod w, floor(tile_selected / w));
var cellS = new vec2(pos.x * 32, pos.y * 32);

draw_set_colour(0x000FFF);
draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, true);
					
// -- Cell Name
var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			
if tile_hovered != undefined
{
	// -- Highlight Hovered Cell
	var pos = new vec2(tile_hovered.index mod w, floor(tile_hovered.index / w));
	var cellS = new vec2(pos.x * 32, pos.y * 32);
	var p = 4;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(fnt_UI);
	draw_set_alpha(abs(sin(get_timer() / 300000)) * 0.5);
	draw_set_colour(c_white);
	draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, false);
			
	// -- Cell Name
	draw_set_alpha(0.75);
	draw_set_colour(c_black);
	draw_rectangle(m.x + 16 - p, m.y + 12 - p, m.x + 16 + string_width(tile_hovered.name) + p, m.y + 12 + string_height(tile_hovered.name) + p, false);
				
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_text(m.x + 16, m.y + 13, tile_hovered.name);
}