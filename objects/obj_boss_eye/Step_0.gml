/// Step Event — obj_boss_eye

state_timer++;

var p = instance_find(obj_player, 0);
if (!instance_exists(p)) exit;

var hp_lost = max_hp - hp;
var hp_ratio = hp_lost / max_hp;
var hand_count = min(3 + hp_lost, 7);

// ==========================================
// SQUISH DO OLHO
// ==========================================

// fechando
if (state == 1)
{
    eye_squish_target = 0.62;
}

// abrindo
else if (state == 0)
{
    // overshootzinho p parecer orgânico
    if (state_timer < 4)
        eye_squish_target = 1.08;
    else
        eye_squish_target = 1;
}

// fechado
else if (state == 2)
{
    eye_squish_target = 1;
}

eye_squish = lerp(eye_squish, eye_squish_target, 0.20);

// ==========================================
#region STATE 99 — CUTSCENE SPAWN
// ==========================================
if (state == 99)
{
    fade_alpha = max(0, fade_alpha + fade_speed);

    spawn_scale = min(1, spawn_scale + spawn_speed);

    p.freeze = true;

    if (fade_alpha <= 0 && spawn_scale >= 1)
    {
        state = 0;
        state_timer = 0;

        spawn_scale = 1;

        p.freeze = false;
    }

    exit;
}
#endregion

// ==========================================
#region STATE 3 — MORTE ÉPICA
// ==========================================
if (state == 3)
{
    var dt = state_timer;

    sprite_index = spr_eye_open_new;

    p.freeze = true;

    with (obj_boss_hand_ground) instance_destroy();
    with (obj_boss_hand_warning_ground) instance_destroy();

    if (dt <= 6)
    {
        death_flash = 1;

        pupila_scale = lerp(pupila_scale, 2, 0.3);

        exit;
    }

    death_flash = max(0, death_flash - 0.035);

    if (dt < 20)
        pupila_scale = lerp(pupila_scale, 1.5, 0.1);
    else if (dt < 70)
        pupila_scale = lerp(pupila_scale, 0, 0.06);
    else
        pupila_scale = 0;

    var t = clamp((dt - 6) / 180, 0, 1);

    death_shake = t * 22;

    death_rot_speed = lerp(death_rot_speed, 16, 0.008);

    death_angle += death_rot_speed;

    var pf = 0.12 + t * 0.35;
    var pa = 0.04 + t * 0.14;

    death_pulse = sin(dt * pf) * pa * max(0, 1 - t * 1.2);

    if (dt > 40)
        death_y_drift += 0.25;

    if (t > 0.35)
    {
        var st = (t - 0.35) / 0.65;

        death_scale = max(0, 1 - st);
    }

    if (death_scale > 0.03)
    {
        if (t > 0.15)
            death_red = min(0.7, death_red + 0.005);
    }
    else
    {
        death_scale = 0;

        death_red = min(1, death_red + 0.02);
    }

    if (death_scale <= 0 && death_red >= 1)
    {
        var fb = instance_create_depth(0, 0, -9999, obj_fade_black);

        fb.alpha = 1;

        p.freeze = false;

        instance_destroy();
    }

    exit;
}
#endregion

// ==========================================
#region MOVIMENTO DA BATALHA — RESPIRAÇÃO
// ==========================================

float_timer += float_spd;

// Movimento horizontal suave (como se "respirasse")
var breath_x = sin(float_timer * 0.8) * 120;
var breath_y = cos(float_timer * 0.6) * 40;

// Pulso de escala (cresce/diminui sutilmente)
var breath_pulse = sin(float_timer * 1.2) * 0.03;
image_xscale = eye_open_scale * (1 + breath_pulse);
image_yscale = eye_open_scale * (1 - breath_pulse * 0.5);

// Segue player + respiração
x = lerp(x, p.x + breath_x, 0.08);
y = 1184 + breath_y;

x = clamp(x, 300, room_width - 300);

#endregion

// ==========================================
#region MOVIMENTO DA BATALHA
// ==========================================

float_timer += float_spd;

var cyclo_radius_x_dynamic =
    30 + 50 * hp_ratio + 100 / obj_camera.zoom_manual;

var ang = float_timer * 2;

var cyc_x =
    base_x + cos(ang) * cyclo_radius_x_dynamic;

x =
    lerp(x, p.x, 0.08)
    + (cyc_x - base_x) * 0.08;

y = 1184;

x = clamp(x, 300, room_width - 300);

#endregion

// ==========================================
#region LIMPEZA DE MÃOS
// ==========================================

if (wrong_hand_hit || correct_hand_hit)
{
    with (obj_boss_hand_ground) instance_destroy();
    with (obj_boss_hand_warning_ground) instance_destroy();

    state = 0;
    state_timer = 0;

    hands_spawned = false;

    wrong_hand_hit = false;
    correct_hand_hit = false;
}

#endregion

// ==========================================
#region ESTADOS DA BATALHA
// ==========================================

switch (state)
{
    case 0:

        sprite_index = spr_eye_open_new;

        if (state_timer >= max(10, room_speed * 1.2 - hp_lost * 10))
        {
            state = 1;
            state_timer = 0;

            hands_spawned = false;
        }

    break;

case 1:

    sprite_index = spr_eye_open_new;

    if (state_timer >= 6)
    {
        sprite_index = spr_eye_closed_new;

        if (!hands_spawned && instance_exists(p))
        {
            hands_spawned = true;

            var platform_left = 3648;
            var platform_right = 8032;
            
            var target_index = irandom(hand_count - 1);
            
            var spacing = 400;
            var total_width = spacing * (hand_count - 1);
            
            // Tenta centralizar no player
            var center_x = p.x;
            
            // Mas se não couber, ajusta
            var min_x = platform_left + 100;
            var max_x = platform_right - 100;
            
            // Calcula onde começa pra ficar centralizado
            var start_x = center_x - (total_width / 2);
            
            // Se passar dos limites, ajusta
            if (start_x < min_x)
            {
                start_x = min_x;
            }
            
            if (start_x + total_width > max_x)
            {
                start_x = max_x - total_width;
            }

            for (var i = 0; i < hand_count; i++)
            {
                var hand_x = start_x + (i * spacing);

                var w = instance_create_layer(
                    hand_x,
                    1792,
                    "inimigos",
                    obj_boss_hand_warning_ground
                );

                w.spawn_x = hand_x;
                w.spawn_y = 1792 + 220;
                w.target_y = 1792;

                w.owner = id;

                w.is_target = (i == target_index);

                w.warning_time = max(8, 45 - hp_lost * 4);

                w.hand_speed = 0.35 + hp_ratio * 0.45;
            }
        }

        state = 2;
        state_timer = 0;
    }

break;

    case 2:

        sprite_index = spr_eye_closed_new;

        if (
            instance_number(obj_boss_hand_ground) <= 0
            && instance_number(obj_boss_hand_warning_ground) <= 0
        )
        {
            state = 0;
            state_timer = 0;

            hands_spawned = false;
        }

    break;
}

#endregion

// ==========================================
#region CHECAR MORTE
// ==========================================

if (hp <= 0 && state != 3)
{
    state = 3;
    state_timer = 0;

    death_scale = 1;
    death_angle = 0;
    death_rot_speed = 0;

    death_shake = 0;
    death_flash = 0;
    death_red = 0;

    death_pulse = 0;
    death_y_drift = 0;

    pupila_scale = 1;

    with (obj_boss_hand_ground) instance_destroy();
    with (obj_boss_hand_warning_ground) instance_destroy();
}

#endregion