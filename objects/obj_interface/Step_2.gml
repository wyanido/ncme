/// -- @desc Refresh map mesh

if !global.compiled_view
{
	if refresh_map
	{
		map_compile();
		
		refresh_map = false;
	}
}
