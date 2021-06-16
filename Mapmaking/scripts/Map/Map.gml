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
	tallgrass_thick,
	
	land_rock_S,
	land_rock_L
	
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
		
		var posX = _x * 16, posY = _y * 16;
		var frame = -1;
		
		switch(hai)
		{
			default:
				if(hai >= 2 && hai <= 14) frame = hai - 1;
				if(hai >= 19 && hai <= 30) frame = hai - 3;
			break;
			case(tile.floor_grass): draw_sprite_part(sTile_Full, 0, posX mod 64, posY mod 64, 16, 16, posX + 1, posY + 1); break;
			
			case(tile.TallPineTree):
			case(tile.PineTree): frame = 14; break;
			
			case(tile.TallOakTree):
			case(tile.OakTree): frame = 15; break;
			
			case(tile.tallgrass): frame = 28; break;
			case(tile.tallgrass_thick): frame = 29; break;
			
			case(tile.land_rock_S): frame = 30; break;
			case(tile.land_rock_L): frame = 31; break;
		}
		
		if(frame != -1)
		{
			draw_sprite(sTile_Full, frame, posX + 1, posY + 1);
		}

	}
		
}