/// Create Event — obj_boss_hand_ground

// timers e estados
timer = 0;
state = 0; // 0 = subindo, 1 = parada, 2 = morrendo

// variáveis de referência
owner = noone;
is_target = false;
spawn_x = x;
spawn_y = y;
target_y = y;

// controle de subida (mais LENTO pra ser mais dramático)
hand_speed = 0.18; // antes era 0.6 — agora sobe bem mais devagar
stay_time = 300;

// colisão
can_be_hit = false;

// sprite
sprite_index = spr_hand_ground;
image_speed = 0;
depth = 16;

// ==========================================
// ESCALA PROPORCIONAL
// ==========================================
var target_visible_height = 220;
var sprite_h = sprite_get_height(sprite_index);
hand_scale = target_visible_height / sprite_h;

image_xscale = hand_scale;
image_yscale = hand_scale;

// Começa invisível (fade in)
image_alpha = 0;

// ==========================================
// MORTE (fade + afundar)
// ==========================================
dying = false;
death_timer = 0;
death_duration = 20;
death_start_y = 0;
death_start_alpha = 1;

// ==========================================
// TRAIL FANTASMA (mais longo e espaçado)
// ==========================================
trail_positions = [];
trail_max = 14;            // mais fantasmas
trail_record_interval = 4; // mais espaçados (era 2)
trail_timer = 0;

// ==========================================
// BRILHO (só pra mão certa)
// ==========================================
glow_pulse = 0;
