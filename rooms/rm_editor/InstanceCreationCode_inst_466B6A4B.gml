
label = "Flood Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		if !ds_map_exists(chunk, chunk_get_key())
				chunk[? chunk_get_key()] = new Chunk(chunk_selected.x, chunk_selected.y);
		
		var lr = chunk[? chunk_get_key()].layers[| layer_selected];
		ds_grid_set_region(lr.tiles, 0, 0, 31, 31, new ChunkTile(tile_selected, 15 - z_selected));
		
		chunk_compile(chunk_get_key());
	}
}