
label = "Clear Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		ds_grid_set_region(chunk[? chunk_get_key()].layers[| layer_selected].tiles, 0, 0, 31, 31, new ChunkTile(undefined, 15));
				
		chunk_compile(chunk_get_key());
	}
}