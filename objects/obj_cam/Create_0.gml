/// -- @desc Initialise camera

view_mat = undefined;
proj_mat = undefined;
	
pos = new vec3(256, 256, 512);
to = new vec3(0, 0, 0);
pitch = -90;
yaw = 90;

spd = 4;

mdl_grid = create_grid_model(6);
