/// Step Event — obj_boss_fish

// se já estiver "morrendo", só anima e sai
// (opcional) aqui vamos destruir direto quando acertar certo no hitbox
// então não precisa morrer state.

x += hspd;

// movimento vertical suave
y += sin((current_time * 0.01) + wave_offset) * wave_amp * 0.03;

// Sai da tela
if (x > room_width + 250)
{
    // se for o peixe correto e você não acertou, pune
    if (is_correct)
    {
        var pl = instance_find(obj_player, 0);
        if (instance_exists(pl) && pl.invincible <= 0)
        {
            pl.hp -= 2;
            pl.invincible = 30;
            pl.hurt_timer = 12;
            pl.hitstun = 16;
            pl.knockback_x = 8 * -sign(pl.x - x);
        }

        with (obj_camera_boss_fixed)
        {
            shake_time = 10;
            shake_strength = 6;
        }
    }

    instance_destroy();
    exit;
}