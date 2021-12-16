function chunk_layercache_refresh(this_chunk, this_layer = undefined)
{
	with obj_layers
	{
		this_layer ??= sel;
		
		var mesh = obj_interface.chunk_mesh[? this_chunk][this_layer];
		
		if mesh != undefined
		{
			if !surface_exists(surf_layercache)
				surf_layercache = surface_create(72, 72);

			surface_set_target(surf_layercache);
			draw_clear_alpha(c_black, 0);
	
			var view_mat = matrix_build_lookat(256, 256, 1600, 256, 256, 0, 0, 1, 0);
			var proj_mat = matrix_build_projection_ortho(-512, 512, 1, 16000);
		
			camera_set_view_mat(0, view_mat);
			camera_set_proj_mat(0, proj_mat);

			camera_apply(0);
		
			vertex_submit(obj_interface.chunk_mesh[? this_chunk][this_layer], pr_trianglelist, sprite_get_texture(tx_grass, 0));
		
			surface_reset_target();
		}
		else
		{
			if cache[? this_chunk] == undefined
				cache[? this_chunk] = array_create(8, undefined);
			
			cache[? this_chunk][this_layer] = undefined;
		}
		
		 if cache[? this_chunk] == undefined
			cache[? this_chunk] = array_create(8, undefined);
		else if cache[? this_chunk][this_layer] != undefined
			sprite_delete(cache[? this_chunk][this_layer]);
		
		if mesh != undefined
		{
			cache[? this_chunk][this_layer] = sprite_create_from_surface(surf_layercache, 0, 0, 72, 72, false, false, 0, 0);
		}
	}
}