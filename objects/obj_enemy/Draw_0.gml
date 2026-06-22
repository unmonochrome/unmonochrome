/// Draw Event — obj_enemy

// ==========================================
// PARÂMETROS
// ==========================================
var final_scale = current_scale;
var final_alpha = 1;

if (dying)
{
    final_alpha *= death_alpha;
}

if (hurt_timer > 0 && (hurt_timer div 2) mod 2 != 0)
{
    final_alpha = 0;
}

// ==========================================
// SOMBRA
// ==========================================
var shadow_y = y + 24;

draw_set_color(c_black);

for (var i = 0; i < 8; i++)
{
    var s = 1 + i * 0.14;
    var a = 0.025 - i * 0.0025;

    if (a < 0) a = 0;

    draw_set_alpha(a * final_alpha);

    draw_ellipse(
        x - 13 * s,
        shadow_y - 3 * s,
        x + 13 * s,
        shadow_y + 3 * s,
        false
    );
}

draw_set_alpha(1);
draw_set_color(c_white);

// ==========================================
// AURA BLUR MONOCROMÁTICA
// ==========================================
gpu_set_blendmode(bm_add);

var pulse = sin(current_time * 0.004 + aura_pulse_seed);

var c_center_1 = make_colour_rgb(180, 180, 180);
var c_center_2 = make_colour_rgb(90, 90, 90);
var c_edge = c_black;

var glow_radius_x = 90 + (pulse * 10);
var glow_radius_y = 90 + (pulse * 10);

draw_set_alpha(0.6 * final_alpha);
draw_ellipse_colour(
    x - (glow_radius_x * 1.5),
    y - (glow_radius_y * 1.5),
    x + (glow_radius_x * 1.5),
    y + (glow_radius_y * 1.5),
    c_center_2, c_edge, false
);

draw_set_alpha(0.8 * final_alpha);
draw_ellipse_colour(
    x - glow_radius_x,
    y - glow_radius_y,
    x + glow_radius_x,
    y + glow_radius_y,
    c_center_1, c_edge, false
);

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);

// ==========================================
// SPRITE PRINCIPAL (MONOCROMÁTICO)
// ==========================================
shader_set(sh_monochrome);

draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y,
    final_scale * -facing * death_scale,
    final_scale * death_scale,
    0,
    c_white,
    final_alpha
);

shader_reset();

// ==========================================
// BRILHO LEVE POR CIMA DO OLHO
// ==========================================
gpu_set_blendmode(bm_add);
draw_set_alpha(0.1 * final_alpha);

shader_set(sh_monochrome);

draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y,
    final_scale * -facing,
    final_scale,
    0,
    c_white,
    1
);

shader_reset();

gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
draw_set_color(c_white);