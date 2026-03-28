#region Draw

if (state == 0)
{
    draw_set_alpha(0.5);
    draw_set_color(c_red);
    draw_circle(x, target_y, 30, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

draw_self();

#endregion