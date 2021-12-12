/// -- @desc Viewport

if global.compiled_view && compiled
{
	// Render chunks in 3D space
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
} 
else if !global.compiled_view
{
	// Render chunks in editor
	// Tile Placement Area
	draw_set_colour(0x6B5854);
	draw_grid(0, 0, 32, 32, 16, 0.25)
		
	draw_set_colour(c_white);
	draw_border_width(0, 0, 512, 512, 3);

	if refresh_layer
	{
		var surf = surface_create(512, 512);
		surface_set_target(surf);
			
		draw_clear_alpha(c_white, 0);
		map_data.chunk[? chunk_get_key()].layers[| selLayer].Render();
				
		if(map_data.chunk[? chunk_get_key()].render_cache[selLayer] != undefined)
		{
			sprite_delete(map_data.chunk[? chunk_get_key()].render_cache[selLayer]);
		}
		map_data.chunk[? chunk_get_key()].render_cache[selLayer] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
		surface_reset_target();
		surface_free(surf);

		refresh_layer = false;
	}
		
	if refresh_map
	{
		for(var c = ds_map_find_first(map_data.chunk); c < ds_map_size(map_data.chunk); c = ds_map_find_next(map_data.chunk, c))
		{
			for(var l = 0; l < 8; l ++)
			{
				var surf = surface_create(512, 512);
				surface_set_target(surf);
			
				draw_clear_alpha(c_white, 0);
				map_data.chunk[? c].layers[| l].Render();
				
				if map_data.chunk[? c].render_cache[l] != undefined
					sprite_delete(map_data.chunk[? c].render_cache[l]);
					
				map_data.chunk[? c].render_cache[l] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
				surface_reset_target();
				surface_free(surf);
			}
		}
		
		refresh_map = false;
	}
	
	// Current Chunk Layers
	for ( var i = 0; i < 8; i ++ )
	{
		// Darken lower layers
		var val = (selLayer - i) * 20;
		var mult = i < selLayer ? make_colour_hsv(170, max(0, val / 2), 255 - val) : c_white;
		
		var this_chunk = map_data.chunk[? chunk_get_key()].render_cache[i];
		if !is_undefined(this_chunk) && i <= selLayer
		{
			draw_sprite_ext(this_chunk, 0, 1, 1, 1, 1, 0, mult, 1);
		}
	}
}
