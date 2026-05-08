/// Create Event — obj_bg_menu2

depth = 100;

#region Active
active = false;
#endregion

#region Sprites
bg_sprite = spr_fundomenu2;
john_sprite = spr_johnmenu2;
john_light_sprite = spr_luzjohnmenu2;
#endregion

#region Fundo
bg_x = 0;
bg_y = 0;
#endregion

#region Reset Function
reset_intro = function()
{
    // Mantendo a mesma posição (0,0) do original
    john_target_x = 192;
    john_target_y = 0;

    // Começa fora da tela à direita
    john_x = 1600;  // era room_width, agora explícito
    john_y = 0;

    john_intro_done = false;
    john_lerp_spd = 0.08;

    john_float_seed = random(1000);
    john_float_amp = 8;
    john_float_spd = 0.035;

    light_alpha_min = 0.5;
    light_alpha_max = 1.0;
    light_pulse_speed = 0.05;

    glitch_timer = 0;
    glitch_interval_min = room_speed * 0.4;
    glitch_interval_max = room_speed * 1.5;
    glitch_duration = 4;

    glitch_next = irandom_range(glitch_interval_min, glitch_interval_max);
    glitch_active = false;
};

reset_intro();
#endregion