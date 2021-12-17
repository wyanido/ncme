
label = "Redo";

onUpdate = function()
{
	active = obj_interface.action_number < array_length(obj_interface.action_list);
}

onClick = function()
{
	with obj_interface
	{
		var action = action_list[action_number];
		action_number ++;
		
		switch action.type
		{
			case "tile":
				global.chunk[? action.chunk].layers[action.layer].tiles[# action.x, action.y] = new ChunkTile(action.to.type, action.to.z);
			break;
			case "layer":
				ds_grid_set_region(global.chunk[? action.chunk].layers[action.layer].tiles, 0, 0, 31, 31, new ChunkTile(action.to.type, 15 - action.to.z));
			break;
			case "layer_adjust":
				ds_grid_copy(global.chunk[? action.chunk].layers[action.layer].tiles, action.to);
			break;
		}

		layer_compile(action.chunk, action.layer);
	}
}