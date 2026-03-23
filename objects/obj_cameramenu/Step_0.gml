#region MENU CAMERA MOTION

wave += 0.02;

// movimento base (seno suave)
var target_x = sin(wave) * 1.2;
var target_y = cos(wave * 0.8) * 0.8;
var target_r = sin(wave * 0.6) * 0.05;

// leve aleatório (tipo s_shake)
target_x += random_range(-0.3, 0.3);
target_y += random_range(-0.3, 0.3);

// suavização
shake_x = lerp(shake_x, target_x, 0.05);
shake_y = lerp(shake_y, target_y, 0.05);
shake_r = lerp(shake_r, target_r, 0.05);

// posição final
var cam_x = base_x + shake_x;
var cam_y = base_y + shake_y;

// aplica
camera_set_view_pos(cam, cam_x, cam_y);
camera_set_view_angle(cam, shake_r);

#endregion