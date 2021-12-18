
label = "Save";
icon = ui_save;

onUpdate = function()
{
	active = !global.viewport_3d;	
}

onClick = function()
{
	with obj_interface
	{
		map_export()
	}
}