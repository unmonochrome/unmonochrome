#region SURFACE

if !surface_exists(surf_final)
{
    surf_final = surface_create(
        surface_get_width(application_surface),
        surface_get_height(application_surface)
    );
}

surface_set_target(surf_final);

draw_clear_alpha(c_black, 0);

draw_surface(application_surface, 0, 0);

surface_reset_target();

#endregion


#region SHADER

shader_set(shd_saturation);

shader_set_uniform_f(u_saturation, saturation_value);

draw_surface(surf_final, 0, 0);

shader_reset();

#endregion