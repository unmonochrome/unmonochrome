/// Draw GUI Event — obj_pause_menu

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// FUNDO ESCURO
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

var opts = get_options();
var total = array_length(opts);

// TÍTULO (muda baseado na tela)
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var title_y = gh / 2 - (total * 70) / 2 - 100;
var title_text = (screen == 0) ? "PAUSADO" : "OPÇÕES";

draw_set_alpha(alpha / 0.95);
draw_text_transformed(gw / 2, title_y, title_text, 2.5, 2.5, 0);

draw_set_alpha(0.5 * (alpha / 0.95));
draw_rectangle(gw/2 - 120, title_y + 50, gw/2 + 120, title_y + 52, false);
draw_set_alpha(1);

// OPÇÕES
var start_y = gh / 2 - (total * 70) / 2 + 50;
var spacing = 70;

for (var i = 0; i < total; i++)
{
    var opt = opts[i];
    var oy = start_y + i * spacing;
    var is_selected = (i == selected_index);
    
    var opt_alpha = (is_selected ? 1.0 : 0.45) * (alpha / 0.95);
    var opt_scale = is_selected ? (1.15 + abs(sin(hover_pulse)) * 0.05) : 1.0;
    
    draw_set_alpha(opt_alpha);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Setas pulsantes se aceita left/right
    var aceita_lr = (screen == 1) && variable_struct_exists(opt, "type") 
                    && (opt.type == "toggle" || opt.type == "slider");
    
    if (is_selected && aceita_lr)
    {
        var arrow_offset = abs(sin(hover_pulse * 1.5)) * 6;
        draw_text_transformed(gw/2 - 250 - arrow_offset, oy, "<", 1.5, 1.5, 0);
        draw_text_transformed(gw/2 + 250 + arrow_offset, oy, ">", 1.5, 1.5, 0);
    }
    
    // Texto
    if (screen == 1 && opt.type == "toggle")
    {
        var val = global.fullscreen ? "LIGADO" : "DESLIGADO";
        draw_text_transformed(gw/2, oy, opt.name + ": " + val, opt_scale, opt_scale, 0);
    }
    else if (screen == 1 && opt.type == "slider")
    {
        var pct = round(global.volume_master * 100);
        draw_text_transformed(gw/2, oy, opt.name + ": " + string(pct) + "%", opt_scale, opt_scale, 0);
        
        // Mini barra
        var slider_w = 200;
        var slider_h = 4;
        var slider_x = gw/2 - slider_w/2;
        var slider_y = oy + 22;
        
        draw_set_alpha(opt_alpha * 0.3);
        draw_set_color(c_white);
        draw_rectangle(slider_x, slider_y, slider_x + slider_w, slider_y + slider_h, false);
        
        draw_set_alpha(opt_alpha);
        draw_rectangle(slider_x, slider_y, slider_x + slider_w * global.volume_master, slider_y + slider_h, false);
    }
    else
    {
        draw_text_transformed(gw/2, oy, opt.name, opt_scale, opt_scale, 0);
    }
}

// Dica
draw_set_alpha(0.5 * (alpha / 0.95));
draw_set_color(c_white);
draw_set_valign(fa_bottom);
draw_set_halign(fa_center);

var hint = (screen == 0) ? "ESC PARA CONTINUAR" : "ESC PARA VOLTAR";
draw_text_transformed(gw / 2, gh - 30, hint, 0.8, 0.8, 0);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
