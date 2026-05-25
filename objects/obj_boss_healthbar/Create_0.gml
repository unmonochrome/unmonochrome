/// Create Event — obj_boss_healthbar
/// Barra de vida estilo Terraria pra qualquer boss
/// Coloca um na rm_boss_olho e outro na rm_sereia

depth = -9999; // sempre na frente

// ==========================================
// CONFIGURAÇÕES (mude por room/boss se quiser)
// ==========================================

// Tamanho da barra
bar_width = 600;
bar_height = 28;

// Posição na tela (vai ser calculada no Draw GUI)
// fica na parte de baixo, centralizada

// Cores
color_bg        = make_colour_rgb(20, 20, 25);    // fundo
color_border    = make_colour_rgb(200, 200, 220); // borda branca
color_fill_top  = make_colour_rgb(220, 30, 50);   // gradiente vermelho (topo)
color_fill_bot  = make_colour_rgb(120, 10, 20);   // gradiente vermelho (base)
color_lost      = make_colour_rgb(255, 180, 180); // "ghost bar" que mostra dano recente
color_text      = c_white;
color_text_low  = make_colour_rgb(255, 80, 80);   // texto quando HP baixo

// ==========================================
// ESTADO INTERNO
// ==========================================
alpha = 0;          // fade in/out
alpha_target = 0;

displayed_hp = 1;   // % de HP mostrado (smooth)
ghost_hp = 1;       // a "ghost bar" (fica atrasada pra mostrar o dano)

pulse_timer = 0;    // pulsação quando HP baixo

boss_ref = noone;   // referência do boss
boss_name = "";     // nome a mostrar
