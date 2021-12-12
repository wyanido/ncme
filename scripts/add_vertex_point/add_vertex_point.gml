
function add_vertex_point(matrix, buff, _x, _y, _z, nx, ny, nz, col, a, u, v) 
{
	var coords = matrix_transform_vertex(matrix, _x, _y, _z);
	
	vertex_position_3d(buff, coords[0], coords[1], coords[2]);
	vertex_color(buff, col, a);
	vertex_texcoord(buff, u, v);
}
