/// -- @desc Render viewport
// Iterate through chunks to render
for ( var c = ds_map_find_first(global.chunk); c < ds_map_size(global.chunk); c = ds_map_find_next(global.chunk, c) )
{
	var cchunk = chunk_mesh[? c];
	
	if ( is_undefined(cchunk) || !is_array(cchunk)) { 
		continue;
	}
	
	// Get real position of chunk
	var	pos_x = global.chunk[? c].pos_x * 512,
			pos_y = global.chunk[? c].pos_y * 512;
	
	for ( var l = 0; l < 8; l ++ )
	{
		// Layer mesh
		var lmesh = cchunk[l];
		
		if (is_undefined(lmesh)) {
			continue;	
		}
		
		matrix_set(matrix_world, matrix_build(pos_x, pos_y, 0, 0, 0, 0, 1, 1, 1));
		vertex_submit(cchunk[l], pr_trianglelist, global.tex_world);
		
		if (global.heightmap_visible) 
		{
			var	hmap = global.heightmap_cache[? c];
			
			if (!is_undefined(hmap)) 
			{
				// Render heightmap on top of mesh
				gpu_set_ztestenable(false);
				
				matrix_set(matrix_world, matrix_build(pos_x, pos_y, 0, 0, 0, 0, TILE_SIZE, TILE_SIZE, TILE_SIZE));
				vertex_submit(hmap, pr_trianglelist, -1);	
				
				gpu_set_ztestenable(true);
			}
		}
	}
}

matrix_set(matrix_world, matrix_build_identity());

// Cell outline
var	mx = window_mouse_get_x(),
		my = window_mouse_get_x();

if ( !global.viewport_is_3d && point_in_rectangle(mx, my, 0, 0, global.viewport_w, window_get_height()))
{
	var	mgrid_x = floor(mouse_x / 16) * 16,
			mgrid_y = floor(mouse_y / 16) * 16;
	
	var	grid_sz = obj_tiles.list[| obj_tiles.sel].size,
			grid_w = grid_sz.x * 16 - 1,
			grid_h = grid_sz.y * 16 - 1;

	gpu_set_ztestenable(false);
	draw_set_colour(0x000FFF);
	draw_rectangle(mgrid_x, mgrid_y, mgrid_x + grid_w, mgrid_y + grid_h, true);
	gpu_set_ztestenable(true);
}

// Chunk Outline
if (!global.viewport_is_3d)
{
	gpu_set_ztestenable(false);
	draw_set_colour(c_white);
	draw_border_width(chunk_selected.x * 32 * 16, chunk_selected.y * 32 * 16, (chunk_selected.x + 1) * 32 * 16 - 1, (chunk_selected.y + 1) * 32 * 16 - 1, 2);
	gpu_set_ztestenable(true);
}