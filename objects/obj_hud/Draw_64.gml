/// Draw GUI Event — obj_hud

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
#region MORTE DO PLAYER
// ==========================================
var w = display_get_gui_width();
var h = display_get_gui_height();

if (player.death_anim)
{
    var death_alpha = (1 - player.death_fade) * 0.75;

    draw_set_alpha(death_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, w, h, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

if (player.dead)
{
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(0, 0, w, h, false);
    draw_set_alpha(1);

    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(w / 2, h / 2 - 10, "voce morreu");
    draw_text(w / 2, h / 2 + 24, "pressione Z para renascer");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
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