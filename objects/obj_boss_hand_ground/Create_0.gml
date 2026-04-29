// timers e estados
timer = 0;
state = 0; // 0 = subindo, 1 = parada

// variáveis de referência
owner = noone;       // referência pro boss
is_target = false;   // se é a mão certa
spawn_x = x;
spawn_y = y;
target_y = y;

// controle de subida
hand_speed = 0.6;   // sobe rápido, pode ser sobrescrita pelo boss
stay_time = 120;    // tempo que fica parada

// variável nova pra colisão
can_be_hit = false; // só pode bater quando chega na posição final

// sprite
sprite_index = spr_hand_ground;
image_speed = 0;
depth = 16;
