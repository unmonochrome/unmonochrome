/// Clean Up Event — obj_cutscene

if (video_started)
{
    video_close();
    video_started = false;
}

application_surface_draw_enable(true);
