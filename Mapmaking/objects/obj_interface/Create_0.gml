/// -- @desc Initialise UI
// Globals
global.compiled_view = false;
global.surf_sprite = undefined;

// Chunk data
compiled = false;
selTile = 0;
selChunk = new vec2(0, 0);
selLayer = 0;
selZ = 15;

mapData = new Map();
chunkMesh = ds_map_create();		
preTile = new vec2(-1, -1);
		
refreshMap = false;
updateMap = false;

tiles = tile_get_list();
hoverTile = noone;

// Config
application_surface_draw_enable(false)

gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
