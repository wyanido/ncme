
z = 15;
x_target = x;
y_target = y;

dir = 0;
step_lr = true;

sprite_index = s_hero_m_walk_down;
image_speed = 0;
frame_cooldown = 0;

pointToTile_Max = function(px, py)
{
	var	cx = ceil(px / TILE_SIZE) mod CHUNK_SIZE,
			cy = ceil(py/ TILE_SIZE) mod CHUNK_SIZE;
	
	while (cx < 0) {
		cx += CHUNK_SIZE;
	}
	
	while (cy < 0) {
		cy += CHUNK_SIZE;
	}
	
	return new vec2(cx, cy);
}
