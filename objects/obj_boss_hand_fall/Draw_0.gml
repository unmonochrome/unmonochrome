/// Draw Event — obj_boss_hand_ground

// respeita depth
event_inherited();

if (!variable_instance_exists(id, "fade_alpha"))
{
    fade_alpha = 1;
}

var target_size = 128;
var sprite_w = sprite_get_width(sprite_index);
var scale = target_size / sprite_w;

draw_sprite_ext(
    sprite_index, image_index,
    x, y,
    scale, scale,
    image_angle,
    c_white, fade_alpha
);