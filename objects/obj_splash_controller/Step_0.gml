/// Step Event — obj_splash_controller

#region Skip Input
if (can_skip)
{
    // Teclado
    var skip_input = keyboard_check_pressed(vk_anykey) || 
                     keyboard_check_pressed(vk_enter) || 
                     keyboard_check_pressed(ord("Z"));
    
    // Controle
    if (gamepad_is_connected(0))
    {
        skip_input = skip_input || 
                     gamepad_button_check_pressed(0, gp_face1) || 
                     gamepad_button_check_pressed(0, gp_start);
    }
    
    if (skip_input)
    {
        room_goto_next(); // vai pro menu
        exit;
    }
}
#endregion

#region State Machine
switch (state)
{
    case 0: // FADE IN
        alpha += fade_in_speed;
        
        if (alpha >= 1)
        {
            alpha = 1;
            state = 1;
            hold_timer = 0;
        }
    break;
    
    case 1: // HOLD
        hold_timer++;
        
        // Fade in do texto (começa após delay)
        if (hold_timer >= text_fade_delay)
        {
            text_alpha += 0.025; // velocidade do fade in do texto
            text_alpha = min(text_alpha, 1);
        }
        
        if (hold_timer >= hold_time)
        {
            state = 2;
        }
    break;
    
    case 2: // FADE OUT
        alpha -= fade_out_speed;
        text_alpha -= fade_out_speed; // texto some junto
        
        if (alpha <= 0)
        {
            alpha = 0;
            room_goto_next(); // vai pro menu
        }
    break;
}
#endregion