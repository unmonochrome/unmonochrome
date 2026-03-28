timer++;
if (timer >= room_speed*2) // warning dura 2s
{
    var h = instance_create_depth(spawn_x, spawn_y, -20, obj_boss_hand_ground);
    h.owner = owner;
    h.is_target = is_target;
    h.target_y = target_y;
    instance_destroy();
}