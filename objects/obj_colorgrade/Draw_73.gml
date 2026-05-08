shader_set(shd_saturation);

shader_set_uniform_f(u_saturation, saturation_value);

draw_surface(application_surface, 0, 0);

shader_reset();