/// Draw GUI Event — obj_player
/// Overlay de cegueira (efeito de bolha da sereia)

if (blind_alpha < 0.01) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ==========================================
// OVERLAY BRANCO-AZULADO (cegueira / borrão)
// ==========================================
var pulse = abs(sin(blind_pulse)) * 0.1;
var final_alpha = blind_alpha + pulse * blind_alpha;

draw_set_alpha(min(1, final_alpha));
draw_set_color(make_colour_rgb(220, 235, 255));
draw_rectangle(0, 0, gw, gh, false);

// Camada extra mais opaca no centro (simula "foco perdido")
draw_set_alpha(min(1, final_alpha * 0.4));
draw_set_color(c_white);
draw_rectangle(0, 0, gw, gh, false);

draw_set_alpha(1);
draw_set_color(c_white);
