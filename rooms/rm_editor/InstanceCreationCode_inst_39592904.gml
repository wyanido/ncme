
label = "Clear Layer";

onUpdate = function()
{
	active = !global.viewport_is_3d;	
}

onClick = function()
{
	with (obj_interface)
	{
		var lr = chunk_get_tiles(chunk_selected.x, chunk_selected.y, obj_layers.sel);
		
		// Log tile changes
		var action_log = {
			chunk: chunk_get_key() ,
			layer: obj_layers.sel, 
			type: "layer",
			from: ds_grid_create(32, 32),
			to: {
				type: undefined,
				z: -1
			}
		}
		
		ds_grid_copy(action_log.from, lr)
		
		array_insert(action_list, action_number, action_log);
		
		action_number ++;
		array_delete(action_list, action_number, array_length(action_list) - action_number);
		
		ds_grid_set_region(lr, 0, 0, 31, 31, new ChunkTile(undefined, 0));
		
		// Destroy heightmap
		ds_map_delete(global.heightmap, chunk_get_key())
		vertex_delete_buffer(global.heightmap_cache[? chunk_get_key()]);
		global.heightmap_cache[? chunk_get_key()] = undefined;
		
		chunk_compile(chunk_get_key());	
	}
}