/// Step Event — obj_camera

if (!instance_exists(target)) exit;
var _player = instance_nearest(x, y, target);

// ZOOM MANUAL
var zoom_speed_manual = 0.02;

if (keyboard_check(vk_add) || keyboard_check(ord("=")) || keyboard_check(ord("+")))
    zoom_manual += zoom_speed_manual;

if (keyboard_check(vk_subtract) || keyboard_check(ord("-")))
    zoom_manual -= zoom_speed_manual;

zoom_manual = clamp(zoom_manual, 0.5, 2);

// SPEED LOOK AHEAD
var look_max = 90;
var speed_ratio = clamp(abs(_player.hspd) / 6, 0, 1);
var target_look_x = sign(_player.hspd) * look_max * speed_ratio;

if (abs(_player.hspd) < 0.1) target_look_x = 0;

look_offset_x = lerp(look_offset_x, target_look_x, 0.08);

// ==========================================
// ZOOM DINÂMICO CINEMATOGRÁFICO (rm_game)
// ==========================================
var run_zoom_min, run_zoom_max;

if (room == rm_game)
{
    run_zoom_min = 1.05;
    run_zoom_max = 0.88;
}
else
{
    run_zoom_min = 1.00;
    run_zoom_max = 0.94;
}

var run_ratio = clamp(abs(_player.hspd) / 6, 0, 1);
var target_run_zoom = lerp(run_zoom_min, run_zoom_max, run_ratio);
zoom_run = lerp(zoom_run, target_run_zoom, 0.05);

// ==========================================
// CAMERA BREATHING
// ==========================================
var breath_zoom = 1.0;
if (room == rm_game)
{
    var breath_speed = 0.5 + run_ratio * 1.0;
    var breath_amp = 0.005 + run_ratio * 0.008;
    breath_zoom = 1 + sin(current_time * 0.001 * breath_speed) * breath_amp;
}

// ==========================================
// TILT (inclinação) AO CORRER - cinematográfico
// ==========================================
var target_tilt = 0;
if (room == rm_game)
{
    // Inclina suavemente baseado em pra onde tá correndo
    target_tilt = -sign(_player.hspd) * run_ratio * 1.5; // até 1.5 graus
}
rot_target = lerp(rot_target, target_tilt, 0.05);

// TARGET CAMERA
var target_x = _player.x + look_offset_x;
var target_y = _player.y + cam_offset_y;
x = lerp(x, target_x, smooth);
y = lerp(y, target_y, smooth_y);

// BOSS CAMERA TENSION (mantém)
var boss = instance_find(obj_boss_eye, 0);

if (instance_exists(boss) && boss.state != 99 && boss.state != 3)
{
    boss_tension_active = true;
    
    var breath_t = current_time * 0.001;
    var breath_x = sin(breath_t * 0.7) * 2;
    var breath_y = cos(breath_t * 0.5) * 1.5;
    
    var hp_ratio = boss.hp / boss.max_hp;
    var panic_level = 1 - hp_ratio;
    
    var nervous_x = random_range(-1, 1) * panic_level * 3;
    var nervous_y = random_range(-0.8, 0.8) * panic_level * 2;
    
    boss_heartbeat_timer += 1;
    
    var beat_speed = lerp(90, 25, panic_level);
    
    if (boss_heartbeat_timer >= beat_speed)
    {
        boss_heartbeat_timer = 0;
        boss_heartbeat_pulse = 1;
        
        shake_time = 3;
        shake_strength = 1 + panic_level * 2;
    }
    
    boss_heartbeat_pulse = lerp(boss_heartbeat_pulse, 0, 0.2);
    
    var tension_zoom = sin(breath_t * 1.5) * 0.01 * (1 + panic_level);
    zoom_target += tension_zoom;
    
    x += breath_x + nervous_x + (boss_heartbeat_pulse * 4);
    y += breath_y + nervous_y + (boss_heartbeat_pulse * 3);
}
else
{
    boss_tension_active = false;
    boss_heartbeat_timer = 0;
    boss_heartbeat_pulse = 0;
}

// SHAKE
if (shake_time > 0) shake_time--;
else shake_strength = 0;

var shake_x = 0;
var shake_y = 0;
if (shake_time > 0)
{
    shake_x = random_range(-shake_strength, shake_strength);
    shake_y = random_range(-shake_strength, shake_strength);
}

// BOSS HANDS ZOOM OUT
var boss2 = instance_find(obj_boss_eye, 0);
var hand_count = instance_number(obj_boss_hand_ground) + instance_number(obj_boss_hand_warning_ground);

if (hand_count > 0 && instance_exists(boss2))
{
    boss_hands_active = true;
    var zoom_factor = clamp(1 - (hand_count * 0.035), 0.75, 1);
    boss_zoom_out_target = zoom_factor;
}
else
{
    boss_hands_active = false;
    boss_zoom_out_target = 1;
}

boss_zoom_out = lerp(boss_zoom_out, boss_zoom_out_target, 0.08);

// ZOOM E ROTAÇÃO
var shake_zoom = 1;
var shake_rot = 0;

if (shake_time > 0)
{
    shake_zoom = 1.03;
    shake_rot = random_range(-1.2, 1.2);
}

rot_target += shake_rot;

var final_zoom_target = zoom_manual * zoom_run * breath_zoom * shake_zoom * boss_zoom_out;

zoom_current = lerp(zoom_current, final_zoom_target, zoom_speed);
rot_current = lerp(rot_current, rot_target, rot_speed);

// VIEW SIZE FINAL
var view_w = cam_w / zoom_current;
var view_h = cam_h / zoom_current;
var cam_x = x - view_w / 2 + shake_x;
var cam_y = y - view_h / 2 + shake_y;

cam_x = clamp(cam_x, 0, room_width - view_w);
cam_y = clamp(cam_y, 0, room_height - view_h);

cam_x = floor(cam_x);
cam_y = floor(cam_y);

camera_set_view_pos(cam, cam_x, cam_y);
camera_set_view_size(cam, view_w, view_h);
camera_set_view_angle(cam, rot_current);

// Expõe pra outros objetos
player_speed_ratio = run_ratio;
