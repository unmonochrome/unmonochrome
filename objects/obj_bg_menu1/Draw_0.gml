if (!active) exit;

#region Cabeças + luzes

var max_heads = min(head_count, 3);

for (var i = 0; i < max_heads; i++)
{
    var final_y = head_y[i];

    // flutuação
    if (head_arrived[i])
    {
        final_y += sin((current_time * 0.001 * 60 * head_float_speed) + head_float_seed[i]) * head_float_amp;
    }

    // cabeça
    draw_sprite(head_sprite[i], 0, head_x[i], final_y);

    // luz
    var light_draw_x = head_light_x[i];
    var light_draw_y = final_y;

    if (glitch_active)
    {
        light_draw_x += irandom_range(-3, 3);
    }

    var pulse = light_alpha_min
        + ((sin((current_time * 0.001 * 60 * light_pulse_speed) + i * 1.4) + 1) * 0.5)
        * (light_alpha_max - light_alpha_min);

    if (glitch_active)
    {
        pulse = min(1, pulse + 0.25);
    }

    gpu_set_blendmode(bm_add);

    draw_set_alpha(pulse);
    draw_sprite(head_light_sprite[i], 0, light_draw_x, light_draw_y);

    if (glitch_active)
    {
        draw_set_alpha(pulse * 0.35);
        draw_sprite(head_light_sprite[i], 0, light_draw_x + irandom_range(-4, 4), light_draw_y);
    }

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(1);
}

#endregion
