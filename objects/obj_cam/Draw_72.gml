draw_clear_alpha(0x111111, 1);

if !global.compiled_view
{	
	var	chunk_x = obj_interface.selChunk.x * 32 * 16 + 0.5,
			chunk_y = obj_interface.selChunk.y * 32 * 16 + 0.5;
	
	view_mat = matrix_build_lookat(256.5 + chunk_x, 256.6 + chunk_y, 1600, 256.6 + chunk_x, 256.5 + chunk_y, 0, 0, 1, 0);
	proj_mat = matrix_build_projection_ortho(-616, 720, 1, 16000);
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
camera_set_view_mat(0, view_mat);
camera_set_proj_mat(0, proj_mat);

camera_apply(0);
view_set_camera(0, 0);

// Scene Grid
matrix_set(matrix_world, matrix_build_identity());
vertex_submit(mdl_grid, pr_linelist, -1)