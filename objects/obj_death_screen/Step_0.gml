/// Step Event — obj_death_screen

state_timer++;
hint_pulse += 0.06;

switch (state)
{
    // ==========================================
    // STATE 0: APARECENDO
    // ==========================================
    case 0:
        // Fade do vermelho
        red_alpha = lerp(red_alpha, red_alpha_target, 0.03);
        
        // Título sobe e aparece
        if (state_timer > 30)
        {
            title_alpha = lerp(title_alpha, 1, 0.05);
            title_y_offset = lerp(title_y_offset, 0, 0.1);
        }
        
        // Dica aparece depois
        if (state_timer > 90)
        {
            hint_alpha = lerp(hint_alpha, 1, 0.04);
        }
        
        // Conta delay antes de aceitar input
        if (input_delay > 0) input_delay--;
        
        // Quando tudo aparecer + delay acabar, vai pro state 1
        if (state_timer > 90 && input_delay <= 0)
        {
            state = 1;
            state_timer = 0;
        }
    break;
    
    // ==========================================
    // STATE 1: AGUARDANDO INPUT
    // ==========================================
    case 1:
        // Mantém alphas
        red_alpha = red_alpha_target;
        title_alpha = 1;
        hint_alpha = 0.7 + abs(sin(hint_pulse)) * 0.3; // pulsa pra chamar atenção
        
        // Detecta input
        var key_continue = keyboard_check_pressed(ord("Z")) || 
                          keyboard_check_pressed(vk_enter) ||
                          keyboard_check_pressed(vk_space);
        
        if (gamepad_is_connected(0))
        {
            key_continue = key_continue ||
                          gamepad_button_check_pressed(0, gp_face1) ||
                          gamepad_button_check_pressed(0, gp_start);
        }
        
        if (key_continue)
        {
            state = 2;
            state_timer = 0;
        }
    break;
    
    // ==========================================
    // STATE 2: FADE PRETO + RESTART
    // ==========================================
    case 2:
        black_alpha = lerp(black_alpha, 1, 0.06);
        
        // Quando tela tiver bem preta, reinicia a room
        if (black_alpha >= 0.98)
        {
            room_restart();
        }
    break;
}
