/// -- @desc Camera control
// Exit compiled view and destroy mesh
if !global.compiled_view
{
	// Camera panning
	if mouse_check_button(mb_middle)
	{
		if !panning
		{
			with obj_interface
			{
				var	chunkgrid_x = floor(mouse_x / 512), 
						chunkgrid_y = floor(mouse_y / 512);
						
				chunk_selected = new vec2(chunkgrid_x, chunkgrid_y);
			}
			
			panning = true;
			pan_start = new vec2(window_mouse_get_x(), window_mouse_get_y());
			
			window_set_cursor(cr_size_all);
		}
		
		var diff = new vec2(window_mouse_get_x() - pan_start.x, window_mouse_get_y() - pan_start.y);
		
		x -= diff.x
		y -= diff.y;
		
		pan_start = new vec2(window_mouse_get_x(), window_mouse_get_y());
	}
	else
	{
		panning = false;
		window_set_cursor(cr_default);
	}
}
else
{
	// Freecam control
	// Look
	yaw -= (window_mouse_get_x() - 308) / 10;
	pitch = clamp(pitch - (window_mouse_get_y() - 360) / 10, -89, 89);
	
	window_mouse_set(308, 360);

	// From
	pos.z += (keyboard_check(ord(("E"))) - keyboard_check(ord("Q"))) * spd;

	var da_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	pos.x += da_dir * (dsin(yaw) * spd);
	pos.y += da_dir * (dcos(yaw) * spd);

	var sw_dir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	pos.x -= sw_dir * (dcos(yaw) * spd);
	pos.y += sw_dir * (dsin(yaw) * spd);
}