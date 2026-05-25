/// Post-Draw Event — obj_camera
/// Esse evento roda DEPOIS de toda a cena ser desenhada,
/// mas ANTES da GUI. Perfeito pra aplicar um shader na tela inteira.

// ==========================================
// CALCULAR POSIÇÃO DA APPLICATION SURFACE
// (respeitando aspect ratio / letterbox)
// ==========================================
var ww = window_get_width();
var wh = window_get_height();

var base_aspect = cam_w / cam_h;
var screen_aspect = ww / wh;

var draw_w, draw_h, draw_x, draw_y;

if (screen_aspect > base_aspect)
{
    // tela mais larga que o jogo → letterbox lateral
    draw_h = wh;
    draw_w = draw_h * base_aspect;
    draw_x = (ww - draw_w) / 2;
    draw_y = 0;
}
else
{
    // tela mais alta que o jogo → letterbox em cima/baixo
    draw_w = ww;
    draw_h = draw_w / base_aspect;
    draw_x = 0;
    draw_y = (wh - draw_h) / 2;
}

// ==========================================
// APLICA SHADER SE FOR ROOM MONOCROMÁTICA
// ==========================================
if (room == rm_game || room == rm_boss_olho)
{
    shader_set(shd_saturation);
    
    shader_set_uniform_f(
        shader_get_uniform(shd_saturation, "saturation"),
        0.0
    );
    
    draw_surface_stretched(application_surface, draw_x, draw_y, draw_w, draw_h);
    
    shader_reset();
}
else
{
    // Outras rooms: desenha normal (sem shader)
    draw_surface_stretched(application_surface, draw_x, draw_y, draw_w, draw_h);
}
