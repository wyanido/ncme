function hmap_compile_mesh(chunk)
{
	// Delete existing mesh
	if (!is_undefined(global.heightmap_cache[? chunk])) {
		vertex_delete_buffer(global.heightmap_cache[? chunk]);
	}
	
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	var vf = vertex_format_end();
	
	var vb = vertex_create_buffer();
	vertex_begin(vb, vf);
	
	var sz = CHUNK_SIZE * 2;
	
	for ( var _y = 0; _y < sz; _y += 2 ) { 
		for ( var _x = 0; _x < sz; _x += 2 ) {
			var	rx = _x / 2,
					ry = _y / 2,
					rz_tl = global.heightmap[? chunk][# _x, _y],
					rz_tr = global.heightmap[? chunk][# _x + 1, _y],
					rz_bl = global.heightmap[? chunk][# _x, _y + 1],
					rz_br = global.heightmap[? chunk][# _x + 1, _y + 1],
					a = 0.25,
					c = c_purple;
			
			vertex_position_3d(vb, rx, ry, rz_tl);
			vertex_colour(vb, c, a);
			vertex_position_3d(vb, rx + 1, ry, rz_tr);
			vertex_colour(vb, c, a);
			vertex_position_3d(vb, rx, ry + 1, rz_bl);
			vertex_colour(vb, c, a);
			
			vertex_position_3d(vb, rx + 1, ry, rz_tr);
			vertex_colour(vb, c, a);
			vertex_position_3d(vb, rx + 1, ry + 1, rz_br);
			vertex_colour(vb, c, a);
			vertex_position_3d(vb, rx, ry + 1, rz_bl);
			vertex_colour(vb, c, a);
		}
	}
		
	vertex_end(vb);
	vertex_freeze(vb);
	global.heightmap_cache[? chunk] = vb;
}