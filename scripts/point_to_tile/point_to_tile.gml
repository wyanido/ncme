function point_to_tile(px, py)
{
	var	cx = floor(px / TILE_SIZE) mod CHUNK_SIZE,
			cy = floor(py/ TILE_SIZE) mod CHUNK_SIZE;
	
	while (cx < 0) {
		cx += CHUNK_SIZE;
	}
	
	while (cy < 0) {
		cy += CHUNK_SIZE;
	}
	
	return new vec2(cx, cy);
}