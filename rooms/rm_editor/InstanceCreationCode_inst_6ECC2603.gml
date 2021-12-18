
label = "Undo";
icon = ui_undo;

onUpdate = function()
{
	active = obj_interface.action_number > 0 && !global.viewport_3d;
}

onClick = function()
{
	with obj_interface
	{
		action_number --;
		var action = action_list[action_number];
		
		switch action.type
		{
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