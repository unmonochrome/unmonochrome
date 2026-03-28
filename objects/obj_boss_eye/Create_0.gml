hp = 6;
max_hp = 6;
enraged = false;

state = 0; 
state_timer = 0;

hands_spawned = false;
hand_count = 3;
max_hands = 7;
spacing = 300;

sprite_index = spr_eye_open;
image_speed = 0;
depth = -50;

base_x = x;
base_y = y;

var p_init = instance_find(obj_player,0);
if (instance_exists(p_init)) player_ground_y = p_init.y;
else player_ground_y = 800;

float_timer = random(1000);
float_spd = 0.02;
cyclo_radius_x = 30;
cyclo_radius_y = 15;

errada_atingida = false;

pupila_limit_x = 20;
pupila_limit_y = 15;
pupila_offset_y = 8;

hand_spawn_cooldown = 90;
hand_spawn_timer = 0;