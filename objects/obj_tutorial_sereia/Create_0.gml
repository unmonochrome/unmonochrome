/// Create Event — obj_tutorial_sereia

depth = -9990; // bem na frente

// Pausa todo o resto
instance_deactivate_all(true);

// ==========================================
// SPRITES DO TUTORIAL (ordem)
// ==========================================
tutorial_sprites = [tutorial4 ,tutorial5 ,tutorial1, tutorial2, tutorial3];
total_tutorials = array_length(tutorial_sprites);

current = 0; // índice atual

// ==========================================
// FADE
// ==========================================
// state: 0 = fade in, 1 = exibindo, 2 = fade out
state = 0;
state_timer = 0;
fade_duration = 20;   // frames pra fade in/out
hold_min_time = 30;   // mínimo de frames mostrando antes de aceitar Z

alpha = 0;

// ==========================================
// ESCALA — sprite é 2887x1618 (16:9)
// Encaixa exatamente na tela mantendo proporção
// ==========================================
var sprite_w = sprite_get_width(tutorial_sprites[0]);
var sprite_h = sprite_get_height(tutorial_sprites[0]);

// Pega tamanho da GUI (1600x900)
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Escala pra caber INTEIRO na tela
tutorial_scale = min(gw / sprite_w, gh / sprite_h);

// Trava input no início (pra não pular sem ver)
input_lock = 10;

