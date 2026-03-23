#region DRAW

if (dead) {
    exit;
}

if (death_anim) {

    draw_sprite_ext(
        sprite_index,
        image_index,
        x,
        y,
        image_xscale,
        image_yscale,
        death_rot,
        c_white,
        death_fade
    );

} else {

    if (hurt_timer > 0) {
        if ((hurt_timer div 2) mod 2 == 0) {
            draw_self();
        }
    } else {
        draw_self();
    }

}

#endregion