/// Step Event — obj_player

// ==========================================
#region TIMERS
// ==========================================
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
if (hitstun > 0) hitstun--;
if (atk_cd > 0) atk_cd--;
if (step_timer > 0) step_timer--;
#endregion

// ==========================================
#region FREEZE
// ==========================================
if (freeze)
{
    hspd = 0;
    vspd = 0;
    image_speed = 0;
    exit;
}
#endregion

// ==========================================
#region ROOM TRANSITION
// ==========================================
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

// ==========================================
#region CONTROLS — TECLADO + CONTROLE
// ==========================================
// Teclado
var key_left   = keyboard_check(vk_left);
var key_right  = keyboard_check(vk_right);
var key_jump   = keyboard_check_pressed(ord("Z"));
var key_attack = keyboard_check_pressed(ord("C"));
var key_run    = keyboard_check(ord("X"));

// Controle Xbox (gamepad 0)
var gp_connected = gamepad_is_connected(0);

if (gp_connected)
{
    // D-pad
    var gp_left  = gamepad_button_check(0, gp_padl);
    var gp_right = gamepad_button_check(0, gp_padr);
    
    // Analógico esquerdo
    var gp_axis_h = gamepad_axis_value(0, gp_axislh);
    var deadzone = 0.3;
    
    // Considera analógico se passar da deadzone
    var analog_left  = (gp_axis_h < -deadzone);
    var analog_right = (gp_axis_h > deadzone);
    
    // Botões
    var gp_jump   = gamepad_button_check_pressed(0, gp_face1); // A
    var gp_run    = gamepad_button_check(0, gp_face2);          // B
    var gp_attack = gamepad_button_check_pressed(0, gp_face3);  // X
    
    // Combina teclado + controle
    key_left   = key_left   || gp_left  || analog_left;
    key_right  = key_right  || gp_right || analog_right;
    key_jump   = key_jump   || gp_jump;
    key_attack = key_attack || gp_attack;
    key_run    = key_run    || gp_run;
}

var move = key_right - key_left;
#endregion

