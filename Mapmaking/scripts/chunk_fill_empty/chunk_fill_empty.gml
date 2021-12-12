
function chunk_fill_empty()
{
	with(obj_interface)
	{
		mapData.chunk[? chunk_get_key()] = new Chunk(selChunk.x, selChunk.y);
	}
}