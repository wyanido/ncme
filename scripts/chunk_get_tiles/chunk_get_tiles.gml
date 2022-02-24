function chunk_get_tiles(pos_x, pos_y, _layer)
{
	var key = chunk_get_key(pos_x, pos_y);
	
	if (!ds_map_exists(global.chunk, key)) {
		global.chunk[? key] = new Chunk(pos_x, pos_y);
	}
	
	if (!ds_map_exists(global.heightmap, key)) {
		var sz = CHUNK_SIZE * 2;
		
		global.heightmap[? key] = ds_grid_create(sz, sz);
		ds_grid_set_region(global.heightmap[? key], 0, 0, sz - 1, sz - 1, 0);
		
		global.heightmap_cache[? key] = undefined;
	}
	
	return global.chunk[? key].layers[_layer].tiles;
}