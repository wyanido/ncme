	
var xx = 768, w = 6, h = 20, i = 0, count = sprite_get_number(s_tile_icons);
	
draw_set_colour(0x111111);
draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), false);
			
draw_set_colour(c_white);
draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), true);
			
for(var _y = 0; _y < h && i < count; _y ++)
{
	for(var _x = 0; _x < 8 && _x < w && i < count; _x ++)
	{
		draw_sprite_ext(s_tile_icons, i, xx + (_x * 32), 28 + (_y * 32), 2, 2, 0, c_white, 1);

		i ++;
	}
}

var pos = new vec2(selTile mod w, floor(selTile / w));
var cellS = new vec2(pos.x * 32, pos.y * 32);

draw_set_colour(0x000FFF);
draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, true);
					
// -- Cell Name
var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			
if(hoverTile != undefined) 
{
	// -- Highlight Hovered Cell
	var pos = new vec2(hoverTile.index mod w, floor(hoverTile.index / w));
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
	draw_rectangle(m.x + 16 - p, m.y + 12 - p, m.x + 16 + string_width(hoverTile.label) + p, m.y + 12 + string_height(hoverTile.label) + p, false);
				
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_text(m.x + 16, m.y + 13, hoverTile.label);
}