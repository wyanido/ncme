function draw_grid(xx, yy, w, h, s, a)
{
	
	var oA = draw_get_alpha();
	draw_set_alpha(a);
		
	for(var _x = 0; _x < w; _x ++)
	{
		draw_rectangle(1 + xx,		1 + yy,	xx + _x * s + s,		 yy + (h * s), true);
	}
	
	for(var _y = 0; _y < h; _y ++)
	{
		draw_rectangle(1 + xx,		1 + yy,	xx + (w * s),		 yy + _y * s + s, true);
	}
	
	draw_set_alpha(oA);
	
}