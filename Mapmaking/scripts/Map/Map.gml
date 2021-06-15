enum tile
{
	
	none,
	floor_grass,
	
	floor_dirt,
	floor_dirtS,
	floor_dirtN,
	floor_dirtE,
	floor_dirtW,
	floor_dirtSEOut,
	floor_dirtSWOut,
	floor_dirtNWOut,
	DirtPathNWOut,
	DirtPathSEIn,
	DirtPathSWIn,
	DirtPathNEIn,
	DirtPathNWIn,
			
	PineTree,
	TallPineTree,
	OakTree,
	TallOakTree,
	
	cliffN_S,
	cliffS_S,
	cliffE_S,
	cliffW_S,
	cliffSEOut_S,
	cliffSWOut_S,
	cliffNEOut_S,
	cliffNWOut_S,
	cliffNWIn_S,
	cliffNEIn_S,
	cliffSWIn_S,
	cliffSEIn_S,
	
	tallgrass,
	tallgrass_thick
	
}


function MapCompile()
{
	
	window_mouse_set(308, 360);
	GAME.cam.view3D = true;
	
	// --- Compile Map Data
	chunkMesh = ds_map_create();
	
	vertex_format_begin();

	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();

	format = vertex_format_end();
	
	for(var _c = ds_map_find_first(GAME.mapData.chunk); _c < ds_map_size(GAME.mapData.chunk); _c = ds_map_find_next(GAME.mapData.chunk, _c))
		{
			
			ds_map_add(chunkMesh, _c, vertex_create_buffer());
			vertex_begin(chunkMesh[? _c], format);
			var placed = 0;
			
			for(var l = 0; l < 8; l ++)
			{
					for(var _x = 0; _x < 32; _x ++)
					{
						for(var _y = 0; _y < 32; _y ++)
						{
							var m = GAME.mapData.chunk[? _c].layers[| l].tiles[# _x, _y].hai;
							var _z = 15 - GAME.mapData.chunk[? _c].layers[| l].tiles[# _x, _y].z;
							var rp = new vec2(_x * 16, _y * 16); // World position, accounting for chunk position
				
							switch(m)
							{
								default:
									// -- Path Tiles
									if(m >= 1 && m <= 14)
									{
										placed ++;
										var txOff;
							
										switch(m)
										{
											case(tile.floor_dirt): txOff = new vec2(5,  1); break;
											case(tile.floor_dirtS): txOff = new vec2(5, 0); break;
											case(tile.floor_dirtN): txOff = new vec2(5, 2); break;
											case(tile.floor_dirtE): txOff = new vec2(4, 1); break;
											case(tile.floor_dirtW): txOff = new vec2(6, 1); break;
											case(tile.floor_dirtSEOut): txOff = new vec2(4, 0); break;
											case(tile.floor_dirtSWOut): txOff = new vec2(6, 0); break;
											case(tile.floor_dirtNWOut): txOff = new vec2(4, 2); break;
											case(tile.DirtPathNWOut): txOff = new vec2(6, 2); break;
											case(tile.DirtPathSEIn): txOff = new vec2(4, 3); break;
											case(tile.DirtPathSWIn): txOff = new vec2(5, 3); break;
											case(tile.DirtPathNEIn): txOff = new vec2(6, 3); break;
											case(tile.DirtPathNWIn): txOff = new vec2(7, 3); break;
										}
							
										file_get_vertices ( 
											chunkMesh[? _c], "tiles/geometry/floor.gmmod", 
											matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
											new vec3(1, 1, 1), 
											new vec3(0, 0, 0),
											txOff,
											new vec2(1, 1),
											txOW_1,
								
										);
							
									}
						
									if(m >= 19 && m <= 30)
									{
										placed ++;
										var posOff, mdl = "", rot;
							
										switch(floor((m - 19) / 4))
										{
											case(0): // -- NESW
												mdl = "tiles/geometry/cliff_small.gmmod";
												switch(m) {
													case 19:
														posOff = new vec2(0, 0); 
														rot = 0;
													break;
													case 20:
														posOff = new vec2(1, 1); 
														rot = 180;
													break;
													case 21:
														posOff = new vec2(1, 0); 
														rot = 270;
													break;
													case 22:
														posOff = new vec2(0, 1); 
														rot = 90;
													break;
											}
											break;
											case(1): // -- Outwards Corners
												mdl = "tiles/geometry/cliff_small_cornerOut.gmmod";
												switch(m) {
													case 26:
														posOff = new vec2(0, 0); 
														rot = 0;
													break;
													case 23:
														posOff = new vec2(1, 1); 
														rot = 180;
													break;
													case 25:
														posOff = new vec2(1, 0); 
														rot = 270;
													break;
													case 24:
														posOff = new vec2(0, 1); 
														rot = 90;
													break;
												}
											break;
											case(2): // -- Inwards Corners
												mdl = "tiles/geometry/cliff_small_cornerIn.gmmod";
												switch(m) {
													case 27:
														posOff = new vec2(0, 0); 
														rot = 0;
													break;
													case 29:
														posOff = new vec2(1, 1); 
														rot = 180;
													break;
													case 28:
														posOff = new vec2(1, 0); 
														rot = 270;
													break;
													case 30:
														posOff = new vec2(0, 1); 
														rot = 90;
													break;
												}
											break;
										}
							
										file_get_vertices ( 
											chunkMesh[? _c], mdl, 
											matrix_build(rp.x + (posOff.x * 16), rp.y + (posOff.y * 16), _z * 16, 0, 0, rot, 1, 1, 1), 
											new vec3(1, 1, 1), 
											new vec3(0, 0, 0),
											new vec2(5, 8),
											new vec2(1, 2),
											txOW_1,
								
										);
							
									}
								break;
								case(1):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/floor.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2((_x mod 4), (_y mod 4)),
																	new vec2(1, 1),
																	txOW_1
																	);
								break;
								case(tile.PineTree):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_body.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(0, 4),
																	new vec2(4, 4),
																	txOW_1
																	);
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_base.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(14, 2),
																	new vec2(2, 2),
																	txOW_1
																	);
								break;
								case(tile.TallPineTree):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_body.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1.25), 
																	new vec3(0, 0, 0),
																	new vec2(0, 4),
																	new vec2(4, 4),
																	txOW_1
																	);
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_base.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(14, 2),
																	new vec2(2, 2),
																	txOW_1
																	);
								break;
								case(tile.OakTree):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_body.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(8, 4),
																	new vec2(4, 4),
																	txOW_1
																	);
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_base.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(14, 2),
																	new vec2(2, 2),
																	txOW_1
																	);
								break;
								case(tile.TallOakTree):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_body.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1.25), 
																	new vec3(0, 0, 0),
																	new vec2(8, 4),
																	new vec2(4, 4),
																	txOW_1
																	);
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tree_base.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(14, 2),
																	new vec2(2, 2),
																	txOW_1
																	);
								break;
								case(31):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tall_grass.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(13, 0),
																	new vec2(1, 1),
																	txOW_1
																	);
								break;
								case(32):
									placed ++;
									file_get_vertices( chunkMesh[? _c], "tiles/geometry/tall_grass.gmmod", 
																	matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
																	new vec3(1, 1, 1), 
																	new vec3(0, 0, 0),
																	new vec2(13, 1),
																	new vec2(1, 1),
																	txOW_1
																	);
								break;
														
							}
			
						}
					}
			}
			
			vertex_end(chunkMesh[? _c]);
			
			if(!placed) {
				vertex_delete_buffer(chunkMesh[? _c]);
				chunkMesh[? _c] = noone;
			} else {
				vertex_freeze(chunkMesh[? _c]);	
		}
	}
	
	compiled = true;
	
}

