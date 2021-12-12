
label = "Compile & View Map Model";

onUpdate = function()
{
	active = !global.compiled_view;	
}

onClick = function()
{
	with(obj_interface) map_compile();
}