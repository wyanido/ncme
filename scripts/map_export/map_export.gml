
function map_export()
{
	var save_path = get_save_filename_ext("NCME Map File|*.ncmap", "", working_directory, "Save Map");
	if save_path == "" return;
	
	var save_buff = buffer_create(512, buffer_grow, 1);
	
	for ( var c = ds_map_find_first(global.chunk); c < ds_map_size(global.chunk); c = ds_map_find_next(global.chunk, c) )
	{
		buffer_write(save_buff, buffer_string, string(global.chunk[? c].pos_x) + "," + string(global.chunk[? c].pos_y));
			
		for ( var l = 0; l < 8; l ++ )
		{
			var layer_string = "";

			for(var _x = 0; _x < 32; _x ++)
			{
				for(var _y = 0; _y < 32; _y ++)
				{
					var this_tile = global.chunk[? c].layers[| l].tiles[# _x, _y];
					if this_tile.type != undefined
					{
						var z = string_length(this_tile.z) == 1 ? "0" + string(this_tile.z) : string(this_tile.z);
						layer_string += z + string(this_tile.type) + ".";
					}
					else
					{
						layer_string += "x";
					}
				}
			}
			
			if layer_string == ""
				buffer_write(save_buff, buffer_string, "NONE");
			else
				buffer_write(save_buff, buffer_string, layer_string);
		}
	}
	
	buffer_write(save_buff, buffer_string, "END");
	var compressed = buffer_compress(save_buff, 0, buffer_tell(save_buff));
	
	buffer_save(compressed, save_path);
	buffer_delete(save_buff);
	buffer_delete(compressed);
}