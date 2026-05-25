/// Step Event — obj_boss_hand_warning_ground

timer++;
x = spawn_x;
y = target_y; // warning fixo, na posição final da mão

if (timer >= warning_time)
{
    // CRIA NA MESMA LAYER (que tem os layer effects)
    // ANTES: instance_create_depth (ia pra layer auto sem efeito)
    // AGORA: instance_create_layer na layer "inimigos"
    var g = instance_create_layer(spawn_x, spawn_y, "inimigos", obj_boss_hand_ground);
    g.spawn_x = spawn_x;
    g.spawn_y = spawn_y;
    g.target_y = target_y;
    g.owner = owner;
    g.is_target = is_target;
    g.hand_speed = 0.6;

    instance_destroy(); // destrói o warning
}
