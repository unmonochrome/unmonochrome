/// SUBSTITUI o trecho da MÁSCARA DE COLISÃO no INÍCIO do Step

// ==========================================
// MÁSCARA DE COLISÃO baseada no estado
// ==========================================
// SÓ usa mask_index do swim na room da sereia
if (in_water && room == rm_sereia)
    mask_index = spr_player_swim;
else
    mask_index = spr_player_mask;

// ==========================================
#region TIMERS
// ==========================================
if (hurt_timer > 0) hurt_timer--;
if (invincible > 0) invincible--;
if (hitstun > 0) hitstun--;
if (atk_cd > 0) atk_cd--;
if (step_timer > 0) step_timer--;
if (dash_cooldown > 0) dash_cooldown--;
if (swim_jump_timer > 0) swim_jump_timer--;

// Cegueira vai sumindo
blind_pulse += 0.1;
blind_alpha = lerp(blind_alpha, blind_alpha_target, 0.015);
if (blind_alpha < 0.02) blind_alpha = 0;
blind_alpha_target = lerp(blind_alpha_target, 0, 0.015);
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
    if (transition_alpha >= 1) room_goto(transition_target_room);
    exit;
}
#endregion

/// SUBSTITUI APENAS A REGIÃO #region CONTROLS no Step do obj_player

// ==========================================
#region CONTROLS (usando configurações globais)
// ==========================================
var key_left   = keyboard_check(global.key_left);
var key_right  = keyboard_check(global.key_right);
var key_up     = keyboard_check(global.key_up);
var key_down   = keyboard_check(global.key_down);

// Pular aceita SPACE (configurado) E ↑ (sempre, por conveniência)
var key_jump   = keyboard_check_pressed(global.key_jump) 
              || keyboard_check_pressed(global.key_up);

var key_attack = keyboard_check_pressed(global.key_attack);
var key_run    = keyboard_check(global.key_run);

var gp_connected = gamepad_is_connected(0);

if (gp_connected)
{
    var gp_left  = gamepad_button_check(0, gp_padl);
    var gp_right = gamepad_button_check(0, gp_padr);
    var gp_up    = gamepad_button_check(0, gp_padu);
    var gp_down  = gamepad_button_check(0, gp_padd);
    
    var gp_axis_h = gamepad_axis_value(0, gp_axislh);
    var gp_axis_v = gamepad_axis_value(0, gp_axislv);
    var deadzone = 0.3;
    
    var analog_left  = (gp_axis_h < -deadzone);
    var analog_right = (gp_axis_h > deadzone);
    var analog_up    = (gp_axis_v < -deadzone);
    var analog_down  = (gp_axis_v > deadzone);
    
    var gp_jump   = gamepad_button_check_pressed(0, gp_face1);
    var gp_run    = gamepad_button_check(0, gp_face2);
    var gp_attack = gamepad_button_check_pressed(0, gp_face3);
    
    key_left   = key_left   || gp_left  || analog_left;
    key_right  = key_right  || gp_right || analog_right;
    key_up     = key_up     || gp_up    || analog_up;
    key_down   = key_down   || gp_down  || analog_down;
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
        
        if (!instance_exists(obj_death_screen))
            instance_create_depth(0, 0, -9998, obj_death_screen);
    }

    exit;
}

if (dead)
{
    hspd = 0;
    vspd = 0;
    exit;
}
#endregion

// ==========================================
#region FACING
// ==========================================
if (move != 0 && hitstun <= 0 && !attacking && !dash_active)
    facing = sign(move);
#endregion

