// Variables for the retry button text
spread_lvl = global.player_gun_spread_lvl
added_accuracy = 20;
_cost = global.accuracy_cost;
text = "Accuracy" + " [" + string(_cost) + "]";

font = fnt_agency_fb_24;
colour = c_black;
halign = fa_center;
valign = fa_middle;

// Variable for target scale
target_scale = 1.0;

// Variables for scaling rate
scale_rate = 0.1;
can_scale_at_rate = false;

// Variable for pressed state
is_pressed = false;

if (global.player_coins < _cost || global.player_gun_spread_lvl < added_accuracy){
	is_locked = true;
} else {
	is_locked = false;
}

// Variable for retry button sound
sound_button = -1;