/// Create Event — obj_tutorial_game
/// Versão LIMPA — não mexe em câmera nem application_surface.
/// Deixa o obj_cutscene cuidar disso. Tutorial só desenha em Draw GUI.

depth = -9999; // bem na frente

audio_stop_all();

// ==========================================
// SPRITES DO TUTORIAL (acromatopsia)
// ==========================================
tutorial_sprites = [tutorial_game_1, tutorial_game_2, tutorial_game_3];
total_tutorials = array_length(tutorial_sprites);

current = 0;

// ==========================================
// ESTADOS
// 0=fade in, 1=exibindo, 2=fade out
// ==========================================
state = 0;
state_timer = 0;
fade_duration = 20;
hold_min_time = 30;
alpha = 0;

input_lock = 10;
