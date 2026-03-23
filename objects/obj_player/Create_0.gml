
// movimento
hspd = 0;
vspd = 0;

walkspd = 4;
grav = 0.5;
jump_force = -15;

on_ground = false;

// coyote
coyote = 0;
coyote_max = 6;

// corrida progressiva
run_timer = 0;

// direção
facing = 1;

// ataque
atk_cd = 0;
atk_cd_max = 15;

// vida
hp_max = 10;
hp = hp_max;

// dano
hurt_timer = 0;
invincible = 0;
knockback_x = 0;
hitstun = 0;

// dash attack
dash_speed = 8;
dash_time = 0;
dash_time_max = 8;
dash_cd = 0;
dash_cd_max = 20;

dash_attacking = false;
dash_damage = 1;

// morte estilosa
dead = false;
death_anim = false;
death_timer = 0;
death_timer_max = 45;

death_fade = 1;
death_rot = 0;

// spawn inicial
global.spawn_x = x;
global.spawn_y = y;

step_timer = 0;
step_interval_walk = 16;
step_interval_run = 10;

step_sound_id = -1;

transitioning = false;
transition_alpha = 0;
transition_speed = 0.02;
transition_target_room = noone;

attacking = false;
attack_timer = 0;
attack_duration = 12; // ajusta depois


