/// Create Event — obj_death_bubble

vspeed = -random_range(1.5, 3.5);
hspeed = random_range(-0.5, 0.5);

alpha = random_range(0.3, 0.7);
scale = random_range(0.3, 0.8);

life = 0;
max_life = random_range(60, 120);

sprite_index = spr_boss_bubble; // use seu sprite de bolha

image_speed = 0;
image_index = 0;
image_alpha = alpha;
image_xscale = scale;
image_yscale = scale;