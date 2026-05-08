/// Create Event — obj_cameramenu

// Tamanho da câmera (16:9) — mesma resolução do jogo
cam_w = 1600;
cam_h = 900;

// Define GUI também
display_set_gui_size(cam_w, cam_h);

cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);

view_enabled = true;
view_visible[0] = true;
view_set_camera(0, cam);

// base da câmera (centro da room normalmente)
base_x = 0;
base_y = 0;

// shake atual
shake_x = 0;
shake_y = 0;
shake_r = 0;

// força (bem suave pro menu)
shake_power = 1.2;
shake_rot_power = 0.08;

wave = 0;