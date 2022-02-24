/// -- @desc UI control
windowCheckResize();

// Exit if not in edit mode
var	editor_active = !global.viewport_is_3d && point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), 0, 0, global.viewport_w, window_get_height());
if (!editor_active) {
	if (stroke_active) {
		historyLogEnd();
	}
	return;
}

var	mouse = point_to_tile(mouse_x, mouse_y),
		_chunk = point_to_chunk(mouse_x, mouse_y);

var	lmb = mouse_check_button(mb_left),
		rmb = mouse_check_button(mb_right);

// Tile placement
if (mouse_check_button(mb_any)) {
	chunk_selected = new vec2(_chunk.x, _chunk.y);
}

// Action history
historyTrimEarliest();

if (stroke_active) 
{
	if	(chunk_get_key() != stroke_chunk || obj_layers.sel != stroke_layer) || 
		(mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right)) ||
		!window_has_focus()
	{
		// End stroke
		historyLogEnd();
	}
}

if ( !stroke_active && (lmb || rmb) ) {
	// Begin stroke
	tile_previous = undefined;
	historyLogStart();
}

var place_valid = true;

if (tile_previous != undefined)
{
	var	pre_space_x = abs(mouse.x - tile_previous.x),
			pre_space_y = abs(mouse.y - tile_previous.y);
	
	// Test if new placement intersects with previous tile
	var place_valid = pre_space_x >= obj_tiles.list[| obj_tiles.sel].size.x || pre_space_y >= obj_tiles.list[| obj_tiles.sel].size.y;
}

if (place_valid)
{
	var set_tile = undefined;
	
	if ( lmb || rmb )
	{
		if (lmb) {
			set_tile = new ChunkTile(obj_tiles.sel, obj_tileheight.sel);
		} else if (rmb) {
			set_tile = new ChunkTile(undefined, -1);
		}
		
		var this_layer = chunk_get_tiles(chunk_selected.x, chunk_selected.y, obj_layers.sel);
		var target = this_layer[# mouse.x, mouse.y];
		
		var is_same_tile = ( target.type == set_tile.type ) && ( obj_tileheight.sel == target.z );
		var already_empty = set_tile.type == undefined && target.type == undefined;
		
		if ( set_tile != undefined && !already_empty && !is_same_tile )
		{
			action_meaningful = true;
			tile_previous = new vec2(mouse.x, mouse.y);
			
			this_layer[# mouse.x, mouse.y] = set_tile;
			
			var	ckey = chunk_get_key(),
					cmx = mouse.x * 2,
					cmy = mouse.y * 2;
			
			var hmap = global.heightmap[? ckey];
			hmap[# cmx, cmy] = obj_tileheight.sel + global.heightmap_vert_tl;
			hmap[# cmx + 1, cmy] = obj_tileheight.sel + global.heightmap_vert_tr;
			hmap[# cmx, cmy + 1] = obj_tileheight.sel + global.heightmap_vert_bl;
			hmap[# cmx + 1, cmy + 1] = obj_tileheight.sel + global.heightmap_vert_br;
			
			layer_compile(ckey, obj_layers.sel);
			hmap_compile_mesh(ckey);
		}
	}
}