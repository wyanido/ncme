
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
		var action = actionlist[action_number];
		show_debug_message(action);
		
		global.chunk[? action.chunk].layers[action.layer].tiles[# action.x, action.y] = new ChunkTile(action.from.type, action.from.z);
		
		layer_compile(action.chunk, action.layer);
	}
}