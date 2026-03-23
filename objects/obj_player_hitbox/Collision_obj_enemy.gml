if (other.invincible <= 0) {
    other.hp -= damage;
    other.aggro = true;
    other.knockback_x = 7 * direction_x;
    other.vspd = -3;
    other.hitstun = 16;
    other.hurt_timer = 10;
    other.invincible = 10;

    with (obj_camera) {
        shake_time = 6;
        shake_strength = 4;
    }
}

instance_destroy();