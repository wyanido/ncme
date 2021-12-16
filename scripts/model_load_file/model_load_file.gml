
function model_load_file(vbuff, filename, uvs, matrix, fliptex = true) 
{
	if !is_undefined(global.model_cache[? filename])
	{
		// Load cached model
		var cache = global.model_cache[? filename];
		
		var model_size = ds_list_size(cache);
		for ( var i = 0; i < model_size; i ++)
		{
			var tri = cache[| i];
			
			for ( var j = 0; j < 3; j ++ )
			{
				var new_pos = matrix_transform_vertex(matrix, tri[j].x, tri[j].y, tri[j].z);
				
				var	uv_w = uvs[2] - uvs[0],
						uv_h = uvs[3] - uvs[1];
				
				var ytex = fliptex ? uvs[1] + (1 - tri[j].v) * uv_h : uvs[1] + tri[j].v * uv_h;
				
				vertex_position_3d(vbuff, round(new_pos[0]), round(new_pos[1]), round(new_pos[2]));
				vertex_color(vbuff, c_white, 1);
				vertex_texcoord(vbuff, uvs[0] + tri[j].u * uv_w, ytex);
			}
		}
	}
	else
	{
		// Load model normally and add it to cache
		var tri_cache = ds_list_create();
		
		var obj_file = file_text_open_read(filename);
		
		var vertex_x = ds_list_create();
		var vertex_y = ds_list_create();
		var vertex_z = ds_list_create();

		var vertex_xtex = ds_list_create();
		var vertex_ytex = ds_list_create();
	
		var	uv_w = uvs[2] - uvs[0],
				uv_h = uvs[3] - uvs[1];

		while !file_text_eof(obj_file)
		{
			var line = file_text_read_string(obj_file);
			file_text_readln(obj_file);
		
			var index = 0, terms = array_create(string_count(line, " ") + 1, "");
		
			for ( var i = 1; i <= string_length(line); i++ )
			{
				if (string_char_at(line, i) == " ")
				{
					index++;
					terms[index] = "";
				} else	terms[index] += string_char_at(line, i);
			}
		
			switch terms[0]
			{
				case "v":
					ds_list_add(vertex_x, real(terms[1]));
					ds_list_add(vertex_y, real(terms[2]));
					ds_list_add(vertex_z, real(terms[3]));
				break;
				case "vt":
					ds_list_add(vertex_xtex, real(terms[1]));
					ds_list_add(vertex_ytex, real(terms[2]));
				break;
				case "f":
					ds_list_add(tri_cache, array_create(3, 0));

					for ( var n = 1; n <= 3; n++ )
					{
						var index = 0, data = array_create(string_count(terms[n], "/") + 1, "");
						var len = string_length(terms[n]);
						for ( var i = 1; i <= len; i++ )
						{
							if ( string_char_at(terms[n], i) == "/" )
							{
								index++;
								data[index] = "";
							} 
							else data[index] += string_char_at(terms[n], i);
						}
					
						var xx = ds_list_find_value(vertex_x, real(data[0]) - 1);
						var yy = ds_list_find_value(vertex_y, real(data[0]) - 1);
						var zz = ds_list_find_value(vertex_z, real(data[0]) - 1);
					
						var xtex = vertex_xtex[| real(data[1]) - 1];
						var ytex = vertex_ytex[| real(data[1]) - 1];
						
						var t = yy;
						yy = zz;
						zz = t;

						var new_pos = matrix_transform_vertex(matrix, xx, yy, zz);
						
						vertex_position_3d(vbuff, round(new_pos[0]), round(new_pos[1]), round(new_pos[2]));
						vertex_color(vbuff, c_white, 1);
						vertex_texcoord(vbuff, uvs[0] + xtex * uv_w, fliptex ? uvs[1] + (1.0 - ytex) * uv_h : uvs[1] + ytex * uv_h);
						
						tri_cache[| ds_list_size(tri_cache) - 1][n - 1] = { x: xx, y: yy, z: zz, u: xtex, v: ytex }
					}
				break;
			}
		}
	
		ds_list_destroy(vertex_x);
		ds_list_destroy(vertex_y);
		ds_list_destroy(vertex_z);
		ds_list_destroy(vertex_xtex);
		ds_list_destroy(vertex_ytex);

		file_text_close(obj_file);
		
		global.model_cache[? filename] = tri_cache;
	}
}