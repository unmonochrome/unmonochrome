#region SHADER

application_surface_draw_enable(false);

u_saturation = shader_get_uniform(shd_saturation, "saturation");

saturation_value = 0.0;

surf_final = -1;

#endregion	