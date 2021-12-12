/// -- @desc Refresh map mesh

if !global.compiled_view
{
	if refresh_layer
	{
		map_compile();
		
		refresh_layer = false;
	}
		
	if refresh_map
	{
		map_compile();
		
		refresh_map = false;
	}
}
