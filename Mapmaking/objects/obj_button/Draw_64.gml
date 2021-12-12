/// -- @desc Draw button

if hidden return;

//  BG
draw_set_colour(hovering ? 0x6B5854 : 0x332420);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	
draw_set_colour(active ? c_white : 0x7f675b);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		
// Label
draw_set_font(fnt_UI);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
	
draw_text(lerp(bbox_left, bbox_right, 0.5), lerp(bbox_top, bbox_bottom, 0.5), label);
