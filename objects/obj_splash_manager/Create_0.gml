
global.floor_number = 0;
global.player_score = 0;
global.player_coins = 0;
global.player_firerate_upgrd = 0;
global.firerate_cost = 25;
global.accuracy_cost = 10;
global.armor_cost = 10;
global.player_gun_type = 0;
global.player_gun_type_max = 0;
global.player_gun_spread_lvl = 10;
global.player_hp_lvl = 3;

// Creates the splash screen squence
layer_sequence_create("Instances", room_width / 2, room_height / 2, seq_splash);

// Sets variables used for the highscore table visible state
is_highscore_table = false;
highscores_alpha = 0.0;
highscores_alpha_target = 0.0;
show_debug_message("Floor Number splash menu: " + string(global.floor_number));
// Array used for storing the high scores within
highscores = [];

// Loops to set array to 0 values
for (var _i = 0; _i < 10; _i ++)
{
	highscores[_i] = 0;
}

// Loads buffer for highscores
high_score_buffer = buffer_load("TWIN_STICK_HS.sav");

// Checks if buffer exists
if(buffer_exists(high_score_buffer))
{
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Sets the highscores to values read from the buffer
		highscores[_i] = buffer_read(high_score_buffer, buffer_u64);
	}
}
else
{
	// Creates highscore buffer
	high_score_buffer = buffer_create(16384, buffer_fixed, 2);
	// Goes to the start of the buffer
	buffer_seek(high_score_buffer, buffer_seek_start, 0);
	
	// Loops 10 times
	for (var _i = 0; _i < 10; _i ++)
	{
		// Writes highscore values to the buffer
		buffer_write(high_score_buffer, buffer_u64, highscores[_i]);
	}
	
	// Saves the new empty highscore buffer
	buffer_save(high_score_buffer, "TWIN_STICK_HS.sav");
}

// Variables used for highscore text
text = "HIGH SCORES";
font_1 = fnt_agency_fb_96_outline;
font_2 = fnt_agency_fb_36_outline;
colour = c_white;
halign = fa_center;
valign = fa_middle;

// Sets font to have outline effect
font_enable_effects(fnt_agency_fb_96_outline, true, {
    outlineEnable: true,
    outlineDistance: 4,
    outlineColour: c_black
});

// Sets font to have outline effect
font_enable_effects(fnt_agency_fb_36_outline, true, {
    outlineEnable: true,
    outlineDistance: 2,
    outlineColour: c_black
});

// Stops all previous running audio
audio_stop_all();
// Plays menu audio
music = audio_play_sound(snd_music_menu_main, 100, true);

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