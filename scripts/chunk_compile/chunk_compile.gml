function chunk_compile(this_chunk)
{
	// Delete existing mesh if
	if chunk_mesh[? this_chunk] != undefined
		vertex_delete_buffer(chunk_mesh[? this_chunk]);
	
	var this_mesh = vertex_create_buffer();
	vertex_begin(this_mesh, global.vformat);
	
	var tiles_placed = 0;	
	
	for(var l = 0; l < 8; l ++)
	{
		for(var _x = 0; _x < 32; _x ++)
		{
			for(var _y = 0; _y < 32; _y ++)
			{
				var this_type = map_data.chunk[? this_chunk].layers[| l].tiles[# _x, _y].tile_type;
				var _z = 15 - map_data.chunk[? this_chunk].layers[| l].tiles[# _x, _y].z;
				var rp = new vec2(_x * 16, _y * 16); // World position, accounting for chunk position
				
				switch(this_type)
				{
					default:
						// -- Path Tiles
						if (this_type >= 1 && this_type <= 14)
						{
							tiles_placed ++;
							var txOff;
							
							switch this_type
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
								this_mesh, "tiles/geometry/floor.gmmod", 
								matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
								new vec3(1, 1, 1), 
								new vec3(0, 0, 0),
								txOff,
								new vec2(1, 1),
								txOW_1,
							);
							
						}
						
						if (this_type>= 19 && this_type <= 30)
						{
							tiles_placed ++;
							var posOff, mdl = "", rot;
							
							switch(floor((this_type - 19) / 4))
							{
								case(0): // -- NESW
									mdl = "tiles/geometry/cliff_small.gmmod";
									switch this_type {
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
									switch(this_type) {
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
									switch(this_type) {
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
								this_mesh, mdl, 
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
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/floor.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2((_x mod 4), (_y mod 4)),
														new vec2(1, 1),
														txOW_1
														);
					break;
					case(tile.PineTree):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tree_body.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(0, 4),
														new vec2(4, 4),
														txOW_1
														);
						file_get_vertices( this_mesh, "tiles/geometry/tree_base.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(14, 2),
														new vec2(2, 2),
														txOW_1
														);
					break;
					case(tile.TallPineTree):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tree_body.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1.25), 
														new vec3(0, 0, 0),
														new vec2(0, 4),
														new vec2(4, 4),
														txOW_1
														);
						file_get_vertices( this_mesh, "tiles/geometry/tree_base.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(14, 2),
														new vec2(2, 2),
														txOW_1
														);
					break;
					case(tile.OakTree):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tree_body.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(8, 4),
														new vec2(4, 4),
														txOW_1
														);
						file_get_vertices( this_mesh, "tiles/geometry/tree_base.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(14, 2),
														new vec2(2, 2),
														txOW_1
														);
					break;
					case(tile.TallOakTree):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tree_body.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1.25), 
														new vec3(0, 0, 0),
														new vec2(8, 4),
														new vec2(4, 4),
														txOW_1
														);
						file_get_vertices( this_mesh, "tiles/geometry/tree_base.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16 - 56, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(14, 2),
														new vec2(2, 2),
														txOW_1
														);
					break;
					case(31):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tall_grass.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(13, 0),
														new vec2(1, 1),
														txOW_1
														);
					break;
					case(32):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/tall_grass.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(13, 1),
														new vec2(1, 1),
														txOW_1
														);
					break;
					case(tile.land_rock_S):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/rock_small.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(7, 10),
														new vec2(2, 2),
														txOW_1
														);
					break;
					case(tile.land_rock_L):
						tiles_placed ++;
						file_get_vertices( this_mesh, "tiles/geometry/rock_big.gmmod", 
														matrix_build(rp.x, rp.y, _z * 16, 0, 0, 0, 1, 1, 1), 
														new vec3(1, 1, 1), 
														new vec3(0, 0, 0),
														new vec2(7, 10),
														new vec2(2, 2),
														txOW_1
														);
					break;
				}
			}
		}
	}
			
	vertex_end(this_mesh);
	
	if tiles_placed == 0 
		vertex_delete_buffer(this_mesh);
	else 
	{
		vertex_freeze(this_mesh);	
		ds_map_add(chunk_mesh, this_chunk, this_mesh);
	}
}