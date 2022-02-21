
// Find camera direction in range 0-359
var yaw_real = angle_simplify(obj_cam.yaw);

// Change drawn sprite based on angle between camera and facing direction
var	angle_diff = angle_simplify(yaw_real - dir - 180),
		angle_result = round(angle_diff / 90),
		dir_real = "down";

switch (angle_result)
{
	case (0): dir_real = "down"; break;
	case (1): dir_real = "left"; break;
	case (2): dir_real = "up"; break;
	case (3): dir_real = "right"; break;
}

sprite_index = asset_get_index("s_hero_m_walk_" + dir_real);

// Draw player in world
matrix_set(matrix_world, matrix_build(x + 8, y + 8, 0.1, 0, 0, 0, 1, 1, 1));
draw_sprite(s_shadow, 0, 0, 0);

matrix_set(matrix_world, matrix_build(x + 8, y + 8, 0, 0, 0, 0, 1, 1, 1));

shader_set(shd_billboard);
draw_sprite(sprite_index, image_index, 0, 0);
shader_reset();

matrix_set(matrix_world, matrix_build_identity());