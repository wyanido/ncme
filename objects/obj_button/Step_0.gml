/// -- @desc onUpdate
// Visibility and hover detect
if onUpdate != undefined onUpdate();

var pre_hovering = hovering;
	
var	mx = window_mouse_get_x(), 
		my = window_mouse_get_y();
	
hovering = active && !hidden && point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom);
if hovering && !pre_hovering
	window_set_cursor(cr_handpoint);
else if !hovering && pre_hovering
	window_set_cursor(cr_default);

// Hover and onClick action
if hovering
{
	if mouse_check_button_pressed(mb_left)
	{
		if onClick != undefined
			onClick();	
		
		// Prevent other objects from detecting click
		io_clear();
	}
}