
function draw_border_width(x1, y1, x2, y2, width)
{
	var ext = width / 2;
	
	draw_line_width(x1 - ext,	y1, x2 + ext, y1, width);
	draw_line_width(x2,			y1, x2,			y2, width);
	draw_line_width(x1 - ext,	y2, x2 + ext, y2, width);
	draw_line_width(x1,			y1, x1,			y2, width);
}