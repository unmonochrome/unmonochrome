/// Create Event — obj_boss_fish

// define pelo boss:
is_correct = false;

// movimento rápido
hspd = 16;
vspd = 0;

// onda visual
wave_offset = random(1000);
wave_amp = 10;
wave_speed = 0.02;

sprite_index = spr_boss_fish;
image_speed = 1;

// ==========================================
// ESCALA FIXA (ajustada pro tamanho do player de 600px)
// ==========================================
// Se seu sprite do peixe for ~200x80px (exemplo comum),
// essa escala deixa ele ~3x maior que o player (visível mas não absurdo)

image_xscale = 2.5;  // ajuste: 2.0 (menor) / 2.5 (médio) / 3.0 (grande)
image_yscale = 2.5;

// ==========================================
// Se quiser que os 3 peixes cubram a altura da tela (original),
// mas não fiquem gigantes INDIVIDUALMENTE, use isso:
// ==========================================
// var spacing_vertical = room_height / 3; // ~300px cada
// var sprite_h = sprite_get_height(sprite_index);
// 
// // escala pra caber na faixa dele (não na tela toda)
// image_yscale = (spacing_vertical * 0.8) / sprite_h;
// image_xscale = image_yscale; // mantém proporção