#region John Movement

if (!john_intro_done)
{
    john_x = lerp(john_x, john_target_x, john_lerp_spd);

    if (abs(john_x - john_target_x) < 1)
    {
        john_x = john_target_x;
        john_intro_done = true;
    }
}

#endregion


#region Glitch Timer

if (john_intro_done)
{
    glitch_timer++;

    if (!glitch_active && glitch_timer >= glitch_next)
    {
        glitch_active = true;
        glitch_timer = 0;
    }
    else if (glitch_active && glitch_timer >= glitch_duration)
    {
        glitch_active = false;
        glitch_timer = 0;
        glitch_next = irandom_range(glitch_interval_min, glitch_interval_max);
    }
}

#endregion