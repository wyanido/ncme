/// -- @desc Initialise UI
// Globals
global.compiled_view = false;

// Chunk data
compiled = false;
selTile = 0;
selChunk = new vec2(0, 0);
selLayer = 0;
selZ = 15;

map_data = new Map();
chunk_mesh = ds_map_create();
preTile = new vec2(-1, -1);

refresh_map = false;
refresh_layer = false;

tiles = tile_get_list();
hoverTile = noone;

// Config
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
