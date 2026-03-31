#region GET PLAYER
if (!instance_exists(target)) exit;
var _player = instance_nearest(x, y, target);
#endregion

#region ZOOM MANUAL COM TECLADO (segurar)
var zoom_speed_manual = 0.02; // quanto o zoom muda por Step

// aumentar zoom
if (keyboard_check(vk_add) || keyboard_check(ord("=")) || keyboard_check(ord("+"))) {
    zoom_manual += zoom_speed_manual;
}

// diminuir zoom
if (keyboard_check(vk_subtract) || keyboard_check(ord("-"))) {
    zoom_manual -= zoom_speed_manual;
}

// limitar zoom
zoom_manual = clamp(zoom_manual, 0.5, 2);
#endregion

#region SPEED LOOK AHEAD
var look_max = 90;
var speed_ratio = clamp(abs(_player.hspd) / 6, 0, 1);
var target_look_x = sign(_player.hspd) * look_max * speed_ratio;

if (abs(_player.hspd) < 0.1) target_look_x = 0;

look_offset_x = lerp(look_offset_x, target_look_x, 0.08);
#endregion

#region SPEED ZOOM DO PLAYER
var run_zoom_min = 1.00;
var run_zoom_max = 0.94;
var run_ratio = clamp(abs(_player.hspd) / 6, 0, 1);
var target_run_zoom = lerp(run_zoom_min, run_zoom_max, run_ratio);
zoom_run = lerp(zoom_run, target_run_zoom, 0.05);
#endregion

#region TARGET CAMERA
var target_x = _player.x + look_offset_x;
var target_y = _player.y + cam_offset_y;
x = lerp(x, target_x, smooth);
y = lerp(y, target_y, smooth_y);
#endregion

#region SHAKE
if (shake_time > 0) {
    shake_time--;
} else {
    shake_strength = 0;
}

var shake_x = 0;
var shake_y = 0;
if (shake_time > 0) {
    shake_x = random_range(-shake_strength, shake_strength);
    shake_y = random_range(-shake_strength, shake_strength);
}
#endregion

#region ZOOM E ROTAÇÃO
var shake_zoom = 1;
var shake_rot = 0;

if (shake_time > 0) {
    shake_zoom = 1.03;
    shake_rot = random_range(-1.2, 1.2);
}

rot_target = shake_rot;

// zoom final = manual * corrida * shake
var final_zoom_target = zoom_manual * zoom_run * shake_zoom;

// suaviza
zoom_current = lerp(zoom_current, final_zoom_target, zoom_speed);
rot_current = lerp(rot_current, rot_target, rot_speed);
#endregion

#region VIEW SIZE FINAL
var view_w = cam_w / zoom_current;
var view_h = cam_h / zoom_current;
var cam_x = x - view_w / 2 + shake_x;
var cam_y = y - view_h / 2 + shake_y;

// limitar dentro da room
cam_x = clamp(cam_x, 0, room_width - view_w);
cam_y = clamp(cam_y, 0, room_height - view_h);

// pixel perfect
cam_x = floor(cam_x);
cam_y = floor(cam_y);
#endregion

#region APLICAR CAMERA
camera_set_view_pos(cam, cam_x, cam_y);
camera_set_view_size(cam, view_w, view_h);
camera_set_view_angle(cam, rot_current);
#endregion