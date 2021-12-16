/// -- @desc Viewport Info
	
if !global.compiled_view
{ 
	var	mgrid_x = floor(mouse_x / 16) mod 32,
			mgrid_y = floor(mouse_y / 16) mod 32;
	
	while mgrid_x < 0 mgrid_x += 32;
	while mgrid_y < 0 mgrid_y += 32;
	
	var	cell_onmap_x = floor(mouse_x / 16) + (32 * chunk_selected.x),
			cell_onmap_y = floor(mouse_y / 16) + (32 * chunk_selected.y);
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_font(fnt_UI);
	draw_set_colour(c_white);
	
	draw_text(16, 691 - 52, "Zoom: " + string((1 / obj_cam.zoom) * 100) + "%");
	draw_text(16, 691, "Within Chunk | X: " + string(mgrid_x) + ", Y: " + string(mgrid_y));
	draw_text(232, 691, "On Map | X: " + string(cell_onmap_x) + ", Y: " + string(cell_onmap_y));
	
	if chunk_mesh[? chunk_get_key()] != undefined
		draw_text(440, 691, "Vertex Count: " + string(vertex_get_number(chunk_mesh[? chunk_get_key()])));
		
	draw_set_colour(c_white);
	draw_text(16, 16, "LMB - Place Tile\nRMB - Clear Tile\nMMB - Pan viewport\nMouse Wheel - Zoom");
}
else
{
	draw_set_colour(c_white);
	draw_text(16, 16, "WASD - Move\nQE - Up/Down\nMOUSE - Look");
}

draw_set_colour(0x714AE8);
draw_text(16, 720 - 56, "Press SPACE to toggle 3D View");