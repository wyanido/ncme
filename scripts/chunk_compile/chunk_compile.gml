function chunk_compile(this_chunk)
{
	var skiplist = ds_list_create();
	
	for ( var l = 0; l < 8; l ++ ) 
	{
		// Delete existing mesh
		if chunk_mesh[? this_chunk] != undefined
		{
			if chunk_mesh[? this_chunk][l] != undefined
			{
				vertex_delete_buffer(chunk_mesh[? this_chunk][l]);
			}
		}
		else chunk_mesh[? this_chunk] = array_create(8, undefined);

		var this_mesh = vertex_create_buffer();
		vertex_begin(this_mesh, global.vformat);
		
		ds_list_clear(skiplist);
		var tiles_placed = 0;	
	
		for ( var _x = 0; _x < 32; _x ++ ) { 
			for ( var _y = 0; _y < 32; _y ++ ) {
				var this_tile = global.chunk[? this_chunk].layers[l].tiles[# _x, _y];
				if this_tile.type = undefined continue;
	
				var this_type = obj_tiles.list[| this_tile.type];

				switch this_type.model
				{
					default:
						// Load model
						tiles_placed ++;
						
						var uvs = sprite_get_uvs(this_type.tex, 0);	
						var matrix = matrix_build(_x * 16, _y * 16, this_tile.z * 16, 0, 0, 0, 16, 16, 16);
						var rot = this_type[$ "rotation"];
						rot ??= 0;
						
						switch rot
						{
							case 90:
								var matrix = matrix_build(_x * 16, (_y + 1) * 16, this_tile.z * 16, 0, 0, rot, 16, 16, 16);
							break;
							case 180:
								var matrix = matrix_build((_x + 1) * 16, (_y + 1) * 16, this_tile.z * 16, 0, 0, rot, 16, 16, 16);
							break;
							case 270:
								var matrix = matrix_build((_x + 1) * 16, _y * 16, this_tile.z * 16, 0, 0, rot, 16, 16, 16);
							break;
						}
						
						model_load_file(this_mesh, "tiles/" + this_type.model + ".obj", uvs, matrix);
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
								if (_x + _xx > 31) || global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y].type == undefined || obj_tiles.list[| global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y)) != -1 || (_x + _xx) mod 4 == 0 || global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y].z != global.chunk[? this_chunk].layers[l].tiles[# _x, _y].z
								{
									row_width = _xx;
									break;
								}
							}
							
							var largest_column = 4;
							for ( var _xx = 0; _xx < row_width; _xx ++ )
							{
								for ( var _yy = 1; _yy < 4; _yy ++ )
								{
									if (_y + _yy > 31)  || global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y + _yy].type == undefined || obj_tiles.list[| global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y + _yy].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y + _yy)) != -1 || (_y + _yy) mod 4 == 0 || global.chunk[? this_chunk].layers[l].tiles[# _x + _xx, _y + _yy].z != global.chunk[? this_chunk].layers[l].tiles[# _x, _y].z
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
		
		vertex_end(this_mesh);
	
		if tiles_placed == 0 
		{
			vertex_delete_buffer(this_mesh);
			chunk_mesh[? this_chunk][l] = undefined;
		}
		else 
		{
			vertex_freeze(this_mesh);	
			chunk_mesh[? this_chunk][l] = this_mesh;
		}
	}
	
	ds_list_destroy(skiplist);
	chunk_layercache_refresh(this_chunk);
}