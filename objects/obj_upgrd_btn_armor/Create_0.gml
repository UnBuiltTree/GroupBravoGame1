// Variables for the retry button text
armor_lvl = global.player_hp_lvl
added_hp = 3;
_cost = global.armor_cost;
text = "Armor" + string(armor_lvl/3) +" [" + string(_cost) + "]";

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

if (global.player_coins < _cost || armor_lvl >= 9){
	is_locked = true;
} else {
	is_locked = false;
}

// Variable for retry button sound
sound_button = -1;