/// update_viewport()
/// Recalcula viewport pra manter aspect ratio 16:9 com letterbox automático
/// Pode ser chamado de QUALQUER lugar (não depende de instância)

function update_viewport()
{
    // Tamanho base do jogo (resolução de design)
    var base_w = 1600;
    var base_h = 900;
    
    // Pega tamanho da janela atual
    var display_w = window_get_width();
    var display_h = window_get_height();

    // Web fallback
    if (os_browser != browser_not_a_browser)
    {
        display_w = browser_width;
        display_h = browser_height;
    }
    
    // Evita divisão por zero
    if (display_w <= 0) display_w = base_w;
    if (display_h <= 0) display_h = base_h;

    var target_aspect = base_w / base_h;
    var screen_aspect = display_w / display_h;

    var port_w, port_h;

    if (screen_aspect > target_aspect)
    {
        // Tela MAIS LARGA que o jogo → letterbox lateral (barras nas laterais)
        port_h = display_h;
        port_w = port_h * target_aspect;
    }
    else
    {
        // Tela MAIS ALTA que o jogo → letterbox vertical (barras em cima/baixo)
        port_w = display_w;
        port_h = port_w / target_aspect;
    }

    var port_x = (display_w - port_w) * 0.5;
    var port_y = (display_h - port_h) * 0.5;

    // Aplica no view 0
    view_enabled = true;
    view_visible[0] = true;

    view_wview[0] = base_w;
    view_hview[0] = base_h;

    view_wport[0] = port_w;
    view_hport[0] = port_h;

    view_xport[0] = port_x;
    view_yport[0] = port_y;

    // Atualiza GUI size pra ficar consistente
    display_set_gui_size(base_w, base_h);
}
