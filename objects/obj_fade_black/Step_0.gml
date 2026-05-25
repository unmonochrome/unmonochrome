/// Step Event — obj_fade_black

// Fade in até preto total
alpha = min(1, alpha + 0.02);

// ==========================================
// QUANDO ATINGIR PRETO TOTAL → IR PRA PRÓXIMA FASE
// ==========================================
if (alpha >= 1 && go_to_loading && !already_triggered)
{
    hold_timer++;
    
    // Segura tela preta por um momento (peso dramático)
    if (hold_timer >= hold_duration)
    {
        already_triggered = true;
        
        // Define qual room carregar depois do loading
        global.loading_target_room = target_room;
        
        // Vai pra tela de loading
        room_goto(rm_loading);
    }
}
