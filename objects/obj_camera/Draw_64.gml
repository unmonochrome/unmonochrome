/// Draw GUI Event — obj_camera

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ==========================================
// VINHETA (normal, sem intensificar)
// ==========================================
if (room == rm_game || room == rm_boss_olho)
{
    draw_sprite_stretched(spr_camera, 0, 0, 0, gw, gh);
}

// ==========================================
// LETTERBOX CINEMATOGRÁFICO (barras filme em rm_game)
// ==========================================
if (room == rm_game)
{
    // Inicializa
    if (!variable_instance_exists(id, "letterbox_h"))
    {
        letterbox_h = 0;
        letterbox_target = 0;
    }
    
    // Sempre tem barras pequenas, mas crescem quando corre rápido
    var speed_boost = (variable_instance_exists(id, "player_speed_ratio")) ? player_speed_ratio : 0;
    letterbox_target = 40 + speed_boost * 30; // 40px parado, até 70px correndo
    
    letterbox_h = lerp(letterbox_h, letterbox_target, 0.08);
    
    // Desenha as barras
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, letterbox_h, false);
    draw_rectangle(0, gh - letterbox_h, gw, gh, false);
}

// ==========================================
// MENSAGEM "PERSIGA O OLHO!" (elegante, sem pulso)
// ==========================================
if (room == rm_game)
{
    if (!variable_instance_exists(id, "msg_alpha"))
    {
        msg_alpha = 0;
        msg_timer = 0;
        msg_state = 0;
        msg_slide_y = 30; // começa um pouco abaixo, sobe ao aparecer
    }
    
    msg_timer++;
    
    switch (msg_state)
    {
        case 0:
            if (msg_timer >= 60)
            {
                msg_state = 1;
                msg_timer = 0;
            }
        break;
        
        case 1:
            msg_alpha = lerp(msg_alpha, 1, 0.04);
            msg_slide_y = lerp(msg_slide_y, 0, 0.08); // desliza pra cima suave
            
            if (msg_timer >= 300)
            {
                msg_state = 2;
                msg_timer = 0;
            }
        break;
        
        case 2:
            msg_alpha = lerp(msg_alpha, 0, 0.03);
            msg_slide_y = lerp(msg_slide_y, 10, 0.05); // desliza levemente pra baixo ao sair
        break;
    }
    
    if (msg_alpha > 0.01)
    {
        var text = "PERSIGA O OLHO";
        var ty = gh - 110 + msg_slide_y;
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        // Linhas decorativas finas dos lados (estilo título de filme)
        var line_alpha = msg_alpha * 0.4;
        var line_w = 80;
        var line_y = ty;
        
        // medir a largura do texto pra posicionar as linhas
        var text_w = string_width(text) * 1.0;
        
        draw_set_alpha(line_alpha);
        draw_set_color(c_white);
        draw_rectangle(gw/2 - text_w/2 - line_w - 20, line_y - 1, gw/2 - text_w/2 - 20, line_y + 1, false);
        draw_rectangle(gw/2 + text_w/2 + 20, line_y - 1, gw/2 + text_w/2 + line_w + 20, line_y + 1, false);
        
        // Sombra suave
        draw_set_alpha(msg_alpha * 0.6);
        draw_set_color(c_black);
        draw_text_transformed(gw/2 + 2, ty + 2, text, 1.0, 1.0, 0);
        
        // Texto principal (limpo, sem pulso)
        draw_set_alpha(msg_alpha);
        draw_set_color(c_white);
        draw_text_transformed(gw/2, ty, text, 1.0, 1.0, 0);
        
        draw_set_alpha(1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

// ==========================================
// BOSS TENSION VIGNETTE (mantém)
// ==========================================
var boss = instance_find(obj_boss_eye, 0);

if (instance_exists(boss) && boss.state != 99 && boss.state != 3)
{
    var hp_ratio = boss.hp / boss.max_hp;
    var danger_level = 1 - hp_ratio;
    var blur_alpha = clamp(danger_level * 0.4, 0, 0.6);
    
    if (blur_alpha > 0.01)
    {
        var blur_color = make_colour_rgb(20, 5, 5);
        var blur_size = lerp(60, 180, danger_level);
        
        for (var i = 0; i < blur_size; i += 10)
        {
            var layer_alpha = blur_alpha * (1 - (i / blur_size));
            draw_set_alpha(layer_alpha);
            draw_set_color(blur_color);
            
            draw_rectangle(0, i, gw, i + 10, false);
            draw_rectangle(0, gh - i - 10, gw, gh - i, false);
            draw_rectangle(i, 0, i + 10, gh, false);
            draw_rectangle(gw - i - 10, 0, gw - i, gh, false);
        }
        
        if (boss_heartbeat_pulse > 0.5)
        {
            draw_set_alpha(boss_heartbeat_pulse * 0.08);
            draw_set_color(make_colour_rgb(80, 10, 10));
            draw_rectangle(0, 0, gw, gh, false);
        }
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
