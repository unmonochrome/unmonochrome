/// Draw GUI Event — obj_hud

if (instance_exists(obj_death_screen)) exit;

var p = instance_find(obj_player, 0);
if (!instance_exists(p)) exit;

var hp_atual = p.hp;

for (var i = 0; i < heart_count; i++)
{
    var hp_min = i * 2;
    var hp_metade = hp_min + 1;
    var hp_cheio = hp_min + 2;
    
    var spr;
    
    if (hp_atual >= hp_cheio)
        spr = vida;
    else if (hp_atual >= hp_metade)
        spr = vidametade;
    else
        spr = vida0;
    
    var draw_x = heart_x + (i * heart_spacing);
    var draw_y = heart_y;
    
    draw_sprite_ext(
        spr, 0,
        draw_x, draw_y,
        heart_scale, heart_scale,
        0,
        c_white,
        1
    );
}
