/// Collision with obj_player — obj_boss_fish

if (!is_correct)
{
    if (other.invincible <= 0)
    {
        other.hp -= 1;
        other.invincible = 30;
        other.hurt_timer = 12;
        other.hitstun = 16;

        other.knockback_x = 8 * -sign(other.x - x);
        if (other.knockback_x == 0) other.knockback_x = 8 * -other.facing;

        with (obj_camera_boss_fixed)
        {
            shake_time = 6;
            shake_strength = 4;
        }
    }
}