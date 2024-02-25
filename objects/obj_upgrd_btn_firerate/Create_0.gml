// Variables for the retry button text

upgrd_name = "Rate of Fire"

switch (global.player_firerate_upgrd) {
	//the case her means the next turret_type name so everything is one behind
	case 0:
		_cost = 5;
	break;
	case 1:
		_cost = 15;
	break;
	default:
		_cost = global.firerate_cost;
	break;
}

text = string(upgrd_name) + " " + string(global.player_firerate_upgrd+1) + " [" + string(_cost) + "]";


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