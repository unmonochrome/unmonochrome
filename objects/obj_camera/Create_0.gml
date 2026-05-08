/// Create Event — obj_camera

// Tamanho da câmera (16:9 HD)
cam_w = 1600;
cam_h = 900;

// IMPORTANTE: Define que a interface (UI) vai usar essa resolução também
display_set_gui_size(cam_w, cam_h);

// cria camera
cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);

view_enabled = true;
view_visible[0] = true;
view_set_camera(0, cam);

// target do player
target = obj_player;

// suavização
smooth = 0.1;
smooth_y = 0.03;

// shake
shake_time = 0;
shake_strength = 0;

// zoom
zoom_manual = 1;
zoom_current = 1;
zoom_target = 1;
zoom_run = 1;
zoom_speed = 0.2;

// rotação
rot_current = 0;
rot_target = 0;
rot_speed = 0.2;

// lookahead
look_offset_x = 0;
cam_offset_y = -360; // Pode precisar ajustar isso, pois a tela ficou mais "baixa"