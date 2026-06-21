/// Draw GUI Event — obj_tutorial_sereia

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Fundo preto (mais escuro ainda que o normal pra dar foco no tutorial)
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// ==========================================
// DESENHA SPRITE DO TUTORIAL ATUAL (centralizado)
// ==========================================
if (current < total_tutorials && alpha > 0.01)
{
    var spr = tutorial_sprites[current];
    
    draw_sprite_ext(
        spr, 0,
        gw / 2, gh / 2,
        tutorial_scale, tutorial_scale,
        0,
        c_white,
        alpha
    );
}


