if (obj_game_manager.curr_game_state == GAME_STATE.PLAYING){
	// Sets the flash to the gun angle
	image_angle = owner.gun_angle;

	// Set offset for flash orgin from original gun position
	var _projectile_origin_x = 104;
	//var _projectile_origin_y = -2;
	var _projectile_origin_y = player_instance._projectile_offset;
	
	// Store the angle in radians
	var _theta = degtorad(image_angle);

	// Calculate adjusted position from offset and angle
	var _projectile_adjust_x = (_projectile_origin_x * cos(_theta)) - (_projectile_origin_y * sin(_theta));
	var _projectile_adjust_y = (_projectile_origin_y * cos(_theta)) + (_projectile_origin_x * sin(_theta));

	// Apply adjusted position to the flash position
	x = owner.x + _projectile_adjust_x;
	y = owner.y - _projectile_adjust_y;
}