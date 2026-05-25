/// Step Event — obj_boss_bubble

if (spawn_delay > 0)
{
    spawn_delay--;
    exit;
}

active = true;

// Aparece gradualmente
if (scale < target_scale)
{
    scale = lerp(scale, target_scale, 0.15);
    image_alpha = lerp(image_alpha, 1, 0.1);
}

image_xscale = scale * 0.2;
image_yscale = scale * 0.2;

// MOVIMENTO (vai até o alvo)
x += hspd;
y += vspd;

timer++;

// Sai da tela ou tempo acaba
if (timer >= lifetime || x < -100 || x > room_width + 100 || y < -100 || y > room_height + 100)
{
    instance_destroy();
}

// Dano no player
if (active && scale > 0.8)
{
    var p = instance_place(x, y, obj_player);
    
    if (p != noone && p.invincible <= 0)
    {
        p.hp--;
        p.invincible = 30;
        p.hurt_timer = 12;
        
        with (obj_camera_boss_fixed)
        {
            shake_time = 5;
            shake_strength = 3;
        }
        
        instance_destroy(); // bolha estoura ao acertar
    }
}