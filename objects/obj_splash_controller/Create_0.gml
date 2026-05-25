/// Create Event — obj_splash_controller

#region Setup
// Logo única
logo_sprite = spr_trio; // seu sprite 2048x2048

// Timing
fade_in_speed = 0.02;
fade_out_speed = 0.02;
hold_time = 300;        // 2.5 segundos
hold_timer = 0;

// Estados: 0 = fade in, 1 = hold, 2 = fade out
state = 0;

alpha = 0;

// Escala ajustada (maior agora)
logo_scale = 550 / 2048; // ~27% do tamanho original (550px na tela)

// Permite pular
can_skip = true;

// Fade in do texto
text_alpha = 0;
text_fade_delay = 60; // começa a aparecer após 1 segundo
#endregion

#region Camera Setup
cam_w = 1600;
cam_h = 900;

display_set_gui_size(cam_w, cam_h);

cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_enabled = true;
view_visible[0] = true;
view_set_camera(0, cam);
#endregion