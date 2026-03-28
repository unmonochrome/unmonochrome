if (can_be_hit)
{
    if (is_target && instance_exists(owner))
    {
        owner.hp -= 1;

        with (obj_camera)
        {
            shake_time = 8;
            shake_strength = 5;
        }

        with (obj_boss_hand_ground)
        {
            instance_destroy();
        }

        with (obj_boss_hand_fall)
        {
            instance_destroy();
        }

        with (obj_boss_hand_warning_ground)
        {
            instance_destroy();
        }
    }

    instance_destroy();
}