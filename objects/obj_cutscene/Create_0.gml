/// Create Event — obj_cutscene

depth = -9990;

// PARA TODOS OS SONS (incluindo música do menu)
audio_stop_all();

// CONFIG por room
if (room == rm_cutscene_game)
{
    video_file = "cutscene_game.mp4";
    next_room  = rm_game;
}
else if (room == rm_cutscene_boss_olho)
{
    video_file = "cutscene_boss_olho.mp4";
    next_room  = rm_boss_olho;
}
else
{
    video_file = "";
    next_room  = rm_menu;
}

// ESTADO (sem fade)
// 0 = abrindo video, 1 = tocando, 2 = encerrando
state = 0;
state_timer = 0;

input_lock = 10;

video_started = false;
video_format = -1;

// CAMERA + LETTERBOX
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

application_surface_draw_enable(false);

video_set_volume(1);