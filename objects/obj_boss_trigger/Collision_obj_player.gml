/// Collision Event com obj_player
var p = other;       // player que colidiu
p.freeze = true;     // bloqueia player

// cria o boss fora da tela
var boss = instance_create_layer(room_width/2, -30, "Instances", obj_boss_eye);
boss.state = 99;      // cutscene descendo
boss.state_timer = 0;

// destrói o trigger
instance_destroy();