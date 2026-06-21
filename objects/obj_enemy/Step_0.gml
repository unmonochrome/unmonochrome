/// Step Event — obj_enemy

if (hitstun > 0) hitstun--;
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
behavior_timer++;

// ATIVAÇÃO
if (!activated)
{
    var cam = view_camera[0];
    var cx = camera_get_view_x(cam);
    var cy = camera_get_view_y(cam);
    var cw = camera_get_view_width(cam);
    var ch = camera_get_view_height(cam);

    if (x + sprite_width / 2 > cx && x - sprite_width / 2 < cx + cw
     && y + sprite_height / 2 > cy && y - sprite_height / 2 < cy + ch)
    {
        activated = true;
    }
    else exit;
}

// MORTE ANIMADA
if (dying)
{
    death_timer++;
    var t = death_timer / death_timer_max;
    death_scale = max(0, 1 - t);
    death_alpha = max(0, 1 - t);
    x += irandom_range(-2, 2);
    hspd = 0;
    vspd = 0;
    if (death_timer >= death_timer_max) instance_destroy();
    exit;
}

if (hp <= 0 && !dying)
{
    dying = true;
    death_timer = 0;
    hspd = 0;
    vspd = 0;

    with (obj_camera)
    {
        shake_time = 6;
        shake_strength = 3;
    }
    exit;
}

// IA FUGA
var player = instance_nearest(x, y, target);
var move = 0;
var current_speed_mult = 1.0;

if (instance_exists(player))
{
    var dist = point_distance(x, y, player.x, player.y);
    var dx = x - player.x;
    var flee_dir = sign(dx);
    if (flee_dir == 0) flee_dir = choose(-1, 1);
    
    if (dist < panic_range)
    {
        behavior_state = 2;
        behavior_timer = 0;
    }
    else if (dist < flee_range)
    {
        if (behavior_state == 2)
        {
            behavior_state = 1;
            behavior_timer = 0;
        }
        else if (behavior_state == 0)
        {
            behavior_state = 1;
            behavior_timer = 0;
        }
    }
    else
    {
        if (behavior_state == 1 || behavior_state == 2)
        {
            behavior_state = 0;
            behavior_timer = 0;
            next_behavior_change = irandom_range(behavior_change_min, behavior_change_max);
        }
    }
    
    if (hitstun <= 0)
    {
        switch (behavior_state)
        {
            case 0: // PATRULHA
                move = facing;
                current_speed_mult = 0.7;
                
                if (behavior_timer > next_behavior_change)
                {
                    behavior_timer = 0;
                    next_behavior_change = irandom_range(behavior_change_min, behavior_change_max);
                    
                    if (random(100) < 30) facing *= -1;
                    if (random(100) < peek_chance) behavior_state = 3;
                }
            break;
            
            case 1: // FUGA NORMAL
                var fear_factor = 1 - (dist / flee_range);
                fear_factor = clamp(fear_factor, 0, 1);
                
                var wobble = sin(current_time * 0.003 + wobble_seed) * wobble_strength * 0.1;
                
                move = flee_dir;
                // Velocidade base mais alta + fear factor mais forte
                current_speed_mult = 1.8 + fear_factor * 2.0 + wobble;
                
                facing = flee_dir;
            break;
            
            case 2: // PÂNICO
                move = flee_dir;
                current_speed_mult = 3.5; // bem mais rápido (era 2.5)
                facing = flee_dir;
            break;
            
            case 3: // VIGIA
                move = 0;
                facing = -sign(dx);
                
                if (behavior_timer > 40)
                {
                    behavior_state = 0;
                    behavior_timer = 0;
                    next_behavior_change = irandom_range(behavior_change_min, behavior_change_max);
                }
            break;
        }
    }
}

// MOVIMENTO HORIZONTAL
if (hitstun > 0)
{
    hspd = knockback_x;
    if (abs(knockback_x) > 0.1) knockback_x *= 0.85;
    else knockback_x = 0;
}
else
{
    var target_hspd = move * walkspd * current_speed_mult;
    target_hspd = clamp(target_hspd, -max_flee_speed, max_flee_speed);
    
    // Aceleração mais rápida pra responder melhor à fuga
    hspd = lerp(hspd, target_hspd, 0.25);
}

x += hspd;

// Sai da room
if (x < -300 || x > room_width + 300)
{
    instance_destroy();
    exit;
}

// FLUTUAÇÃO VERTICAL
var float_mult = 1.0;
if (behavior_state == 2) float_mult = 1.5;
else if (behavior_state == 1) float_mult = 1.2;

float_y = sin((current_time * 0.001 * 60 * float_speed * float_mult) + float_seed) * float_height;
y = base_y + float_y;

// SPRITE
image_xscale = facing;
image_yscale = 1;

sprite_index = spr_olhinho;
image_speed = 0;
