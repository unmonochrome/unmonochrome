/// Collision with obj_player_hitbox — obj_boss_fish

// sempre destrói a hitbox (ataque consumiu)
var hb = other;

// peixe correto: danifica boss e destrói peixe
if (is_correct)
{
    var boss = instance_find(obj_boss_sereia, 0);

    if (instance_exists(boss))
    {
        boss.hp -= hb.damage;

        boss.current_expression = "hurt";
        boss.expression_timer = 30; // tempo da expressão de dano
    }

    with (obj_camera_boss_fixed)
    {
        shake_time = 8;
        shake_strength = 5;
    }

    instance_destroy(self); // destroy do peixe
    instance_destroy(hb);  // destroy do hitbox
}
else
{
    // peixe errado: invulnerável
    instance_destroy(hb);
}