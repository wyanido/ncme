
function Interface() constructor
{
	
	Init = function()
	{
		
		compiled = false;
		selTile = 0;
		selChunk = new vec2(0, 0);
		selLayer = 0;
		selZ = 15;
		
		ss = noone;
		cam = new Camera();
		mapData = new Map();
		buttons = ds_list_create();
		
		ds_list_add(buttons, new Button("Compile & View Map Model", 1120, 512 + 68, 284, 48, button.compile));
		ds_list_add(buttons, new Button("Export Model Buffer", 1120, 580 - 64, 284, 48, button.export_model));
		ds_list_add(buttons, new Button("Import Map File", 1041 + 4, 644, 134, 48, button.import));
		ds_list_add(buttons, new Button("Export Map File", 1199 - 4, 644, 134, 48, button.export));
		
		ds_list_add(buttons, new Button("Flood Layer", 1045, 52, 128, 48, button.fill_layer));
		ds_list_add(buttons, new Button("Clear Layer", 1045, 52 + 64, 128, 48, button.clear_layer));
		ds_list_add(buttons, new Button("Smart Tile", 1045, 52 + 128, 128, 48, button.smart_tiles));
		
		// -- Chunk Panning
		ds_list_add(buttons, new Button("<", 24.5 , 342.5, 32, 256, button.chunk_left));
		ds_list_add(buttons, new Button(">", 78.5 + 512 , 342.5, 32, 256, button.chunk_right));
		ds_list_add(buttons, new Button("^", 308, 42 + 16, 256, 32, button.chunk_up));
		ds_list_add(buttons, new Button("v", 308, 126 + 512 - 12, 256, 32, button.chunk_down));
		
		gpu_set_alphatestenable(true);
		
		preMouse = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
		preTile = new vec2(-1, -1);
		
		refreshMap = false;
		updateMap = false;

		tiles = tile_get_list();
		hoverTile = noone;

	}

	Update = function()
	{

		cam.Update();
		
		#region --- Interact with Things
			var d = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			var click = mouse_check_button_pressed(mb_left), hold = mouse_check_button(mb_left);
			var right = mouse_check_button(mb_right);
			window_set_cursor(cr_default);
			
			// --- Place TIle
			if(!cam.view3D)
			{
				// -- Highlight Cell
				gridSel = (mouse_x > 0 && mouse_x < room_width) && (mouse_y > 0 && mouse_y < room_height) ? new vec2(mouse_x, mouse_y) : -1;
			
				if(gridSel != -1)
				{
					var mg = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
					if(right || !mouse_check_button(mb_left) || click) { preTile = new vec2(-5, -5); }
					
					if(abs(mg.x - preTile.x) >= tiles[selTile].size.x || abs(mg.y - preTile.y) >= tiles[selTile].size.y)
					{
						if(hold)
						{
							var tls = mapData.chunk[? chunk_get_key()].layers[| selLayer].tiles;
							
							ds_grid_set(tls, mg.x, mg.y, new ChunkTile(tiles[selTile].hai, selZ));
							updateMap = true;
							
							preTile = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
						}
					
						if(right)
						{
							var tls = mapData.chunk[? chunk_get_key()].layers[| selLayer].tiles;

							ds_grid_set(tls, mg.x, mg.y, new ChunkTile(tile.none, 15));
							updateMap = true;
							
							preTile = new vec2(floor(mouse_x / 16), floor(mouse_y / 16));
						}
					}
				}
			}
		
			// -- Height
			if(d.x > 626 && d.x < 646) && (d.y > 28 && d.y < 679)
			{
				window_set_cursor(cr_handpoint);
			
				if hold selZ = floor((d.y - 28) / 21);
			}
			
			for(var i = 0; i < ds_list_size(buttons); i ++) 
			{ 
				var b = buttons[| i];
				if(b.IsHovering())
				{
					window_set_cursor(cr_handpoint);
				
					if(click)
					{
						b.Click();	
					}
				}
			}
			
			// -- Select Tile
			if(d.x > 768 && d.x < 960) && (d.y > 28 && d.y < 670.5)
			{
				window_set_cursor(cr_handpoint);
				
				var pos = new vec2(floor((d.x - 768) / 32), floor((d.y - 28) / 32));
				var checkPos = new vec2(0, 0);
				var sel = 0;
					
				while(pos.x != checkPos.x || pos.y != checkPos.y)
				{
					sel ++;
					checkPos = new vec2(floor(sel mod 6), floor(sel / 6));
				}

				hoverTile = (sel < array_length(tiles)) ? tiles[sel] : noone;
				
				if(click && sel < array_length(tiles))  selTile = sel; 
				
			} else {
				hoverTile = noone;	
			}
			
			// -- Select Layer
			if(d.x > 671.5 && d.x < 743.5) && (d.y > 36.5 && d.y < 670.5)
			{
				window_set_cursor(cr_handpoint);
			
				if click selLayer = floor((d.y - 36.5) / 80.5);
			}
		#endregion
		
	}
	
	Render = function()
	{
		
		cam.Render();
		
		if(cam.view3D && compiled)
		{
			draw_set_colour(0xFFFFFF);
			
			for(var _c = ds_map_find_first(GAME.mapData.chunk); _c < ds_map_size(GAME.mapData.chunk); _c = ds_map_find_next(GAME.mapData.chunk, _c))
			{	
				if(chunkMesh[? _c] != noone) {
					matrix_set(matrix_world, matrix_build(GAME.mapData.chunk[? _c].offX * 512, GAME.mapData.chunk[? _c].offY * 512, 0, 0, 0, 0, 1, 1, 1));
						
					vertex_submit(chunkMesh[? _c], pr_trianglelist, sprite_get_texture(txOW_1, 0)); 
						
					matrix_set(matrix_world, matrix_build_identity());
				}
			}
		}
		
		if(!cam.view3D)
		{
			// --- Draw Tile Placement Area
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
				
				if(mapData.chunk[? chunk_get_key()].renderCache[| selLayer] != noone)
				{
					sprite_delete(mapData.chunk[? chunk_get_key()].renderCache[| selLayer]);
				}
				mapData.chunk[? chunk_get_key()].renderCache[| selLayer] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
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

						sprite_delete(mapData.chunk[? _c].renderCache[| l]);
						mapData.chunk[?  _c].renderCache[| l] = sprite_create_from_surface(surf, 0, 0, 512, 512, false, true, 0, 0);
			
						surface_reset_target();
						surface_free(surf);

						refreshMap = false;
					}
				}
			}
		
			for(var i = 0; i < 8; i ++)
			{
				var val = (selLayer - i) * 20;
				mult = (i < selLayer) ? make_colour_hsv(170, max(0, val / 2), 255 - val) : 0xFFFFFF;
					
				if(mapData.chunk[? chunk_get_key()].renderCache[| i] != noone && i <= selLayer) {
					draw_sprite_ext(mapData.chunk[? chunk_get_key()].renderCache[| i], 0, 1, 1, 1, 1, 0, mult, 1);
				}
			}
		
			// -- Highlighted Cell
			if(gridSel != -1) { 
				var mg = new vec2(floor(mouse_x / 16) * 16, floor(mouse_y / 16) * 16);
				var sz = new vec2(tiles[selTile].size.x * 16, tiles[selTile].size.y * 16);
			
				draw_set_colour(0x000FFF);
				draw_rectangle(mg.x + 2, mg.y + 2, mg.x + sz.x, mg.y + sz.y, true);
			
			}
		}
		
	}
	
	GUI = function()
	{
		
		if(cam.view3D) {
			draw_clear_alpha(0x000000, 0);
			sprite_delete(ss);
			ss = sprite_create_from_surface(application_surface, 0, 0, 1280, 720, false, true, 0, 0);

			draw_sprite_ext(ss, 0, 0, 0, 616 / 1280, 1, 0, 0xFFFFFF, 1);
			
			draw_set_colour(0xFFFFFF);
			draw_text(16, 720 - 32, "Projection | X: " + string(cam.pos.x) + ", Y: "+ string(cam.pos.y) + ", Z: " + string(cam.pos.z) + "        Pitch: " + string(cam.pitch) + ", Yaw: " + string(cam.yaw));
			draw_set_colour(0x714AE8);
			draw_text(16, 720 - 56, "Press ESC to exit Compiled View");
			
		} else { 
			draw_surface_ext(application_surface, 0, 0, 1, 1, 0, 0xFFFFFF, 1); 
		}

		// --- Background
		draw_set_colour(0x332420);
		draw_rectangle(616, 0, 1280, 720, false);
		if(!cam.view3D) draw_rectangle(4, 715 - 32, 611, 715, false);
		
		#region --- Layers
			var w = 664, h = 36, s = 72, sep = 8.5;
			
			for(var l = 0; l < 8; l ++)
			{
				draw_set_colour(0x111111);
				draw_rectangle(w + sep, h + (l * (s + sep)), w + sep + s, h + s + (l * (s + sep)), false);
				
				if(mapData.chunk[? chunk_get_key()].renderCache[| l] != noone) {
					draw_sprite_ext(mapData.chunk[? chunk_get_key()].renderCache[| l], 0, w + sep, h + (l * (s + sep)), 72 / 512 , 72 / 512, 0, 0xFFFFFF, 1);
				}
			}
			
			// -- Border
			draw_set_colour(0xFFFFFF);
			draw_rectangle(w, h - sep, w + s + (sep * 2), h + (8 * (s + sep)), true);

			// -- Layer Selection
			draw_set_colour(0x000FFF);
			draw_rectangle(w + sep, h + (selLayer * (s + sep)), w + sep + s, h + s + (selLayer * (s + sep)), true);
		#endregion

		#region --- Tile Height
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(fntZ);
		
			var i = 15, w = 636, p = 10;
			for(var h = 0; h < 31; h ++)
			{
				var v = 39.5 + (h * 21);
			
				draw_set_colour(make_colour_hsv((31 - h) * 5, 128 + (128 * (h mod 2)), 255));
				draw_rectangle(w - p, v - p, w + p, v + p, false);
			
				draw_set_colour(0x000000);
				draw_text(w + 1, v + 1, string(i));

				i --;
			}
		
			// -- Border
			draw_set_colour(0xFFFFFF);
			draw_border_width(w - p, 28, w + p, 679, 2);
		
			// -- Z Selection
			var v = 39.5 + (selZ * 21);
			draw_set_colour(0x000FFF);
			draw_rectangle(w - p + 1, v - p - 1, w + p, v + p, true);
			draw_set_alpha(0.5);
			draw_rectangle(w - p + 1, v - p - 1, w + p, v + p, false);	
			draw_set_alpha(1);
		
			draw_set_valign(fa_top);
			draw_set_halign(fa_left);
		#endregion
		
		#region --- Cell Selection
			// -- Highlighted Cell
			if(gridSel != -1 && !cam.view3D) { 
				var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))
				var mg = new vec2(floor(mouse_x / 16) * 16, floor(mouse_y / 16) * 16)
				var cell = new vec2(mg.x / 16, mg.y / 16);
				var cell_glob = new vec2(cell.x + (32 * selChunk.x), cell.y + (32 * selChunk.y));
			
				draw_set_font(fntGUI);
				draw_set_colour(0xFFFFFF);
				draw_text(16, 691, "Within Chunk | X: " + string(cell.x) + ", Y: " + string(cell.y));
				draw_text(256, 691, "On Map | X: " + string(cell_glob.x + (selChunk.x * 32)) + ", Y: " + string(cell_glob.y + (selChunk.y * 32)));
				
			}
		#endregion
		
		#region --- Tileset
			
			var xx = 768, w = 6, h = 20, i = 0, count = sprite_get_number(sTile_Ico);
	
			draw_set_colour(0x111111);
			draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), false);
			
			draw_set_colour(0xFFFFFF);
			draw_rectangle(xx, 28, xx + (w * 32), 28 + (h * 32), true);
			
			for(var _y = 0; _y < h && i < count; _y ++)
			{
				for(var _x = 0; _x < 8 && _x < w && i < count; _x ++)
				{
					draw_sprite_ext(sTile_Ico, i, xx + (_x * 32), 28 + (_y * 32), 2, 2, 0, c_white, 1);

					i ++;
				}
			}
			
			var pos = new vec2(selTile mod w, floor(selTile / w));
			var cellS = new vec2(pos.x * 32, pos.y * 32);
			
			draw_set_colour(0x000FFF);
			draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, true);
					
			// -- Cell Name
			var m = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			
			if(hoverTile != noone) 
			{
				
				// -- Highlight Hovered Cell
				var pos = new vec2(hoverTile.index mod w, floor(hoverTile.index / w));
				var cellS = new vec2(pos.x * 32, pos.y * 32);
				var p = 4;
				
				draw_set_font(fntGUI);
				draw_set_alpha(abs(sin(get_timer() / 300000)) * 0.5);
				draw_set_colour(0xFFFFFF);
				draw_rectangle(xx + cellS.x + 1, 28 + cellS.y + 1, 768 + cellS.x + 31, 28 + cellS.y + 31, false);
			
				// -- Cell Name
				draw_set_alpha(0.75);
				draw_set_colour(0x000000);
				draw_rectangle(m.x + 16 - p, m.y + 12 - p, m.x + 16 + string_width(hoverTile.label) + p, m.y + 12 + string_height(hoverTile.label) + p, false);
				
				draw_set_alpha(1);
				draw_set_colour(0xFFFFFF);
				draw_text(m.x + 16, m.y + 13, hoverTile.label);

			}
			
		#endregion
		
		for(var i = 0; i < ds_list_size(buttons); i ++)  { buttons[| i].Visibility(); buttons[| i].Render(); }
		
	}
	
}