// ==========================================
#region MODO AQUÁTICO
// ==========================================
if (in_water)
{
    grav = 0;
    
    if (hitstun <= 0 && !dash_active)
    {
        if (move != 0)
        {
            hspd += move * 0.5;
            hspd = clamp(hspd, -3, 3);
        }
        else
        {
            hspd *= 0.95;
            if (abs(hspd) < 0.1) hspd = 0;
        }
    }
    
    if (hitstun <= 0 && !dash_active)
    {
        if (key_jump)
        {
            water_vspd = -12;
            swim_jump_timer = swim_jump_duration;
            
            if (sprite_index == spr_player_jump_swim)
                image_index = 0;
        }
        
        if (key_down)
        {
            water_vspd += 0.8;
            water_vspd = clamp(water_vspd, -35, 14);
        }
        else
        {
            water_vspd += 0.18;
            water_vspd = clamp(water_vspd, -35, 8);
        }
        
        water_vspd *= 0.94;
        vspd = water_vspd;
    }
    
    if (!dash_active && dash_cooldown <= 0 && key_attack && hitstun <= 0)
    {
        dash_active = true;
        dash_timer = dash_duration;
        dash_cooldown = dash_cooldown_max;

        var hb = instance_create_layer(x + (100 * facing), y, "effects", obj_player_hitbox);
        hb.direction_x = facing;

        hspd = dash_speed * facing;
        water_vspd = 0;
        vspd = 0;

        audio_play_sound(snd_attack, 1, false);
    }
    
    if (dash_active)
    {
        dash_timer--;
        
        hspd = dash_speed * facing;
        water_vspd = 0;
        vspd = 0;
        
        if (dash_timer <= 0)
        {
            dash_active = false;
            hspd *= 0.4;
        }
    }
    
    x += hspd;
    y += vspd;
    
    var margin = 100;
    x = clamp(x, -margin, room_width  + margin);
    y = clamp(y, -margin, room_height + margin);
    
    on_ground = false;
    state = "water";
    
    if (dash_active || hitstun > 0 || swim_jump_timer > 0)
    {
        swim_tilt_target = 0;
    }
    else
    {
        var tilt_factor = hspd / 3;
        tilt_factor = clamp(tilt_factor, -1, 1);
        
        var vert_factor = vspd / 10;
        vert_factor = clamp(vert_factor, -0.5, 0.5);
        
        swim_tilt_target = -tilt_factor * swim_tilt_max + vert_factor * swim_tilt_max * 0.6;
    }
    
    swim_tilt_angle = lerp(swim_tilt_angle, swim_tilt_target, swim_tilt_speed);
}
#endregion

// ==========================================
#region MODO TERRESTRE
// ==========================================
else
{
    state = "ground";
    
    swim_tilt_angle = lerp(swim_tilt_angle, 0, 0.2);
    swim_jump_timer = 0;
    
    if (move != 0 && on_ground && hitstun <= 0)
        run_timer++;
    else if (on_ground)
        run_timer = 0;
    
    var base_speed = walkspd;
    var max_boost = 1.5;
    var t = clamp(run_timer / 120, 0, 1);
    var current_max_speed = lerp(base_speed, base_speed * max_boost, t);

    var run_multiplier = 1.0;
    if (key_run && hitstun <= 0) run_multiplier = 1.6;

    var final_max_speed = current_max_speed * run_multiplier;
    
    var accel_ground = 0.7;
    var accel_air = 0.3;
    var decel_ground = 0.9;
    var decel_air = 0.15;

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
            if (on_ground)
            {
                hspd = lerp(hspd, 0, decel_ground);
                if (abs(hspd) < 0.08) hspd = 0;
            }
            else
            {
                hspd = lerp(hspd, 0, decel_air);
                if (abs(hspd) < 0.05) hspd = 0;
            }
        }
    }
    
    if (hitstun <= 0 && move != 0 && abs(hspd) > 0.1 && sign(move) != sign(hspd))
        hspd *= 0.55;
    
    if (hitstun <= 0)
        hspd = clamp(hspd, -final_max_speed, final_max_speed);
    
    grav = 0.5;
    vspd += grav;
    
    if (on_ground) coyote = coyote_max;
    else coyote--;
    
    if (hitstun <= 0 && key_jump && coyote > 0)
    {
        vspd = jump_force;
        coyote = 0;
        audio_play_sound(snd_jump, 1, false);
    }
    
    if (!attacking && hitstun <= 0 && key_attack && atk_cd <= 0)
    {
        attacking = true;
        attack_timer = attack_duration;

        var hb = instance_create_layer(x + (100 * facing), y, layer, obj_player_hitbox);
        hb.direction_x = facing;

        audio_play_sound(snd_attack, 1, false);
        atk_cd = atk_cd_max;
    }
    
    if (attacking)
    {
        attack_timer--;

        if (on_ground) hspd = lerp(hspd, 0, 0.25);
        else hspd *= 0.92;

        if (attack_timer <= 0) attacking = false;
    }
    
    if (place_meeting(x + hspd, y, obj_solid))
    {
        while (!place_meeting(x + sign(hspd), y, obj_solid))
            x += sign(hspd);

        hspd = 0;
        knockback_x = 0;
    }

    x += hspd;
    
    on_ground = false;

    if (place_meeting(x, y + vspd, obj_solid))
    {
        while (!place_meeting(x, y + sign(vspd), obj_solid))
            y += sign(vspd);

        if (vspd > 0)
        {
            on_ground = true;
            ground_y = y;
        }
        vspd = 0;
    }

    y += vspd;
}
#endregion

