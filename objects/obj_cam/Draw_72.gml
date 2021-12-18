draw_clear_alpha(0x111111, 1);

if !global.viewport_3d
{	
	var	vx = 256 + round(x),
			vy = 256 + round(y);
	
	view_mat = matrix_build_lookat(vx, vy, 1600, vx, vy, 0, 0, 1, 0);
	proj_mat = matrix_build_projection_ortho(-obj_interface.viewport_w * zoom, 720 * zoom, 1, 16000);
	
	// Adjust 3D position to editor position
	pos.x = vx;
	pos.y = vy;
	pos.z = obj_interface.viewport_w * zoom - 96;
	
	yaw = 90;
	pitch = -90;
}
else
{
	to.x = pos.x + dcos(yaw) * dcos(pitch);
	to.y = pos.y - dsin(yaw) * dcos(pitch);
	to.z = pos.z + dsin(pitch);
	
	view_mat = matrix_build_lookat(pos.x, pos.y, pos.z, to.x, to.y, to.z, 0, 0, 1);
	proj_mat = matrix_build_projection_perspective_fov(-70, -obj_interface.viewport_w / 720, 0.5, 32000);
}

// Set projection
camera_set_view_mat(0, view_mat);
camera_set_proj_mat(0, proj_mat);

camera_apply(0);
view_set_camera(0, 0);

// Scene Grid
matrix_set(matrix_world, matrix_build_identity());
gpu_set_zwriteenable(false);
vertex_submit(mdl_grid, pr_linelist, -1)
gpu_set_zwriteenable(true);