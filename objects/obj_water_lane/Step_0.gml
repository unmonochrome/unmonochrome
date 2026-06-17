/// Step Event — obj_water_lane

warning_pulse += 0.2;

var sprite_h = sprite_get_height(spr_jato_ataque);

// Anima bordas
jato_anim_timer++;
if (jato_anim_timer >= jato_anim_speed)
{
    jato_anim_timer = 0;
    jato_anim_frame++;
    if (jato_anim_frame >= sprite_get_number(spr_jato))
        jato_anim_frame = 0;
}

// Anima frames dos peixes
ataque_anim_timer++;
if (ataque_anim_timer >= ataque_anim_speed)
{
    ataque_anim_timer = 0;
    ataque_anim_frame++;
    if (ataque_anim_frame >= sprite_get_number(spr_jato_ataque))
        ataque_anim_frame = 0;
}

// Fade da borda
jato_alpha = lerp(jato_alpha, jato_alpha_target, 0.08);

// ==========================================
// MOVE AS 2 CÓPIAS PRA BAIXO (sempre, no state 1)
// ==========================================
if (state == 1)
{
    fish_y_1 += ataque_scroll_speed;
    fish_y_2 += ataque_scroll_speed;
    
    // Loop infinito SÓ se peixes_active
    // (quando uma cópia sai da tela, reposiciona acima da outra)
    if (peixes_active)
    {
        if (fish_y_1 - sprite_h / 2 > room_height)
            fish_y_1 = fish_y_2 - sprite_h;
        
        if (fish_y_2 - sprite_h / 2 > room_height)
            fish_y_2 = fish_y_1 - sprite_h;
    }
}

// ==========================================
// ESTADO 0 = WARNING
// ==========================================
if (state == 0)
{
    warning_timer++;
    jato_alpha_target = 0;
    
    if (warning_timer >= warning_time)
    {
        state = 1;
        jato_alpha_target = 1;
        peixes_active = true;
        
        // Reseta posições: cópia 1 entra primeiro, cópia 2 vem logo atrás
        fish_y_1 = -sprite_h;
        fish_y_2 = -sprite_h * 2;
    }
    exit;
}

// ==========================================
// ESTADO 1 = ATIVA
// ==========================================
if (is_dangerous)
{
    var p = instance_find(obj_player, 0);
    
    if (instance_exists(p))
    {
        if (p.x >= x && p.x <= x + lane_width && p.invincible <= 0)
        {
            p.hp--;
            p.invincible = 30;
            p.hurt_timer = 12;
            
            with (obj_camera)
            {
                shake_time = 5;
                shake_strength = 3;
            }
        }
    }
}

// ==========================================
// AUTO-DESTRUIÇÃO
// quando: borda invisível + AS 2 CÓPIAS saíram da tela
// ==========================================
if (should_destroy 
    && jato_alpha < 0.02 
    && fish_y_1 - sprite_h / 2 > room_height
    && fish_y_2 - sprite_h / 2 > room_height)
{
    instance_destroy();
}
