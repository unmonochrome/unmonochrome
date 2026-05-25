/// Create Event — obj_camera

// Tamanho da câmera (16:9)
cam_w = 1600;
cam_h = 900;

// Cria a câmera DO ZERO
cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_set_camera(0, cam);

// Configura view
view_enabled = true;
view_visible[0] = true;

view_wview[0] = cam_w;
view_hview[0] = cam_h;

// Port enche a janela inteira
view_wport[0] = window_get_width();
view_hport[0] = window_get_height();
view_xport[0] = 0;
view_yport[0] = 0;

// GUI sempre no tamanho base
display_set_gui_size(cam_w, cam_h);

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
cam_offset_y = -350;

// ==========================================
// BOSS TENSION SYSTEM
// ==========================================
boss_heartbeat_timer = 0;
boss_heartbeat_pulse = 0;
boss_tension_active = false;

// ==========================================
// BOSS HANDS ZOOM OUT
// ==========================================
boss_hands_active = false;
boss_zoom_out = 1;
boss_zoom_out_target = 1;

// ==========================================
// POST-PROCESS MONOCROMÁTICO GLOBAL
// ==========================================
application_surface_draw_enable(false);

// Guarda tamanho da janela pra detectar mudanças
last_window_w = window_get_width();
last_window_h = window_get_height();
