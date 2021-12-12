draw_clear_alpha(0x111111, 1);

if !global.compiled_view
{	
	var	xw = 50.5,
			yv = 85.5;
	
	view_mat = matrix_build_lookat(640 - xw, 360 - yv, -16000, 640 - xw, 360 - yv, 0, 0, 1, 0);
	proj_mat = matrix_build_projection_ortho(1280, 720, 1, 16000);
}
else
{
	to.x = pos.x + dcos(yaw) * dcos(pitch);
	to.y = pos.y - dsin(yaw) * dcos(pitch);
	to.z = pos.z + dsin(pitch);

	view_mat = matrix_build_lookat(pos.x, pos.y, pos.z, to.x, to.y, to.z, 0, 0, 1);
	proj_mat = matrix_build_projection_perspective_fov(-70, -616 / 720, 0.5, 32000);
}

// Set projection
var cam = camera_get_active();
	
camera_set_view_mat(cam, view_mat);
camera_set_proj_mat(cam, proj_mat);
	
camera_apply(cam);

// Scene Grid
if global.compiled_view { vertex_submit(mdl_grid, pr_linelist, -1) }