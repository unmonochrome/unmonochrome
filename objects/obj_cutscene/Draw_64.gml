/// Draw GUI Event — obj_cutscene
/// Hint de pular discreto no canto

if (state != 1 || state_timer < 60) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

draw_set_alpha(0.6);
draw_set_color(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

draw_text_transformed(gw - 30, gh - 30, "PULAR  >  ESC", 0.8, 0.8, 0);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
