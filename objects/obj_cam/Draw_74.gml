if global.compiled_view 
{
	draw_clear_alpha(c_black, 0);
	
	// View surface
	if global.surf_sprite != undefined sprite_delete(global.surf_sprite);
	global.surf_sprite = sprite_create_from_surface(application_surface, 0, 0, 1280, 720, false, true, 0, 0);

	draw_sprite_ext(global.surf_sprite, 0, 0, 0, 616 / 1280, 1, 0, c_white, 1);
	
	// View info
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
	
	draw_set_font(fnt_UI);
	draw_text(16, 720 - 32, "Projection | X: " + string(pos.x) + ", Y: "+ string(pos.y) + ", Z: " + string(pos.z) + "        Pitch: " + string(pitch) + ", Yaw: " + string(yaw));
	draw_set_colour(0x714AE8);
	draw_text(16, 720 - 56, "Press ESC to exit Compiled View");
}
else
{
	draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1); 
	draw_set_colour(0x332420);
	draw_rectangle(4, 715 - 32, 611, 715, false);
}

draw_set_colour(0x332420);
draw_rectangle(616, 0, 1280, 720, false);
