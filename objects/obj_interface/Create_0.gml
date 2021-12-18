/// -- @desc Initialise UI
// Editor settings
max_undo_history = 30;

// Globals
vertex_format_begin();

vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();

global.vformat = vertex_format_end();
global.model_cache = ds_map_create();
global.viewport_3d = false;

// Undo / Redo History
action_list = [];
action_number = 0;
action_meaningful = false;

stroke_begin = undefined;
stroke_chunk = undefined;
stroke_layer = undefined;
stroke_active = false;

tile_previous = undefined;

// Chunk data
global.chunk = map_format();

chunk_selected = new vec2(0, 0);
chunk_mesh = ds_map_create();
chunk_mesh[? chunk_get_key()] = array_create(8, undefined);

// Render Config
gpu_set_ztestenable(true);
gpu_set_tex_repeat(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

// Viewport & Window
viewport_w = 608;

view_set_wport(0, viewport_w);
view_set_wport(1, room_width - viewport_w);
view_set_xport(1, viewport_w)
window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);

// Functions
mouseToGrid = function()
{
	var	mgrid_x = floor(mouse_x / 16) mod 32,
			mgrid_y = floor(mouse_y / 16) mod 32;
	
	while mgrid_x < 0 mgrid_x += 32;
	while mgrid_y < 0 mgrid_y += 32;

	return new vec2(mgrid_x, mgrid_y);
}

mouseToChunk = function()
{
	var	chunkgrid_x = floor(mouse_x / 512), 
			chunkgrid_y = floor(mouse_y / 512);
			
	return new vec2(chunkgrid_x, chunkgrid_y);
}

historyTrimEarliest = function()
{
	while array_length(action_list) > max_undo_history
	{
		array_delete(action_list, 0, 1);
		action_number --;
	}
}

historyLogStart = function()
{
	var _chunk = mouseToChunk();
	var lr = chunk_get_tiles(_chunk.x, _chunk.y, obj_layers.sel);
	
	action_meaningful = false;	
	stroke_begin = ds_grid_create(32, 32);
	stroke_chunk = chunk_get_key();
	stroke_layer = obj_layers.sel;
	stroke_active = true;
		
	ds_grid_copy(stroke_begin, lr);
}

historyLogEnd = function()
{
	var mouse = mouseToGrid();

	if action_meaningful
	{
		var action_data = {
			chunk: stroke_chunk,
			layer: stroke_layer,
			x: mouse.x,
			y: mouse.y,
			type: "layer_adjust",
			from: ds_grid_create(32, 32),
			to: ds_grid_create(32, 32)
		}
		
		ds_grid_copy(action_data.from, stroke_begin);
		ds_grid_copy(action_data.to, global.chunk[? stroke_chunk].layers[stroke_layer].tiles);
			
		array_insert(action_list, action_number, action_data);	
		action_number ++;
			
		array_delete(action_list, action_number, array_length(action_list) - action_number);
	}
		
	stroke_active = false;
}