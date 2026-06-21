/// Step Event — obj_game

if (global.hit_pause > 0) global.hit_pause--;

if (room == rm_game || room == rm_boss_olho || room == rm_sereia)
{
    if (keyboard_check_pressed(vk_escape) && !instance_exists(obj_pause_menu))
    {
        instance_create_depth(0, 0, -9997, obj_pause_menu);
    }
}
