// olho
draw_sprite(sprite_index, 0, x, y);

// pupila
var p = instance_find(obj_player, 0);
if (instance_exists(p))
{
    var dx = p.x - x;
    var dy = p.y - y;

    dx = clamp(dx, -pupila_limit_x, pupila_limit_x);
    dy = clamp(dy, -pupila_limit_y, pupila_limit_y);

    draw_sprite(spr_pupila, 0, x + dx, y + dy + pupila_offset_y);
}

