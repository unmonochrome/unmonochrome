/// Step Event — obj_splash_controller

#region PRELOAD SILENCIOSO (enquanto splash roda)
// Carrega alguns sprites por frame, sem travar a animação

var processed = 0;
var total_sprites = array_length(menu_sprites_to_preload);
var total_sounds = array_length(menu_sounds_to_preload);

while (processed < preload_per_step)
{
    // Carrega sprite
    if (preload_sprite_index < total_sprites)
    {
        var spr = menu_sprites_to_preload[preload_sprite_index];
        if (sprite_exists(spr))
        {
            sprite_prefetch(spr);
        }
        preload_sprite_index++;
        processed++;
    }
    // Depois carrega sons
    else if (preload_sound_index < total_sounds)
    {
        var snd = menu_sounds_to_preload[preload_sound_index];
        if (audio_exists(snd))
        {
            var s = audio_play_sound(snd, 0, false);
            audio_sound_gain(s, 0, 0);
            audio_stop_sound(s);
        }
        preload_sound_index++;
        processed++;
    }
    else
    {
        // Acabou tudo, sai do loop
        break;
    }
}
#endregion

#region Skip Input
if (can_skip)
{
    var skip_input = keyboard_check_pressed(vk_anykey) || 
                     keyboard_check_pressed(vk_enter) || 
                     keyboard_check_pressed(ord("Z"));
    
    if (gamepad_is_connected(0))
    {
        skip_input = skip_input || 
                     gamepad_button_check_pressed(0, gp_face1) || 
                     gamepad_button_check_pressed(0, gp_start);
    }
    
    if (skip_input)
    {
        room_goto_next();
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
        
        if (hold_timer >= text_fade_delay)
        {
            text_alpha += 0.025;
            text_alpha = min(text_alpha, 1);
        }
        
        if (hold_timer >= hold_time)
        {
            state = 2;
        }
    break;
    
    case 2: // FADE OUT
        alpha -= fade_out_speed;
        text_alpha -= fade_out_speed;
        
        if (alpha <= 0)
        {
            alpha = 0;
            room_goto_next();
        }
    break;
}
#endregion
