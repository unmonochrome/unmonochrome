/// Step Event — obj_boss_hand_ground

// Define sprite
sprite_index = is_target ? spr_hand_ground_target : spr_hand_ground;

// Recalcula escala
if (!variable_instance_exists(id, "scale_calculated") || !scale_calculated)
{
    var target_visible_height = 220;
    var sprite_h = sprite_get_height(sprite_index);
    hand_scale = target_visible_height / sprite_h;
    scale_calculated = true;
}

// Escala sempre fixa
image_xscale = hand_scale;
image_yscale = hand_scale;

// ==========================================
// PULSO DO BRILHO (mão certa)
// ==========================================
if (is_target)
{
    glow_pulse += 0.08;
}

// ==========================================
// MORRENDO (fade out + afunda + trail residual)
// ==========================================
if (dying)
{
    death_timer++;
    
    var t = death_timer / death_duration;
    
    var sink_distance = 70;
    y = death_start_y + (t * sink_distance);
    
    image_alpha = death_start_alpha * (1 - t);
    
    trail_timer++;
    if (trail_timer >= trail_record_interval)
    {
        trail_timer = 0;
        array_push(trail_positions, [y, 0.7]);
        
        if (array_length(trail_positions) > trail_max)
        {
            array_delete(trail_positions, 0, 1);
        }
    }
    
    for (var i = 0; i < array_length(trail_positions); i++)
    {
        trail_positions[i][1] *= 0.88;
    }
    
    if (death_timer >= death_duration)
    {
        instance_destroy();
    }
    
    exit;
}

// ==========================================
// SUBIDA DA MÃO (mais LENTA + fade in suave)
// ==========================================
if (state == 0)
{
    // Fade in MAIS LENTO (era 0.1, agora 0.04)
    image_alpha = lerp(image_alpha, 1, 0.04);
    
    // Move pra cima (lerp lento)
    y = lerp(y, target_y, hand_speed);
    
    // GRAVA POSIÇÕES DO TRAIL
    trail_timer++;
    if (trail_timer >= trail_record_interval)
    {
        trail_timer = 0;
        array_push(trail_positions, [y, image_alpha]);
        
        if (array_length(trail_positions) > trail_max)
        {
            array_delete(trail_positions, 0, 1);
        }
    }
    
    if (abs(y - target_y) < 2)
    {
        y = target_y;
        state = 1;
        timer = 0;
        can_be_hit = true;
        image_alpha = 1;
    }
}
else if (state == 1)
{
    image_alpha = 1;
    
    // Fade out do trail após chegar (mais suave)
    for (var i = 0; i < array_length(trail_positions); i++)
    {
        trail_positions[i][1] *= 0.94;
    }
    
    while (array_length(trail_positions) > 0 && trail_positions[0][1] < 0.02)
    {
        array_delete(trail_positions, 0, 1);
    }
    
    timer++;
    
    if (timer >= stay_time)
    {
        start_death_animation();
    }
}

// ==========================================
// COLISÃO COM HITBOX DO PLAYER
// ==========================================
var atk = instance_place(x, y, obj_player_hitbox);

if (atk != noone && can_be_hit)
{
    if (is_target)
    {
        if (instance_exists(owner))
        {
            owner.hp -= 1;
            owner.correct_hand_hit = true;
        }
        
        with (obj_camera)
        {
            shake_time = 12;
            shake_strength = 8;
        }
        
        instance_destroy(atk);
        start_death_animation();
    }
    else
    {
        with (obj_camera)
        {
            shake_time = 4;
            shake_strength = 3;
        }
        
        instance_destroy(atk);
        start_death_animation();
    }
}

// ==========================================
// FUNÇÃO PRA INICIAR MORTE
// ==========================================
function start_death_animation()
{
    if (dying) exit;
    
    dying = true;
    death_timer = 0;
    death_start_y = y;
    death_start_alpha = image_alpha;
    can_be_hit = false;
}
