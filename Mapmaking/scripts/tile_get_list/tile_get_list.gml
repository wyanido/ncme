
function TileDesc() constructor
{
	
}

function tile_get_list()
{
	
	function AddItem(_id, _label, _w, _h) constructor
	{
		var tl = new TileDesc(), len = array_length(list);
		tl.hai = _id;
		tl.label = _label;
		tl.index = len;
		tl.size = new vec2(_w, _h);
		
		list[len] = tl;
	}

	list = [];
	
	AddItem(tile.floor_grass, "Grass Tile", 1, 1);
	
	// -- Paths
	AddItem(tile.floor_dirt, "Dirt Path", 1, 1);
	AddItem(tile.floor_dirtS, "Dirt Path S", 1, 1);
	AddItem(tile.floor_dirtN, "Dirt Path N", 1, 1);
	AddItem(tile.floor_dirtE, "Dirt Path E", 1, 1);
	AddItem(tile.floor_dirtW, "Dirt Path W", 1, 1);
	AddItem(tile.floor_dirtSEOut, "Dirt Path SE (Out)", 1, 1);
	AddItem(tile.floor_dirtSWOut, "Dirt Path SW (Out)", 1, 1);
	AddItem(tile.floor_dirtNWOut, "Dirt Path NE (Out)", 1, 1);
	AddItem(tile.DirtPathNWOut, "Dirt Path NW (Out)", 1, 1);
	AddItem(tile.DirtPathSEIn, "Dirt Path SE (In)", 1, 1);
	AddItem(tile.DirtPathSWIn, "Dirt Path SW (In)", 1, 1);
	AddItem(tile.DirtPathNEIn, "Dirt Path NE (In)", 1, 1);
	AddItem(tile.DirtPathNWIn, "Dirt Path NW (In)", 1, 1);
	
	AddItem(tile.PineTree, "Pine Tree", 2, 2);
	AddItem(tile.TallPineTree, "Tall Pine Tree", 2, 2);
	AddItem(tile.OakTree, "Oak Tree", 2, 2);
	AddItem(tile.TallOakTree, "Tall Oak Tree", 2, 2);
	
	AddItem(tile.cliffN_S, "Small Cliff N (Grassy)", 1, 1);
	AddItem(tile.cliffS_S, "Small Cliff S (Grassy)", 1, 1);
	AddItem(tile.cliffE_S, "Small Cliff E (Grassy)", 1, 1);
	AddItem(tile.cliffW_S, "Small Cliff W (Grassy)", 1, 1);
	AddItem(tile.cliffSEOut_S, "Small Cliff SE (Out, Grassy)", 1, 1);
	AddItem(tile.cliffSWOut_S, "Small Cliff SW (Out, Grassy)", 1, 1);
	AddItem(tile.cliffNEOut_S, "Small Cliff NE (Out, Grassy)", 1, 1);
	AddItem(tile.cliffNWOut_S, "Small Cliff NW (Out, Grassy)", 1, 1);
	AddItem(tile.cliffNWIn_S, "Small Cliff NW (In, Grassy)", 1, 1);
	AddItem(tile.cliffNEIn_S, "Small Cliff NE (In, Grassy)", 1, 1);
	AddItem(tile.cliffSWIn_S, "Small Cliff SW (In, Grassy)", 1, 1);
	AddItem(tile.cliffSEIn_S, "Small Cliff SE (In, Grassy)", 1, 1);
	
	AddItem(tile.tallgrass, "Tall Grass", 1, 1);
	AddItem(tile.tallgrass_thick, "Tall Grass (Thick)", 1, 1);
	
	AddItem(tile.land_rock_S, "Rock", 1, 1);
	AddItem(tile.land_rock_L, "Rock (Large)", 2, 2);
	
	return list;
}