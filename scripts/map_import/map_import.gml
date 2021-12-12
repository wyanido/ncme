
function map_import()
{
	var load_path = get_open_filename_ext("Carbon Map File|*.pcbmap", "", working_directory, "Load Map");
				
	if(load_path != "")	// -- If Operation Not Cancelled
	{
		var buff = buffer_load(load_path);
		var decmp = buffer_decompress(buff);
		buffer_seek(decmp, buffer_seek_start, 0);
		var chunkstring = "";
		
		while(chunkstring != "END")	// Read Chunks until marked "END" position
		{
			var chunkstring = buffer_read(decmp, buffer_string);
			
			if(chunkstring != "END")
			{
				
				var char = 1, tile_index = 0, coordlen = 0;
				
				// -- Read Chunk Coordinates
				while(string_char_at(chunkstring, char + coordlen) != ",") coordlen ++;
				var _cx = string_copy(chunkstring, char, coordlen);
				
				char += coordlen + 1;
				coordlen = 0;
				
				while(string_char_at(chunkstring, char + coordlen) != "|") coordlen ++;
				var _cy = string_copy(chunkstring, char, coordlen);
				
				char += coordlen + 1;
				
				for(var l = 0; l < 8; l ++)
				{
					
					if(string_copy(chunkstring, char, 5) == "EMPTY")
					{
						if(obj_interface.map_data.chunk[? _cx + "," + _cy] == undefined) obj_interface.map_data.chunk[? _cx + "," + _cy] = new Chunk(real(_cx), real(_cy));
						
						ds_grid_set_region(obj_interface.map_data.chunk[? _cx + "," + _cy].layers[| l].tiles, 0, 0, 31, 31, new ChunkTile(tile.none, 15));
						
						char += 6;
						continue;
					}
					
					tile_index = 0;

					while(string_char_at(chunkstring, char) != ":")
					{
						var _z = string_copy(chunkstring, char, 2);
				
						var IDlen = 1;
						while (string_char_at(chunkstring, char + 2 + IDlen) != "-") IDlen ++;
						var _h = string_copy(chunkstring, char + 2, IDlen);
					
						if(obj_interface.map_data.chunk[? _cx + "," + _cy] == undefined) obj_interface.map_data.chunk[? _cx + "," + _cy] = new Chunk(real(_cx), real(_cy));
						obj_interface.map_data.chunk[? _cx + "," + _cy].layers[| l].tiles[# floor(tile_index / 32), tile_index mod 32] = new ChunkTile(real(_h), real(_z));
					
						char += 3 + IDlen;
						tile_index ++;
					}
					
					char ++;
					
				}	
			}
		}
		
		buffer_delete(decmp);
		buffer_delete(buff);
					
		obj_interface.refresh_map = true;
	}
}