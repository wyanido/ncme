/// -- @desc Select height

var	mx = window_mouse_get_x(),
		my = window_mouse_get_y();

var	height = bbox_bottom - bbox_top,
		max_h = height / 31;

var pre_hover = hovering;
hovering = point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom);

if hovering
{
	if !pre_hover
		window_set_cursor(cr_handpoint);
			
	if mouse_check_button_pressed(mb_left)
		obj_interface.z_selected = floor((my - bbox_top) / max_h);
}
else if !hovering && pre_hover
	window_set_cursor(cr_default);