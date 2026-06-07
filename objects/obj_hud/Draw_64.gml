/// Draw GUI Event — obj_hud

/// Draw GUI Event — obj_hud (adiciona NO TOPO)

// Não desenha HUD se a tela de morte estiver ativa
if (instance_exists(obj_death_screen)) exit;

if (instance_exists(obj_fade_black)) exit;

// ... resto do código normal aqui


var player = instance_find(obj_player, 0);
if (!instance_exists(player)) exit;

// ==========================================
#region CORAÇÕES
// ==========================================
var start_x = 32;
var start_y = 32;
var spacing = 120;
var scale = 0.12;

var hearts_total = player.hp_max div 2;

for (var i = 0; i < hearts_total; i++)
{
    var draw_x = start_x + (i * spacing);
    var hp_for_this_heart = player.hp - (i * 2);

    if (hp_for_this_heart >= 2)
    {
        // cheio
        draw_sprite_ext(spr_heart_full, 0, draw_x, start_y, scale, scale, 0, c_white, 1);
    }
    else if (hp_for_this_heart == 1)
    {
        // metade
        draw_sprite_ext(spr_heart_empty, 0, draw_x, start_y, scale, scale, 0, c_white, 1);
    }
    else
    {
        // vazio — desenha transparente pra mostrar que existe
        draw_sprite_ext(spr_heart_empty, 0, draw_x, start_y, scale, scale, 0, c_white, 0.3);
    }
}
#endregion


// ==========================================
#region TRANSIÇÃO DE ROOM
// ==========================================
if (player.transitioning && player.transition_alpha > 0)
{
    draw_set_alpha(player.transition_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, w, h, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
#endregion