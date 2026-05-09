/// Draw Event — obj_player

// ==========================================
#region SOMBRA
// ==========================================

if (!dead && !death_anim)
{
    // Posição da sombra
    var shadow_x = x + (10 * facing);
    var shadow_y = ground_y;
    
    // Tamanho base
    var shadow_width = 80;
    var shadow_height = 20;
    
    // Opacidade e escala base
    var shadow_alpha = 0.22;
    var shadow_scale = 1;
    
    // Física da sombra no ar
    if (!on_ground)
    {
        var distance_from_ground = abs(y - ground_y);
        var air_factor = clamp(distance_from_ground / 150, 0, 1);
        
        shadow_scale = lerp(1, 0.45, air_factor);
        shadow_alpha = lerp(0.22, 0.02, air_factor);
    }
    
    draw_set_color(c_black);

    // ==========================================
    // BLUR SUAVE SEM NÚCLEO NÍTIDO
    // ==========================================

    for (var i = 0; i < 12; i++)
    {
        var t = i / 11;

        // expansão progressiva
        var blur_scale = shadow_scale * (1 + t * 2.2);

        // alpha extremamente suave
        var layer_alpha = shadow_alpha * (0.18 * (1 - t));

        // leve achatamento
        var width_scale = blur_scale;
        var height_scale = blur_scale * 0.72;

        draw_set_alpha(max(layer_alpha, 0));

        draw_ellipse(
            shadow_x - (shadow_width * width_scale) / 2,
            shadow_y - (shadow_height * height_scale) / 2,
            shadow_x + (shadow_width * width_scale) / 2,
            shadow_y + (shadow_height * height_scale) / 2,
            false
        );
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
}

#endregion

// ... resto do código
#region DRAW

if (dead) exit;

if (death_anim)
{
    draw_sprite_ext(
        sprite_index, image_index,
        x, y,
        image_xscale, image_yscale,
        death_rot, c_white, death_fade
    );
}
else
{
    // piscar quando tomou dano
    if (hurt_timer > 0)
    {
        if ((hurt_timer div 2) mod 2 == 0) draw_self();
    }
    else
    {
        draw_self();
    }
}

// fade de transição de room
if (transitioning && transition_alpha > 0)
{
    draw_set_alpha(transition_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

#endregion

#region BLACK AND WHITE

shader_set(shd_saturation);

shader_set_uniform_f(
    shader_get_uniform(shd_saturation, "saturation"),
    0.0
);

draw_self();

shader_reset();

#endregion
