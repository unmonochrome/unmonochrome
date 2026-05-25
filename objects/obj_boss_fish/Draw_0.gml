/// Draw Event — obj_boss_fish

// Placeholder visual: correto = magenta, errado = ciano
if (is_correct)
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, make_colour_rgb(255, 0, 200), 1);
else
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, make_colour_rgb(0, 220, 255), 0.95);