/// Post-Draw Event — obj_camera
/// Desenha a tela inteira com letterbox 16:9
/// (Shader monocromático fica nos objetos individuais — olho, mãos, etc)

var ww = window_get_width();
var wh = window_get_height();

// Calcula área 16:9 centralizada (letterbox automático)
var target_aspect = cam_w / cam_h;
var screen_aspect = ww / wh;

var dw, dh, dx, dy;

if (screen_aspect > target_aspect)
{
    // Tela mais larga (ultrawide) → letterbox lateral
    dh = wh;
    dw = dh * target_aspect;
    dx = (ww - dw) * 0.5;
    dy = 0;
}
else
{
    // Tela mais alta → letterbox em cima/baixo
    dw = ww;
    dh = dw / target_aspect;
    dx = 0;
    dy = (wh - dh) * 0.5;
}

// ==========================================
// BARRAS PRETAS DE LETTERBOX
// ==========================================
draw_set_color(c_black);

if (dx > 0)
{
    draw_rectangle(0, 0, dx, wh, false);
    draw_rectangle(dx + dw, 0, ww, wh, false);
}

if (dy > 0)
{
    draw_rectangle(0, 0, ww, dy, false);
    draw_rectangle(0, dy + dh, ww, wh, false);
}

draw_set_color(c_white);

// ==========================================
// DESENHA O JOGO (SEM shader — cores naturais)
// ==========================================
draw_surface_stretched(application_surface, dx, dy, dw, dh);
