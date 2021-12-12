/// -- @desc Interface
// Background
draw_set_colour(0x332420);
draw_rectangle(616, 0, 1280, 720, false);
if(!global.compiled_view) draw_rectangle(4, 715 - 32, 611, 715, false);
		
#region --- Layers
	var w = 664, h = 36, s = 72, sep = 8.5;
			
	for(var l = 0; l < 8; l ++)
	{
		draw_set_colour(0x111111);
		draw_rectangle(w + sep, h + (l * (s + sep)), w + sep + s, h + s + (l * (s + sep)), false);
				
		if(mapData.chunk[? chunk_get_key()].render_cache[l] != undefined) {
			draw_sprite_ext(mapData.chunk[? chunk_get_key()].render_cache[l], 0, w + sep, h + (l * (s + sep)), 72 / 512 , 72 / 512, 0, 0xFFFFFF, 1);
		}
	}
			
	// -- Border
	draw_set_colour(0xFFFFFF);
	draw_rectangle(w, h - sep, w + s + (sep * 2), h + (8 * (s + sep)), true);

	// -- Layer Selection
	draw_set_colour(0x000FFF);
	draw_rectangle(w + sep, h + (selLayer * (s + sep)), w + sep + s, h + s + (selLayer * (s + sep)), true);
#endregion

#region --- Tile Height
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_UI_small);
		
	var i = 15, w = 636, p = 10;
	for(var h = 0; h < 31; h ++)
	{
		var v = 39.5 + (h * 21);
			
		draw_set_colour(make_colour_hsv((31 - h) * 5, 128 + (128 * (h mod 2)), 255));
		draw_rectangle(w - p, v - p, w + p, v + p, false);
			
		draw_set_colour(0x000000);
		draw_text(w + 1, v + 1, string(i));

		i --;
	}
		
	// -- Border
	draw_set_colour(0xFFFFFF);
	draw_border_width(w - p, 28, w + p, 679, 2);
		
	// -- Z Selection
	var v = 39.5 + (selZ * 21);
	draw_set_colour(0x000FFF);
	draw_rectangle(w - p + 1, v - p - 1, w + p, v + p, true);
	draw_set_alpha(0.5);
	draw_rectangle(w - p + 1, v - p - 1, w + p, v + p, false);	
	draw_set_alpha(1);
		
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
#endregion
		
#region --- Cell Selection
	// -- Highlighted Cell
	if(gridSel != -1 && !global.compiled_view) { 
		var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))
		var mg = new vec2(floor(mouse_x / 16) * 16, floor(mouse_y / 16) * 16)
		var cell = new vec2(mg.x / 16, mg.y / 16);
		var cell_glob = new vec2(cell.x + (32 * selChunk.x), cell.y + (32 * selChunk.y));
			
		draw_set_font(fnt_UI);
		draw_set_colour(0xFFFFFF);
		draw_text(16, 691, "Within Chunk | X: " + string(cell.x) + ", Y: " + string(cell.y));
		draw_text(256, 691, "On Map | X: " + string(cell_glob.x + (selChunk.x * 32)) + ", Y: " + string(cell_glob.y + (selChunk.y * 32)));
				
	}
#endregion
		
#region --- Tileset
			
	var xx = 768, w = 6, h = 20, i = 0, count = sprite_get_number(sTile_Ico);
	
	draw_set_colour(0x111111);
	draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), false);
			
	draw_set_colour(0xFFFFFF);
	draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), true);
			
	for(var _y = 0; _y < h && i < count; _y ++)
	{
		for(var _x = 0; _x < 8 && _x < w && i < count; _x ++)
		{
			draw_sprite_ext(sTile_Ico, i, xx + (_x * 32), 28 + (_y * 32), 2, 2, 0, c_white, 1);

			i ++;
		}
	}
			
	var pos = new vec2(selTile mod w, floor(selTile / w));
	var cellS = new vec2(pos.x * 32, pos.y * 32);
			
	draw_set_colour(0x000FFF);
	draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, true);
					
	// -- Cell Name
	var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			
	if(hoverTile != noone) 
	{
				
		// -- Highlight Hovered Cell
		var pos = new vec2(hoverTile.index mod w, floor(hoverTile.index / w));
		var cellS = new vec2(pos.x * 32, pos.y * 32);
		var p = 4;
				
		draw_set_font(fnt_UI);
		draw_set_alpha(abs(sin(get_timer() / 300000)) * 0.5);
		draw_set_colour(0xFFFFFF);
		draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, false);
			
		// -- Cell Name
		draw_set_alpha(0.75);
		draw_set_colour(0x000000);
		draw_rectangle(m.x + 16 - p, m.y + 12 - p, m.x + 16 + string_width(hoverTile.label) + p, m.y + 12 + string_height(hoverTile.label) + p, false);
				
		draw_set_alpha(1);
		draw_set_colour(0xFFFFFF);
		draw_text(m.x + 16, m.y + 13, hoverTile.label);

	}
			
#endregion
