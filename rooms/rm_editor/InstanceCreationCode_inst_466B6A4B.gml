
label = "Flood Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		if !ds_map_exists(global.chunk, chunk_get_key())
				global.chunk[? chunk_get_key()] = new Chunk(chunk_selected.x, chunk_selected.y);
		
		var lr = global.chunk[? chunk_get_key()].layers[| obj_layers.sel];
		ds_grid_set_region(lr.tiles, 0, 0, 31, 31, new ChunkTile(obj_tiles.sel, 15 - z_selected));
		
		chunk_compile(chunk_get_key());
	}
}