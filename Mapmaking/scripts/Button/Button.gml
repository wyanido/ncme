
enum button
{
	compile,
	export_model,
	import,
	export,
	fill_layer,
	clear_layer,
	smart_tiles,
	
	chunk_left,
	chunk_right,
	chunk_up,
	chunk_down
}

function Button(_label, _x, _y, w, h, _act) constructor
{
	
	hidden = false;
	active = true;
	action = _act
	label = _label;
	pos = new vec2(_x, _y);
	size = new vec2(w, h);
	
	Visibility = function()
	{
		switch(action)
		{
			case(button.compile): active = !GAME.cam.view3D; break;
			case(button.export_model): active =!GAME.cam.view3D; break;
			case(button.fill_layer): active =			!GAME.cam.view3D; break;
			case(button.clear_layer): active =		!GAME.cam.view3D; break;
			case(button.smart_tiles): active =		!GAME.cam.view3D; break;
			
			case(button.chunk_up):		hidden = GAME.cam.view3D; break;
			case(button.chunk_right):	hidden = GAME.cam.view3D; break;
			case(button.chunk_down):	hidden = GAME.cam.view3D; break;
			case(button.chunk_left):		hidden = GAME.cam.view3D; break;
		}
	}
	
	IsHovering = function()
	{
		
		var hovering = false;
		
		if(active && !hidden)
		{
			var d = new vec2(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
			if((d.x > pos.x - size.x / 2 && d.x < pos.x + size.x / 2) && (d.y > pos.y - size.y / 2 && d.y < pos.y + size.y / 2)) hovering = true;
		}
		
		return hovering;
	}
	
	Click = function()
	{
		switch(action)
		{
			case(button.compile): with(GAME) MapCompile(); break;
			case(button.export_model): /* No action yet */ break;
			case(button.import): map_import(); break;
			case(button.export): map_export(); break;
			case(button.fill_layer):
				var lr = GAME.mapData.chunk[? chunk_get_key()].layers[| GAME.selLayer];
				ds_grid_set_region(lr.tiles, 0, 0, 31, 31, new ChunkTile(GAME.tiles[GAME.selTile].hai, GAME.selZ));
				
				GAME.updateMap = true;
			break;
			case(button.clear_layer):
				ds_grid_set_region(GAME.mapData.chunk[? chunk_get_key()].layers[| GAME.selLayer].tiles, 0, 0, 31, 31, new ChunkTile(tile.none, 15));
				
				GAME.updateMap = true;
			break;
			case(button.smart_tiles):
				var lr = GAME.mapData.chunk[? chunk_get_key()].layers[| GAME.selLayer];
			
				for(var _x = 0; _x < 32; _x ++)
				{
					for(var _y = 0; _y < 32; _y ++)
					{
						if(lr.tiles[# _x, _y].hai == tile.floor_dirt)
						{
							
							var _z = lr.tiles[# _x, _y].z;
							
							/// --- Path Neatening Algorithm
							// -- Find Neighbours
							var nb = [false, false, false, false];
							if(_y <= 0) || (lr.tiles[# _x, _y - 1].hai > 1 && lr.tiles[# _x, _y - 1].hai < 15) nb[0] = true;
							if(_x >= 31) || (lr.tiles[# _x + 1, _y].hai > 1 && lr.tiles[# _x + 1, _y].hai < 15) nb[1] = true;
							if(_y >= 31) || (lr.tiles[# _x, _y + 1].hai > 1 && lr.tiles[# _x, _y + 1].hai < 15) nb[2] = true;
							if(_x <= 0) || (lr.tiles[# _x - 1, _y ].hai > 1 && lr.tiles[# _x - 1, _y].hai < 15) nb[3] = true;

							// -- NESW
							if(nb[0] && nb[1] && !nb[2] && nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtN, _z); }
							if(nb[0] && nb[1] && nb[2] && !nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtE, _z); }
							if(!nb[0] && nb[1] && nb[2] && nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtS, _z); }
							if(nb[0] && !nb[1] && nb[2] && nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtW, _z); }
							
							// -- The Diagonal One
							if(nb[0] && nb[1] && !nb[2] && !nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtNWOut, _z); }
							if(!nb[0] && nb[1] && nb[2] && !nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtSEOut, _z); }
							if(!nb[0] && !nb[1] && nb[2] && nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.floor_dirtSWOut, _z); }
							if(nb[0] && !nb[1] && !nb[2] && nb[3]) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathNWOut, _z); }
							
						}
					}
				}
				
				for(var _x = 0; _x < 32; _x ++)
				{
					for(var _y = 0; _y < 32; _y ++)
					{
						if(lr.tiles[# _x, _y].hai == tile.floor_dirt)
						{
							
							var nb = [false, false, false, false];
							if(_y > 0) nb[0] = lr.tiles[# _x, _y - 1].hai;
							if(_x < 31) nb[1] = lr.tiles[# _x + 1, _y].hai;
							if(_y < 31) nb[2] = lr.tiles[# _x, _y + 1].hai ;
							if(_x > 0) nb[3] = lr.tiles[# _x - 1, _y ].hai;

							if(nb[3] == tile.floor_dirtS || nb[3] == tile.floor_dirtSEOut) && (nb[0] == tile.floor_dirtE || nb[0] == tile.floor_dirtSEOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathNWIn, _z); }
							if(nb[0] == tile.floor_dirtW || nb[0] == tile.floor_dirtSWOut) && (nb[1] == tile.floor_dirtS || nb[1] == tile.floor_dirtSWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathNEIn, _z); }
							if(nb[1] == tile.floor_dirtN || nb[1] == tile.DirtPathNWOut) && (nb[2] == tile.floor_dirtW || nb[2] == tile.DirtPathNWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathSEIn, _z); }
							if(nb[2] == tile.floor_dirtE || nb[2] == tile.floor_dirtNWOut) && (nb[3] == tile.floor_dirtN || nb[3] == tile.floor_dirtNWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathSWIn, _z); }
							
						}
					}
				}
				
				GAME.updateMap = true;
			break;
			case(button.chunk_up): 	
				GAME.selChunk.y --;
				chunk_fill_empty();
			break;
			case(button.chunk_right): 
				GAME.selChunk.x ++;
				chunk_fill_empty();
			break;
			case(button.chunk_down): 
				GAME.selChunk.y ++;
				chunk_fill_empty();
			break;
			case(button.chunk_left): 
				GAME.selChunk.x --;
				chunk_fill_empty();
			break;
		}
	}
	
	Render = function()
	{
		
		if(!hidden)
		{
			var drawcol = IsHovering() ? 0x6B5854 : 0x332420;
			draw_set_colour(drawcol);
			draw_rectangle(pos.x - size.x / 2, pos.y - size.y / 2, pos.x + size.x / 2, pos.y + size.y / 2, false);
		
			if(active) { draw_set_colour(0xFFFFFF); } 
			else { draw_set_colour(0x7f675b); }
		
			draw_rectangle(pos.x - size.x / 2, pos.y - size.y / 2, pos.x + size.x / 2, pos.y + size.y / 2, true);
		
			draw_set_font(fntGUI);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(pos.x, pos.y, label);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		}
		
	}
	
}