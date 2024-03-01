// Checks game is not paused
if (obj_game_manager.curr_game_state != GAME_STATE.PAUSED)
{	
	// Checks if enemy is spawning
	if (is_spawning)
	{
		// Slows enemy to half speed but still lets them move into arena
		speed = 1.5;	
	}
	else
	{	
		// Sets colliding state to true
		is_colliding = true;
	
		// Recalculates path to target
		find_path();
	
		// Calculates distance to player
		var _player_dist = point_distance(x, y, other.x, other.y);
		// Calculates direction of player
		var _player_dir = point_direction(other.x, other.y, x, y);
		// Sets buffer value to repel from player
		var _buff = 184;
		
		// Calculates speed of repulsion from player
		var _repulse_x = lengthdir_x(clamp(1 - _player_dist / _buff, 0, 1), _player_dir) * _buff;
		var	_repulse_y = lengthdir_y(clamp(1 - _player_dist / _buff, 0, 1), _player_dir) * _buff;

		// Adjusts the new speed
		var _adjusted_speed_x = lerp(hspeed, hspeed + _repulse_x, repulse_rate) * speed_dropoff;
		var _adjusted_speed_y = lerp(vspeed, vspeed + _repulse_y, repulse_rate) * speed_dropoff;
	
		// Applies the speed to the position
		x = lerp(x, x + _adjusted_speed_x, 0.99);
		y = lerp(y, y + _adjusted_speed_y, 0.99);
	
		// Slows the speed down
		speed *= speed_dropoff;
	}
}


if (owner.id != other.id)
{
	// Checks if the player is flashed
	if (!other.is_flashed)
	{
		// Checks if the owner is a player
		if (owner.object_index == obj_player)
		{
			// Stores the owners local id
			var _owner_id = owner.player_local_id;
		
			// Loops through players
			with (obj_player)
			{
				// Checks if the players local id matches its own local id
				if (self.player_local_id == _owner_id)
				{
					// Increases the players score by 500
					global.player_score += 500;
				}
			}
		}
		
		if (contact_damage_cooldown > 0)
		{
			// reduces the fireing cooldown
			contact_damage_cooldown -= delta_time * 0.000001;
		}
		// Sets the player to flashed state
		other.is_flashed = true;
		// Sets the hud alpha for player to 1 meaning it will fade out
		other.hud_health_alpha = 1.0;
		// Reduces the players health
		other.player_health--;
		global.player_score = global.player_score - 200;
		// Plays player hit sound effect
		var _sound_player_hit = audio_play_sound(snd_player_hit, 100, false, 0.6, 0, 1.0);
	}
}