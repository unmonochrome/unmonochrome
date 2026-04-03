/// Create Event — obj_boss_eye

#region HP e Estado
hp = 6;
max_hp = 6;
state = 99;
state_timer = 0;
hands_spawned = false;
wrong_hand_hit = false;
correct_hand_hit = false;
#endregion

#region Sprite e Posição
sprite_index = spr_eye_open;
image_speed = 0;
depth = -50;
base_x = x;
base_y = y;
var p_init = instance_find(obj_player, 0);
player_ground_y = instance_exists(p_init) ? p_init.y : 800;
#endregion

#region Flutuação
float_timer = random(1000);
float_spd = 0.02;
cyclo_radius_x = 30;
cyclo_radius_y = 15;
#endregion

#region Pupila
pupila_limit_x = 20;
pupila_limit_y = 15;
pupila_offset_y = 8;
pupila_scale = 1;
#endregion

#region Spawn Cinematográfico
fade_alpha = 1;
fade_speed = -0.02;
spawn_scale = 0.1;
spawn_speed = 0.05;
#endregion

#region Morte Épica
death_shake = 0;
death_angle = 0;
death_rot_speed = 0;
death_pulse = 0;
death_flash = 0;
death_red = 0;
death_scale = 1;
death_y_drift = 0;
#endregion