function Map() constructor
{
	
	chunk = ds_map_create();
	chunk[? "0,0"] = new Chunk(0, 0);
	
	Render = function()
	{
		for(var _c = ds_map_find_first(chunk); _c < ds_map_size(chunk); _c = ds_map_find_next(chunk, _c))
		{
			_c.Render();
		}
	}
	
}

function Chunk(_cx, _cy) constructor
{
	
	offX = _cx;
	offY = _cy;
	
	layers = ds_list_create();
	
	renderCache = ds_list_create();
	for(var i = 0; i < 8; i ++) { renderCache[| i] = noone; }
	
	repeat(8)
	{
		ds_list_add(layers, new ChunkLayer());	
	}
	
	Render = function()
	{
		for(var _l = 0; _l < 8; _l ++)
			{
				var lr = ds_list_find_value(layers, _l);
				
				lr.Render();
			}
	}
	
}

function ChunkLayer() constructor
{
	
	tiles = ds_grid_create(32, 32);
	ds_grid_set_region(tiles, 0, 0, 31, 31, new ChunkTile(tile.none, GAME.selZ));
	
	Render = function()
	{
		for(var _x = 0; _x < 32; _x ++)
		{
			for(var _y = 0; _y < 32; _y ++)
			{
				var tl = ds_grid_get(tiles, _x, _y);
				
				tl.Render(_x, _y);
			}
		}
	}
}

function ChunkTile(_type, _z) constructor
{
	
	hai = _type;
	z = _z;

	Render = function(_x, _y)
	{
		
		var m = new vec2(_x * 16, _y * 16);
		var p = new vec2(1 + _x * 16, 1 + _y * 16);
		var frame = -1;
		
		switch(hai)
		{
			default:
				if(hai >= 2 && hai <= 14) frame = hai - 1;
				if(hai >= 19 && hai <= 30) frame = hai - 3;
			break;
			case(tile.floor_grass): draw_sprite_part(sTile_Full, 0, m.x mod 64, m.y mod 64, 16, 16, m.x + 1, m.y + 1); break;
			
			case(tile.TallPineTree):
			case(tile.PineTree): frame = 14; break;
			
			case(tile.TallOakTree):
			case(tile.OakTree): frame = 15; break;
			
			case(tile.tallgrass): frame = 28; break;
			case(tile.tallgrass_thick): frame = 29; break;
		}
		
		if(frame != -1)
		{
			draw_sprite(sTile_Full, frame, p.x, p.y);
		}

	}
		
}