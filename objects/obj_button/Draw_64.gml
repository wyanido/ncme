/// -- @desc Draw button

if hidden return;

//  BG
draw_set_colour(hovering ? 0x6B5854 : 0x332420);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	
draw_set_colour(active ? c_white : 0x7f675b);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		
// Label / Icon
if icon != undefined
{
	var pad = 8;
	var scale = (min(bbox_right - bbox_left, bbox_bottom - bbox_top) - pad) / 32;
	
	gpu_set_tex_filter(true);
	draw_sprite_ext(icon, 0, lerp(bbox_left, bbox_right, 0.5), lerp(bbox_top, bbox_bottom, 0.5), scale, scale, 0, active ? c_white : 0x7F675B, 1);
	gpu_set_tex_filter(false);
}
else
{
	draw_set_font(fnt_UI);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(lerp(bbox_left, bbox_right, 0.5), lerp(bbox_top, bbox_bottom, 0.5), label);
}