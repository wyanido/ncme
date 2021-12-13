
function create_grid_model(chunkCount)
{
	// Vertex Format
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_colour();
	vformat = vertex_format_end();
	
	// Line Creation Function
	function add_vertex_line(x1, y1, z1, x2, y2, z2, col, a)
	{
		vertex_position_3d(g, x1, y1, z1);
		vertex_colour(g, col, a);
	
		vertex_position_3d(g, x2, y2, z2);
		vertex_colour(g, col, a);
	}
	
	// -- Grid Parameters
	var cc = chunkCount;	// Number of chunks to render
	var cmax = 256 * cc;		// Max Span of Chunks
	var tmax = cc * 16 / 2;	// Max Span of Tiles
	
	// --- Create Vertex Model
	g = vertex_create_buffer();
	vertex_begin(g, vformat);

	add_vertex_line(0, 0, -496, 0, 0, 496, 0xF46653, 1);			// Z Axis Indicator
	add_vertex_line(0, -cmax, 0, 0, cmax, 0, 0x98E853, 1);	// Y Axis Indicator
	add_vertex_line(-cmax, 0, 0, cmax, 0, 0, 0x714AE8, 1);	// X Axis Indicator

	// -- Draw Chunk Borders
	for(var _x = -cc / 2; _x <= cc / 2; _x ++) { if _x != 0 add_vertex_line(_x * 512, -cmax, 0, _x * 512, cmax, 0, c_white, 0.5); }
	for(var _y = -cc / 2; _y <= cc / 2; _y ++) { if _y != 0 add_vertex_line(-cmax, _y * 512, 0, cmax, _y * 512, 0, c_white, 0.5); }
	
	// -- Draw Tile Borders
	for(var _x = -tmax * 2; _x < tmax * 2; _x ++)  {
		if(_x != 0 && _x mod 32 != 0) {
			add_vertex_line(_x * 16, -cmax, 0, _x * 16, cmax, 0, 0xA38080, 0.25);
	}	}
	
	for(var _y = -tmax * 2; _y < tmax * 2; _y ++) {
		if(_y != 0 &&  _y mod 32 != 0) {
			add_vertex_line(-cmax, _y * 16, 0, cmax, _y * 16, 0, 0xA38080, 0.25);
	}	}

	vertex_end(g);
	vertex_freeze(g);

	return g;
}