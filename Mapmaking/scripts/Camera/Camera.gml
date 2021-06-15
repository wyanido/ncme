
function Camera() constructor
{
	
	application_surface_draw_enable(false)

	view_mat = undefined;
	proj_mat = undefined;
	
	pos = new vec3(256, 256, 512);
	to = new vec3(0, 0, 0);
	fov = 70;
	pitch = -90;
	yaw = 90;

	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	gpu_set_alphatestenable(true);
	
	view3D = false;
	grid = create_grid_model(6);
	
	Update = function()
	{

		if(view3D)
		{
				
			if(keyboard_check_pressed(vk_escape))
			{ 
				view3D = false; 
				
				for(var _c = ds_map_find_first(GAME.chunkMesh); _c < ds_map_size(GAME.chunkMesh) - 1; _c = ds_map_find_next(GAME.chunkMesh, _c))
				{
					if(GAME.chunkMesh[? _c] != noone)
					{
						vertex_delete_buffer(GAME.chunkMesh[? _c]);
						GAME.chunkMesh[? _c] = noone;
					}
				}
			}
			
			yaw -= (window_mouse_get_x() - 308) / 10;
			pitch = clamp(pitch - (window_mouse_get_y() - 360) / 10, -89, 89);
	
			if(keyboard_check(vk_lshift)) { pos.z -= 4; }
			if(keyboard_check(vk_space)) { pos.z += 4; }
	
			window_mouse_set(308, 360);

			if (keyboard_check(ord("A"))){
				pos.x -= dsin(yaw) * 4;
				pos.y -= dcos(yaw) * 4;
			}

			if (keyboard_check(ord("S"))){
				pos.x -= dcos(yaw) * 4;
				pos.y += dsin(yaw) * 4;
			}

			if (keyboard_check(ord("D"))){
				pos.x += dsin(yaw) * 4;
				pos.y += dcos(yaw) * 4;
			}

			if (keyboard_check(ord("W"))) {
				pos.x += dcos(yaw) * 4;
				pos.y -= dsin(yaw) * 4;
			}	
		
			to.x = pos.x + dcos(yaw) * dcos(pitch);
			to.y = pos.y - dsin(yaw) * dcos(pitch);
			to.z = pos.z + dsin(pitch);
			
			view_mat = matrix_build_lookat(pos.x, pos.y, pos.z, to.x, to.y, to.z, 0, 0, 1);
			proj_mat = matrix_build_projection_perspective_fov(-fov, -616 / 720, 0.5, 32000);
			
		}

	}
	
	Render = function()
	{
		
		draw_clear_alpha(0x111111, 1);
		
		if(view3D)
		{
			
			var _cam = camera_get_active();
				
	        camera_set_view_mat(_cam, view_mat);
	        camera_set_proj_mat(_cam, proj_mat);
	        camera_apply(_cam);
			
			vertex_submit(grid, pr_linelist, -1);
			
		}
		else
		{
		
			view_mat = matrix_build_lookat(589.5, 274.5, -16000, 589.5, 274.5, 0, 0, 1, 0);
			proj_mat = matrix_build_projection_ortho(1280, 720, 1, 16000);
			
			var _cam = camera_get_active();
	        camera_set_view_mat(_cam, view_mat);
	        camera_set_proj_mat(_cam, proj_mat);
	        camera_apply(_cam);
		
		}
	}
	
}