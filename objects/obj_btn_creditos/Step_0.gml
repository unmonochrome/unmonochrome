#region Intro Animation

if (!intro_done)
{
    intro_timer++;

    if (intro_timer >= intro_delay)
    {
        x = lerp(x, target_x, intro_spd);

        if (abs(x - target_x) < 1)
        {
            x = target_x;
            intro_done = true;
        }
    }
}

#endregion