/// -- @desc Select height

var	mx = window_mouse_get_x(),
		my = window_mouse_get_y();

var	height = bbox_bottom - bbox_top,
		max_h = height / 31;

if point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom)
{
	window_set_cursor(cr_handpoint);
			
	if mouse_check_button_pressed(mb_left)
		obj_interface.z_selected = floor((my - bbox_top) / max_h);
}