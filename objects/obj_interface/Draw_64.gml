/// -- @desc Interface
// Layers
var w = 664, h = 36, s = 72, sep = 8.5;
for ( var l = 0; l < 8; l ++ )
{
	draw_set_colour(0x111111);
	draw_rectangle(w + sep, h + (l * (s + sep)), w + sep + s, h + s + (l * (s + sep)), false);
				
	if !is_undefined(chunk[? chunk_get_key()]) && !is_undefined(chunk[? chunk_get_key()].render_cache[l])
	{
		draw_sprite_stretched(chunk[? chunk_get_key()].render_cache[l], 0, w + sep, h + (l * (s + sep)), s, s);
	}
}
			
// -- Border
draw_set_colour(c_white);
draw_rectangle(w, h - sep, w + s + (sep * 2) - 1, h + (8 * (s + sep)) - 1, true);

// -- Layer Selection
draw_set_colour(0x000FFF);
draw_rectangle(w + sep, h + (layer_selected * (s + sep)), w + sep + s - 1, h + s + (layer_selected * (s + sep)) - 1, true);

// Selected Cell
if !global.compiled_view
{ 
	var	mgrid_x = floor(mouse_x / 16) mod 32,
			mgrid_y = floor(mouse_y / 16) mod 32;
	
	while mgrid_x < 0 mgrid_x += 32;
	while mgrid_y < 0 mgrid_y += 32;
	
	var	cell_onmap_x = floor(mouse_x / 16) + (32 * chunk_selected.x),
			cell_onmap_y = floor(mouse_y / 16) + (32 * chunk_selected.y);

	// Cell location
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_UI);
	draw_set_colour(c_white);
	
	draw_text(16, 691, "Within Chunk | X: " + string(mgrid_x) + ", Y: " + string(mgrid_y));
	draw_text(232, 691, "On Map | X: " + string(cell_onmap_x) + ", Y: " + string(cell_onmap_y));
	
	if chunk_mesh[? chunk_get_key()] != undefined
		draw_text(440, 691, "Vertex Count: " + string(vertex_get_number(chunk_mesh[? chunk_get_key()])));
}