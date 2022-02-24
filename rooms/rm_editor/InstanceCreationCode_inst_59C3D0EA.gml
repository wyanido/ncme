
z = 0;
global.heightmap_vert_tr = z;
label = string(z);

onUpdate = function()
{
	
}

onClick = function()
{
	var new_z = get_string("Enter new Z offset for tile vertex", string(z));
	
	label = string(new_z);
	z = real(new_z);
	
	global.heightmap_vert_tr = z;
}