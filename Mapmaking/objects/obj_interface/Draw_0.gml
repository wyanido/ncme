/// -- @desc Viewport

if(global.compiled_view && compiled)
{
	draw_set_colour(0xFFFFFF);
			
	for(var _c = ds_map_find_first(obj_interface.mapData.chunk); _c < ds_map_size(obj_interface.mapData.chunk); _c = ds_map_find_next(obj_interface.mapData.chunk, _c))
	{	
		if(chunkMesh[? _c] != undefined) {
			matrix_set(matrix_world, matrix_build(obj_interface.mapData.chunk[? _c].pos_x * 512, obj_interface.mapData.chunk[? _c].pos_y * 512, 0, 0, 0, 0, 1, 1, 1));
						
			vertex_submit(chunkMesh[? _c], pr_trianglelist, sprite_get_texture(txOW_1, 0)); 
						
			matrix_set(matrix_world, matrix_build_identity());
		}
	}
}
		
if(!global.compiled_view)
{
	// Tile Placement Area
	draw_set_colour(0x6B5854);
	draw_grid(0, 0, 32, 32, 16, 0.25)
		
	draw_set_colour(0xFFFFFF);
	draw_border_width(0, 0, 512, 512, 3);
		
	if(updateMap)
	{
		var surf = surface_create(512, 512);
		surface_set_target(surf);
			
		draw_clear_alpha(0xFFFFFF, 0);
		mapData.chunk[? chunk_get_key()].layers[| selLayer].Render();
				
		if(mapData.chunk[? chunk_get_key()].render_cache[selLayer] != undefined)
		{
			sprite_delete(mapData.chunk[? chunk_get_key()].render_cache[selLayer]);
		}
		mapData.chunk[? chunk_get_key()].render_cache[selLayer] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
		surface_reset_target();
		surface_free(surf);

		updateMap = false;
	}
		
	if(refreshMap)
	{
		for(var _c = ds_map_find_first(mapData.chunk); _c < ds_map_size(mapData.chunk); _c = ds_map_find_next(mapData.chunk, _c))
		{
			for(var l = 0; l < 8; l ++)
			{
				var surf = surface_create(512, 512);
				surface_set_target(surf);
			
				draw_clear_alpha(0xFFFFFF, 0);
				mapData.chunk[? _c].layers[| l].Render();
				
				if mapData.chunk[? _c].render_cache[l] != undefined
					sprite_delete(mapData.chunk[? _c].render_cache[l]);
					
				mapData.chunk[?  _c].render_cache[l] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
				surface_reset_target();
				surface_free(surf);

				refreshMap = false;
			}
		}
	}
	
	// Draw active layers
	for ( var i = 0; i < 8; i ++ )
	{
		var val = (selLayer - i) * 20;
		mult = (i < selLayer) ? make_colour_hsv(170, max(0, val / 2), 255 - val) : 0xFFFFFF;
		
		if(mapData.chunk[? chunk_get_key()].render_cache[i] != undefined && i <= selLayer) 
		{
			draw_sprite_ext(mapData.chunk[? chunk_get_key()].render_cache[i], 0, 1, 1, 1, 1, 0, mult, 1);
		}
	}
	
		
	// -- Highlighted Cell
	if gridSel != -1
	{ 
		var mg = new vec2(floor(mouse_x / 16) * 16, floor(mouse_y / 16) * 16);
		var sz = new vec2(tiles[selTile].size.x * 16, tiles[selTile].size.y * 16);
			
		draw_set_colour(0x000FFF);
		draw_rectangle(mg.x + 2, mg.y + 2, mg.x + sz.x, mg.y + sz.y, true);
	}
}
