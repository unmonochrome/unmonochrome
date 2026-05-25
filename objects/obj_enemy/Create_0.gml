/// Create Event — obj_enemy

#region Movimento
hspd = 0;
vspd = 0;
walkspd = 2;
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

#region IA
aggro = false;
aggro_range = 300;
lose_aggro_range = 500;
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

#region Ataque
attacking = false;
attack_timer = 0;
attack_duration = 20;
attack_cooldown = 0;
attack_cooldown_max = 60;
#endregion

#region Escala dos Sprites
// Tamanho real que o olho deve ter (128x128 original)
target_size = 128;

// ==========================================
// IDLE: 469x670 → escala pra 128px
// ==========================================
spr_idle_w = sprite_get_width(spr_olhinho);
spr_idle_h = sprite_get_height(spr_olhinho);

scale_idle = target_size / max(spr_idle_w, spr_idle_h);

// ==========================================
// ATAQUE: Mantém a MESMA escala do idle
// (porque o olho em si tem o mesmo tamanho, só tem espaço vazio)
// ==========================================
scale_attack = scale_idle; // ← MESMA ESCALA

current_scale = scale_idle;
#endregion

mask_index = spr_olhinho_mask;

#region Visual
image_speed = 0;
sprite_index = spr_olhinho;
#endregion

// ... todo seu código existente ...

#region Aura/Glow
aura_hue = random(360); // variação de cor única por inimigo
aura_pulse_seed = random(1000);
#endregion