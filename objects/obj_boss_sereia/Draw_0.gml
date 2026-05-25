/// Draw Event — obj_boss_sereia

var dx = x;
var dy = y;

// Aplicar transformações de morte
if (state == 98)
{
    dx += death_x_shake;
    dy += death_y_offset;
}

// ==========================================
// DRAW NORMAL
// ==========================================
draw_sprite_ext(
    sprite_index,
    image_index,
    dx,
    dy,
    1,
    1,
    0,
    c_white,
    image_alpha
);

// ==========================================
// FLASH BRANCO QUANDO LEVA DANO
// ==========================================
if (hit_flash_timer > 0)
{
    var flash_alpha = hit_flash_timer / hit_flash_max;
    
    gpu_set_blendmode(bm_add);
    
    draw_sprite_ext(
        sprite_index,
        image_index,
        dx,
        dy,
        1,
        1,
        0,
        c_white,
        flash_alpha * 0.8
    );
    
    gpu_set_blendmode(bm_normal);
}

