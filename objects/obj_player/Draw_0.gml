
// Disable if not in 3D view
if (!global.viewport_is_3d) {
	return;
}

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

// Adjust Z coordinate to current tile
var	cchunk = point_to_chunk(x + 8, y + 8),
		ctile = point_to_tile(x + 8, y + 8),
		ckey = chunk_get_key(cchunk.x, cchunk.y),
		ctx = ctile.x * 2,
		cty = ctile.y * 2;

if (ds_map_exists(global.heightmap, ckey)) {
	var	z_topl = global.heightmap	[? ckey][# ctx,			cty			],
			z_topr = global.heightmap[? ckey][# ctx + 1,	cty			],
			z_botl = global.heightmap	[? ckey][# ctx,			cty + 1	],
			z_botr = global.heightmap[? ckey][# ctx + 1,	cty + 1	];
	
	var	xdiv = (x + 8) / 16,
			ydiv = (y + 8) / 16,
			xprog = xdiv - floor(xdiv),
			yprog = ydiv - floor(ydiv);
	
	var	z1 = 1 / (sqr(0 - xprog) + sqr(0 - yprog)),
			z2 = 1 / (sqr(1 - xprog) + sqr(0 - yprog)),
			z3 = 1 / (sqr(0 - xprog) + sqr(1 - yprog)),
			z4 = 1 / (sqr(1 - xprog) + sqr(1 - yprog));

	z = ((z_topl * z1) + (z_topr * z2) + (z_botl * z3) + (z_botr * z4)) / (z1 + z2 + z3 + z4);
}

// Draw player in world
rz = z * 16;
matrix_set(matrix_world, matrix_build(x + 8, y + 8, rz, 0, 0, 0, 1, 1, 1));
draw_sprite(s_shadow, 0, 0, 0);

matrix_set(matrix_world, matrix_build(x + 8, y + 8, rz, 0, 0, 0, 1, 1, 1));

shader_set(shd_billboard);
draw_sprite(sprite_index, image_index, 0, 0);
shader_reset();

matrix_set(matrix_world, matrix_build_identity());