
label = "Undo";

onUpdate = function()
{
	active = obj_interface.action_number > 0;
}

onClick = function()
{
	with obj_interface
	{
		action_number --;
		var action = action_list[action_number];
		
		switch action.type
		{
			case "tile":
				global.chunk[? action.chunk].layers[action.layer].tiles[# action.x, action.y] = new ChunkTile(action.from.type, action.from.z);
			break;
			case "layer":
				ds_grid_copy(global.chunk[? action.chunk].layers[action.layer].tiles, action.from);
			break;
			case "layer_adjust":
				ds_grid_copy(global.chunk[? action.chunk].layers[action.layer].tiles, action.from);
			break;
		}

		layer_compile(action.chunk, action.layer);
	}
}