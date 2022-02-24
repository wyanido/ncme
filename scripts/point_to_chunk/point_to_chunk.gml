function point_to_chunk(px, py)
{
	var sz = CHUNK_SIZE * TILE_SIZE;
	
	return new vec2(floor(px / sz), floor(py / sz));
}