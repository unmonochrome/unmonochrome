/// Draw Event — obj_player

// ==========================================
#region SOMBRA
// ==========================================

// SÓ DESENHA SOMBRA SE NÃO ESTIVER NA ÁGUA
if (!dead && !death_anim && !in_water)
{
    var shadow_x = x + (10 * facing);
    var shadow_y = ground_y;
    
    var shadow_width = 80;
    var shadow_height = 20;
    
    var shadow_alpha = 0.35;
    var shadow_scale = 1;
    
    if (!on_ground)
    {
        var distance_from_ground = abs(y - ground_y);
        var air_factor = clamp(distance_from_ground / 150, 0, 1);
        
        shadow_scale = lerp(1, 0.4, air_factor);
        shadow_alpha = lerp(0.35, 0.05, air_factor);
    }
    
    for (var i = 0; i < 3; i++)
    {
        var layer_scale = shadow_scale * (1 + i * 0.2);
        var layer_alpha = shadow_alpha * (0.7 - i * 0.2);
        
        draw_set_alpha(layer_alpha);
        draw_set_color(c_black);
        
        draw_ellipse(
            shadow_x - (shadow_width * layer_scale) / 2,
            shadow_y - (shadow_height * layer_scale) / 2,
            shadow_x + (shadow_width * layer_scale) / 2,
            shadow_y + (shadow_height * layer_scale) / 2,
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

// ==========================================