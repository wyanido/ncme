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
								if (_x + _xx > 31) || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y].type == undefined || tile_list[| chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y)) != -1 || (_x + _xx) mod 4 == 0 || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y].z != chunk[? this_chunk].layers[| this_layer].tiles[# _x, _y].z
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
									if (_y + _yy > 31)  || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y + _yy].type == undefined || tile_list[| chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y + _yy].type].type != "grass" || ds_list_find_index(skiplist, string(_x + _xx) + "," + string(_y + _yy)) != -1 || (_y + _yy) mod 4 == 0 || chunk[? this_chunk].layers[| this_layer].tiles[# _x + _xx, _y + _yy].z != chunk[? this_chunk].layers[| this_layer].tiles[# _x, _y].z
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
		
		if chunk[? this_chunk].render_cache[this_layer] != undefined
				sprite_delete( chunk[? this_chunk].render_cache[this_layer]);
		
		chunk[? this_chunk].render_cache[this_layer] = undefined;
		return;
	}
	else 
	{
		vertex_freeze(this_mesh);	
		
		if !surface_exists(surf_layercache)
			surf_layercache = surface_create(72, 72);

		surface_set_target(surf_layercache);
		draw_clear_alpha(c_black, 0);
	
		var view_mat = matrix_build_lookat(256, 256, 1600, 256, 256, 0, 0, 1, 0);
		var proj_mat = matrix_build_projection_ortho(-512, 512, 1, 16000);
		
		camera_set_view_mat(0, view_mat);
		camera_set_proj_mat(0, proj_mat);

		camera_apply(0);

		vertex_submit(this_mesh, pr_trianglelist, sprite_get_texture(tx_grass, 0));
	
		surface_reset_target();
		if  chunk[? this_chunk].render_cache[this_layer] != undefined
			sprite_delete(chunk[? this_chunk].render_cache[this_layer]);
	
		chunk[? this_chunk].render_cache[this_layer] = sprite_create_from_surface(surf_layercache, 0, 0, 72, 72, false, false, 0, 0);
		
		vertex_delete_buffer(this_mesh);

	}
}