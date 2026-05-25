/// Draw Event — obj_water_lane

var lane_color;
var wave_speed;
var particle_count;

if (is_dangerous)
{
    // PERIGOSA: Vermelho escuro, rápido, caótico
    lane_color = make_colour_rgb(150, 30, 40);
    wave_speed = 8;
    particle_count = 5;
}
else
{
    // SEGURA: Azul claro, lento, calmo
    lane_color = make_colour_rgb(60, 120, 180);
    wave_speed = 2;
    particle_count = 2;
}

// Fundo da faixa
draw_set_alpha(0.4);
draw_set_color(lane_color);
draw_rectangle(x, 0, x + lane_width, room_height, false);
draw_set_alpha(1);

// Ondas animadas
for (var i = 0; i < 3; i++)
{
    var wave_y = (current_time * 0.01 * wave_speed + i * 100) mod room_height;
    
    draw_set_alpha(0.2);
    draw_line_width_color(
        x, wave_y,
        x + lane_width, wave_y,
        3,
        lane_color, lane_color
    );
}

draw_set_alpha(1);
draw_set_color(c_white);

// Partículas
if (particle_timer mod 10 == 0)
{
    for (var i = 0; i < particle_count; i++)
    {
        var px = x + random(lane_width);
        var py = random(room_height);
        
        // instance_create_layer(px, py, "effects", obj_water_particle);
    }
}