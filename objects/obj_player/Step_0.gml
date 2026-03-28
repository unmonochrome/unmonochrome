// ========================================
// TIMERS
// ========================================
#region TIMERS
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
if (hitstun > 0) hitstun--;
if (atk_cd > 0) atk_cd--;
#endregion


// ========================================
// ROOM TRANSITION
// ========================================
#region ROOM TRANSITION
if (transitioning)
{
    transition_alpha += transition_speed;

    if (transition_alpha >= 1)
    {
        room_goto(transition_target_room);
    }

    exit;
}
#endregion


// ========================================
// CONTROLS
// ========================================
#region CONTROLS
var key_left   = keyboard_check(vk_left);
var key_right  = keyboard_check(vk_right);

var key_jump   = keyboard_check_pressed(ord("Z"));
var key_attack = keyboard_check_pressed(ord("C"));
var key_run    = keyboard_check(ord("X"));
#endregion


// ========================================
// DEATH STATE
// ========================================
#region DEATH STATE
if (death_anim)
{
    death_timer--;

    // queda controlada
    if (vspd < 0) vspd += 0.2;
    else vspd += 0.1;

    vspd = clamp(vspd, -4, 3);

    // movimento de queda
    hspd = 0;
    y += vspd;

    // fade
    var fall_progress = clamp(abs(vspd) / 6, 0, 1);
    death_fade -= 0.01 + (fall_progress * 0.01);
    death_fade = clamp(death_fade, 0, 1);

    // só entra em dead quando sumir
    if (death_timer <= 0 || death_fade <= 0)
    {
        death_anim = false;
        dead = true;

        hspd = 0;
        vspd = 0;
        death_fade = 0;
    }

    exit;
}

if (dead)
{
    hspd = 0;
    vspd = 0;

    if (keyboard_check_pressed(ord("Z")))
    {
        x = global.spawn_x;
        y = global.spawn_y;

        hp = hp_max;
        invincible = 30;
        hurt_timer = 0;
        hitstun = 0;
        knockback_x = 0;

        dead = false;
        death_anim = false;
        death_timer = 0;
        death_fade = 1;
        death_rot = 0;
        image_alpha = 1;
        image_angle = 0;
    }

    exit;
}
#endregion


// ========================================
// INPUT
// ========================================
#region INPUT
var move = key_right - key_left;
#endregion


// ========================================
// FACING
// ========================================
#region FACING
if (move != 0) facing = sign(move);
#endregion


// ========================================
// RUN TIMER
// ========================================
#region RUN TIMER
if (move != 0 && on_ground && hitstun <= 0)
{
    run_timer++;
}
else if (move == 0 && on_ground)
{
    run_timer = 0;
}
#endregion


// ========================================
// SPEED PROGRESSION
// ========================================
#region SPEED
var base_speed = walkspd;
var max_boost = 1.5;

var t = clamp(run_timer / 120, 0, 1);
var current_max_speed = lerp(base_speed, base_speed * max_boost, t);
#endregion


// ========================================
// RUN
// ========================================
#region RUN
var run_multiplier = 1.0;

if (key_run && hitstun <= 0)
{
    if (on_ground || abs(hspd) > walkspd)
    {
        run_multiplier = 1.6;
    }
}
#endregion


// ========================================
// MOVEMENT
// ========================================
#region MOVEMENT
var accel_ground = 0.5;
var accel_air = 0.2;

var decel_ground = 0.4;
var decel_air = 0.1;

if (hitstun > 0)
{
    hspd = knockback_x;

    if (abs(knockback_x) > 0.1) knockback_x *= 0.85;
    else knockback_x = 0;
}
else if (!attacking)
{
    if (move != 0)
    {
        if (on_ground) hspd += move * accel_ground;
        else hspd += move * accel_air;
    }
    else
    {
        if (abs(hspd) > 0)
        {
            if (on_ground) hspd -= sign(hspd) * decel_ground;
            else hspd -= sign(hspd) * decel_air;

            if (abs(hspd) < 0.1) hspd = 0;
        }
    }
}
#endregion


// ========================================
// TURN CONTROL
// ========================================
#region TURN
if (hitstun <= 0 && move != 0 && sign(move) != sign(hspd))
{
    hspd *= 0.7;
}
#endregion


// ========================================
// SPEED LIMIT
// ========================================
#region SPEED LIMIT
if (hitstun <= 0)
{
    hspd = clamp(hspd, -current_max_speed * run_multiplier, current_max_speed * run_multiplier);
}
#endregion


// ========================================
// GRAVITY
// ========================================
#region GRAVITY
vspd += grav;
#endregion


// ========================================
// COYOTE
// ========================================
#region COYOTE
if (on_ground) coyote = coyote_max;
else coyote--;
#endregion


// ========================================
// JUMP
// ========================================
#region JUMP
if (hitstun <= 0 && key_jump && coyote > 0)
{
    vspd = jump_force;
    audio_play_sound(snd_jump, 1, false);
}
#endregion


// ========================================
// ATTACK
// ========================================
#region ATTACK
if (!attacking && on_ground && hitstun <= 0)
{
    if (key_attack && atk_cd <= 0)
    {
        attacking = true;
        attack_timer = attack_duration;

        var hb = instance_create_layer(x + (80 * facing), y, layer, obj_player_hitbox);
        hb.direction_x = facing;

        audio_play_sound(snd_attack, 1, false);

        atk_cd = atk_cd_max;
    }
}
#endregion


