/// Draw Event — obj_boss_bubble

if (!active) exit;

// UM draw só (sem glow pesado)
draw_sprite_ext(
    sprite_index, image_index,
    x, y,
    image_xscale, image_yscale,
    0, c_white, image_alpha
);