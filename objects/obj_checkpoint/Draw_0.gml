var yy = y + sin(bob) * 2;

if (active) {
    var glow = 1 + sin(pulse) * 0.08;

    draw_sprite_ext(sprite_index, image_index, x, yy, glow, glow, 0, c_white, 1);

    // brilho externo simples
    draw_sprite_ext(sprite_index, image_index, x, yy, glow + 0.08, glow + 0.08, 0, c_white, 0.2);
} else {
    draw_sprite_ext(sprite_index, image_index, x, yy, 1, 1, 0, c_white, 0.85);
}