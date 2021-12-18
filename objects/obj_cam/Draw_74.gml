if global.viewport_3d 
{
	// View info
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_colour(c_white);
	
	draw_set_font(fnt_UI);
	draw_text(16, 691, "Projection | X: " + string(pos.x) + ", Y: "+ string(pos.y) + ", Z: " + string(pos.z) + "        Pitch: " + string(pitch) + ", Yaw: " + string(yaw));
}

draw_set_colour(0x332420);
draw_rectangle(obj_interface.viewport_w, 0, window_get_width(), 720, false);
