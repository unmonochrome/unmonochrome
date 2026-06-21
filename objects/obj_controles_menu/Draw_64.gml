/// Draw GUI Event — obj_controles_menu

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// RESETA estado de desenho antes de tudo
draw_set_alpha(1);
draw_set_color(c_white);

// FUNDO PRETO 100% OPACO
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(gw / 2, 100, "CONTROLES", 2, 2, 0);

draw_set_alpha(0.5);
draw_rectangle(gw/2 - 200, 145, gw/2 + 200, 147, false);
draw_set_alpha(1);

var start_y = 220;
var spacing = 60;

var name_x  = gw/2 - 80;
var value_x = gw/2 + 80;

var n_ctrls = array_length(controles);

for (var i = 0; i < n_ctrls; i++)
{
    var ctrl = controles[i];
    var oy = start_y + i * spacing;
    var is_selected = (i == selected_index);
    var is_binding = (binding_index == i);
    
    var opt_alpha = is_selected ? 1.0 : 0.45;
    var opt_scale = is_selected ? (1.1 + abs(sin(hover_pulse)) * 0.04) : 1.0;
    
    draw_set_alpha(opt_alpha);
    draw_set_color(c_white);
    
    draw_set_halign(fa_right);
    draw_set_valign(fa_middle);
    draw_text_transformed(name_x, oy, ctrl.name, opt_scale, opt_scale, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    
    var val = key_to_string(variable_global_get(ctrl.control_key));
    
    if (is_binding)
    {
        val = "...";
        draw_set_color(make_colour_rgb(255, 220, 100));
    }
    
    draw_text_transformed(value_x, oy, val, opt_scale, opt_scale, 0);
    draw_set_color(c_white);
}

for (var j = 0; j < array_length(acoes); j++)
{
    var acao = acoes[j];
    var oy = start_y + (n_ctrls + j) * spacing;
    var is_selected = ((n_ctrls + j) == selected_index);
    
    var opt_alpha = is_selected ? 1.0 : 0.45;
    var opt_scale = is_selected ? (1.1 + abs(sin(hover_pulse)) * 0.04) : 1.0;
    
    draw_set_alpha(opt_alpha);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    draw_text_transformed(gw/2, oy, acao.name, opt_scale, opt_scale, 0);
}

if (binding_index >= 0)
{
    draw_set_alpha(0.88);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var pulse_a = 0.7 + abs(sin(hover_pulse * 2)) * 0.3;
    draw_set_alpha(pulse_a);
    draw_text_transformed(gw/2, gh/2 - 60, "PRESSIONE UMA TECLA", 1.6, 1.6, 0);
    
    var time_left = ceil((binding_timeout - binding_timer) / 60);
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_set_alpha(1);
    draw_text_transformed(gw/2, gh/2 + 10, string(time_left) + "s", 2.5, 2.5, 0);
    
    var bar_w = 300;
    var bar_h = 8;
    var bar_x = gw/2 - bar_w/2;
    var bar_y = gh/2 + 80;
    var fill = 1 - (binding_timer / binding_timeout);
    
    draw_set_color(c_white);
    draw_set_alpha(0.3);
    draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);
    draw_set_alpha(1);
    draw_set_color(make_colour_rgb(255, 200, 100));
    draw_rectangle(bar_x, bar_y, bar_x + bar_w * fill, bar_y + bar_h, false);
    
    draw_set_color(c_white);
    draw_set_alpha(0.6);
    draw_text_transformed(gw/2, gh/2 + 130, "ESC para cancelar", 0.8, 0.8, 0);
}

draw_set_alpha(0.5);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

var hint = (binding_index >= 0)
    ? "AGUARDANDO TECLA..."
    : "SETAS/MOUSE  NAVEGAR     ENTER/CLIQUE  CONFIRMAR     ESC  VOLTAR";

draw_text_transformed(gw / 2, gh - 30, hint, 0.7, 0.7, 0);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
