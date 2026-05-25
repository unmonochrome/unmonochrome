/// Draw GUI Event — obj_camera

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ==========================================
#region VIGNETTE SPRITE (só em rm_game e rm_boss_olho)
// ==========================================
if (room == rm_game || room == rm_boss_olho)
{
    draw_sprite_stretched(
        spr_camera, 0,
        0, 0,
        gw, gh
    );
}
#endregion

// ==========================================
#region BOSS TENSION BLUR VIGNETTE (extra durante boss do olho)
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
        
        // TOPO
        for (var i = 0; i < blur_size; i += 10)
        {
            var layer_alpha = blur_alpha * (1 - (i / blur_size));
            
            draw_set_alpha(layer_alpha);
            draw_set_color(blur_color);
            draw_rectangle(0, i, gw, i + 10, false);
        }
        
        // BAIXO
        for (var i = 0; i < blur_size; i += 10)
        {
            var layer_alpha = blur_alpha * (1 - (i / blur_size));
            
            draw_set_alpha(layer_alpha);
            draw_set_color(blur_color);
            draw_rectangle(0, gh - i - 10, gw, gh - i, false);
        }
        
        // ESQUERDA
        for (var i = 0; i < blur_size; i += 10)
        {
            var layer_alpha = blur_alpha * (1 - (i / blur_size));
            
            draw_set_alpha(layer_alpha);
            draw_set_color(blur_color);
            draw_rectangle(i, 0, i + 10, gh, false);
        }
        
        // DIREITA
        for (var i = 0; i < blur_size; i += 10)
        {
            var layer_alpha = blur_alpha * (1 - (i / blur_size));
            
            draw_set_alpha(layer_alpha);
            draw_set_color(blur_color);
            draw_rectangle(gw - i - 10, 0, gw - i, gh, false);
        }
        
        // PULSO DE BATIDA (flash sutil)
        if (boss_heartbeat_pulse > 0.5)
        {
            draw_set_alpha(boss_heartbeat_pulse * 0.08);
            draw_set_color(make_colour_rgb(80, 10, 10));
            draw_rectangle(0, 0, gw, gh, false);
        }
        
        // Reset
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
#endregion
