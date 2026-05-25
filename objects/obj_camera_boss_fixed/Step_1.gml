/// Begin Step Event — obj_camera_boss_fixed
/// Detecta mudança de tamanho da janela

var w = window_get_width();
var h = window_get_height();

if (w != last_window_w || h != last_window_h)
{
    last_window_w = w;
    last_window_h = h;
    
    view_wport[0] = w;
    view_hport[0] = h;
    view_xport[0] = 0;
    view_yport[0] = 0;
}
