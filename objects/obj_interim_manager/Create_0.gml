/*This is the manager i created for the interim menu that
  shows up after clearing a floor ~Weston*/
  
//show_debug_message("Floor Number, iterim manager: " + string(global.floor_number));

// Creates the splash screen squence
layer_sequence_create("Instances", room_width / 2, room_height / 2, seq_interim_menu);
_x_center = room_width / 2
_y_center = room_height / 2

row_top = _y_center-384;
row_1 = _y_center-256;
row_2 = _y_center-128;
row_middle = _y_center;
row_4 = _y_center+128;
row_5 = _y_center+256;
row_bottom = _y_center+384;

clm_left = _x_center - (room_width/4)
clm_mid_left = _x_center - (room_width/6)
clm_middle = _x_center
clm_mid_right = _x_center + (room_width/6)
clm_right = _x_center + (room_width/4)

//a func to creat all the buttons for the upgrade menu ~Weston
create_buttons = function(){
	instance_create_layer(_x_center, row_top, "Buttons", obj_next_floor);
	
	switch (global.player_gun_type) {
	    case 0:
			instance_create_layer(clm_mid_left, row_2, "Buttons", obj_upgrd_btn_turret);
	        instance_create_layer(clm_mid_right, row_2, "Buttons", obj_upgrd_btn_firerate);
			instance_create_layer(clm_right, row_4, "Buttons", obj_upgrd_btn_accuracy);
			instance_create_layer(clm_left, row_4, "Buttons", obj_upgrd_btn_ammo);
			if (global.player_hp_lvl < 9){
				instance_create_layer(clm_middle, row_4, "Buttons", obj_upgrd_btn_armor);
			}
	        break;
		case 4:
	        instance_create_layer(clm_mid_left, row_2, "Buttons", obj_dngrd_btn_turret);
			instance_create_layer(clm_mid_right, row_2, "Buttons", obj_upgrd_btn_firerate);
			instance_create_layer(clm_right, row_4, "Buttons", obj_upgrd_btn_accuracy);
			instance_create_layer(clm_left, row_4, "Buttons", obj_upgrd_btn_ammo);
			if (global.player_hp_lvl < 9){
				instance_create_layer(clm_middle, row_4, "Buttons", obj_upgrd_btn_armor);
			}
	        break;
	    default:
			instance_create_layer(clm_left, row_2, "Buttons", obj_dngrd_btn_turret);
	        instance_create_layer(clm_middle, row_2, "Buttons", obj_upgrd_btn_turret);
			instance_create_layer(clm_right, row_2, "Buttons", obj_upgrd_btn_firerate);
			instance_create_layer(clm_right, row_4, "Buttons", obj_upgrd_btn_accuracy);
			instance_create_layer(clm_left, row_4, "Buttons", obj_upgrd_btn_ammo);
			if (global.player_hp_lvl < 9){
				instance_create_layer(clm_middle, row_4, "Buttons", obj_upgrd_btn_armor);
			}
	        break;
	}
}

//A func to destoy all buttons ~Weston
destoy_buttons = function(){
layer_destroy_instances("Buttons")
}

//A func to refresh buttons for the upgrade menu ~Weston
refresh_buttons = function(){
	//calls func to destoy all buttons
	destoy_buttons()
	//updates the player_gun_type_max value if needed
	if (global.player_gun_type > global.player_gun_type_max){
	global.player_gun_type_max = global.player_gun_type
	}
	//creates new buttons
	create_buttons()
}

create_buttons()


// Makes the cursor show up again
window_set_cursor(cr_default);

// Stops all previous running audio
audio_stop_all();
// Plays menu audio
music = audio_play_sound(snd_music_menu_main, 100, true);

/*Copied the rest of this code from the splash manager, i dont think will need it though*/

// Checks if game is being played on android or ios devices for touch controls
if (os_type == os_android || os_type == os_ios)
{
	// Sets global touch to true
	global.is_touch = true;
}
else
{
	// Sets global touch to false
	global.is_touch = false;
}