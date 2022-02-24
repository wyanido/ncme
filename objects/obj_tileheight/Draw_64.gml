/// -- @desc Tile height selection
// Heights

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_UI_small);

var	height = bbox_bottom - bbox_top,
		width = bbox_right - bbox_left,
		max_h = height / 31;

var i = 15;
for(var h = 0; h < 31; h ++)
{
	var v = y + (h * max_h);
	var col = make_colour_hsv((31 - h) * 5, 128 + (128 * (h mod 2)), 255);
	
	draw_set_colour(col);
	draw_rectangle(x, v, x + width, v + max_h, false);
	
	draw_set_colour(c_black);
	draw_text(lerp(bbox_left, bbox_right, 0.5) + 1, lerp(v, v + max_h, 0.5) + 1, string(i));
	
	i --;
}

// Border
draw_set_colour(c_white);
draw_border_width(bbox_left, bbox_top, bbox_right, bbox_bottom, 2);

// Selection Highlight
var v = y + ((15 - sel) * max_h);
draw_set_colour(0x000FFF);
draw_rectangle(x + 1, v, x + width, v + max_h, true);
draw_set_alpha(0.3);
draw_rectangle(x + 1, v, x + width, v + max_h, false);	
draw_set_alpha(1);
