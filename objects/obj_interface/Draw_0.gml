/// -- @desc Render viewport
// Layer cache
var tex = sprite_get_texture(tx_grass, 0);
if mdl_layercache != undefined
{
	if mdl_layercache != "cleared_layer"
	{
		if !surface_exists(surf_layercache)
			surf_layercache = surface_create(72, 72);

		surface_set_target(surf_layercache);
		draw_clear_alpha(c_black, 0);
	
		var view_mat = matrix_build_lookat(256, 256, 1600, 256, 256, 0, 0, 1, 0);
		var proj_mat = matrix_build_projection_ortho(-512, 512, 1, 16000);
		
		// Set projection
		camera_set_view_mat(0, view_mat);
		camera_set_proj_mat(0, proj_mat);

		camera_apply(0);

		vertex_submit(mdl_layercache, pr_trianglelist, tex);
	
		surface_reset_target();
		if chunk[? chunk_get_key()].render_cache[layer_selected] != undefined
			sprite_delete(chunk[? chunk_get_key()].render_cache[layer_selected]);
	
		chunk[? chunk_get_key()].render_cache[layer_selected] = sprite_create_from_surface(surf_layercache, 0, 0, 72, 72, false, false, 0, 0);
		vertex_delete_buffer(mdl_layercache);
	}
	else
	{
		if chunk[? chunk_get_key()].render_cache[layer_selected] != undefined
			sprite_delete(chunk[? chunk_get_key()].render_cache[layer_selected]);
		chunk[? chunk_get_key()].render_cache[layer_selected] = undefined;
	}

	mdl_layercache = undefined;
}

// Map chunks
draw_set_colour(c_white);

for(var c = ds_map_find_first(chunk); c < ds_map_size(chunk); c = ds_map_find_next(chunk, c))
{
	if !is_undefined(chunk_mesh[? c]) 
	{
		matrix_set(matrix_world, matrix_build(chunk[? c].pos_x * 512, chunk[? c].pos_y * 512, 0, 0, 0, 0, 1, 1, 1));
		
		vertex_submit(chunk_mesh[? c], keyboard_check(ord("V")) ? pr_linelist : pr_trianglelist, tex); 
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

	var	grid_w = tile_list[| tile_selected].size.x * 16 - 1,
			grid_h = tile_list[| tile_selected].size.y * 16 - 1;

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