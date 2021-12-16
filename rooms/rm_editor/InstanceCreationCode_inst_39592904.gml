
label = "Clear Layer";

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
				
		ds_grid_set_region(global.chunk[? chunk_get_key()].layers[| obj_layers.sel].tiles, 0, 0, 31, 31, new ChunkTile(undefined, 15));
		
		chunk_compile(chunk_get_key());	
	}
}