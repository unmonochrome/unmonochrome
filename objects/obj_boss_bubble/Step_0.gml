/// Step Event — obj_boss_bubble

if (spawn_delay > 0)
{
    spawn_delay--;
    exit;
}

active = true;

if (scale < target_scale)
{
    scale = lerp(scale, target_scale, 0.15);
    image_alpha = lerp(image_alpha, 1, 0.1);
}

image_xscale = scale * 0.2;
image_yscale = scale * 0.2;

x += hspd;
y += vspd;

timer++;

if (timer >= lifetime || x < -100 || x > room_width + 100 || y < -100 || y > room_height + 100)
    instance_destroy();

// Dano + CEGUEIRA no player
if (active && scale > 0.8)
{
    var p = instance_place(x, y, obj_player);
    
    if (p != noone && p.invincible <= 0)
    {
        p.hp--;
        p.invincible = 60;
        p.hurt_timer = 60;
        p.hitstun = 20;
        
        // CEGUEIRA — tela embaçada
        p.blind_alpha = 0.85;
        p.blind_alpha_target = 0;
        
        with (obj_camera_boss_fixed)
        {
            shake_time = 5;
            shake_strength = 3;
        }
        
        instance_destroy();
    }
}
