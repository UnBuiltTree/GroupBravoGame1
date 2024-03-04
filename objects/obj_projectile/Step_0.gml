// Checks if x position has left the playable area
if (x < wall_buffer || x > (obj_game_manager.arena_grid_width * obj_game_manager.cell_width) - wall_buffer)
{
	// Calls spark function
	spark_projectile();
}

// Checks if the y position has left the playable area
if (y < wall_buffer || y > (obj_game_manager.arena_grid_height * obj_game_manager.cell_height) - wall_buffer)
{
	// Calls the spark function
	spark_projectile();
}

direction = direction + _spread;
image_angle = image_angle + _spread;
if (spread_counter <= spread_limit){
	_spread = 0;
} else {
	spread_counter++;
}