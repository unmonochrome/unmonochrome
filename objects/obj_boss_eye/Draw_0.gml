/// Draw Event — obj_boss_eye

// ==========================================
#region Calcular posição, escala e ângulo
// ==========================================

var draw_x = x;
var draw_y = y;

var draw_sc = spawn_scale;

var draw_ang = 0;
var draw_blend = c_white;

if (state == 99)
{
    draw_x += irandom_range(-3, 3);
    draw_y += irandom_range(-3, 3);

    draw_sc = spawn_scale;
}
else if (state == 3)
{
    draw_x += irandom_range(-death_shake, death_shake) * 0.5;

    draw_y += irandom_range(-death_shake, death_shake) * 0.5 + death_y_drift;

    draw_sc = max(0, death_scale + death_pulse);

    draw_ang = death_angle + irandom_range(-death_shake, death_shake);

    var tint_t = clamp((state_timer - 30) / 120, 0, 1);

    draw_blend = merge_colour(
        c_white,
        make_colour_rgb(255, 50, 50),
        tint_t
    );
}

#endregion

// ==========================================
#region Escala Atual
// ==========================================

var eye_scale = eye_open_scale;

if (sprite_index == spr_eye_closed_new)
{
    eye_scale = eye_closed_scale;
}

#endregion

// ==========================================
/// SUBSTITUI A PARTE "Desenhar Boss" DO DRAW POR ISSO

// ==========================================
#region Desenhar Boss
// ==========================================

if (draw_sc > 0.01)
{
    var final_xscale = eye_scale * draw_sc;
    var final_yscale = eye_scale * draw_sc;

    // squish só no olho aberto
    if (sprite_index == spr_eye_open_new)
    {
        final_xscale *= (1 + ((1 - eye_squish) * 0.12));
        final_yscale *= eye_squish;
    }

    draw_sprite_ext(
        sprite_index,
        image_index,

        draw_x,
        draw_y,

        final_xscale,
        final_yscale,

        draw_ang,

        draw_blend,
        image_alpha
    );
}

#endregion

// ==========================================
#region Desenhar Pupila
// ==========================================

// NÃO desenha pupila no olho fechado
if (
    sprite_index != spr_eye_closed_new
    && pupila_scale > 0.01
    && draw_sc > 0.01
)
{
    var pdx = 0;
    var pdy = 0;

    if (state == 3)
    {
        if (state_timer > 6 && state_timer < 70)
        {
            pdx = irandom_range(-18, 18);
            pdy = irandom_range(-12, 12);
        }
    }
    else
    {
        var pp = instance_find(obj_player, 0);

        if (instance_exists(pp))
        {
            pdx = clamp(
                pp.x - x,
                -pupila_limit_x,
                pupila_limit_x
            );

            pdy = clamp(
                pp.y - y,
                -pupila_limit_y,
                pupila_limit_y
            );
        }
    }

    draw_sprite_ext(
        spr_pupil_new,
        0,

        draw_x + pdx * draw_sc,
        draw_y + (pdy + pupila_offset_y) * draw_sc,

        pupil_scale_base * pupila_scale * draw_sc,
        pupil_scale_base * pupila_scale * draw_sc,

        draw_ang,

        c_white,
        1
    );
}

#endregion

// ==========================================
#region Sobreposições de Tela
// ==========================================

// Fade preto
if (state == 99 && fade_alpha > 0)
{
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);

    draw_rectangle(
        0,
        0,
        room_width,
        room_height,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Tela vermelha
if (state == 3 && death_red > 0)
{
    var dark_t = clamp(
        (death_red - 0.7) / 0.3,
        0,
        1
    );

    var overlay_color = merge_colour(
        c_red,
        c_black,
        dark_t
    );

    draw_set_alpha(death_red);
    draw_set_color(overlay_color);

    draw_rectangle(
        0,
        0,
        room_width,
        room_height,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Flash branco
if (state == 3 && death_flash > 0)
{
    draw_set_alpha(death_flash);
    draw_set_color(c_white);

    draw_rectangle(
        0,
        0,
        room_width,
        room_height,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}

#endregion