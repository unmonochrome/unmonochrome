if (!active) exit;

#region Draw Background

draw_sprite(bg_sprite, 0, bg_x, bg_y);

#endregion


#region Draw John

var final_john_x = john_x;
var final_john_y = john_y;

// flutuação horizontal
if (john_intro_done)
{
    final_john_x += sin((current_time * 0.001 * 60 * john_float_spd) + john_float_seed) * john_float_amp;
}

// john normal
draw_sprite(john_sprite, 0, final_john_x, final_john_y);

// luz por cima
var light_draw_x = final_john_x;
var light_draw_y = final_john_y;

if (glitch_active)
{
    light_draw_x += irandom_range(-3, 3);
}

var pulse = light_alpha_min
    + ((sin((current_time * 0.001 * 60 * light_pulse_speed) + 1.4) + 1) * 0.5)
    * (light_alpha_max - light_alpha_min);

if (glitch_active)
{
    pulse = min(1, pulse + 0.25);
}

draw_set_alpha(pulse);
draw_sprite(john_light_sprite, 0, light_draw_x, light_draw_y);

if (glitch_active)
{
    draw_set_alpha(pulse * 0.35);
    draw_sprite(john_light_sprite, 0, light_draw_x + irandom_range(-4, 4), light_draw_y);
}

draw_set_alpha(1);

#endregion