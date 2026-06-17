/// Create Event — obj_water_lane

lane_width = 384;
is_dangerous = false;

depth = 100;

// ==========================================
// TELEGRAPH
// ==========================================
state = 0;
warning_time = 60;
warning_timer = 0;
warning_pulse = 0;

// ==========================================
// FADE IN/OUT DAS BORDAS
// ==========================================
jato_alpha = 0;
jato_alpha_target = 0;
jato_anim_frame = 0;
jato_anim_timer = 0;
jato_anim_speed = 6;

// ==========================================
// ANIMAÇÃO DOS PEIXES
// ==========================================
ataque_anim_frame = 0;
ataque_anim_timer = 0;
ataque_anim_speed = 4;

ataque_scroll_speed = 14;

// ==========================================
// DUAS CÓPIAS DE PEIXES (INDEPENDENTES)
// Ambas sempre descem. Quando ativo, fazem loop entre si.
// ==========================================
var _sh = sprite_get_height(spr_jato_ataque);

fish_y_1 = -_sh;      // cópia 1 — começa acima da tela
fish_y_2 = -_sh * 2;  // cópia 2 — começa ainda mais acima

peixes_active = false;
should_destroy = false;
