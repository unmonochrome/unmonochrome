/// Draw Event — obj_player

#region DRAW

if (dead) exit;

if (death_anim)
{
    draw_sprite_ext(
        sprite_index, image_index,
        x, y,
        image_xscale, image_yscale,
        death_rot, c_white, death_fade
    );
}
else
{
    // piscar quando tomou dano
    if (hurt_timer > 0)
    {
        if ((hurt_timer div 2) mod 2 == 0) draw_self();
    }
    else
    {
        draw_self();
    }
}

// fade de transição de room
if (transitioning && transition_alpha > 0)
{
    draw_set_alpha(transition_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

#endregion
