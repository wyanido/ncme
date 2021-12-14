/// -- @desc Camera control
// Exit compiled view and destroy mesh
if !global.compiled_view return;

// Freecam control
// Look
yaw -= (window_mouse_get_x() - 308) / 10;
pitch = clamp(pitch - (window_mouse_get_y() - 360) / 10, -89, 89);
	
window_mouse_set(308, 360);

// From
pos.z += (keyboard_check(ord(("E"))) - keyboard_check(ord("Q"))) * spd;

var da_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
pos.x += da_dir * (dsin(yaw) * spd);
pos.y += da_dir * (dcos(yaw) * spd);

var sw_dir = keyboard_check(ord("S")) - keyboard_check(ord("W"));
pos.x -= sw_dir * (dcos(yaw) * spd);
pos.y += sw_dir * (dsin(yaw) * spd);
