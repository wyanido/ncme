function chunk_get_tiles(pos_x, pos_y, _layer)
{
	var key = chunk_get_key(pos_x, pos_y);
	
	if !ds_map_exists(global.chunk, key)
		global.chunk[? key] = new Chunk(pos_x, pos_y);
	
	return global.chunk[? key].layers[_layer].tiles;
}