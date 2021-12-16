
function chunk_fill_empty()
{
	with(obj_interface)
	{
		global.chunk[? chunk_get_key()] = new Chunk(chunk_selected.x, chunk_selected.y);
	}
}