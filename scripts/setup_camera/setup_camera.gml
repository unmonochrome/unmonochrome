/// setup_camera()

with (obj_cameramenu)
{
    display_set_gui_size(cam_w, cam_h);
    
    cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
    
    view_enabled = true;
    view_visible[0] = true;
    view_set_camera(0, cam);
}