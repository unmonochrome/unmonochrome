/// Create Event — obj_boss_bubble

// AGORA É UM PROJÉTIL
spawn_delay = 0;
active = false;

scale = 0;
target_scale = 1.2; // um pouco maior

// MOVIMENTO
hspd = 0;
vspd = 0;
target_x = 0;
target_y = 0;
speed_projectile = 8;

lifetime = 300; // 5 segundos (caso não saia da tela)
timer = 0;

// Placeholder
if (sprite_exists(spr_boss_bubble))
{
    sprite_index = spr_boss_bubble;
}
else
{
    sprite_index = spr_player_idle;
}

image_speed = 0;
image_alpha = 0;