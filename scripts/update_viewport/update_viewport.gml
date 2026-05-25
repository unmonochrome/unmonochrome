/// update_viewport()

function update_viewport()
{
    var display_w = window_get_width();
    var display_h = window_get_height();

    // Browser
    if (os_browser != browser_not_a_browser)
    {
        display_w = browser_width;
        display_h = browser_height;
    }

    var target_aspect = base_w / base_h;
    var screen_aspect = display_w / display_h;

    var port_w;
    var port_h;

    if (screen_aspect > target_aspect)
    {
        port_h = display_h;
        port_w = port_h * target_aspect;
    }
    else
    {
        port_w = display_w;
        port_h = port_w / target_aspect;
    }

    var port_x = (display_w - port_w) * 0.5;
    var port_y = (display_h - port_h) * 0.5;

    // Sistema legacy
    view_enabled = true;
    view_visible[0] = true;

    // Tamanho interno da câmera
    view_wview[0] = base_w;
    view_hview[0] = base_h;

    // Tamanho na tela
    view_wport[0] = port_w;
    view_hport[0] = port_h;

    // Posição na tela
    view_xport[0] = port_x;
    view_yport[0] = port_y;

    display_set_gui_size(base_w, base_h);
}