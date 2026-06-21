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

jato_alpha = lerp(jato_alpha, jato_alpha_target, 0.08);

if (state == 1)
{
    fish_y_1 += ataque_scroll_speed;
    fish_y_2 += ataque_scroll_speed;
    
    if (peixes_active)
    {
        if (fish_y_1 - sprite_h / 2 > room_height)
            fish_y_1 = fish_y_2 - sprite_h;
        
        if (fish_y_2 - sprite_h / 2 > room_height)
            fish_y_2 = fish_y_1 - sprite_h;
    }
}

if (state == 0)
{
    warning_timer++;
    jato_alpha_target = 0;
    
    if (warning_timer >= warning_time)
    {
        state = 1;
        jato_alpha_target = 1;
        peixes_active = true;
        
        fish_y_1 = -sprite_h;
        fish_y_2 = -sprite_h * 2;
    }
    exit;
}

// ==========================================
// ESTADO 1 = ATIVA — DANO SÓ NA ALTURA DOS PEIXES (não na lane inteira)
// ==========================================
if (is_dangerous)
{
    var p = instance_find(obj_player, 0);
    
    if (instance_exists(p))
    {
        // Player precisa estar dentro do X da lane
        var inside_x = (p.x >= x && p.x <= x + lane_width);
        
        if (inside_x && p.invincible <= 0)
        {
            // Hitbox vertical: só causa dano se o player tá perto da Y dos peixes
            // Tolerância vertical de cada peixe (raio de colisão)
            var hit_range = sprite_h / 2 * 0.6; // 60% do raio do peixe
            
            var hit_1 = (abs(p.y - fish_y_1) < hit_range);
            var hit_2 = (abs(p.y - fish_y_2) < hit_range);
            
            if (hit_1 || hit_2)
            {
                p.hp--;
                p.invincible = 60;
                p.hurt_timer = 60;
                p.hitstun = 20;
                
                with (obj_camera_boss_fixed)
                {
                    shake_time = 5;
                    shake_strength = 3;
                }
            }
        }
    }
}

if (should_destroy 
    && jato_alpha < 0.02 
    && fish_y_1 - sprite_h / 2 > room_height
    && fish_y_2 - sprite_h / 2 > room_height)
{
    instance_destroy();
}
