/// -- @desc Render viewport
// Map chunks
draw_set_colour(c_white);

for(var c = ds_map_find_first(global.chunk); c < ds_map_size(global.chunk); c = ds_map_find_next(global.chunk, c))
{
	if !is_undefined(chunk_mesh[? c]) 
	{
		matrix_set(matrix_world, matrix_build(global.chunk[? c].pos_x * 512, global.chunk[? c].pos_y * 512, 0, 0, 0, 0, 1, 1, 1));
		vertex_submit(chunk_mesh[? c], keyboard_check(ord("V")) ? pr_linelist : pr_trianglelist, sprite_get_texture(tx_grass, 0)); 
	}
}

matrix_set(matrix_world, matrix_build_identity());

// Cell outline
var	mx = window_mouse_get_x(),
		my = window_mouse_get_x();

if !global.compiled_view && point_in_rectangle(mx, my, 0, 0, viewport_w, 720)
{
	var	mgrid_x = floor(mouse_x / 16) * 16,
			mgrid_y = floor(mouse_y / 16) * 16;

	var	grid_w = obj_tiles.list[| obj_tiles.sel].size.x * 16 - 1,
			grid_h = obj_tiles.list[| obj_tiles.sel].size.y * 16 - 1;

	gpu_set_ztestenable(false);
	draw_set_colour(0x000FFF);
	draw_rectangle(mgrid_x, mgrid_y, mgrid_x + grid_w, mgrid_y + grid_h, true);
	gpu_set_ztestenable(true);
}

// Chunk Outline
if !global.compiled_view
{
	gpu_set_ztestenable(false);
	draw_set_colour(c_white);
	draw_border_width(chunk_selected.x * 32 * 16, chunk_selected.y * 32 * 16, (chunk_selected.x + 1) * 32 * 16 - 1, (chunk_selected.y + 1) * 32 * 16 - 1, 2);
	gpu_set_ztestenable(true);
}