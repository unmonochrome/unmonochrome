/// Create Event — obj_splash_controller

// ==========================================
// FONTE PADRÃO DO JOGO INTEIRO
// ==========================================
draw_set_font(fnt_countdown);

// ==========================================
// INICIALIZA CONFIGURAÇÕES
// ==========================================
settings_init();

#region Setup
logo_sprite = spr_trio;

fade_in_speed = 0.02;
fade_out_speed = 0.02;
hold_time = 300;
hold_timer = 0;

state = 0;
alpha = 0;

logo_scale = 550 / 2048;

can_skip = true;

text_alpha = 0;
text_fade_delay = 60;
#endregion

#region PRELOAD DOS ASSETS DO MENU
menu_sprites_to_preload = [
    spr_cabeca1, spr_cabeca2, spr_cabeca3,
    spr_cabecaluz1, spr_cabecaluz2, spr_cabecaluz3,
    spr_fundomenu2, spr_johnmenu2, spr_luzjohnmenu2,
    spr_bgmenu3, spr_johnmenu3, spr_johnmenu3luz,
];

menu_sounds_to_preload = [snd_menu];

preload_sprite_index = 0;
preload_sound_index = 0;
preload_per_step = 2;
#endregion

#region Camera + Letterbox
cam_w = 1600;
cam_h = 900;

cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_set_camera(0, cam);

view_enabled = true;
view_visible[0] = true;

view_wview[0] = cam_w;
view_hview[0] = cam_h;

view_wport[0] = window_get_width();
view_hport[0] = window_get_height();
view_xport[0] = 0;
view_yport[0] = 0;

display_set_gui_size(cam_w, cam_h);

application_surface_draw_enable(false);
#endregion
