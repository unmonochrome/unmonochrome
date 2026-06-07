/// Draw GUI Event — obj_death_screen

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ==========================================
// OVERLAY VERMELHO ESCURO
// ==========================================
if (red_alpha > 0.01)
{
    draw_set_alpha(red_alpha);
    draw_set_color(make_colour_rgb(30, 0, 0)); // vermelho bem escuro, quase preto
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ==========================================
// TÍTULO "VOCÊ MORREU"
// ==========================================
if (title_alpha > 0.01)
{
    draw_set_alpha(title_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var title_y = gh / 2 - 50 + title_y_offset;
    
    // Sombra suave atrás
    draw_set_color(c_black);
    draw_text_transformed(gw / 2 + 4, title_y + 4, "VOCÊ MORREU", title_scale, title_scale, 0);
    
    // Texto principal (branco com leve tinge vermelho)
    draw_set_color(make_colour_rgb(255, 220, 220));
    draw_text_transformed(gw / 2, title_y, "VOCÊ MORREU", title_scale, title_scale, 0);
    
    draw_set_color(c_white);
    draw_set_alpha(1);
}

// ==========================================
// DICA "APERTE Z PARA TENTAR DE NOVO"
// ==========================================
if (hint_alpha > 0.01)
{
    draw_set_alpha(hint_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var hint_y = gh / 2 + 50;
    
    draw_set_color(c_white);
    draw_text_transformed(gw / 2, hint_y, "APERTE Z PARA TENTAR DE NOVO", 0.8, 0.8, 0);
    
    draw_set_alpha(1);
}

// ==========================================
// FADE PRETO FINAL (antes do restart)
// ==========================================
if (black_alpha > 0.01)
{
    draw_set_alpha(black_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// Reset
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
