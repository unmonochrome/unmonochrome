/// Step Event — obj_enemy

// ==========================================
#region TIMERS
// ==========================================
if (hitstun > 0) hitstun--;
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
#endregion

// ==========================================
#region ATIVAÇÃO — só ativa quando aparecer na tela pela primeira vez
// ==========================================
if (!activated)
{
    var cam = view_camera[0];
    var cx = camera_get_view_x(cam);
    var cy = camera_get_view_y(cam);
    var cw = camera_get_view_width(cam);
    var ch = camera_get_view_height(cam);

    // checa se o inimigo tá dentro da view
    if (x + sprite_width / 2 > cx && x - sprite_width / 2 < cx + cw
     && y + sprite_height / 2 > cy && y - sprite_height / 2 < cy + ch)
    {
        activated = true;
        image_speed = 1;
    }
    else
    {
        // parado, sem gravidade, sem nada
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
#region IA / MOVIMENTO
// ==========================================
var move = 0;

if (hitstun <= 0)
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
        move = facing;

        var wall_ahead = place_meeting(x + (facing * wall_check), y, obj_solid);
        var floor_ahead = place_meeting(x + (facing * edge_check), y + 16, obj_solid);

        if (wall_ahead || !floor_ahead)
        {
            facing *= -1;
            move = facing;
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
#endregion

// ==========================================
#region GRAVITY
// ==========================================
vspd += grav;
#endregion

// ==========================================
#region H COLLISION
// ==========================================
if (place_meeting(x + hspd, y, obj_solid))
{
    while (!place_meeting(x + sign(hspd), y, obj_solid))
    {
        x += sign(hspd);
    }
    hspd = 0;
    knockback_x = 0;

    if (hitstun <= 0) facing *= -1;
}
x += hspd;
#endregion

// ==========================================
#region V COLLISION
// ==========================================
if (place_meeting(x, y + vspd, obj_solid))
{
    while (!place_meeting(x, y + sign(vspd), obj_solid))
    {
        y += sign(vspd);
    }
    vspd = 0;
}
y += vspd;
#endregion

// ==========================================
#region SPRITE / VISUAL
// ==========================================
image_xscale = facing;
image_yscale = 1;
#endregion