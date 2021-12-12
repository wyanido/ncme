/// -- @desc onUpdate
// Visibility and hover detect
if onUpdate != undefined onUpdate();

if active && !hidden
{
	var	mx = window_mouse_get_x(), 
			my = window_mouse_get_y();
	
	hovering = point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom);
}
else hovering = false;

// Hover and onClick action
if hovering
{
	window_set_cursor(cr_handpoint);
	
	if mouse_check_button_pressed(mb_left) && onClick != undefined
		onClick();	
}