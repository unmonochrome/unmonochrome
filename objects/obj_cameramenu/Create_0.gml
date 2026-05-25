/// Create Event — obj_cameramenu

cam_w = 1600;
cam_h = 900;

// Cria a câmera
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

// base da câmera
base_x = 0;
base_y = 0;

shake_x = 0;
shake_y = 0;
shake_r = 0;

shake_power = 1.2;
shake_rot_power = 0.08;

wave = 0;

// Música do menu
if (!audio_is_playing(snd_menu)) audio_play_sound(snd_menu, 1, true);

// Janela
last_window_w = window_get_width();
last_window_h = window_get_height();

// POST-PROCESS pra desenhar com letterbox 16:9
application_surface_draw_enable(false);
