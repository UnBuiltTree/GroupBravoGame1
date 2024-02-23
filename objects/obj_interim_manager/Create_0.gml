/*This is the manager i created for the interim menu that
  shows up after clearing a floor ~Weston*/

// increases floor_number for the player to advance to the next floor
global.floor_number++;
show_debug_message("Floor Number: " + string(global.floor_number));

// Creates the splash screen squence
layer_sequence_create("Instances", room_width / 2, room_height / 2, seq_interim_menu);

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