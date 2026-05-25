/// Create Event — obj_fade_black

depth = -9999;
alpha = 0;

// ==========================================
// TRANSIÇÃO AUTOMÁTICA QUANDO FICAR 100% PRETO
// ==========================================
go_to_loading = false;   // se true, vai pro loading quando alpha = 1
target_room   = noone;   // qual room carregar APÓS o loading
hold_timer    = 0;       // espera um pouco com tela preta antes de transicionar
hold_duration = 30;      // ~0.5 segundos de tela preta (peso dramático)

// Trava de segurança pra não disparar 2x
already_triggered = false;
