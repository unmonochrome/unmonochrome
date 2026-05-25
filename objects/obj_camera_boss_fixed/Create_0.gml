/// Create Event — obj_camera_boss_fixed

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

x = 0;
y = 0;

shake_time = 0;
shake_strength = 0;

last_window_w = window_get_width();
last_window_h = window_get_height();

// POST-PROCESS pra desenhar com letterbox 16:9
application_surface_draw_enable(false);
