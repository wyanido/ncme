
function draw_border_width(x1, y1, x2, y2, w)
{

		draw_line_width(x1 - w * 0.5,			y1 - w * 0.5 + 1,		x2 + w * 0.5,				y1 - w * 0.5 + 1,		w);
		draw_line_width(x1 - w * 0.5 + 1,	y1 - w * 0.5,				x1 - w * 0.5 + 1,		y2 + w * 0.5,				w);
		draw_line_width(x1 - w * 0.5,			y2 + w * 0.5,				x2 + w * 0.5 + 2,				y2 + w * 0.5,		w);
		draw_line_width(x2 + w * 0.5,			y1 - w * 0.5,				x2 + w * 0.5,				y2 + w * 0.5 + 2,				w);

}