
switch (global.player_gun_type) {
    case 0:
		//default gun (1 barrel)
        _player_gun = spr_player_gun_0
		gun_fire_rate = 1;
        break;
	case 1:
		//double trouble (2 barrel)
        _player_gun = spr_player_gun_1
		gun_fire_rate = 1/2;
        break;
	case 2:
		//triple threat (3 barrel)
        _player_gun = spr_player_gun_2
		gun_fire_rate = 1/3;
        break;
	case 3:
		//quad barrel (4 barrel)
        _player_gun = spr_player_gun_3
		gun_fire_rate = 1/4;
        break;
	case 4:
		//auto-cannon (1 barrel, High Fire rate)
		_player_gun = spr_player_gun_4
		gun_fire_rate = 1/6;
		break;
    default:
        _player_gun = spr_player_gun_0
		gun_fire_rate = 1;
        break;
}

switch (global.player_hp_lvl) {
    case 3:
        _player_body = 0
        break;
	case 6:
        _player_body = 2
        break;
	case 9:
        _player_body = 4
        break;
    default:
        break;
}

//upgrd_fire_rate = global.player_upgrd_fire_rate;
upgrd_fire_rate = 1 + (global.player_firerate_upgrd/2);

player_initialize = function()
{
// Variable for local player id
player_local_id = 0;
// Variable for player score
player_score = 0;
// Variable for player health
player_health = global.player_hp_lvl;

// Variable for player ammo
player_curr_ammo = global.player_ammo_lvl * 8;
// Variable for player max ammo
player_max_ammo = global.player_ammo_lvl * 8;
// Variable for player fire rate
player_fire_rate = gun_fire_rate / upgrd_fire_rate;

// Variable for firing cooldown
player_fire_cooldown = 0;


_burstfire_num = 0;

// Variable for reload rate
player_reload_rate = 0.075;
// Variable for reload cooldown
player_reload_cooldown = 0;
// Variable for reloading state
player_is_reloading = false; 

// Variable for gamepad deadzone
controller_deadzone = 0.1;
// Variable for if player is mouse aiming
is_mouse_aiming = global.is_mouse_aiming;
// Variable for checking if the first frame has finished (used for mouse aiming)
is_first_frame = true;
// Variable for storing previous mouse positions
mouse_prev_x = mouse_x;
mouse_prev_y = mouse_y;

// Variable for the players buffer distance from arena edges
wall_buffer = 250;
// Variable for players rotation speed
rotation_speed = 0.25;
// Variable for players speed drop off
speed_dropoff = 0.9;
// Variable for players move speed
move_speed = 1;
// Variable for players maximum move speed
max_speed = 10;

// Sets players direction to its image angle
direction = image_angle;
// Variable for players gun angle
gun_angle = direction;
// Variable for players body angle
body_angle = direction;

// Variables for players speeds
hspeed = 0;
vspeed = 0;

// Variable for storing players speed when paused
last_speed = speed;

// Variable for players flashed state
is_flashed = 0;
// Variable for players immunity time
flash_time = 0.2;
// Variable for immunity cooldown
flash_cooldown = flash_time;

// Variable for players last hud alpha
hud_health_alpha = 0;

// Variable for storing players reloading sound
reloading_sound = -1;

_cur_barrel = 0;
}

player_initialize()



// Creates new particle emitter for dust smoke on left
var _new_dust_1 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_1.owner = self;
_new_dust_1.set_dust_smoke(1);

// Creates new particle emitter for dust smoke centre
var _new_dust_2 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_2.owner = self;
_new_dust_2.set_dust_smoke(1);

// Creates new particle emitter for dust smoke on right
var _new_dust_3 = instance_create_depth(x, y, depth - 1, obj_particle_handler);
_new_dust_3.owner = self;
_new_dust_3.set_dust_smoke(3);

