
label = "Open";
icon = ui_open;

onUpdate = function()
{
	active = !global.viewport_is_3d;	
}

onClick = function()
{
	with obj_interface
	{
		map_import()
	}
}