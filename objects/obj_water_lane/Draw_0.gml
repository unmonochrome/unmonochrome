/// Draw Event — obj_water_lane

var center_x = x + lane_width / 2;
var center_y = room_height / 2;

// ==========================================
// ESTADO 0 = WARNING
// ==========================================
if (state == 0)
{
    var pulse_intensity = 0.4 + abs(sin(warning_pulse)) * 0.6;
    var warning_color = make_colour_rgb(255, 60 * pulse_intensity, 60 * pulse_intensity);
    
    var t = warning_timer / warning_time;
    var warning_alpha_mult = lerp(0.3, 0.9, t);
    
    draw_sprite_ext(
        spr_jato, jato_anim_frame,
        center_x, center_y,
        1, 1,
        0,
        warning_color,
        warning_alpha_mult
    );
    
    // "!" subindo
    var icon_pulse = 0.5 + abs(sin(warning_pulse * 1.5)) * 0.5;
    draw_set_alpha(icon_pulse);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    for (var iy = room_height; iy > 0; iy -= 200)
    {
        draw_text_transformed(
            center_x,
            iy - ((warning_timer * 3) mod 200),
            "!", 3, 3, 0
        );
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(c_white);
    
    exit;
}

// ==========================================
// ESTADO 1 = JATO ATIVO
// ==========================================

// SEMPRE desenha as 2 cópias (independentes)
draw_sprite_ext(
    spr_jato_ataque, ataque_anim_frame,
    center_x, fish_y_1,
    1, 1, 0,
    c_white, 1
);

draw_sprite_ext(
    spr_jato_ataque, ataque_anim_frame,
    center_x, fish_y_2,
    1, 1, 0,
    c_white, 1
);

// BORDAS DO JATO (com fade in/out)
if (jato_alpha > 0.02)
{
    draw_sprite_ext(
        spr_jato, jato_anim_frame,
        center_x, center_y,
        1, 1, 0,
        c_white, jato_alpha
    );
}
