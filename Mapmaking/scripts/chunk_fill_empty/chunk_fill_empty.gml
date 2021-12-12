
function chunk_fill_empty()
{
	with(obj_interface)
	{
		map_data.chunk[? chunk_get_key()] = new Chunk(selChunk.x, selChunk.y);
	}
}