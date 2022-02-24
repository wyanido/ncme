/// -- @desc Tile select
var	mx = window_mouse_get_x(), 
		my = window_mouse_get_y();

x = global.viewport_w + start_x;

if point_in_rectangle(mx, my, bbox_left, bbox_top, bbox_right, bbox_bottom)
{
	// Convert mouse position to list position
	var hcount = 6;
	var ww = (bbox_right - bbox_left) / hcount;
	
	var	xx = floor((mx - bbox_left) / ww) mod hcount,
			yy = floor((my - bbox_top) / ww) * hcount;
	var hover_index = xx + yy;

	// Selection valid
	if hover_index != -1 && hover_index < ds_list_size(list)
	{
		hovered = list[| hover_index];
		window_set_cursor(cr_handpoint);
		
		if mouse_check_button_pressed(mb_left)
			sel = hover_index; 
	}		
} else {
	hovered = undefined;	
}
