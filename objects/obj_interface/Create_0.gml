/// -- @desc Initialise UI
// Editor settings
window_set_min_width(window_get_width());
window_set_min_height(window_get_height());

// Undo / Redo History
action_list = [];
action_number = 0;
action_meaningful = false;

stroke_begin = undefined;
stroke_chunk = undefined;
stroke_layer = undefined;
stroke_active = false;

tile_previous = undefined;

chunk_selected = new vec2(0, 0);
chunk_mesh = ds_map_create();
chunk_mesh[? chunk_get_key()] = array_create(LAYER_COUNT, undefined);

// Render Config
gpu_set_ztestenable(true);
gpu_set_tex_repeat(false);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

// Functions
historyTrimEarliest = function()
{
	while (array_length(action_list) > UNDO_MAX)
	{
		array_delete(action_list, 0, 1);
		action_number --;
	}
}

historyLogStart = function()
{
	var _chunk = point_to_chunk(mouse_x, mouse_y);
	var lr = chunk_get_tiles(_chunk.x, _chunk.y, obj_layers.sel);
	
	action_meaningful = false;	
	stroke_begin = ds_grid_create(CHUNK_SIZE, CHUNK_SIZE);
	stroke_chunk = chunk_get_key();
	stroke_layer = obj_layers.sel;
	stroke_active = true;
		
	ds_grid_copy(stroke_begin, lr);
}

historyLogEnd = function()
{
	var mouse = point_to_tile(mouse_x, mouse_y);

	if (action_meaningful)
	{
		var action_data = {
			chunk: stroke_chunk,
			layer: stroke_layer,
			x: mouse.x,
			y: mouse.y,
			type: "layer_adjust",
			from: ds_grid_create(CHUNK_SIZE, CHUNK_SIZE),
			to: ds_grid_create(CHUNK_SIZE, CHUNK_SIZE)
		}
		
		ds_grid_copy(action_data.from, stroke_begin);
		ds_grid_copy(action_data.to, global.chunk[? stroke_chunk].layers[stroke_layer].tiles);
			
		array_insert(action_list, action_number, action_data);	
		action_number ++;
			
		array_delete(action_list, action_number, array_length(action_list) - action_number);
	}
		
	stroke_active = false;
}

windowCheckResize = function()
{
	if	(window_get_width() != display_get_gui_width()) || 
		(window_get_height() != display_get_gui_height())
	{
		var	new_w = window_get_width(),
				new_h = window_get_height();
		
		global.viewport_w = new_w - 608;
	
		surface_resize(application_surface, new_w, new_h);
		display_set_gui_size(new_w, new_h);
	
		view_set_wport(0, global.viewport_w);
		view_set_hport(0, new_h);
	
		view_set_wport(1, new_w - global.viewport_w);
		view_set_hport(1, new_h);
	
		view_set_xport(1, global.viewport_w);
	}
}