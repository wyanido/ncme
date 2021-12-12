
function file_set_buffer(srcbuff, srcfile) 
{
	
	var vbuff;
	file_get_vertices(vbuff, srcfile, matrix_build_identity(), new vec3(1, 1, 1), new vec3(0, 0, 0), new vec2(0, 0), new vec2(0, 0), -1);
	
}
