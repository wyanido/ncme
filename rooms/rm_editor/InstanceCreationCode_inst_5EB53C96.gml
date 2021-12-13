
label = ">";

onUpdate = function()
{
	hidden = global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		chunk_selected.x ++;
	
		if is_undefined(chunk[? chunk_get_key()])
			chunk_fill_empty();
	}
}