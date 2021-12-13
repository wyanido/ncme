function vertex_quad(vbuff, x1, y1, x2, y2, z, uv, col, alpha)
{
	// Tri 1
	vertex_position_3d(vbuff, x1, y1, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[0], uv[1]);
						
	vertex_position_3d(vbuff, x2, y1, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[2], uv[1]);
						
	vertex_position_3d(vbuff, x1, y2, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[0], uv[3]);
						
	// Tri 2
	vertex_position_3d(vbuff, x2, y1, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[2], uv[1]);
						
	vertex_position_3d(vbuff, x2, y2, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[2], uv[3]);
						
	vertex_position_3d(vbuff, x1, y2, z);
	vertex_colour(vbuff, col, alpha);
	vertex_texcoord(vbuff, uv[0], uv[3]);
}