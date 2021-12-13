function chunk_compile(this_chunk)
{
	// Delete existing mesh if necessary
	if chunk_mesh[? this_chunk] != undefined
		vertex_delete_buffer(chunk_mesh[? this_chunk]);

	var this_mesh = vertex_create_buffer();
	vertex_begin(this_mesh, global.vformat);
	
	var tiles_placed = 0;	
	
	for ( var l = 0; l < 8; l ++ ) {
		for ( var _x = 0; _x < 32; _x ++ ) {
			for ( var _y = 0; _y < 32; _y ++ ) {
				var this_tile = chunk[? this_chunk].layers[| l].tiles[# _x, _y];
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
							// Repeat texture
							var	uv_w = uvs[2] - uvs[0],
									uv_h = uvs[3] - uvs[1];
							
							var	fac_x = (_x mod 4) * (uv_w / 4),
									fac_y = (_y mod 4) * (uv_h / 4);
									
							uvs[0] += fac_x;
							uvs[1] += fac_y;
							uvs[3] = uvs[1] + (uv_w / 4);
							uvs[2] = uvs[0] + (uv_h / 4);
							
							vertex_quad(this_mesh, px, py, px + 16, py + 16, pz, uvs, c_white, 1);
						}
						else vertex_quad(this_mesh, px, py, px + 16, py + 16, pz, uvs, c_white, 1);
					break;
				}
			}
		}
	}
			
	vertex_end(this_mesh);
	
	if tiles_placed == 0 
	{
		vertex_delete_buffer(this_mesh);
		chunk_mesh[? this_chunk] = undefined;
	}
	else 
	{
		show_debug_message(vertex_get_number(this_mesh));
		
		vertex_freeze(this_mesh);	
		chunk_mesh[? this_chunk] = this_mesh;
	}
}