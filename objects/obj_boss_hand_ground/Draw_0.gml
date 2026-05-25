/// Draw Event — obj_boss_hand_ground

// ==========================================
// TRAIL FANTASMA (cópias residuais com opacidade real)
// ==========================================
var trail_count = array_length(trail_positions);

for (var i = 0; i < trail_count; i++)
{
    var ghost_y = trail_positions[i][0];
    var ghost_alpha_stored = trail_positions[i][1];
    
    // Mais novos (índices maiores) = mais visíveis
    var age_factor = (i + 1) / trail_count;
    
    var final_ghost_alpha = ghost_alpha_stored * age_factor * 0.6;
    
    if (final_ghost_alpha > 0.01)
    {
        draw_sprite_ext(
            sprite_index,
            image_index,
            x, ghost_y,
            image_xscale * 1.03,
            image_yscale * 1.03,
            0,
            c_white,
            final_ghost_alpha
        );
    }
}

// ==========================================
// BRILHO ATRÁS DA MÃO CERTA (pulsante)
// ==========================================
if (is_target && !dying && image_alpha > 0.3)
{
    gpu_set_blendmode(bm_add);
    
    var pulse_intensity = 0.6 + abs(sin(glow_pulse)) * 0.4;
    var glow_size = 180 + abs(sin(glow_pulse)) * 30;
    
    var glow_color_center = make_colour_rgb(255, 220, 100);
    var glow_color_edge = c_black;
    
    draw_set_alpha(0.4 * pulse_intensity * image_alpha);
    draw_ellipse_colour(
        x - glow_size,
        y - glow_size * 0.7,
        x + glow_size,
        y + glow_size * 0.3,
        glow_color_center, glow_color_edge,
        false
    );
    
    draw_set_alpha(0.7 * pulse_intensity * image_alpha);
    draw_ellipse_colour(
        x - glow_size * 0.5,
        y - glow_size * 0.4,
        x + glow_size * 0.5,
        y + glow_size * 0.15,
        glow_color_center, glow_color_edge,
        false
    );
    
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}

// ==========================================
// DESENHA A MÃO PRINCIPAL
// ==========================================
draw_sprite_ext(
    sprite_index,
    image_index,
    x, y,
    image_xscale,
    image_yscale,
    0,
    c_white,
    image_alpha
);

// ==========================================
// BRILHO POR CIMA DA MÃO CERTA (no bracelete)
// ==========================================
if (is_target && !dying && image_alpha > 0.3)
{
    gpu_set_blendmode(bm_add);
    
    var top_pulse = 0.15 + abs(sin(glow_pulse * 1.2)) * 0.15;
    
    draw_sprite_ext(
        sprite_index,
        image_index,
        x, y,
        image_xscale,
        image_yscale,
        0,
        make_colour_rgb(255, 240, 180),
        top_pulse * image_alpha
    );
    
    gpu_set_blendmode(bm_normal);
}

draw_set_alpha(1);
