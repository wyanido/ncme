function tile_compile(tile_type)
{
	var this_mesh = vertex_create_buffer();
	vertex_begin(this_mesh, global.vformat);

	switch tile_type.model
	{
		default:
			// Load model
			var uvs = sprite_get_uvs(tile_type.tex, 0);	
			var matrix = matrix_build(0, 0, 0, 0, 0, 0, 16, 16, 16);
			var rot = tile_type[$ "rotation"];
			rot ??= 0;
						
			switch rot
			{
				case 90:
					var matrix = matrix_build(0, 16, 0, 0, 0, rot, 16, 16, 16);
				break;
				case 180:
					var matrix = matrix_build(16, 16, 0, 0, 0, rot, 16, 16, 16);
				break;
				case 270:
					var matrix = matrix_build(16, 0, 0, 0, 0, rot, 16, 16, 16);
				break;
			}
						
			model_load_file(this_mesh, tile_type.model + ".obj", uvs, matrix);
		break;
		case "plane":	
			var uvs = sprite_get_uvs(tile_type.tex, 0);
			
			if tile_type.type == "grass"
			{
				var	ext_x = 16,
						ext_y = 16;

				// Repeat texture
				var	uv_w = uvs[2] - uvs[0],
						uv_h = uvs[3] - uvs[1];
							
				var	fac_x = 0,
						fac_y = 0;
									
				uvs[0] += fac_x;
				uvs[1] += fac_y;
				uvs[3] = uvs[1] + (uv_h / 4);
				uvs[2] = uvs[0] + (uv_w / 4);
							
				vertex_quad(this_mesh, 0, 0, ext_x, ext_y, 0, uvs, c_white, 1);
			}
			else vertex_quad(this_mesh, 0, 0, 16, 16, 0, uvs, c_white, 1);
		break;
	}
	
	vertex_end(this_mesh);
	vertex_freeze(this_mesh);
	return this_mesh;
}