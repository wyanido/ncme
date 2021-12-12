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
}

function Chunk(_x, _y) constructor
{
	pos_x = _x;
	pos_y = _y;
	
	layers = ds_list_create();
	render_cache = array_create(8, undefined);
	
	repeat(8) ds_list_add(layers, new ChunkLayer());
}

function ChunkLayer() constructor
{
	tiles = ds_grid_create(32, 32);
	ds_grid_set_region(tiles, 0, 0, 31, 31, new ChunkTile(tile.none, obj_interface.selZ));
}

function ChunkTile(_type, _z) constructor
{
	tile_type = _type;
	z = _z;
}