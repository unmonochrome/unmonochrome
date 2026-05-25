/// Step Event — obj_death_bubble

life++;

// Movimento flutuante
hspeed += random_range(-0.1, 0.1);
hspeed = clamp(hspeed, -1, 1);

// Fade out
if (life >= max_life * 0.7)
{
    image_alpha = lerp(image_alpha, 0, 0.05);
}

// Destruir
if (life >= max_life || image_alpha <= 0.05)
{
    instance_destroy();
}

// Sair da tela
if (y < -50)
{
    instance_destroy();
}