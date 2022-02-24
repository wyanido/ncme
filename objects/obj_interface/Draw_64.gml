/// -- @desc Viewport Info

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(fnt_UI);
draw_set_colour(c_white);
	
if !global.viewport_is_3d
{ 
	var	mgrid_x = floor(mouse_x / 16) mod 32,
			mgrid_y = floor(mouse_y / 16) mod 32;
	
	while mgrid_x < 0 mgrid_x += 32;
	while mgrid_y < 0 mgrid_y += 32;
	
	var	cell_onmap_x = floor(mouse_x / 16) + (32 * chunk_selected.x),
			cell_onmap_y = floor(mouse_y / 16) + (32 * chunk_selected.y);

	draw_set_halign(fa_right);
	draw_text(global.viewport_w - 16, 691, "Zoom: " + string((1 / obj_cam.zoom) * 100) + "%");
	
	draw_set_halign(fa_left);
	draw_text(16, 691, "Within Chunk | X: " + string(mgrid_x) + ", Y: " + string(mgrid_y));
	draw_text(232, 691, "On Map | X: " + string(cell_onmap_x) + ", Y: " + string(cell_onmap_y));
	
	var chunk = chunk_mesh[? chunk_get_key()];
	
	if ( chunk != undefined && chunk[obj_layers.sel] != undefined ) {
		draw_text(16, 691 - 26, "Vertex Count: " + string(vertex_get_number(chunk[obj_layers.sel])));
	}
}