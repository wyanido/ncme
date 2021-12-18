
label = "Smart Tiles";

onUpdate = function()
{
	active = !global.viewport_3d;	
}

onClick = function()
{
	with obj_interface
	{
		// Log tile changes
		var action_log = {
			chunk: chunk_get_key() ,
			layer: obj_layers.sel, 
			type: "layer_adjust",
			from: ds_grid_create(32, 32),
			to: ds_grid_create(32, 32)
		}
		
		var lr = chunk_get_tiles(obj_interface.chunk_selected.x, obj_interface.chunk_selected.y, obj_layers.sel);

		ds_grid_copy(action_log.from, lr);
		
		var	neighbours = ds_grid_create(3, 3);
		
		for(var _x = 0; _x < 32; _x ++)
		{
			for(var _y = 0; _y < 32; _y ++)
			{
				if lr[# _x, _y].type == undefined continue;
				var tile_type = obj_tiles.list[| lr[# _x, _y].type].type;
				if tile_type != "grass_path" continue;

				// Find adjacent tiles
				for ( var _xx = -1; _xx < 2; _xx ++ )
				{
					for ( var _yy = -1; _yy < 2; _yy ++ )
					{
						if (_xx == 0 && _yy == 0)
						{
							neighbours[# _xx + 1, _yy + 1] = 0;
							continue;
						}
						else if (_x + _xx < 0) || (_x + _xx > 31) || (_y + _yy < 0) || (_y + _yy > 31)
						{
							neighbours[# _xx + 1, _yy + 1] = 1;
							continue;
						}
						
						if lr.tiles[# _x + _xx, _y + _yy].type == undefined
							neighbours[# _xx + 1, _yy + 1] = false;
						else
							neighbours[# _xx + 1, _yy + 1] = obj_tiles.list[| lr[# _x + _xx, _y + _yy].type].type == "grass_path";
					}
				}

				// Determine tile type
				var set_tile = undefined;
				
				if neighbours[# 1, 0] == 0 && neighbours[# 2, 0] == 0 && neighbours[# 2, 1] == 0
					set_tile = "northeast";
				else if neighbours[# 1, 2] == 0 && neighbours[# 2, 2] == 0 && neighbours[# 2, 1] == 0
					set_tile = "southeast";
				else if neighbours[# 1, 2] == 0 && neighbours[# 0, 2] == 0 && neighbours[# 0, 1] == 0
					set_tile = "southwest";
				else if neighbours[# 0, 0] == 0 && neighbours[# 1, 0] == 0 && neighbours[# 0, 1] == 0
					set_tile = "northwest";
				else if neighbours[# 1, 0] == 0
					set_tile = "north";
				else if neighbours[# 2, 1] == 0
					set_tile = "east";
				else if neighbours[# 1, 2] == 0
					set_tile = "south";
				else if neighbours[# 0, 1] == 0
					set_tile = "west";
				else if ds_grid_get_sum(neighbours, 0, 0, 2, 2) == 7 && !neighbours[# 2, 0]
					set_tile = "northeast_in";
				else if ds_grid_get_sum(neighbours, 0, 0, 2, 2) == 7 && !neighbours[# 2, 2]
					set_tile = "southeast_in";
				else if ds_grid_get_sum(neighbours, 0, 0, 2, 2) == 7 && !neighbours[# 0, 2]
					set_tile = "southwest_in";
				else if ds_grid_get_sum(neighbours, 0, 0, 2, 2) == 7 && !neighbours[# 0, 0]
					set_tile = "northwest_in";
				else
					set_tile = "center";
					
				// Apply tile
				var this_z = lr[# _x, _y].z;

				if set_tile != undefined
				{
					for ( var i = 0; i < ds_list_size(obj_tiles.list); i ++)
					{
						if obj_tiles.list[| i].type == "grass_path"
						{
							if obj_tiles.list[| i].direction == set_tile
							{
								// Apply directional change
								lr[# _x, _y] = new ChunkTile(i, this_z);
								break;
							}
						}
					}
				}
			}
		}
		
		ds_grid_copy(action_log.to, lr);
		
		array_insert(action_list, action_number, action_log);
		action_number ++;
		
		array_delete(action_list, action_number, array_length(action_list) - action_number);
		
		ds_grid_destroy(neighbours);
		chunk_compile(chunk_get_key());
	}
}