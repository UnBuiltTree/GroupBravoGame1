// Variables for the retry button text
turret_lvl = global.player_gun_type

switch (global.player_gun_type) {
	//the case her means the next turret_type name so everything is one behind
	case 0:
		turret_type = "Twin-Turret"
		_cost = 10;
		_spread_cost = 20;
	break;
	case 1:
		turret_type = "Triple-Threat"
		_cost = 15;
		_spread_cost = 20;
	break;
	case 2:
		turret_type = "Quad-Barrel"
		_cost = 25;
		_spread_cost = 20;
	break;
	case 3:
		turret_type = "Auto-Cannon"
		_cost = 40;
		_spread_cost = 40;
	break;
	default:
		turret_type = "Upgrade-Gun"
		_cost = 10;
		_spread_cost = 5;
	break;
}
if (global.player_gun_type == global.player_gun_type_max){
	text = string(turret_type) + " [" + string(_cost) + "]";
} else {
	text = string(turret_type);
}

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

if (global.player_coins < _cost && global.player_gun_type_max == global.player_gun_type){
	is_locked = true;
} else {
	is_locked = false;
}

// Variable for retry button sound
sound_button = -1;