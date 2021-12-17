/// -- @desc Initialise UI
// Editor settings
max_undo_history = 30;

// Globals
global.compiled_view = false;

vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();

global.vformat = vertex_format_end();
global.model_cache = ds_map_create();

action_list = [];
action_number = 0;
action_meaningful = false;
stroke_begin = undefined;

// Chunk data
z_selected = 15;

global.chunk = ds_map_create();
global.chunk[? "0,0"] = new Chunk(0, 0);
chunk_selected = new vec2(0, 0);

chunk_mesh = ds_map_create();
chunk_mesh[? chunk_get_key()] = array_create(8, undefined);

// Render Config
gpu_set_ztestenable(true);
gpu_set_tex_repeat(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

viewport_w = 608;

view_set_wport(0, viewport_w);
view_set_wport(1, room_width - viewport_w);
view_set_xport(1, viewport_w)
window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);