y = lerp(y, target_y, spd);

life_timer++;
if (life_timer >= life_max)
{
    instance_destroy();
}