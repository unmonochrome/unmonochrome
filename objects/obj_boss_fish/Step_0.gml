/// Step Event — obj_boss_fish

// SPRITE
if (is_correct)
{
    sprite_index = spr_boss_fish;
}
else
{
    if (sprite_exists(spr_peixe_falso))
        sprite_index = spr_peixe_falso;
    else
        sprite_index = spr_boss_fish;
}

// ESCALA
if (!scale_calculated && sprite_exists(sprite_index))
{
    var sprite_h = sprite_get_height(sprite_index);
    
    if (sprite_h > 0)
    {
        var fish_scale = target_height / sprite_h;
        image_xscale = fish_scale * fish_direction;
        image_yscale = fish_scale;
        scale_calculated = true;
    }
}

// MOVIMENTO
x += hspd;
y += sin((current_time * 0.01) + wave_offset) * wave_amp * 0.03;

// ==========================================
// SAI DA TELA
// ==========================================
var saiu_da_tela = false;

if (fish_direction == 1 && x > room_width + 250)
    saiu_da_tela = true;
else if (fish_direction == -1 && x < -250)
    saiu_da_tela = true;

if (saiu_da_tela)
{
    if (is_correct)
    {
        // Peixe correto saiu sem ser atacado = dano + todos somem
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
        
        // Destrói TODOS os peixes (inclusive este)
        with (obj_boss_fish) instance_destroy();
        exit;
    }

    instance_destroy();
    exit;
}
