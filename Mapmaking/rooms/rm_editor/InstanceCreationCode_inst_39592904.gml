
label = "Clear Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		ds_grid_set_region(map_data.chunk[? chunk_get_key()].layers[| selLayer].tiles, 0, 0, 31, 31, new ChunkTile(tile.none, 15));
				
		refresh_layer = true;
	}
}