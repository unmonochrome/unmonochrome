var player = instance_find(obj_player, 0);

if (instance_exists(player)) {
    if (variable_instance_exists(player, "hp") && variable_instance_exists(player, "hp_max")) {

        var start_x = 32;
        var start_y = 32;

        var spacing = 120;
        var scale = 0.12;

        var hearts_total = player.hp_max div 2;

        for (var i = 0; i < hearts_total; i++) {

            var draw_x = start_x + (i * spacing);

            var hp_for_this_heart = player.hp - (i * 2);

            if (hp_for_this_heart >= 2) {
                // cheio
                draw_sprite_ext(spr_heart_full, 0, draw_x, start_y, scale, scale, 0, c_white, 1);
            }
            else if (hp_for_this_heart == 1) {
                // metade
                draw_sprite_ext(spr_heart_empty, 0, draw_x, start_y, scale, scale, 0, c_white, 1);
            }
            else {
                // vazio (não desenha nada)
                // ou desenha transparente se quiser
            }
        }
    }
}

var player = instance_find(obj_player, 0);

if (instance_exists(player)) {

    var w = display_get_gui_width();
    var h = display_get_gui_height();

    // escurece DURANTE a animação de morte
    if (player.death_anim) {
        var death_alpha = 1 - player.death_fade;

        draw_sprite_ext(
            spr_fade_black,
            0,
            0,
            0,
            w / sprite_get_width(spr_fade_black),
            h / sprite_get_height(spr_fade_black),
            0,
            c_white,
            death_alpha * 0.75
        );
    }

    // depois que ele sumir, mantém a tela escura + texto
    if (player.dead) {
        draw_sprite_ext(
            spr_fade_black,
            0,
            0,
            0,
            w / sprite_get_width(spr_fade_black),
            h / sprite_get_height(spr_fade_black),
            0,
            c_white,
            0.75
        );

        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_text(w/2, h/2 - 10, "voce morreu");
        draw_text(w/2, h/2 + 24, "pressione Z para renascer");
    }
}




#region ROOM TRANSITION FADE

var player = instance_find(obj_player, 0);

if (instance_exists(player)) {
    if (player.transitioning) {
        var gui_w = display_get_gui_width();
        var gui_h = display_get_gui_height();

        draw_sprite_ext(
            spr_fade_black,
            0,
            0,
            0,
            gui_w / sprite_get_width(spr_fade_black),
            gui_h / sprite_get_height(spr_fade_black),
            0,
            c_white,
            player.transition_alpha
        );
    }
}

#endregion

draw_set_color(c_white);
draw_text(50, 50, "transition: " + string(player.transition_alpha));