
label = "Smart Tiles";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	var lr = obj_interface.map_data.chunk[? chunk_get_key()].layers[| obj_interface.selLayer];
	
	for(var _x = 0; _x < 32; _x ++)
	{
		for(var _y = 0; _y < 32; _y ++)
		{
			if(lr.tiles[# _x, _y].tile_type == tile.floor_dirt)
			{
				// Path Neatening Algorithm
				var _z = lr.tiles[# _x, _y].z;

				// Find Neighbours
				var nb = [false, false, false, false];
				if(_y <= 0) || (lr.tiles[# _x, _y - 1].tile_type > 1 && lr.tiles[# _x, _y - 1].tile_type < 15) nb[0] = true;
				if(_x >= 31) || (lr.tiles[# _x + 1, _y].tile_type > 1 && lr.tiles[# _x + 1, _y].tile_type < 15) nb[1] = true;
				if(_y >= 31) || (lr.tiles[# _x, _y + 1].tile_type > 1 && lr.tiles[# _x, _y + 1].tile_type < 15) nb[2] = true;
				if(_x <= 0) || (lr.tiles[# _x - 1, _y ].tile_type > 1 && lr.tiles[# _x - 1, _y].tile_type < 15) nb[3] = true;

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
			if(lr.tiles[# _x, _y].tile_type == tile.floor_dirt)
			{
				var nb = [false, false, false, false];
				if(_y > 0) nb[0] = lr.tiles[# _x, _y - 1].tile_type;
				if(_x < 31) nb[1] = lr.tiles[# _x + 1, _y].tile_type;
				if(_y < 31) nb[2] = lr.tiles[# _x, _y + 1].tile_type ;
				if(_x > 0) nb[3] = lr.tiles[# _x - 1, _y ].tile_type;

				if(nb[3] == tile.floor_dirtS || nb[3] == tile.floor_dirtSEOut) && (nb[0] == tile.floor_dirtE || nb[0] == tile.floor_dirtSEOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathNWIn, _z); }
				if(nb[0] == tile.floor_dirtW || nb[0] == tile.floor_dirtSWOut) && (nb[1] == tile.floor_dirtS || nb[1] == tile.floor_dirtSWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathNEIn, _z); }
				if(nb[1] == tile.floor_dirtN || nb[1] == tile.DirtPathNWOut) && (nb[2] == tile.floor_dirtW || nb[2] == tile.DirtPathNWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathSEIn, _z); }
				if(nb[2] == tile.floor_dirtE || nb[2] == tile.floor_dirtNWOut) && (nb[3] == tile.floor_dirtN || nb[3] == tile.floor_dirtNWOut) { lr.tiles[# _x, _y] = new ChunkTile(tile.DirtPathSWIn, _z); }			
			}
		}
	}
	
	with obj_interface chunk_compile(chunk_get_key());
}