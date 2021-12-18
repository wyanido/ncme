/// -- @desc UI control
// Exit if not in edit mode
var	editor_active = !global.viewport_3d && point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), 0, 0, viewport_w, 720);
if !editor_active return;

var	mouse = mouseToGrid(),
		_chunk = mouseToChunk();

var	lmb = mouse_check_button(mb_left),
		rmb = mouse_check_button(mb_right),
		mmb = mouse_check_button(mb_middle);

// Tile placement
if ( lmb || rmb || mmb ) {
	chunk_selected = new vec2(_chunk.x, _chunk.y);
}

// Action history
historyTrimEarliest();

if stroke_active && (chunk_get_key() != stroke_chunk || obj_layers.sel != stroke_layer) || (mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right)) {
	// End stroke
	historyLogEnd();
}

if !stroke_active && ( lmb || rmb ) {
	// Begin stroke
	tile_previous = undefined;
	historyLogStart();
}

var place_valid = true;

if tile_previous != undefined
{
	var	pre_space_x = abs(mouse.x - tile_previous.x),
			pre_space_y = abs(mouse.y - tile_previous.y);
		
	// Test if new placement intersects with previous tile
	var place_valid = pre_space_x >= obj_tiles.list[| obj_tiles.sel].size.x || pre_space_y >= obj_tiles.list[| obj_tiles.sel].size.y;
}

if place_valid
{
	var set_tile = undefined;

	if ( lmb || rmb )
	{
		if lmb
			set_tile = new ChunkTile(obj_tiles.sel, 15 - obj_tileheight.sel);
		else if rmb
			set_tile = new ChunkTile(undefined, -1);
		
		var this_layer = chunk_get_tiles(chunk_selected.x, chunk_selected.y, obj_layers.sel);
		var target = this_layer[# mouse.x, mouse.y];
		
		var is_same_tile = ( target.type == set_tile.type ) && ( 15 - obj_tileheight.sel == target.z );
		var already_empty = set_tile.type == undefined && target.type == undefined;
		
		if set_tile != undefined && !already_empty && !is_same_tile
		{
			action_meaningful = true;
			tile_previous = new vec2(mouse.x, mouse.y);
			
			this_layer[# mouse.x, mouse.y] = set_tile;

			layer_compile(chunk_get_key(), obj_layers.sel);
		}
	}
}