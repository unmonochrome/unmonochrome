timer++;
x = spawn_x;
y = target_y; // ⚠️ warning fixo, na posição final da mão

if (timer >= warning_time)
{
    // cria a mão ativa
    var g = instance_create_depth(spawn_x, spawn_y, -16, obj_boss_hand_ground);
    g.spawn_x = spawn_x;
    g.spawn_y = spawn_y;
    g.target_y = target_y;
    g.owner = owner;
    g.is_target = is_target;
    g.hand_speed = 0.6;

    instance_destroy(); // destrói o warning
}