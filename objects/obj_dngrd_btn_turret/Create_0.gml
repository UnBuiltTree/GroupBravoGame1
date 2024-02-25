// Variables for the retry button text
turret_lvl = global.player_gun_type

switch (global.player_gun_type) {
	//the case her means the next turret_type name so everything is one behind
	case 1:
		turret_type = "Default-Gun"
	break;
	case 2:
		turret_type = "Twin-Turret"
	break;
	case 3:
		turret_type = "Triple-Threat"
	break;
	case 4:
		turret_type = "Quad-Barrel"
	break;
	default:
	turret_type = "downgrade-Gun"
	break;
}

text = string(turret_type);
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

is_locked = false;

// Variable for retry button sound
sound_button = -1;