/// Draw GUI Event — obj_splash_controller

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Fundo preto
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// Desenha logo centralizada
if (sprite_exists(logo_sprite))
{
    var draw_x = gw / 2;
    var draw_y = gh / 2;
    
    draw_sprite_ext(
        logo_sprite, 0,
        draw_x, draw_y,
        logo_scale, logo_scale,
        0, c_white, alpha
    );
}

