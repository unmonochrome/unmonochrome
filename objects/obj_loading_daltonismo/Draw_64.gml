/// Draw GUI Event — obj_loading_daltonismo

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Fundo preto
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// Fato sobre Daltonismo
draw_set_alpha(fact_alpha);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var fact_x = gw / 2;
var fact_y = gh / 2;
var fact_width = 900;

draw_text_ext(fact_x, fact_y, current_fact, 30, fact_width);

draw_set_alpha(1);

// ==========================================
// BARRA MINIMALISTA (Inferior Esquerdo)
// ==========================================
var bar_w = 300;
var bar_h = 4;
var bar_x = 60;
var bar_y = gh - 60;

// Fundo sutil
draw_set_alpha(0.3);
draw_set_color(c_dkgray);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
draw_set_alpha(1);

// Preenchimento
var fill_w = (bar_w * visual_progress) / 100;
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + fill_w, bar_y + bar_h, false);

// Texto "carregando..."
draw_set_alpha(0.6);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text(bar_x, bar_y + 12, "carregando" + dots);

// Reset
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);