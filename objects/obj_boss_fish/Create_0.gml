/// Create Event — obj_boss_fish

is_correct = false;

hspd = 16;
vspd = 0;

wave_offset = random(1000);
wave_amp = 10;
wave_speed = 0.02;

// ==========================================
// SPRITE será definido no Step (depende de is_correct)
// ==========================================
image_speed = 1;

// ==========================================
// ESCALA PROPORCIONAL
// Sprites originais são 1342x555 — gigante!
// Vamos escalar pra ter ~250px de altura na tela
// ==========================================
target_height = 250;

// Flag pra calcular escala só uma vez
scale_calculated = false;

/// Create Event — obj_boss_fish

is_correct = false;
fish_direction = 1;  // 1 = indo pra direita, -1 = indo pra esquerda

hspd = 16;
vspd = 0;

wave_offset = random(1000);
wave_amp = 10;
wave_speed = 0.02;

image_speed = 1;

target_height = 250;

scale_calculated = false;

