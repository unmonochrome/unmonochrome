/// Create Event — obj_camera_boss_fixed

// Tamanho da câmera (16:9)
cam_w = 1600;
cam_h = 900;

// Define GUI também
display_set_gui_size(cam_w, cam_h);

// Cria camera
cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_enabled = true;
view_visible[0] = true;
view_set_camera(0, cam);

// Posição FIXA (não se move)
x = 0;
y = 0;

// Shake
shake_time = 0;
shake_strength = 0;