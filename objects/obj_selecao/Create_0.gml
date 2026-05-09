/// Create Event — obj_selecao

#region Setup

menu_index = 0;
menu_total = 4;

previous_menu_index = -1;

// seguir botão
target_x = x;
target_y = y;
follow_spd = 0.25;

// seletor não anima sozinho
image_speed = 0;

#endregion

depth = 0;

if (!audio_is_playing(snd_menu))
{
    audio_play_sound(snd_menu, 1, true);
    audio_sound_gain(snd_menu, 0.7, 0);
}