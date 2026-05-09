/// STEP EVENT — obj_fade_in_black

alpha -= fade_speed;

if (alpha <= 0)
{
    alpha = 0;

    if (destroy_when_done)
    {
        instance_destroy();
    }
}