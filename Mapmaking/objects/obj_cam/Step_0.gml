/// -- @desc Camera control
// Exit compiled view and destroy mesh
if keyboard_check_pressed(vk_escape)
{ 
	global.compiled_view = false; 
	
	with obj_interface
	{
		for ( var c = ds_map_find_first(chunkMesh); c < ds_map_size(chunkMesh) - 1; c = ds_map_find_next(chunkMesh, c) )
		{
			if !is_undefined(chunkMesh[? c])
			{
				vertex_delete_buffer(chunkMesh[? c]);
				chunkMesh[? c] = undefined;
			}
		}
	}
}

if !global.compiled_view return;

// Freecam control
// Look
yaw -= (window_mouse_get_x() - 308) / 10;
pitch = clamp(pitch - (window_mouse_get_y() - 360) / 10, -89, 89);
	
window_mouse_set(308, 360);

// From
pos.z += (keyboard_check(vk_space) - keyboard_check(vk_lshift)) * spd;

var da_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
pos.x += da_dir * (dsin(yaw) * spd);
pos.y += da_dir * (dcos(yaw) * spd);

var sw_dir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
pos.x -= sw_dir * (dcos(yaw) * spd);
pos.y += sw_dir * (dsin(yaw) * spd);