// ==========================================
#region DEATH STATE
// ==========================================
if (death_anim)
{
    death_timer--;

    if (vspd < 0) vspd += 0.2;
    else vspd += 0.1;

    vspd = clamp(vspd, -4, 3);

    hspd = 0;
    y += vspd;

    var fall_progress = clamp(abs(vspd) / 6, 0, 1);
    death_fade -= 0.01 + (fall_progress * 0.01);
    death_fade = clamp(death_fade, 0, 1);

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

    // Aceita Z do teclado ou A do controle pra reviver
    var respawn_input = keyboard_check_pressed(ord("Z"));
    
    if (gp_connected)
    {
        respawn_input = respawn_input || gamepad_button_check_pressed(0, gp_face1);
    }

    if (respawn_input)
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

// ==========================================
#region FACING
// ==========================================
if (move != 0 && hitstun <= 0 && !attacking)
{
    facing = sign(move);
}
#endregion

// ==========================================
#region RUN TIMER
// ==========================================
if (move != 0 && on_ground && hitstun <= 0)
{
    run_timer++;
}
else if (on_ground)
{
    run_timer = 0;
}
#endregion

// ==========================================
#region SPEED CALC
// ==========================================
var base_speed = walkspd;
var max_boost = 1.5;
var t = clamp(run_timer / 120, 0, 1);
var current_max_speed = lerp(base_speed, base_speed * max_boost, t);

var run_multiplier = 1.0;
if (key_run && hitstun <= 0)
{
    run_multiplier = 1.6;
}

var final_max_speed = current_max_speed * run_multiplier;
#endregion

// ==========================================
#region MOVEMENT
// ==========================================
var accel_ground = 0.7;
var accel_air = 0.3;

var decel_ground = 0.9;
var decel_air = 0.15;

if (hitstun > 0)
{
    hspd = knockback_x;

    if (abs(knockback_x) > 0.1)
        knockback_x *= 0.85;
    else
        knockback_x = 0;
}
else if (!attacking)
{
    if (move != 0)
    {
        if (on_ground)
        {
            hspd += move * accel_ground;
        }
        else
        {
            hspd += move * accel_air;
        }
    }
    else
    {
        if (on_ground)
        {
            // chão: para rápido, sem escorregar
            hspd = lerp(hspd, 0, decel_ground);

            if (abs(hspd) < 0.08)
                hspd = 0;
        }
        else
        {
            // ar: desacelera menos
            hspd = lerp(hspd, 0, decel_air);

            if (abs(hspd) < 0.05)
                hspd = 0;
        }
    }
}
#endregion

// ==========================================
#region TURN CONTROL
// ==========================================
if (hitstun <= 0 && move != 0 && abs(hspd) > 0.1 && sign(move) != sign(hspd))
{
    hspd *= 0.55;
}
#endregion

// ==========================================
#region SPEED LIMIT
// ==========================================
if (hitstun <= 0)
{
    hspd = clamp(hspd, -final_max_speed, final_max_speed);
}
#endregion

// ==========================================
#region GRAVITY
// ==========================================
vspd += grav;
#endregion

// ==========================================
#region COYOTE
// ==========================================
if (on_ground) coyote = coyote_max;
else coyote--;
#endregion

// ==========================================
#region JUMP
// ==========================================
if (hitstun <= 0 && key_jump && coyote > 0)
{
    vspd = jump_force;
    coyote = 0;
    audio_play_sound(snd_jump, 1, false);
}
#endregion

// ==========================================
#region ATTACK
// ==========================================
if (!attacking && hitstun <= 0 && key_attack && atk_cd <= 0)
{
    attacking = true;
    attack_timer = attack_duration;

    var hb = instance_create_layer(x + (100 * facing), y, layer, obj_player_hitbox);
    hb.direction_x = facing;

    audio_play_sound(snd_attack, 1, false);
    atk_cd = atk_cd_max;
}
#endregion

// ==========================================
#region ATTACK STATE
// ==========================================
if (attacking)
{
    attack_timer--;

    if (on_ground)
        hspd = lerp(hspd, 0, 0.25);
    else
        hspd *= 0.92;

    if (attack_timer <= 0)
    {
        attacking = false;
    }
}
#endregion

// ==========================================
#region DAMAGE
// ==========================================
var enemy = instance_place(x, y, obj_enemy);
var boss_hand = instance_place(x, y, obj_boss_hand_ground);

var attacker = noone;
if (enemy != noone) attacker = enemy;
if (boss_hand != noone) attacker = boss_hand;

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

// ==========================================
#region DEATH CHECK
// ==========================================
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

// ==========================================
#region VOID DEATH
// ==========================================
if (!death_anim && !dead)
{
    if (y > room_height + 100)
        hp = 0;
}
#endregion

// ==========================================
#region H COLLISION
// ==========================================
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

// ==========================================
// ==========================================
#region V COLLISION
// ==========================================
if (!death_anim)
{
    on_ground = false;

    if (place_meeting(x, y + vspd, obj_solid))
    {
        while (!place_meeting(x, y + sign(vspd), obj_solid))
        {
            y += sign(vspd);
        }

        if (vspd > 0) 
        {
            on_ground = true;
            ground_y = y; // ← ADICIONE ESTA LINHA (salva Y do chão)
        }
        vspd = 0;
    }

    y += vspd;
}
else
{
    y += vspd;
}
#endregion



// ==========================================
#region FOOTSTEPS
// ==========================================
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
            audio_stop_sound(step_sound_id);

        step_sound_id = audio_play_sound(snd_step, 1, false,0.2);
        step_timer = step_interval;
    }
}
#endregion

// ==========================================
#region SPRITE / VISUAL
// ==========================================
var base_scale = 0.35;

image_xscale = base_scale * facing;
image_yscale = base_scale;

if (dead)
{
    // mantém sprite atual
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
                image_index = 2;
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

        if (key_run && abs(hspd) > walkspd)
            image_speed = 1;
        else
            image_speed = 0.8;
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