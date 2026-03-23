#region Timer

menu_intro_timer++;

#endregion


#region Entrada das cabeças

for (var i = 0; i < head_count; i++)
{
    if (!head_arrived[i] && menu_intro_timer >= head_delay[i])
    {
        head_y[i] = lerp(head_y[i], head_target_y[i], head_lerp_speed);

        if (abs(head_y[i] - head_target_y[i]) < 0.5)
        {
            head_y[i] = head_target_y[i];
            head_arrived[i] = true;
        }
    }
}

#endregion

#region Glitch Timer

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

#endregion
