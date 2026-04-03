/// Draw Event — obj_enemy

if (dying)
{
    // morte: encolhe + some + shake tá no step
    draw_sprite_ext(
        sprite_index, image_index,
        x, y,
        image_xscale * death_scale, image_yscale * death_scale,
        0,
        c_white, death_alpha
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