// ========================================
// ATTACK STATE
// ========================================
#region ATTACK STATE
if (attacking)
{
    attack_timer--;

    // trava movimento horizontal
    hspd *= 0.8;

    if (attack_timer <= 0)
    {
        attacking = false;
    }
}
#endregion


// ========================================
// DAMAGE
// ========================================
#region DAMAGE
var enemy = instance_place(x, y, obj_enemy);
var boss_hand = instance_place(x, y, obj_boss_hand_ground);
var falling_hand = instance_place(x, y, obj_boss_hand_fall);

var attacker = noone;

if (enemy != noone) attacker = enemy;
if (boss_hand != noone) attacker = boss_hand;
if (falling_hand != noone) attacker = falling_hand;

if (attacker != noone && invincible <= 0)
{
    hp--;
    invincible = 30;
    hurt_timer = 12;
    hitstun = 12;

    audio_play_sound(snd_hurt, 1, false);

    knockback_x = 6 * -sign(attacker.x - x);
    if (knockback_x == 0) knockback_x = -6 * facing;

    vspd = -4;
}
#endregion


// ========================================
// DEATH CHECK
// ========================================
#region DEATH CHECK
if (hp <= 0 && !dead && !death_anim)
{
    death_anim = true;
    death_timer = death_timer_max;

    hspd = 0;
    vspd = -3;

    audio_play_sound(snd_death, 1, false);

    with (obj_camera)
    {
        shake_time = 10;
        shake_strength = 5;
    }
}
#endregion


// ========================================
// VOID DEATH
// ========================================
#region VOID DEATH
if (!death_anim && !dead)
{
    if (y > room_height + 100)
    {
        hp = 0;
    }
}
#endregion


// ========================================
// DOOR CHECK
// ========================================
#region DOOR CHECK
if (!transitioning)
{
    var door = instance_place(x, y, obj_door);

    if (door != noone)
    {
        transitioning = true;
        transition_alpha = 0;
        transition_target_room = rm_menu;

        audio_play_sound(snd_transition, 1, false);
    }
}
#endregion


// ========================================
// H COLLISION
// ========================================
#region H COLLISION
if (!death_anim)
{
    if (place_meeting(x + hspd, y, obj_solid))
    {
        while (!place_meeting(x + sign(hspd), y, obj_solid))
        {
            x += sign(hspd);
        }

        hspd = 0;
        knockback_x = 0;
    }
}

x += hspd;
#endregion


// ========================================
// V COLLISION
// ========================================
#region V COLLISION
if (!death_anim)
{
    on_ground = false;

    if (place_meeting(x, y + vspd, obj_solid))
    {
        while (!place_meeting(x, y + sign(vspd), obj_solid))
        {
            y += sign(vspd);
        }

        if (vspd > 0) on_ground = true;

        vspd = 0;
    }

    y += vspd;
}
else
{
    y += vspd;
}
#endregion


// ========================================
// FOOTSTEPS
// ========================================
#region FOOTSTEPS
audio_sound_gain(snd_step, 0.3, 0);

if (step_timer > 0)
{
    step_timer--;
}

var is_moving = (abs(hspd) > 0.5) && on_ground && !death_anim && !dead;

if (!is_moving)
{
    if (step_sound_id != -1)
    {
        audio_stop_sound(step_sound_id);
        step_sound_id = -1;
    }

    step_timer = 0;
}
else
{
    var step_interval = step_interval_walk;

    if (key_run && abs(hspd) > walkspd)
    {
        step_interval = step_interval_run;
    }

    if (step_timer <= 0)
    {
        if (step_sound_id != -1)
        {
            audio_stop_sound(step_sound_id);
        }

        step_sound_id = audio_play_sound(snd_step, 1, false);
        step_timer = step_interval;
    }
}
#endregion


// ========================================
// SPRITE / VISUAL
// ========================================
#region SPRITE / VISUAL
var base_scale = 0.3;

image_xscale = base_scale * facing;
image_yscale = base_scale;

if (dead)
{
    // nada
}
else if (death_anim)
{
    // mantém sprite atual
}
else if (attacking)
{
    if (sprite_index != spr_player_attack1)
    {
        sprite_index = spr_player_attack1;
        image_index = 0;
    }

    image_speed = 1;
}
else
{
    if (!on_ground)
    {
        if (sprite_index != spr_player_jump)
        {
            sprite_index = spr_player_jump;
            image_index = 0;
        }

        if (vspd < 0)
        {
            image_speed = 0.25;

            if (image_index > 2)
            {
                image_index = 2;
            }
        }
        else
        {
            image_index = 3;
            image_speed = 0;
        }
    }
    else if (abs(hspd) > 0.3)
    {
        if (sprite_index != spr_player_run)
        {
            sprite_index = spr_player_run;
            image_index = 0;
        }

        image_speed = 1;
    }
    else
    {
        if (sprite_index != spr_player_idle)
        {
            sprite_index = spr_player_idle;
            image_index = 0;
        }

        image_speed = 1;
    }
}
#endregion