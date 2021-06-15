function map_compile()
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