// ==========================================
#region DAMAGE
// ==========================================
var enemy = instance_place(x, y, obj_enemy);

var boss_hand = noone;
with (obj_boss_hand_ground)
{
    if (!dying && place_meeting(x, y, other))
    {
        boss_hand = id;
        break;
    }
}

var attacker = noone;
if (enemy != noone) attacker = enemy;
if (boss_hand != noone) attacker = boss_hand;

if (attacker != noone && invincible <= 0)
{
    hp--;
    // HITSTUN MAIOR: 1 segundo de invencibilidade
    invincible = 60;
    hurt_timer = 60;
    hitstun = 20;

    audio_play_sound(snd_hurt, 1, false);

    knockback_x = 6 * -sign(attacker.x - x);
    if (knockback_x == 0) knockback_x = -6 * facing;

    if (!in_water) vspd = -4;
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

    with (obj_camera_boss_fixed)
    {
        shake_time = 10;
        shake_strength = 5;
    }
}
#endregion

// ==========================================
#region SPRITE / VISUAL
// ==========================================
var base_scale = 0.3;

image_xscale = base_scale * facing;
image_yscale = base_scale;

if (in_water && !dash_active)
    image_angle = swim_tilt_angle;
else
    image_angle = 0;

if (dead) {}
else if (death_anim) {}
else if (dash_active)
{
    if (sprite_index != spr_player_swim_attack)
    {
        sprite_index = spr_player_swim_attack;
        image_index = 0;
    }
    
    image_speed = 0;
    
    var progress = 1 - (dash_timer / dash_duration);
    var total_frames = sprite_get_number(spr_player_swim_attack);
    var frame_to_show = floor(progress * total_frames);
    
    image_index = clamp(frame_to_show, 0, total_frames - 1);
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
    if (in_water)
    {
        if (swim_jump_timer > 0)
        {
            if (sprite_index != spr_player_jump_swim)
            {
                sprite_index = spr_player_jump_swim;
                image_index = 0;
            }
            
            image_speed = 0;
            
            var progress = 1 - (swim_jump_timer / swim_jump_duration);
            var total_frames = sprite_get_number(spr_player_jump_swim);
            var frame_to_show = floor(progress * total_frames);
            
            image_index = clamp(frame_to_show, 0, total_frames - 1);
        }
        else
        {
            if (sprite_index != spr_player_swim)
            {
                sprite_index = spr_player_swim;
                image_index = 0;
            }
            image_speed = 0.8;
        }
    }
    else if (!on_ground)
    {
        if (sprite_index != spr_player_jump)
        {
            sprite_index = spr_player_jump;
            image_index = 0;
        }

        if (vspd < 0)
        {
            image_speed = 0.25;
            if (image_index > 2) image_index = 2;
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

        if (key_run && abs(hspd) > walkspd && !in_water)
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
