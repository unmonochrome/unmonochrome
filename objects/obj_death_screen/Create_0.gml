/// Create Event — obj_death_screen
/// Tela de morte cinematográfica
/// Criada automaticamente pelo obj_player quando ele morre

depth = -9998; // bem na frente, atrás só do fade preto

// ==========================================
// ESTADOS
// 0 = aparecendo (fade in vermelho)
// 1 = aguardando input do jogador
// 2 = saindo (fade pro preto, reinicia room)
// ==========================================
state = 0;
state_timer = 0;

// Overlay vermelho
red_alpha = 0;
red_alpha_target = 0.7;

// Texto "VOCÊ MORREU"
title_alpha = 0;
title_y_offset = -30; // começa acima da posição final
title_scale = 1.5;

// Texto "APERTE Z PARA TENTAR DE NOVO"
hint_alpha = 0;
hint_pulse = 0;

// Fade preto pra reiniciar
black_alpha = 0;

// Não permitir input nos primeiros frames (pra não pular sem ver)
input_delay = 60; // 1 segundo
