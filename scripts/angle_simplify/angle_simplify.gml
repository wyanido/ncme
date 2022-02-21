function angle_simplify(angle)
{
	var new_angle = angle;
	
	while (new_angle < 0) {
		new_angle += 360;	
	}

	while (new_angle >= 360) {
		new_angle -= 360;	
	}
	
	return new_angle;
}