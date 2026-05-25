/// Step Event — obj_water_lane

particle_timer++;

// Dano no player
if (is_dangerous)
{
    var p = instance_find(obj_player, 0);
    
    if (instance_exists(p))
    {
        if (p.x >= x && p.x <= x + lane_width && p.invincible <= 0)
        {
            p.hp--;
            p.invincible = 30;
            p.hurt_timer = 12;
            
            with (obj_camera)
            {
                shake_time = 5;
                shake_strength = 3;
            }
        }
    }
}