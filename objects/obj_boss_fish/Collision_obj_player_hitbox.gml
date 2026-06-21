/// Collision with obj_player_hitbox — obj_boss_fish

var hb = other;

if (is_correct)
{
    // ACERTOU O PEIXE CERTO — dano no boss
    var boss = instance_find(obj_boss_sereia, 0);

    if (instance_exists(boss))
    {
        boss.hp -= hb.damage;
        boss.current_expression = "hurt";
        boss.expression_timer = 30;
    }

    with (obj_camera_boss_fixed)
    {
        shake_time = 8;
        shake_strength = 5;
    }

    instance_destroy(hb);
    
    // Destrói TODOS os peixes
    with (obj_boss_fish) instance_destroy();
}
else
{
    // ACERTOU PEIXE ERRADO — não acontece NADA (atravessa)
    // (apenas destrói a hitbox pra não acertar várias vezes)
    instance_destroy(hb);
}
