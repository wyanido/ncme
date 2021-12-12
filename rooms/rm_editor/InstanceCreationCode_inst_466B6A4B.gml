
label = "Flood Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		var lr = map_data.chunk[? chunk_get_key()].layers[| selLayer];
		ds_grid_set_region(lr.tiles, 0, 0, 31, 31, new ChunkTile(tiles[selTile].tile_type, selZ));
				
		refresh_layer = true;
	}
}