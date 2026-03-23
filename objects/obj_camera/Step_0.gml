#region GET PLAYER
if (!instance_exists(target)) exit;

var _player = instance_nearest(x, y, target);
#endregion


#region SPEED LOOK AHEAD
var look_max = 90;
var speed_ratio = clamp(abs(_player.hspd) / 6, 0, 1);

var target_look_x = sign(_player.hspd) * look_max * speed_ratio;

if (abs(_player.hspd) < 0.1) {
    target_look_x = 0;
}

look_offset_x = lerp(look_offset_x, target_look_x, 0.08);
#endregion


#region SPEED ZOOM
var run_zoom_min = 1.00;
var run_zoom_max = 0.94;

var run_ratio = clamp(abs(_player.hspd) / 6, 0, 1);
var target_run_zoom = lerp(run_zoom_min, run_zoom_max, run_ratio);

zoom_run = lerp(zoom_run, target_run_zoom, 0.05);
#endregion


#region TARGET POSITION
var target_x = _player.x + look_offset_x;
var target_y = _player.y + cam_offset_y;
#endregion


#region CAMERA SMOOTH
x = lerp(x, target_x, smooth);
y = lerp(y, target_y, smooth_y);
#endregion


#region SHAKE TIMER
if (shake_time > 0) {
    shake_time--;
} else {
    shake_strength = 0;
}
#endregion


#region SHAKE OFFSET
var shake_x = 0;
var shake_y = 0;

if (shake_time > 0) {
    shake_x = random_range(-shake_strength, shake_strength);
    shake_y = random_range(-shake_strength, shake_strength);
}
#endregion


#region ZOOM AND ROT TARGET
if (shake_time > 0) {
    zoom_target = 1.03;
    rot_target = random_range(-1.2, 1.2);
} else {
    zoom_target = 1;
    rot_target = 0;
}
#endregion


#region ZOOM AND ROT SMOOTH
zoom_current = lerp(zoom_current, zoom_target, zoom_speed);
rot_current = lerp(rot_current, rot_target, rot_speed);
#endregion


#region VIEW SIZE (FINAL ZOOM)
var final_zoom = zoom_current * zoom_run;

var view_w = cam_w / final_zoom;
var view_h = cam_h / final_zoom;
#endregion


#region FINAL POSITION
var cam_x = x - view_w / 2 + shake_x;
var cam_y = y - view_h / 2 + shake_y;
#endregion


#region ROOM CLAMP
cam_x = clamp(cam_x, 0, room_width - view_w);
cam_y = clamp(cam_y, 0, room_height - view_h);
#endregion


#region PIXEL PERFECT
cam_x = floor(cam_x);
cam_y = floor(cam_y);
#endregion


#region APPLY CAMERA
camera_set_view_pos(cam, cam_x, cam_y);
camera_set_view_size(cam, view_w, view_h);
camera_set_view_angle(cam, rot_current);
#endregion