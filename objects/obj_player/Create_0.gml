/// Create Event — obj_player

#region Movimento
hspd = 0;
vspd = 0;
walkspd = 4;
grav = 0.5;
jump_force = -15;
on_ground = false;
#endregion

#region Coyote
coyote = 0;
coyote_max = 6;
#endregion

#region Corrida Progressiva
run_timer = 0;
#endregion

#region Direção
facing = 1;
#endregion

#region Ataque
atk_cd = 0;
atk_cd_max = 15;
attacking = false;
attack_timer = 0;
attack_duration = 12;
#endregion

#region Vida
hp_max = 10;
hp = hp_max;
#endregion

#region Dano
hurt_timer = 0;
invincible = 0;
knockback_x = 0;
hitstun = 0;
#endregion

#region Freeze
freeze = false;
#endregion

#region Morte
dead = false;
death_anim = false;
death_timer = 0;
death_timer_max = 45;
death_fade = 1;
death_rot = 0;
#endregion

#region Spawn
global.spawn_x = x;
global.spawn_y = y;
#endregion

#region Footsteps
step_timer = 0;
step_interval_walk = 16;
step_interval_run = 10;
step_sound_id = -1;
#endregion

#region Transição
transitioning = false;
transition_alpha = 0;
transition_speed = 0.02;
transition_target_room = noone;
#endregion

#region Sombra
ground_y = y;
#endregion

#region Modo Aquático
in_water = false;
water_vspd = 0;
water_friction = 0.92;
#endregion

/// SUBSTITUI APENAS A REGIÃO #region Dash Aquático no Create

#region Dash Aquático
dash_active = false;
dash_timer = 0;
dash_duration = 18;         // 4 frames / 13 fps * 60 = ~18 frames
dash_speed = 10;
dash_cooldown = 0;
dash_cooldown_max = 40;
#endregion


#region Inclinação Aquática
swim_tilt_angle = 0;
swim_tilt_target = 0;
swim_tilt_speed = 0.15;
swim_tilt_max = 18;
#endregion

#region Pulo Aquático (4 frames a 11 fps)
swim_jump_timer = 0;
swim_jump_duration = 22;    // 4 frames / 11 fps * 60 fps = ~22 frames
swim_jump_anim_speed = 11/60; // toca a exatamente 11 fps
#endregion
