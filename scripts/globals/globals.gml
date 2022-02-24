// Macros
#macro CHUNK_ORIGIN "0,0"
#macro CHUNK_SIZE 32
#macro TILE_SIZE	16
#macro LAYER_COUNT 8
#macro UNDO_MAX 30

// Globals
vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();

global.vformat = vertex_format_end();

global.model_cache = ds_map_create();

global.viewport_is_3d = false;
global.viewport_w = 608;

global.heightmap_visible = false;

global.tex_world = sprite_get_texture(tx_grass, 0);

global.chunk = map_create_empty();

var sz = CHUNK_SIZE * 2;

global.heightmap = ds_map_create();
global.heightmap[? CHUNK_ORIGIN] = ds_grid_create(sz, sz);
ds_grid_set_region(global.heightmap[? CHUNK_ORIGIN], 0, 0, sz - 1, sz - 1, 0);

global.heightmap_cache = ds_map_create();