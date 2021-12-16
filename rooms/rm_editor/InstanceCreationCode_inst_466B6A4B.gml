
label = "Flood Layer";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with obj_tiles
	{
		if !ds_map_exists(global.chunk, chunk_get_key())
				global.chunk[? chunk_get_key()] = new Chunk(obj_interface.chunk_selected.x, obj_interface.chunk_selected.y);
		
		var lr = global.chunk[? chunk_get_key()].layers[obj_layers.sel];
		
		// Clear layer before filling
		var tile_data = list[| sel]
		ds_grid_set_region(lr.tiles, 0, 0, 31, 31, new ChunkTile(undefined, -1));
		
		for ( var _x = 0; _x < 32;  )
		{
			for ( var _y = 0; _y < 32;  )
			{	
				lr.tiles[# _x, _y] = new ChunkTile(sel, 15 - obj_interface.z_selected);
				_y += tile_data.size.y;
			}
			
			_x += tile_data.size.x;
		}
	}
	
	
	with obj_interface
	{
		array_insert(actionlist, action_number, {
			chunk: chunk_get_key() ,
			layer: obj_layers.sel, 
			x: 0, 
			y: 0,
			x2: 31,
			y2: 31
			from: { 
				type: global.chunk[? chunk_get_key()].layers[obj_layers.sel].tiles[# mgrid_x, mgrid_y].type,
				z: global.chunk[? chunk_get_key()].layers[obj_layers.sel].tiles[# mgrid_x, mgrid_y].z
			},
			to: { 
				type: set_tile.type,
				z: set_tile.z
			}
		})
				
		action_number ++;
				
		chunk_compile(chunk_get_key());
	}
}