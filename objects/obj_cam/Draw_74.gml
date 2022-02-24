if global.viewport_is_3d 
{
	// View info
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
	
	draw_set_font(fnt_UI);
	draw_text(16, window_get_width() - 29, "Projection | X: " + string(pos.x) + ", Y: "+ string(pos.y) + ", Z: " + string(pos.z) + "        Pitch: " + string(pitch) + ", Yaw: " + string(yaw));
}

draw_set_colour(0x332420);
draw_rectangle(global.viewport_w, 0, window_get_width(), window_get_height(), false);
