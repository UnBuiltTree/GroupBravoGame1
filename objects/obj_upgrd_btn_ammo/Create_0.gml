// Variables for the retry button text
ammo_lvl = global.player_ammo_lvl
added_ammo_lvl = 1;
_cost = global.ammo_cost;
text = "Ammo " + string(ammo_lvl) +" [" + string(_cost) + "]";

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

if (global.player_coins < _cost){
	is_locked = true;
} else {
	is_locked = false;
}

// Variable for retry button sound
sound_button = -1;