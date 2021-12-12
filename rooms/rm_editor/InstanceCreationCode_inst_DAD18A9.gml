
label = "v";

onUpdate = function()
{
	hidden = global.compiled_view;	
}

onClick = function()
{
	with obj_interface
	{
		selChunk.y ++;
	
		if is_undefined(map_data.chunk[? chunk_get_key()])
			chunk_fill_empty();
	}
}