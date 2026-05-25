/// Step Event — obj_viewport_manager

// Checa se janela foi redimensionada
if (window_get_width() != base_w || window_get_height() != base_h)
{
    update_viewport();
}