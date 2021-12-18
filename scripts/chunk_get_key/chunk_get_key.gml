
function chunk_get_key(xpos = obj_interface.chunk_selected.x, ypos = obj_interface.chunk_selected.y)
{
	return string(xpos) + "," + string(ypos);
}