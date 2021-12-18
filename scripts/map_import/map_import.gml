
function map_import()
{
	var load_path = get_open_filename_ext("NCME Map File|*.ncmap", "", working_directory, "Load Map");
	if load_path == "" return;
	
	var buff_compressed = buffer_load(load_path);
	var save_buff = buffer_decompress(buff_compressed);
	
	// Clear current map
	ds_map_clear(global.chunk);
	global.chunk[? "0,0"] = new Chunk(0, 0);
	
	obj_interface.action_list = [ ];
	action_number = 0;

	var str_chunk = "";
	while true
	{
		var str_chunk = buffer_read(save_buff, buffer_string);
		if str_chunk == "END" break;
		
		// Chunk coordinates
		var index = 0, coord_len = 1;
		while string_char_at(str_chunk, index + coord_len) != "," coord_len ++;
		var chunk_x = string_copy(str_chunk, index, coord_len - 1);
		var chunk_y = string_copy(str_chunk, index + 1 + coord_len, string_length(str_chunk) - index - 1);
		
		index += coord_len + 1;
		
		var chunk_key = chunk_x + "," + chunk_y;
		global.chunk[? chunk_key] = new Chunk(real(chunk_x), real(chunk_y));		
		
		// Read layers
		for ( var l = 0; l < 8; l ++ )
		{	
			var str_layers = buffer_read(save_buff, buffer_string);
			
			if str_layers == "NONE"
			{
				ds_grid_set_region(global.chunk[? chunk_key].layers[l].tiles, 0, 0, 31, 31, new ChunkTile(undefined, -1));
				continue;
			}
			
			var tile_index = 0, char_index = 1;
			while char_index < string_length(str_layers)
			{
				var	xx = floor(tile_index / 32),
						yy = floor(tile_index mod 32);
				
				if string_copy(str_layers, char_index, 1) == "x"
				{
					global.chunk[? chunk_key].layers[l].tiles[# xx, yy] = new ChunkTile(undefined, -1);
					tile_index ++;
					char_index ++;
					continue;
				}
				
				var tile_z = string_copy(str_layers, char_index, 2);
				char_index += 2;

				var type_len = 1;
				while string_char_at(str_layers, char_index + type_len) != "." type_len ++;
				
				var str_type = string_copy(str_layers, char_index, type_len);

				global.chunk[? chunk_key].layers[l].tiles[# xx, yy] = new ChunkTile(str_type, real(tile_z));
					
				char_index += type_len + 1;
				tile_index ++;
			}
		}
	}
		
	//buffer_delete(buff_compressed);
	buffer_delete(save_buff);
	
	// Compile all chunks
	for ( var c = ds_map_find_first(global.chunk); c < ds_map_size(global.chunk); c = ds_map_find_next(global.chunk, c) )
	{
		chunk_compile(c);
	
		for ( var l = 0; l < 8; l ++ )
		{
			chunk_layercache_refresh(c, l)
		}
	}
}