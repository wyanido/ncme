
label = "Undo";
icon = ui_undo;

onUpdate = function()
{
	active = obj_interface.action_number > 0 && !global.viewport_is_3d;
}

onClick = function()
{
	with (obj_interface)
	{
		action_number --;
		var action = action_list[action_number];
		
		ds_grid_copy(global.chunk[? action.chunk].layers[action.layer].tiles, action.from);

		layer_compile(action.chunk, action.layer);
	}
}