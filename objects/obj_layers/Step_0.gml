
// Select Layer
var	mx = window_mouse_get_x(), 
		my = window_mouse_get_y();

var pad = 10, hh = (bbox_bottom - bbox_top - pad) / 8;

if point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom)
{
	window_set_cursor(cr_handpoint);
			
	if mouse_check_button_pressed(mb_left)
	{
		sel = floor((my - bbox_top) / hh);
	}
}
