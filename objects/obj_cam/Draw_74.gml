if global.compiled_view 
{
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
	draw_set_colour(0x332420);
	draw_rectangle(4, 715 - 32, 611, 715, false);
}

draw_set_colour(0x332420);
draw_rectangle(616, 0, 1280, 720, false);
