
function chunk_fill_empty()
{
	with(GAME)
		{
			if(GAME.mapData.chunk[? chunk_get_key()] == undefined)
			{
				mapData.chunk[? chunk_get_key()] = new Chunk(GAME.selChunk.x, GAME.selChunk.y);
			}
		}
}