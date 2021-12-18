
label = "Flood Layer";

onUpdate = function()
{
	active = !global.viewport_3d;	
}

onClick = function()
{
	var lr = chunk_get_tiles(obj_interface.chunk_selected.x, obj_interface.chunk_selected.y, obj_layers.sel);
	
	with obj_interface
	{
		// Log tile changes
		var action_log = {
			chunk: chunk_get_key() ,
			layer: obj_layers.sel, 
			type: "layer",
			from: ds_grid_create(32, 32),
			to: {
				type: obj_tiles.sel,
				z: obj_tileheight.sel
			}
		}
		
		ds_grid_copy(action_log.from, lr)
		
		array_insert(action_list, action_number, action_log);
		
		action_number ++;
		array_delete(action_list, action_number, array_length(action_list) - action_number);
		
	}
	
	with obj_tiles
	{
		// Clear layer before filling
		var tile_data = list[| sel];
		ds_grid_set_region(lr, 0, 0, 31, 31, new ChunkTile(undefined, -1));
		
		for ( var _x = 0; _x < 32;  )
		{
			for ( var _y = 0; _y < 32;  )
			{	
				lr[# _x, _y] = new ChunkTile(sel, 15 - obj_tileheight.sel);
				_y += tile_data.size.y;
			}
			
			_x += tile_data.size.x;
		}
	}
	
	with obj_interface chunk_compile(chunk_get_key());
}