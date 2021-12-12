
function file_get_buffer(srcfile) 
{
	var vbuff = vertex_create_buffer();
	var vfile = buffer_load(srcfile);
	var decmp = buffer_decompress(vfile);
	
	buffer_copy_from_vertex_buffer(decmp, 0, vertex_get_number(decmp), vbuff, 0);
	
	buffer_delete(vfile);
	buffer_delete(decmp);
	
	vertex_end(vbuff);
	vertex_freeze(vbuff);
	
	return vbuff;
}
