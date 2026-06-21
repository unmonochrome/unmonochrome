/// Create Event — obj_enemy

#region Movimento
hspd = 0;
vspd = 0;
walkspd = 4;
grav = 0;
#endregion

#region Vida
hp = 3;
max_hp = 3;
#endregion

#region Alvo
target = obj_player;
facing = choose(-1, 1);
#endregion

#region Knockback
knockback_x = 0;
hitstun = 0;
hurt_timer = 0;
invincible = 0;
#endregion

#region IA — FUGA
flee_range = 700;       // distância em que começa a fugir (maior)
panic_range = 350;      // entra em pânico mais cedo
max_flee_speed = 12;    // velocidade máxima MUITO acima do player
#endregion

#region Ativação
activated = false;
#endregion

#region Morte
dying = false;
death_timer = 0;
death_timer_max = 20;
death_scale = 1;
death_alpha = 1;
#endregion

#region Flutuação
float_y = 0;
float_speed = 0.04;
float_height = 12;
float_seed = random(1000);
base_y = y;
#endregion

#region Comportamento Natural
wobble_seed = random(1000);
wobble_strength = 0.6;

behavior_state = 0;
behavior_timer = 0;
behavior_change_min = 60;
behavior_change_max = 180;
next_behavior_change = irandom_range(behavior_change_min, behavior_change_max);

peek_chance = 3;
#endregion

#region Escala dos Sprites
target_size = 128;
spr_idle_w = sprite_get_width(spr_olhinho);
spr_idle_h = sprite_get_height(spr_olhinho);

scale_idle = target_size / max(spr_idle_w, spr_idle_h);
current_scale = scale_idle;
#endregion

mask_index = spr_olhinho_mask;

#region Visual
image_speed = 0;
sprite_index = spr_olhinho;
#endregion

#region Aura/Glow
aura_hue = random(360);
aura_pulse_seed = random(1000);
#endregion
