/// -- @desc Render viewport
// Map chunks
draw_set_colour(c_white);

for(var c = ds_map_find_first(map_data.chunk); c < ds_map_size(map_data.chunk); c = ds_map_find_next(map_data.chunk, c))
{
	if !is_undefined(chunk_mesh[? c]) 
	{
		matrix_set(matrix_world, matrix_build(map_data.chunk[? c].pos_x * 512, map_data.chunk[? c].pos_y * 512, 0, 0, 0, 0, 1, 1, 1));
			
		vertex_submit(chunk_mesh[? c], pr_trianglelist, sprite_get_texture(txOW_1, 0)); 
	}
}
	
matrix_set(matrix_world, matrix_build_identity());

// Cell outline
var	mx = window_mouse_get_x(),
		my = window_mouse_get_x();

if !global.compiled_view && point_in_rectangle(mx, my, 0, 0, 616, 720)
{ 
	var	mgrid_x = floor(mouse_x / 16) * 16,
			mgrid_y = floor(mouse_y / 16) * 16;

	draw_rectangle(mgrid_x, mgrid_y, mgrid_x + 16, mgrid_y + 16, true);
}
