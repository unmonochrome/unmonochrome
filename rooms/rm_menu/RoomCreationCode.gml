/// Room Creation Code

if (!audio_is_playing(snd_menu))
{
    audio_play_sound(snd_menu, 1, true);
    audio_sound_gain(snd_menu, 0.7, 0);
}