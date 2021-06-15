
// --- Load Model from File
function file_get_vertices(targetbuffer, srcfile, matrix, s, pos, UVshift, UVscale, srctex) {

	var file = file_text_open_read(srcfile);
	var version = file_text_read_real(file);
	var txd = new vec2(sprite_get_width(srctex) / 16, sprite_get_height(srctex) / 16);

	if (version != 100) {
		show_message("Wrong version of the model file!");
		file_text_close(file);
		return -1;
	}

	var n = file_text_read_real(file);
	file_text_readln(file);

	var line = array_create(10, 0);

	for (var i = 0; i < n; i++){
		for (var j = 0; j < 11; j++){
			line[j] = file_text_read_real(file);
		}
		var type = line[0];
		switch (type){
			case 0:
				// ignore this (primitive start)
				break;
			case 1:
				// ignore this (primitive end)
				break;
			case 2:	// vertex position
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix, targetbuffer, xD, yD, zD, 0, 0, 0, c_white, 1, 0, 0);
				break;
			case 3:	// vertex position, color
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var color = line[4];
				var alpha = line[5];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, 0, 0, 0, color, alpha, 0, 0);
				break;
			case 4:	// vertex position, texture
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var xtex = line[4] / txd.x;
				var ytex = line[5] / txd.y;
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, 0, 0, 0, c_white, 1, xtex * UVscale.x + (UVshift.x / txd.x), ytex * UVscale.y + (UVshift.y / txd.y));
				break;
			case 5:	// vertex position, texture, color
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var xtex = line[4] / txd.x;
				var ytex = line[5] / txd.y;
				var color = line[6];
				var alpha = line[7];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, 0, 0, 0, color, alpha, xtex * UVscale.x + (UVshift.x / txd.x), ytex * UVscale.y + (UVshift.y / txd.y));
				break;
			case 6:	// vertex position, normal
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var nx = line[4];
				var ny = line[5];
				var nz = line[6];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, nx, ny, nz, c_white, 1, 0, 0);
				break;
			case 7:	// vertex position, normal, color
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var nx = line[4];
				var ny = line[5];
				var nz = line[6];
				var color = line[7];
				var alpha = line[8];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, nx, ny, nz, color, alpha, 0, 0);
				break;
			case 8:	// vertex position, normal, texture
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var nx = line[4];
				var ny = line[5];
				var nz = line[6];
				var xtex = line[7] / txd.x;
				var ytex = line[8] / txd.y;
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, nx, ny, nz, xtex * UVscale.x + (UVshift.x / txd.x), ytex * UVscale.y + (UVshift.y / txd.y), 0, 0);
				break;
			case 9:	// vertex position, normal, texture, color
				var xx = line[1];
				var yy = line[2];
				var zz = line[3];
				var nx = line[4];
				var ny = line[5];
				var nz = line[6];
				var xtex = line[7] / txd.x;
				var ytex = line[8] / txd.y;
				var color = line[9];
				var alpha = line[10];
				
				var xD = ((xx * 16)) * s.x + pos.x;
				var yD = ((yy * 16)) * s.y + pos.y;
				var zD = ((zz * 16)) * s.z + pos.z;
				add_vertex_point(matrix,  targetbuffer, xD, yD, zD, nx, ny, nz, color, alpha, xtex * UVscale.x + (UVshift.x / txd.x), ytex * UVscale.y + (UVshift.y / txd.y));
				break;
			case 10: // block
				break;
			case 11: // cylinder
				break;
			case 12: // cone
				break;
			case 13: // ellipsoid
				break;
			case 14: // wall
				break;
			case 15: // floor
				break;
		}
	}

	file_text_close(file);
}
