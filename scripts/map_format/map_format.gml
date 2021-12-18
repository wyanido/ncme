function map_format()
{
	var map_data = ds_map_create();
	
	map_data[? chunk_get_key(0, 0)] = new Chunk(0, 0);
	
	return map_data;
}