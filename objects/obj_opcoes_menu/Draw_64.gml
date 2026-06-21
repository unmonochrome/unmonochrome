/// Draw GUI Event — obj_opcoes_menu

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Reset estado de desenho
draw_set_alpha(1);
draw_set_color(c_white);

// FUNDO PRETO SÓLIDO
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// Título
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(gw / 2, 100, "OPÇÕES", 2, 2, 0);

draw_set_alpha(0.5);
draw_rectangle(gw/2 - 150, 145, gw/2 + 150, 147, false);
draw_set_alpha(1);

var start_y = 240;
var spacing = 75;

var name_x  = gw/2 - 80;
var value_x = gw/2 + 80;
var arrow_dist = 500;

for (var i = 0; i < total_options; i++)
{
    var opt = options[i];
    var oy = start_y + i * spacing;
    var is_selected = (i == selected_index);
    
    var opt_alpha = is_selected ? 1.0 : 0.45;
    var opt_scale = is_selected ? (1.1 + abs(sin(hover_pulse)) * 0.04) : 1.0;
    
    draw_set_alpha(opt_alpha);
    draw_set_color(c_white);
    
    if (opt.name == "VOLTAR")
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(gw/2, oy, opt.name, opt_scale, opt_scale, 0);
    }
    else
    {
        if (is_selected && variable_struct_exists(opt, "action_left"))
        {
            var arrow_offset = abs(sin(hover_pulse * 1.5)) * 6;
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            
            draw_text_transformed(gw/2 - arrow_dist - arrow_offset, oy, "<", 1.5, 1.5, 0);
            draw_text_transformed(gw/2 + arrow_dist + arrow_offset, oy, ">", 1.5, 1.5, 0);
        }
        
        draw_set_halign(fa_right);
        draw_set_valign(fa_middle);
        draw_text_transformed(name_x, oy, opt.name, opt_scale, opt_scale, 0);
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        
        var val = opt.get_value();
        draw_text_transformed(value_x, oy, val, opt_scale, opt_scale, 0);
        
        if (opt.type == "slider")
        {
            var slider_w = 180;
            var slider_h = 4;
            var slider_x = gw/2 - slider_w/2;
            var slider_y = oy + 28;
            
            var fill = 0;
            if (opt.name == "VOLUME GERAL")   fill = global.volume_master;
            if (opt.name == "VOLUME MÚSICA")  fill = global.volume_music;
            if (opt.name == "VOLUME EFEITOS") fill = global.volume_sfx;
            
            draw_set_alpha(opt_alpha * 0.3);
            draw_set_color(c_white);
            draw_rectangle(slider_x, slider_y, slider_x + slider_w, slider_y + slider_h, false);
            
            draw_set_alpha(opt_alpha);
            draw_rectangle(slider_x, slider_y, slider_x + slider_w * fill, slider_y + slider_h, false);
        }
    }
}

draw_set_alpha(0.5);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

var hint = "SETAS/MOUSE  NAVEGAR     ENTER/CLIQUE  CONFIRMAR     ESC  VOLTAR";
draw_text_transformed(gw / 2, gh - 30, hint, 0.7, 0.7, 0);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
