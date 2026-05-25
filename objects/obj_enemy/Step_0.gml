/// Step Event — obj_enemy

// ==========================================
#region TIMERS
// ==========================================
if (hitstun > 0) hitstun--;
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
if (attack_cooldown > 0) attack_cooldown--;
#endregion

// ==========================================
#region ATIVAÇÃO
// ==========================================
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
    else
    {
        exit;
    }
}
#endregion

// ==========================================
#region MORTE ANIMADA
// ==========================================
if (dying)
{
    death_timer++;

    var t = death_timer / death_timer_max;

    death_scale = max(0, 1 - t);
    death_alpha = max(0, 1 - t);

    x += irandom_range(-2, 2);

    hspd = 0;
    vspd = 0;

    if (death_timer >= death_timer_max)
    {
        instance_destroy();
    }

    exit;
}
#endregion

// ==========================================
#region CHECAR MORTE
// ==========================================
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
#endregion

// ==========================================
#region AGGRO POR DISTÂNCIA
// ==========================================
var player = instance_nearest(x, y, target);

if (instance_exists(player))
{
    var dist = point_distance(x, y, player.x, player.y);

    if (dist < aggro_range || hp < max_hp)
    {
        aggro = true;
    }

    if (aggro && dist > lose_aggro_range && hp >= max_hp)
    {
        aggro = false;
    }
}
#endregion

// ==========================================
// ==========================================
#region ATAQUE
// ==========================================

var player_collision = instance_place(x, y, obj_player);

// Sempre reinicia animação ao encostar
if (player_collision != noone && aggro)
{
    sprite_index = spr_olhinho_ataque;
    image_index = 0;
    image_speed = 1;

    attacking = true;
    attack_timer = attack_duration;

    current_scale = scale_attack;
}

// Cooldown só pro DANO
if (player_collision != noone && aggro && attack_cooldown <= 0)
{
    attack_cooldown = attack_cooldown_max;

    // Dano aqui
    with (player_collision)
    {
        hp -= 1;
    }
}

// Contagem da animação
if (attacking)
{
    attack_timer--;

    if (attack_timer <= 0)
    {
        attacking = false;

        sprite_index = spr_olhinho;
        image_speed = 0;

        current_scale = scale_idle;
    }
}

#endregion

// ==========================================
#region IA / MOVIMENTO HORIZONTAL
// ==========================================
var move = 0;

if (hitstun <= 0 && !attacking)
{
    if (aggro && instance_exists(player))
    {
        var dx = player.x - x;

        if (abs(dx) > 8)
        {
            move = sign(dx);
        }
    }
    else
    {
        // Patrulha lenta
        move = facing;
        
        // Muda de direção aleatoriamente
        if (random(100) < 1)
        {
            facing *= -1;
        }
    }
}
#endregion

// ==========================================
#region FACING
// ==========================================
if (hitstun <= 0 && move != 0)
{
    facing = sign(move);
}
#endregion

// ==========================================
#region HORIZONTAL MOVEMENT
// ==========================================
if (hitstun > 0)
{
    hspd = knockback_x;

    if (abs(knockback_x) > 0.1) knockback_x *= 0.85;
    else knockback_x = 0;
}
else
{
    hspd = move * walkspd;
}

x += hspd;
#endregion

// ==========================================
#region FLUTUAÇÃO VERTICAL
// ==========================================
// Movimento senoidal pra cima e pra baixo
float_y = sin((current_time * 0.001 * 60 * float_speed) + float_seed) * float_height;

y = base_y + float_y;
#endregion

// ==========================================
#region SPRITE / VISUAL
// ==========================================
image_xscale = facing;
image_yscale = 1;

// Se não tá atacando, usa sprite idle
if (!attacking)
{
    sprite_index = spr_olhinho;
    image_speed = 0;
}
#endregion