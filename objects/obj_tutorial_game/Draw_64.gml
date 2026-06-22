/// Draw GUI Event — obj_tutorial_game
/// Desenha TUDO aqui — fundo preto + sprite + hint + dots.
/// Draw GUI roda DEPOIS do Post-Draw, então sempre fica em cima.

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ============================================
// FUNDO PRETO (cobre cutscene/qualquer coisa atrás)
// ============================================
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// ============================================
// SPRITE DO TUTORIAL (centralizado, cobre a tela)
// ============================================
if (current < total_tutorials && alpha > 0.01)
{
    var spr = tutorial_sprites[current];
    var spr_w = sprite_get_width(spr);
    var spr_h = sprite_get_height(spr);
    
    var scl = min(gw / spr_w, gh / spr_h);
    
    draw_sprite_ext(
        spr, 0,
        gw / 2, gh / 2,
        scl, scl,
        0,
        c_white,
        alpha
    );
}

// ============================================
// DICA NO RODAPÉ
// ============================================
if (state == 1 && state_timer >= 30)
{
    var pulse_a = 0.6 + abs(sin(state_timer * 0.05)) * 0.4;
    
    draw_set_alpha(pulse_a * alpha);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    
    var hint = "APERTE Z / ESPACO PARA CONTINUAR";
    if (current == total_tutorials - 1)
        hint = "APERTE Z / ESPACO PARA COMECAR";
    
    draw_text_transformed(gw / 2, gh - 40, hint, 0.9, 0.9, 0);
}


draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
