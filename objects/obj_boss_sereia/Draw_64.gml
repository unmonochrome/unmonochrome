/// Draw GUI Event — obj_boss_sereia

if (state != 98) exit;

// ==========================================
// USAR DIMENSÕES MÁXIMAS PARA COBRIR LETTERBOX
// ==========================================
var gw = max(display_get_gui_width(),  window_get_width());
var gh = max(display_get_gui_height(), window_get_height());

var pad = 64;
var x1 = -pad;
var y1 = -pad;
var x2 = gw + pad;
var y2 = gh + pad;

// ==========================================
// FLASH BRANCO (FASE 0)
// ==========================================
if (death_flash_alpha > 0)
{
    draw_set_alpha(death_flash_alpha);
    draw_set_color(c_white);
    draw_rectangle(x1, y1, x2, y2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ==========================================
// ESCURECIMENTO PROGRESSIVO
// ==========================================
var darkness = 0;

if (death_phase == 1)
{
    var t = (death_timer - 30) / 120;
    darkness = t * 0.35;
}
else if (death_phase == 2)
{
    var t = (death_timer - 150) / 120;
    darkness = 0.35 + (t * 0.25);
}
else if (death_phase == 3)
{
    darkness = 0.6;
}
else if (death_phase == 4)
{
    var t = (death_timer - 330) / 30;
    darkness = lerp(0.6, 0.5, t);
}
else if (death_phase == 5)
{
    var t = min(1, (death_timer - 360) / 150);
    darkness = 0.5 + (t * 0.5);
}

if (darkness > 0)
{
    draw_set_alpha(darkness);
    draw_set_color(c_black);
    draw_rectangle(x1, y1, x2, y2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ==========================================
// PULSO VERMELHO (FASE 2 e 3)
// ==========================================
if (death_phase == 2 || death_phase == 3)
{
    var pulse_alpha = 0;
    
    if (death_phase == 2)
    {
        var pulse = abs(sin(death_timer * 0.08));
        var t = (death_timer - 150) / 120;
        pulse_alpha = pulse * t * 0.25;
    }
    else if (death_phase == 3)
    {
        var pulse = abs(sin(death_timer * 0.25));
        pulse_alpha = pulse * 0.45;
    }
    
    if (pulse_alpha > 0)
    {
        draw_set_alpha(pulse_alpha);
        draw_set_color(make_colour_rgb(200, 30, 30));
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// ==========================================
// FLASHES BRANCOS ALEATÓRIOS (FASE 3)
// ==========================================
if (death_phase == 3)
{
    if (random(100) < 8)
    {
        draw_set_alpha(random_range(0.3, 0.6));
        draw_set_color(c_white);
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// ==========================================
// OVERLAY AZUL PROFUNDO (FASE 4 e 5)
// ==========================================
if (death_phase == 4)
{
    var t = (death_timer - 330) / 30;
    var blue_alpha = t * 0.3;
    
    if (blue_alpha > 0)
    {
        draw_set_alpha(blue_alpha);
        draw_set_color(make_colour_rgb(15, 40, 80));
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
else if (death_phase == 5)
{
    var t = min(1, (death_timer - 360) / 180);
    var blue_alpha = 0.3 + (t * 0.5);
    
    if (blue_alpha > 0)
    {
        draw_set_alpha(blue_alpha);
        draw_set_color(make_colour_rgb(10, 30, 70));
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// ==========================================
// PISCAR DA TELA (FASE 4 - SILÊNCIO)
// ==========================================
if (death_phase == 4)
{
    if (death_timer mod 20 < 3)
    {
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// ==========================================
// FADE FINAL PARA PRETO (FASE 5)
// ==========================================
if (death_phase == 5)
{
    if (death_alpha < 0.2)
    {
        var final_fade = 1 - (death_alpha / 0.2);
        
        draw_set_alpha(final_fade);
        draw_set_color(c_black);
        draw_rectangle(x1, y1, x2, y2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

draw_set_color(c_white);
