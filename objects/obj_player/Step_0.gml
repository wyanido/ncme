
// Move to target location
x += sign(x_target - x);
y += sign(y_target - y);

var moving = x != x_target || y != y_target;

// Create intended movement
if (!moving)
{
	var	key_down = keyboard_check(vk_down),
			key_left = keyboard_check(vk_left),
			key_up = keyboard_check(vk_up),
			key_right = keyboard_check(vk_right);
		
	var	hsp = 0,
			vsp = 0;
	
	hsp = key_right - key_left;
	vsp = key_down - key_up;
	
	if ( hsp != 0 || vsp != 0 ) {
		// Toggle the foot the player steps on for this tile
		frame_cooldown = 8;
		
		image_index = 1 + step_lr;
		step_lr = !step_lr;
		
		// Move player in direction relative to the camera angle
		var	move_dir = angle_simplify(point_direction(0, 0, hsp, vsp)),
				yaw_real = angle_simplify(-obj_cam.yaw),
				angle_diff = angle_simplify(move_dir - yaw_real - 90),
				angle_result = round(angle_diff / 90) * 90;
		
		x_target = x + lengthdir_x(16, angle_result);
		y_target = y;
		
		if (x_target == x) {
			y_target = y + lengthdir_y(16, angle_result);
		}
		
		dir = angle_result;
	} else {
		image_index = 0;
	}
}
else
{
	frame_cooldown --;
	
	if (frame_cooldown == 0) {
		// Return to both feet down near the end of the footstep
		frame_cooldown = 8;
		image_index = 0;
	}
}