// Function for creating projectile from players gun angle
create_projectile = function(_gun_angle)
{
	// Offsets for players gun position
	var _projectile_origin_x = 104;
	
	switch (global.player_gun_type) {
    case 0:
		_projectile_offset = 0;
        break;
	case 1:
		switch (_cur_barrel) {
		    case 0:
		        _projectile_offset = 18;
				_cur_barrel = 1;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 1:
		        _projectile_offset = -18;
				_cur_barrel = 0;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
		}
        break;
	case 2:
		switch (_cur_barrel) {
		    case 0:
		        _projectile_offset = 20;
				_cur_barrel = 1;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 1:
		        _projectile_offset = 0;
				_cur_barrel = 2;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 2:
		        _projectile_offset = -20;
				_cur_barrel = 0;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
		}
        break;
	case 3:
		switch (_cur_barrel) {
		    case 0:
		        _projectile_offset = 22;
				_cur_barrel = 1;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 1:
		        _projectile_offset = -8;
				_cur_barrel = 2;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 2:
		        _projectile_offset = 8;
				_cur_barrel = 3;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
			case 3:
		        _projectile_offset = -22;
				_cur_barrel = 0;
				show_debug_message("current_barrel: " + string(_cur_barrel));
		        break;
		}
        break;
	case 4:
		_projectile_offset = 0;
        break;
    default:
        _projectile_offset = 0;
        break;
}

var _projectile_origin_y = _projectile_offset;
	
	// Gun angle stored in radians
	var _theta = degtorad(_gun_angle);
	
	// Calculates the adjusted positions from offsets and angle
	var _projectile_adjust_x = (_projectile_origin_x * cos(_theta)) - (_projectile_origin_y * sin(_theta));
	var _projectile_adjust_y = (_projectile_origin_y * cos(_theta)) + (_projectile_origin_x * sin(_theta));
	
	// Sets new postions from adjusted positions and players position
	var _projectile_pos_x = x + _projectile_adjust_x;
	var _projectile_pos_y = y - _projectile_adjust_y;

	// Creates new player projectile from the new positions
	var _new_projectile = instance_create_layer(_projectile_pos_x, _projectile_pos_y, "Projectiles", obj_projectile);
	_new_projectile.owner = self;	
	_new_projectile.correct_player();
	
	// Creates new sparked projectile from angle and offset to add to players fired effect
	var _new_hit = instance_create_depth(_projectile_pos_x, _projectile_pos_y, depth - 1, obj_particle_handler);
	_new_hit.set_player_shot();
	_new_hit.owner = self;
	_new_hit.set_angle(_gun_angle);
	_new_hit.set_offset(true, 110, 0)
	
	// Plays firing audio sound
	var _sound_spark = audio_play_sound(snd_player_fire, 100, false, 0.3, 0, 1.0);
}

// Function called when player triggers to fire
trigger_pressed = function()
{
	// Checks if player has ammo and isnt reloading
	if (!player_is_reloading && player_curr_ammo > 0)
	{
		// Checks if the fire cooldown has finished
		if (player_fire_cooldown <= 0)
		{
			// Resets the fire cooldown, uses special burt mode for auto cannon
			if (global.player_gun_type == 4){
				switch (_burstfire_num) {
				    case 6:
				        player_fire_cooldown = player_fire_rate*5;
						_burstfire_num = 0;
				        break;
				    default:
				        player_fire_cooldown = player_fire_rate;
						_burstfire_num++;
				        break;
				}
			}
			else {
				player_fire_cooldown = player_fire_rate;
			}
			// Reduces the ammo
			player_curr_ammo--;
			// Creates a projectile
			create_projectile(gun_angle);
		}
		
		// Stops the reloading sound
		audio_stop_sound(reloading_sound);
	}
	else
	{
		// Sets player to no longer reload
		player_is_reloading = false;
		
		// Stops the reloading sound
		audio_stop_sound(reloading_sound);
		// Plays a gun jam sound effect
		var _sound_jam = audio_play_sound(snd_gun_jam, 100, false, 0.4, 0, 1.0);
		
		// Offsets used for gun jam smoke
		var _projectile_origin_x = 110;
		var _projectile_origin_y = _projectile_offset;
	
		// Angle smoke is created from
		var _theta = degtorad(gun_angle);
	
		// Calculates the adjusted positions
		var _projectile_adjust_x = (_projectile_origin_x * cos(_theta)) - (_projectile_origin_y * sin(_theta));
		var _projectile_adjust_y = (_projectile_origin_y * cos(_theta)) + (_projectile_origin_x * sin(_theta));
	
		// Creates new positons form adjusted position and players position
		var _projectile_pos_x = x + _projectile_adjust_x;
		var _projectile_pos_y = y - _projectile_adjust_y;
		
		// Creates an empty spark particle system from new position
		var _new_empty_spark = instance_create_depth(_projectile_pos_x, _projectile_pos_y, depth - 1, obj_particle_handler);
		_new_empty_spark.set_empty_shot();
		_new_empty_spark.owner = self;
		_new_empty_spark.set_angle(gun_angle);
		_new_empty_spark.set_offset(true, _projectile_origin_x, _projectile_origin_y)
	}
}