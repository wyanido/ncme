/// -- @desc View control
// Toggle orthographic view
if keyboard_check_pressed(vk_space)
{
	global.viewport_3d = !global.viewport_3d;
	
	if global.viewport_3d
		window_mouse_set(308, 360);
}

// Zoom
if mouse_wheel_up() zoom -= 0.1;
if mouse_wheel_down() zoom += 0.1;

zoom = clamp(zoom, 0.4, 2);

var	mx = window_mouse_get_x(), 
		my = window_mouse_get_y();

var vw = obj_interface.viewport_w;

if !global.viewport_3d
{
	if point_in_rectangle(mx, my, 0, 0, vw, 720)
	{
		// Viewport panning
		if mouse_check_button(mb_middle)
		{
			if !panning
			{
				with obj_interface
				{
					if !is_array(chunk_mesh[? chunk_get_key()])
						chunk_mesh[? chunk_get_key()] = array_create(8, undefined);
				}
			
				panning = true;
				pan_start = new vec2(mouse_x, mouse_y);
			
				window_set_cursor(cr_size_all);
			}
			
			var diff = new vec2(mouse_x - pan_start.x, mouse_y - pan_start.y);
		
			x -= diff.x
			y -= diff.y;
		}
		else
		{
			panning = false;
			window_set_cursor(cr_default);
		}
	}
}
else
{
	// Freecam control
	// Look
	yaw -= (mx - (vw / 2)) / 10;
	pitch = clamp(pitch - (my - (window_get_height() / 2)) / 10, -89.5, 89.5);
	
	window_mouse_set(vw / 2, window_get_height() / 2);

	// From
	pos.z += (keyboard_check(ord(("E"))) - keyboard_check(ord("Q"))) * spd;

	var da_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	pos.x += da_dir * (dsin(yaw) * spd);
	pos.y += da_dir * (dcos(yaw) * spd);

	var sw_dir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	pos.x -= sw_dir * (dcos(yaw) * spd);
	pos.y += sw_dir * (dsin(yaw) * spd);
}