function layer_cache_refresh(this_chunk, this_layer)
{
	var this_mesh = vertex_create_buffer();
	vertex_begin(this_mesh, global.vformat);
	
	var tiles_placed = 0;
	var skiplist = ds_list_create();
	
	for ( var _x = 0; _x < 32; _x ++ ) 
	{
		for ( var _y = 0; _y < 32; _y ++ ) 
		{
			var this_tile = chunk[? this_chunk].layers[| this_layer].tiles[# _x, _y];
			if this_tile.type = undefined continue;
			
			var this_type = tile_list[| this_tile.type];

			switch this_type.model
			{
				default:
					// Load model
					tiles_placed ++;
						
					var uvs = sprite_get_uvs(this_type.tex, 0);	
					var matrix = matrix_build(_x * 16, _y * 16, this_tile.z * 16, 0, 0, 0, 16, 16, 16);
						
					model_load_file(this_mesh, this_type.model + ".obj", uvs, matrix);
				break;
				case "plane":
					tiles_placed ++;
						
					var px = _x * 16, py = _y * 16, pz = this_tile.z * 16;
					var uvs = sprite_get_uvs(this_type.tex, 0);

					if this_type.type == "grass"
					{
						if ds_list_find_index(skiplist, string(_x) + "," + string(_y)) != -1 continue;
							
						// Greedy meshing
						var row_width = 4;
						for ( var _xx = 1; _xx < row_width; _xx ++ )
						{
							if (_x + _xx > 31) || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y].type == undefined || tile_list[| chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y)) != -1 || (_x + _xx) mod 4 == 0
							{
								row_width = _xx;
							}
						}
							
						var largest_column = 4;
						for ( var _xx = 0; _xx < row_width; _xx ++ )
						{
							for ( var _yy = 1; _yy < 4; _yy ++ )
							{
								if (_y + _yy > 31)  || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y + _yy].type == undefined || tile_list[| chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y + _yy].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y + _yy)) != -1 || (_y + _yy) mod 4 == 0
								{
									largest_column = min(largest_column, _yy);
								}
							}
						}
							
						for ( var _xx = 0; _xx < row_width; _xx ++ )
						{
							for ( var _yy = 0; _yy < largest_column; _yy ++ )
							{
								ds_list_add(skiplist, string(_x + _xx) + "," + string(_y + _yy));
							}
						}
							
						var	ext_x = 16 * row_width,
								ext_y = 16 * largest_column;

						// Repeat texture
						var	uv_w = uvs[2] - uvs[0],
								uv_h = uvs[3] - uvs[1];
							
						var	fac_x = (_x mod 4) * (uv_w / 4),
								fac_y = (_y mod 4) * (uv_h / 4);
									
						uvs[0] += fac_x;
						uvs[1] += fac_y;
						uvs[3] = uvs[1] + (uv_h / 4) * largest_column;
						uvs[2] = uvs[0] + (uv_w / 4) * row_width;
							
						vertex_quad(this_mesh, px, py, px + ext_x, py + ext_y, pz, uvs, c_white, 1);
					}
					else vertex_quad(this_mesh, px, py, px + 16, py + 16, pz, uvs, c_white, 1);
				break;
			}
		}
	}
	
	ds_list_destroy(skiplist);
	vertex_end(this_mesh);
	
	if tiles_placed == 0
	{
		vertex_delete_buffer(this_mesh);
		return "cleared_layer";
	}
	else 
	{
		vertex_freeze(this_mesh);	
		return this_mesh;
	}
}