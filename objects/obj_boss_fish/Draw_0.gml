/// Draw Event — obj_boss_fish

// Proteção contra sprite inválido
if (!sprite_exists(sprite_index)) exit;

draw_sprite_ext(
    sprite_index, image_index,
    x, y,
    image_xscale, image_yscale,
    0,
    c_white,
    1
);
