/// Collision with obj_player — obj_boss_trigger

var p = other;
p.freeze = true; // congela player

// cria boss na layer "inimigos" (pra pegar os layer effects!)
var boss = instance_create_layer(room_width/2, 1184, "inimigos", obj_boss_eye);
boss.state = 99;         // cutscene do spawn animado
boss.state_timer = 0;

// fade inicial
boss.fade_alpha = 1;
boss.fade_speed = -0.02;

// animação de spawn
boss.spawn_scale = 0.1;
boss.spawn_speed = 0.05;
boss.battle_base_x = p.x;
boss.hands_spawned = false;

// trigger só dispara uma vez
instance_destroy();
