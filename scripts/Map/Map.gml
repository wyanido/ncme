
function Chunk(_x, _y) constructor
{
	pos_x = _x;
	pos_y = _y;
	
	layers = [ ];
	
	repeat(8) array_push(layers, new ChunkLayer());
}

function ChunkLayer() constructor
{
	tiles = ds_grid_create(32, 32);
	ds_grid_set_region(tiles, 0, 0, 31, 31, new ChunkTile(undefined, -1));
}

function ChunkTile(_tile_index, _z) constructor
{
	type = _tile_index;
	z = _z;
}