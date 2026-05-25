/// Draw GUI Event — obj_boss_healthbar

if (alpha <= 0.01) exit;
if (!instance_exists(boss_ref)) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// ==========================================
// POSIÇÃO (inferior centralizada)
// ==========================================
var bar_x = (gw - bar_width) / 2;
var bar_y = gh - 70; // 70px de baixo

// ==========================================
// PULSAÇÃO (HP baixo)
// ==========================================
var hp_pct = displayed_hp;
var is_low = (hp_pct < 0.3);

var pulse = 1;
if (is_low)
{
    pulse = 1 + abs(sin(pulse_timer)) * 0.08; // pulsa 8% a mais
}

// Ajusta tamanho com pulso
var pulse_w = bar_width * pulse;
var pulse_h = bar_height * pulse;
var pulse_x = (gw - pulse_w) / 2;
var pulse_y = bar_y - ((pulse_h - bar_height) / 2);

// ==========================================
// SOMBRA EMBAIXO (profundidade)
// ==========================================
draw_set_alpha(alpha * 0.5);
draw_set_color(c_black);
draw_rectangle(
    pulse_x + 4,
    pulse_y + 6,
    pulse_x + pulse_w + 4,
    pulse_y + pulse_h + 6,
    false
);

// ==========================================
// FUNDO DA BARRA
// ==========================================
draw_set_alpha(alpha);
draw_set_color(color_bg);
draw_rectangle(
    pulse_x,
    pulse_y,
    pulse_x + pulse_w,
    pulse_y + pulse_h,
    false
);

// ==========================================
// GHOST BAR (mostra dano recente — branco)
// ==========================================
if (ghost_hp > displayed_hp)
{
    var ghost_fill = ghost_hp * pulse_w;
    
    draw_set_alpha(alpha * 0.7);
    draw_set_color(color_lost);
    draw_rectangle(
        pulse_x,
        pulse_y,
        pulse_x + ghost_fill,
        pulse_y + pulse_h,
        false
    );
}

// ==========================================
// BARRA PRINCIPAL (HP atual com gradiente)
// ==========================================
var fill_w = displayed_hp * pulse_w;

if (fill_w > 0)
{
    draw_set_alpha(alpha);
    
    // Gradiente vertical (topo claro → base escuro)
    draw_rectangle_colour(
        pulse_x,
        pulse_y,
        pulse_x + fill_w,
        pulse_y + pulse_h,
        color_fill_top, color_fill_top,
        color_fill_bot, color_fill_bot,
        false
    );
    
    // Linha de brilho no topo (highlight tipo glass)
    draw_set_alpha(alpha * 0.4);
    draw_set_color(c_white);
    draw_rectangle(
        pulse_x,
        pulse_y,
        pulse_x + fill_w,
        pulse_y + (pulse_h * 0.35),
        false
    );
}

// ==========================================
// BORDA
// ==========================================
draw_set_alpha(alpha);
draw_set_color(color_border);
draw_rectangle(
    pulse_x,
    pulse_y,
    pulse_x + pulse_w,
    pulse_y + pulse_h,
    true // só contorno
);

// Segunda borda mais fininha pra dar peso
draw_rectangle(
    pulse_x - 1,
    pulse_y - 1,
    pulse_x + pulse_w + 1,
    pulse_y + pulse_h + 1,
    true
);

// ==========================================
// NOME DO BOSS (acima da barra)
// ==========================================
draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

// Sombra do texto
draw_set_color(c_black);
draw_text_transformed(
    gw / 2 + 3,
    pulse_y - 5 + 3,
    boss_name,
    1.2, 1.2, 0
);

// Texto principal
var name_color = (is_low) ? color_text_low : color_text;
draw_set_color(name_color);
draw_text_transformed(
    gw / 2,
    pulse_y - 5,
    boss_name,
    1.2, 1.2, 0
);

// ==========================================
// HP NUMÉRICO DENTRO DA BARRA (estilo Terraria)
// ==========================================
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var hp_text = string(boss_ref.hp) + " / " + string(boss_ref.max_hp);


// Texto
draw_set_color(c_white);
draw_text(
    gw / 2,
    pulse_y + (pulse_h / 2),
    hp_text
);

// ==========================================
// RESET
// ==========================================
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
