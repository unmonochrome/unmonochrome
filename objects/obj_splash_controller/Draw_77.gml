/// Post-Draw Event — obj_splash_controller

var ww = window_get_width();
var wh = window_get_height();

var target_aspect = cam_w / cam_h;
var screen_aspect = ww / wh;

var dw, dh, dx, dy;

if (screen_aspect > target_aspect)
{
    dh = wh;
    dw = dh * target_aspect;
    dx = (ww - dw) * 0.5;
    dy = 0;
}
else
{
    dw = ww;
    dh = dw / target_aspect;
    dx = 0;
    dy = (wh - dh) * 0.5;
}

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

draw_surface_stretched(application_surface, dx, dy, dw, dh);
