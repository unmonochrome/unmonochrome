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
    
    // Destrói TODOS os peixes (ataque terminou com sucesso)
    with (obj_boss_fish) instance_destroy();
}
else
{
    // ACERTOU PEIXE ERRADO — player toma dano e todos somem
    var pl = instance_find(obj_player, 0);
    
    if (instance_exists(pl) && pl.invincible <= 0)
    {
        pl.hp -= 1;
        pl.invincible = 30;
        pl.hurt_timer = 12;
        pl.hitstun = 16;
        pl.knockback_x = 8 * -sign(pl.x - x);
        if (pl.knockback_x == 0) pl.knockback_x = 8 * -pl.facing;
        
        with (obj_camera_boss_fixed)
        {
            shake_time = 6;
            shake_strength = 4;
        }
    }
    
    instance_destroy(hb);
    
    // Destrói TODOS os peixes — ataque acaba
    with (obj_boss_fish) instance_destroy();
}
