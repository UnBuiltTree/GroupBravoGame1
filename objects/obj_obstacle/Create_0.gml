// Array for storing the possible obstacle sprites
var _obstacle_sprite = [];

// Sets the array variables to the possible sprites
_obstacle_sprite[0] = spr_obstacle_1;
_obstacle_sprite[1] = spr_obstacle_2;
_obstacle_sprite[2] = spr_obstacle_3;
_obstacle_sprite[3] = spr_obstacle_4;
_obstacle_sprite[4] = spr_obstacle_5;

// Sets the sprite to a randomly selected sprite
sprite_index = _obstacle_sprite[irandom_range(0, 4)];