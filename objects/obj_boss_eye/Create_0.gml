hp = 6;
max_hp = 6;

state = 0; // 0=aberto, 1=fechado/spawn warning, 2=esperando hands, 3=morto
state_timer = 0;
hands_spawned = false;
wrong_hand_hit = false;
correct_hand_hit = false;

sprite_index = spr_eye_open;
image_speed = 0;
depth = -50;

base_x = x;
base_y = y;

// pega altura inicial do player para usar como "chão"
var p_init = instance_find(obj_player,0);
if (instance_exists(p_init)) player_ground_y = p_init.y;
else player_ground_y = 800;

// flutuação
float_timer = random(1000);
float_spd = 0.02;

// amplitude circular
cyclo_radius_x = 30;
cyclo_radius_y = 15;

// pupila
pupila_limit_x = 20;
pupila_limit_y = 15;
pupila_offset_y = 8;

fade_alpha = 0;
fade_speed = 0;
battle_base_x = 0; // x fixo do player para spawn de mãos

state = 99;
state_timer = 0;
fade_alpha = 0;
fade_speed = 0.02;
boss_speed = 2;       // descida lenta
battle_base_x = 0;    // x fixo do player
hands_spawned = false;

