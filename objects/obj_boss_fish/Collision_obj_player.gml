/// Collision with obj_player — obj_boss_fish

// ==========================================
// Se o player tá ATACANDO (dash aquático), trata diferente
// ==========================================
if (other.dash_active)
{
    // Se for peixe REAL → causa dano no boss + acaba o ataque (sem dano no player)
    if (is_correct)
    {
        var boss = instance_find(obj_boss_sereia, 0);
        
        if (instance_exists(boss))
        {
            boss.hp -= 1;
            boss.current_expression = "hurt";
            boss.expression_timer = 30;
        }
        
        with (obj_camera_boss_fixed)
        {
            shake_time = 8;
            shake_strength = 5;
        }
        
        with (obj_boss_fish) instance_destroy();
    }
    // Se for peixe FALSO → não acontece nada (player passa por ele atacando)
    
    exit;
}

// ==========================================
// Player NÃO está atacando — recebe dano normalmente
// ==========================================
if (other.invincible <= 0)
{
    var _is_correct = is_correct;
    var _x = x;
    
    var dano = _is_correct ? 2 : 1;
    
    other.hp -= dano;
    other.invincible = 60;
    other.hurt_timer = 60;
    other.hitstun = 16;

    other.knockback_x = 8 * -sign(other.x - _x);
    if (other.knockback_x == 0) other.knockback_x = 8 * -other.facing;

    with (obj_camera_boss_fixed)
    {
        shake_time = _is_correct ? 10 : 6;
        shake_strength = _is_correct ? 6 : 4;
    }
    
    with (obj_boss_fish) instance_destroy();
}
