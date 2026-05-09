/// Create Event — obj_cameramenu (CORRIGIDO)

// Tamanho da câmera
cam_w = 1600;
cam_h = 900;

// IMPORTANTE: aguarda 1 frame antes de criar camera em HTML5
if (os_browser != browser_not_a_browser)
{
    alarm[0] = 1; // cria camera no próximo frame
}
else
{
    // exe: cria imediatamente
    setup_camera();
}

// base da câmera
base_x = 0;
base_y = 0;

// shake atual
shake_x = 0;
shake_y = 0;
shake_r = 0;

// força
shake_power = 1.2;
shake_rot_power = 0.08;

wave = 0;

// Checa se a música do menu NÃO está tocando, aí toca
if (!audio_is_playing(snd_menu)) audio_play_sound(snd_menu, 1, true);