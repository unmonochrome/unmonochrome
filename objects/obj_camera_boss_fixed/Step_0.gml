/// Step Event — obj_camera_boss_fixed

#region SHAKE
if (shake_time > 0)
{
    shake_time--;
}
else
{
    shake_strength = 0;
}

var shake_x = 0;
var shake_y = 0;

if (shake_time > 0)
{
    shake_x = random_range(-shake_strength, shake_strength);
    shake_y = random_range(-shake_strength, shake_strength);
}
#endregion

#region APLICAR CAMERA (FIXA + SHAKE)
var cam_x = x + shake_x;
var cam_y = y + shake_y;

// Câmera SEMPRE em (0, 0), só shake move
cam_x = clamp(cam_x, 0, 0);
cam_y = clamp(cam_y, 0, 0);

camera_set_view_pos(cam, cam_x, cam_y);
camera_set_view_size(cam, cam_w, cam_h);
camera_set_view_angle(cam, 0); // sem rotação
#endregion