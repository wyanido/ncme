
function map_export()
{
	var save_path = get_save_filename_ext("Carbon Map File|*.pcbmap", "", working_directory, "Save Map");
				
	if(save_path != "")	// -- If Operation Not Cancelled
	{
		var save_buff = buffer_create(16, buffer_grow, 1);	// -- Dynamic Buffer
		var chk = obj_interface.chunk;
		var chunkcount = 0;
		
		// -- Iterate through all chunk DS Map entries
		for(var _c = ds_map_find_first(chk); _c < ds_map_size(chk); _c = ds_map_find_next(chk, _c))
		{
			
			// -- Make sure the chunk isn't empty before attempting to save
			var tilecount = 0;
			for(var l = 0; l < 8; l ++)	// -- Each Layer of the Chunk
			{
				for(var _x = 0; _x < 32; _x ++)
				{
					for(var _y = 0; _y < 32; _y ++)
					{
						tilecount += chk[? _c].layers[| l].tiles[# _x, _y].type;	// -- Tile Type
					}
				}
			}
			if(tilecount == 0) continue;
			
			// -- Start Chunk String with coords, e.g. "0,0|"
			var chunkstring = string(chk[? _c].pos_x) + "," + string(chk[? _c].pos_y) + "|";
			
			for(var l = 0; l < 8; l ++)	// -- Each Layer of the Chunk
			{
				
				// -- Make sure the layer isn't empty before saving it
				tilecount = 0;
				for(var _x = 0; _x < 32; _x ++)
				{
					for(var _y = 0; _y < 32; _y ++)
					{
						tilecount += chk[? _c].layers[| l].tiles[# _x, _y].type;	// -- Tile Type
					}
				}
				if(tilecount == 0) { chunkstring += "EMPTY:"; continue; }
				
				for(var _x = 0; _x < 32; _x ++)
				{
					for(var _y = 0; _y < 32; _y ++)
					{
						// -- Example layer string: "081-151-311-201-031- ..."
						var n = string(chk[? _c].layers[| l].tiles[# _x, _y].type);	// -- Tile Type
						var zz = string(chk[? _c].layers[| l].tiles[# _x, _y].z);		// -- Tile Z-Index
					
						if(string_length(zz) == 1) zz = "0" + zz;
						chunkstring += zz + n + "-";
					}
				}
				
				chunkstring += ":";
			}
			
			buffer_write(save_buff, buffer_string, chunkstring);
			chunkcount ++;
		}
		
		buffer_write(save_buff, buffer_string, "END");
		
		if(chunkcount)
		{
			var cmp = buffer_compress(save_buff, 0, buffer_tell(save_buff));
			buffer_save(cmp, save_path);
			buffer_delete(cmp);
		} else {
			show_message("You can't save an empty map!");	
		}
		
		buffer_delete(save_buff);
	}
}