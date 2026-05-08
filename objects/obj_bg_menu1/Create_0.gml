#region Cabeças Setup

head_count = 3;

// sprites normais
head_sprite[0] = spr_cabeca1;
head_sprite[1] = spr_cabeca2;
head_sprite[2] = spr_cabeca3;

// sprites luz
head_light_sprite[0] = spr_cabecaluz1;
head_light_sprite[1] = spr_cabecaluz2;
head_light_sprite[2] = spr_cabecaluz3;

// posições finais das cabeças
head_x[0] = 874 + 118;
head_target_y[0] = 177;

head_x[1] = 715;
head_target_y[1] = 306;

head_x[2] = 594;
head_target_y[2] = 382;

// posições das luzes
head_light_x[0] = 951;
head_light_y[0] = 177;

head_light_x[1] = 670;
head_light_y[1] = 306;

head_light_x[2] = 541;
head_light_y[2] = 384;

// estado inicial (fora da tela)
for (var i = 0; i < head_count; i++)
{
    head_y[i] = head_target_y[i] * 10;
    head_arrived[i] = false;
    head_float_seed[i] = random(1000);
}

#endregion


#region Delay Cinematográfico

menu_intro_timer = 0;

// 0.8 segundos entre cada cabeça
var delay_step = room_speed * 0.8;

for (var i = 0; i < head_count; i++)
{
    head_delay[i] = i * delay_step;
}

#endregion


#region Movimento

head_lerp_speed = 0.10; // velocidade da subida
head_float_amp = 3;     // altura da flutuação
head_float_speed = 0.04;

#endregion

#region Luz dos olhos

light_alpha_min = 0.5;
light_alpha_max = 1.0;
light_pulse_speed = 0.05;

#endregion

#region Glitch Setup

glitch_timer = 0;
glitch_interval_min = room_speed * 2;
glitch_interval_max = room_speed * 4;
glitch_duration = 4;

glitch_next = irandom_range(glitch_interval_min, glitch_interval_max);
glitch_active = false;

#endregion

active = true;