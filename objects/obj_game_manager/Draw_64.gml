// Checks the current game state is playing

if(curr_game_state == GAME_STATE.PLAYING)
{	
	// Loops through the player objects
	with (obj_player)
	{
		// Draws the hud sprite in the top left corner
		// draw_sprite(spr_hud_background, 0, 0, 0);
			
		// Checks if the player health is above 0
		/*if (player_health >= 1)
		{
			// Draws the first health bar sprite at full strength
			draw_sprite_ext(spr_hud_health, 0, 86, 40, 1.0, 1.0, 0, c_white, 1.0);	
			
			// Checks the players health is above 1
			if (player_health >= 2)
			{
				// Draws the second health sprite at full strength
				draw_sprite_ext(spr_hud_health, 0, 237, 40, 1.0, 1.0, 0, c_white, 1.0);
				
				// Checks the players health is above 2
				if (player_health >= 3)
				{
					// Draws the third health sprite at full strength
					draw_sprite_ext(spr_hud_health_end, 0, 385, 40, 1.0, 1.0, 0, c_white, 1.0);
				}
				else
				{
					// Draws the third health sprite at fade out alpha
					draw_sprite_ext(spr_hud_health_end, 0, 385, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);
				}
			}
			else
			{
				// Draws the second health sprite at fade out alpha
				draw_sprite_ext(spr_hud_health, 0, 237, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);	
			}
		}
		else
		{
			// Draws the first health bar sprite at fade out alpha
			draw_sprite_ext(spr_hud_health, 0, 86, 40, 1.0, 1.0, 0, c_white, hud_health_alpha);	
		}*/
		
		for (var _i = 0; _i < global.player_hp_lvl; _i++) {
		    var _x_pos = 86 + 84 * _i; // Starting x position for the first health bar, then move over for each additional bar. Adjust spacing as needed.
		    var _sprite = spr_hud_health; // Default sprite for the health bar
		    var _alpha = 1.0; // Default alpha for full health
    
		    // Check if this is the last health bar piece for a different sprite
		    if (_i == global.player_hp_lvl - 1) {
		        _sprite = spr_hud_health_end; // Change sprite for the last health piece if different
		    }
    
		    // Check if the current health bar should be full strength or faded
		    if (player_health - 1 < _i) {
		        _alpha = hud_health_alpha; // Set alpha to faded if player health is less than the current bar index
		    }
    
		    // Draw the health bar sprite
		    draw_sprite_ext(_sprite, 0, _x_pos, 40, 1.0, 1.0, 0, c_white, _alpha);
		}

		// Loops through the current ammo count
		for (var _i = 0; _i < player_curr_ammo; _i++) {
		    // Calculate row and column based on _i
		    var _row = _i div 32; // 'div' divides and returns the integer quotient (effectively calculating the current row)
		    var _col = _i mod 32; // 'mod' returns the remainder which represents the column in the current row

		    // Calculate x and y positions based on column and row
		    var _x_pos = 48 + _col * 10; // Adjust X position based on column
		    var _y_pos = 85 + _row * 30; // Adjust Y position based on row, change '30' to whatever vertical spacing you prefer

		    // Draw the sprite at the calculated position
		    draw_sprite(spr_hud_ammo, 0, _x_pos, _y_pos);
		}
		
		// Sets the draw options for the scores text
		/*
		draw_set_font(obj_game_manager.score_font);
		draw_set_color(obj_game_manager.score_colour);
		draw_set_alpha(obj_game_manager.score_alpha);
		draw_set_halign(obj_game_manager.score_halign);
		draw_set_valign(obj_game_manager.score_valign);
		*/
		
		// Draws the text
		draw_text(room_width / 2, 64, string(global.player_score));
		
		// Returns the draw options to defaults
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	
	draw_text((room_width/4)*3, 16, string(curr_wave));
	draw_text((room_width/2), 128, string(global.player_coins));
	
	// Hides the cursor
	window_set_cursor(cr_none);
	
	// Sets the alpha to 0.5 for the crosshair
	draw_set_alpha(0.5);
	
	// Checks if the player is aiming
	if (obj_player.is_mouse_aiming)
	{
		// Draws the crosshair sprite on the players mouse position
		draw_sprite(spr_crosshair, 0, mouse_x - x, mouse_y - y);
	}
	else
	{
		// Crosshair position offsets
		var _offset_x = 400;
		var _offset_y = 0;
		
		// Converts angle to radians
		var _theta = degtorad(real(obj_player.gun_angle));
	
		// Calculates the adjusted repositioned angles from the set offsets and angle
		var _crosshair_adjust_x = (_offset_x * cos(_theta)) - (_offset_y * sin(_theta));
		var _crosshair_adjust_y = (_offset_y * cos(_theta)) + (_offset_x * sin(_theta));
	
		// Updates the position to the adjusted player positions
		var _crosshair_pos_x = obj_player.x + _crosshair_adjust_x;
		var _crosshair_pos_y = obj_player.y - _crosshair_adjust_y;
		
		// Sets buffer for crosshair to be from edge of screen
		var _crosshair_buffer = 60;
		
		// Clamps crosshair postions to be in players view
		_crosshair_pos_x = clamp(_crosshair_pos_x - x, _crosshair_buffer, room_width - _crosshair_buffer);
		_crosshair_pos_y = clamp(_crosshair_pos_y - y, _crosshair_buffer, room_height - _crosshair_buffer);
		
		// Draws the crosshair at the adjusted position
		draw_sprite(spr_crosshair, 0, _crosshair_pos_x, _crosshair_pos_y);
	}
	
	// Resets the draw alpha
	draw_set_alpha(1.0);
}
else
{
	// Shows the default normal cursor
	window_set_cursor(cr_default);
}