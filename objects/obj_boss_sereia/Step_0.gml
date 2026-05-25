/// Step Event — obj_boss_sereia

state_timer++;

var p = instance_find(obj_player, 0);

if (!instance_exists(p))
{
    exit;
}

// ======================================================
// DETECÇÃO DE DANO + SHAKE + FLASH
// ======================================================
if (hp < last_hp && state != 98)
{
    var damage_taken = last_hp - hp;
    
    // Shake na câmera (mais forte se HP baixo = mais dramático)
    var hp_ratio_shake = hp / max_hp;
    var shake_str = 6 + (1 - hp_ratio_shake) * 6;
    
    with (obj_camera_boss_fixed)
    {
        shake_time = 12;
        shake_strength = shake_str;
    }
    
    // Flash visual no boss
    hit_flash_timer = hit_flash_max;
    
    // Expressão de dor temporária
    current_expression = "hurt";
    expression_timer = 25;
    
    // Spawnar bolhinhas de impacto
    repeat(8)
    {
        var bx = x + random_range(-100, 100);
        var by = y + random_range(-80, 80);
        
        instance_create_layer(bx, by, "effects", obj_death_bubble);
    }
}

last_hp = hp;

// Diminuir timer do flash
if (hit_flash_timer > 0)
{
    hit_flash_timer--;
}

// ======================================================
// DIFICULDADE PROGRESSIVA (baseada em % de HP)
// ======================================================
var hp_ratio = hp / max_hp;
var difficulty = 1 - hp_ratio;

var idle_duration = lerp(60, 25, difficulty);
var bubble_count_mult = 1 + difficulty * 0.7;
var attack_speed_mult = 1 + difficulty * 0.5;
var lane_duration = lerp(180, 240, difficulty);
var bubble_delay_base = lerp(5, 2, difficulty);

// ======================================================
// EXPRESSÕES
// ======================================================

if (expression_timer > 0)
{
    expression_timer--;
}

if (expression_timer <= 0 && current_expression != "idle")
{
    current_expression = "idle";
}

if (current_expression != last_expression)
{
    switch (current_expression)
    {
        case "idle":
            sprite_index = spr_sereia_idle;
        break;
        
        case "hurt":
            sprite_index = spr_sereia_dano;
        break;
        
        case "angry":
            sprite_index = spr_sereia_bravo;
        break;
    }
    
    image_index = 0;
    
    last_expression = current_expression;
}

// ======================================================
// STATE MACHINE
// ======================================================

switch (state)
{
    // ==================================================
    // SPAWN
    // ==================================================
    case 99:
        if (state_timer >= 90)
        {
            state = 0;
            state_timer = 0;
        }
    break;
    
    // ==================================================
    // IDLE
    // ==================================================
    case 0:
        if (state_timer >= idle_duration)
        {
            var next_attack;
            
            if (debug_attack_sequence)
            {
                next_attack = attack_sequence[attack_sequence_index];
                
                attack_sequence_index++;
                
                if (attack_sequence_index >= attack_sequence_length)
                {
                    attack_sequence_index = 0;
                }
            }
            else
            {
                next_attack = irandom(2) + 1;
            }
            
            state = next_attack;
            state_timer = 0;
            
            bubbles_spawned = false;
            fish_spawned = false;
            water_lanes_active = false;
            
            current_expression = "angry";
            expression_timer = 60;
        }
    break;
    
    // ==================================================
    // ATAQUE BOLHAS (dificuldade progressiva)
    // ==================================================
    case 1:
        if (!bubbles_spawned)
        {
            bubbles_spawned = true;
            
            bubble_pattern = choose(0, 1);
            
            if (bubble_pattern == 0)
            {
                var num_bolhas = round(12 * bubble_count_mult);
                
                for (var i = 0; i < num_bolhas; i++)
                {
                    if (i < num_bolhas / 2)
                    {
                        var start_x = -80;
                        var start_y = lerp(100, room_height - 100, i / (num_bolhas / 2));
                        var end_x = room_width + 80;
                        var end_y = lerp(room_height - 100, 100, i / (num_bolhas / 2));
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = i * bubble_delay_base;
                        bubble.speed_projectile *= attack_speed_mult;
                        
                        var dir = point_direction(start_x, start_y, end_x, end_y);
                        bubble.hspd = lengthdir_x(bubble.speed_projectile, dir);
                        bubble.vspd = lengthdir_y(bubble.speed_projectile, dir);
                    }
                    else
                    {
                        var j = i - (num_bolhas / 2);
                        var start_x = room_width + 80;
                        var start_y = lerp(100, room_height - 100, j / (num_bolhas / 2));
                        var end_x = -80;
                        var end_y = lerp(room_height - 100, 100, j / (num_bolhas / 2));
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = j * bubble_delay_base;
                        bubble.speed_projectile *= attack_speed_mult;
                        
                        var dir = point_direction(start_x, start_y, end_x, end_y);
                        bubble.hspd = lengthdir_x(bubble.speed_projectile, dir);
                        bubble.vspd = lengthdir_y(bubble.speed_projectile, dir);
                    }
                }
            }
            else
            {
                var num_bolhas = round(14 * bubble_count_mult);
                
                for (var i = 0; i < num_bolhas; i++)
                {
                    if (i < num_bolhas / 2)
                    {
                        var start_x = lerp(100, room_width - 100, i / (num_bolhas / 2));
                        var start_y = -80;
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = i * max(1, bubble_delay_base - 1);
                        bubble.speed_projectile *= attack_speed_mult;
                        bubble.vspd = bubble.speed_projectile;
                    }
                    else
                    {
                        var j = i - (num_bolhas / 2);
                        var start_x = lerp(100, room_width - 100, j / (num_bolhas / 2));
                        var start_y = room_height + 80;
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = j * max(1, bubble_delay_base - 1);
                        bubble.speed_projectile *= attack_speed_mult;
                        bubble.vspd = -bubble.speed_projectile;
                    }
                }
            }
        }
        
        if (instance_number(obj_boss_bubble) <= 0)
        {
            state = 0;
            state_timer = 0;
        }
    break;
    
    // ==================================================
    // ATAQUE FAIXAS (dificuldade progressiva)
    // ==================================================
    case 2:
        if (!water_lanes_active)
        {
            water_lanes_active = true;
            water_lane_timer = 0;
            
            // Quando HP < 40%, usa 5 faixas (mais difícil de fugir)
            var num_lanes = (hp_ratio < 0.4) ? 5 : 4;
            var lane_width = room_width / num_lanes;
            
            for (var i = 0; i < num_lanes; i++)
            {
                var lane = instance_create_layer(
                    i * lane_width,
                    0,
                    "effects",
                    obj_water_lane
                );
                
                lane.lane_width = lane_width;
                
                if (water_lane_pattern == 0)
                {
                    lane.is_dangerous = (i mod 2 == 1);
                }
                else
                {
                    lane.is_dangerous = (i mod 2 == 0);
                }
            }
        }
        
        water_lane_timer++;
        
        if (water_lane_timer >= lane_duration)
        {
            with (obj_water_lane)
            {
                instance_destroy();
            }
            
            state = 0;
            state_timer = 0;
            
            water_lane_pattern = !water_lane_pattern;
        }
    break;
    
    // ==================================================
    // ATAQUE PEIXES (dificuldade progressiva)
    // ==================================================
    case 3:
        if (!fish_spawned)
        {
            fish_spawned = true;
            
            // Mais peixes quando HP baixo
            var num_fish = (hp_ratio < 0.5) ? 4 : 3;
            
            var correct = irandom(num_fish - 1);
            var spacing = room_height / num_fish;
            
            for (var i = 0; i < num_fish; i++)
            {
                var fy = spacing * i + (spacing / 2);
                
                var fish = instance_create_layer(-300, fy, "effects", obj_boss_fish);
                
                fish.is_correct = (i == correct);
                fish.hspd *= attack_speed_mult;
                
                if (fish.is_correct)
                {
                    correct_fish_id = fish.id;
                }
            }
        }
        
        if (instance_number(obj_boss_fish) <= 0)
        {
            state = 0;
            state_timer = 0;
        }
    break;
    
    // ==================================================
    // MORTE CINEMÁTICA
    // ==================================================
    case 98:
        current_expression = "hurt";
        
        death_active = true;
        death_timer++;
        
        with (obj_boss_bubble) instance_destroy();
        with (obj_water_lane) instance_destroy();
        with (obj_boss_fish) instance_destroy();
        
        // ==========================================
        // FASE 0: IMPACTO INICIAL (0-30 frames ~ 1s)
        // ==========================================
        if (death_timer <= 30)
        {
            death_phase = 0;
            
            if (death_timer <= 8)
            {
                death_flash_alpha = 1 - (death_timer / 8);
            }
            else
            {
                death_flash_alpha = 0;
            }
            
            if (death_timer <= 12)
            {
                if (death_timer mod 4 == 0)
                {
                    image_alpha = 0.3;
                }
                else
                {
                    image_alpha = 1;
                }
            }
            else
            {
                image_alpha = 1;
            }
            
            death_x_shake = sin(death_timer * 0.5) * 3;
        }
        // ==========================================
        // FASE 1: INSTABILIDADE (31-150 frames ~ 4s)
        // ==========================================
        else if (death_timer <= 150)
        {
            death_phase = 1;
            image_alpha = 1;
            death_flash_alpha = 0;
            
            var t = (death_timer - 30) / 120;
            var shake_intensity = t * 8;
            death_x_shake = sin(death_timer * 0.3) * shake_intensity;
            death_y_offset = sin(death_timer * 0.2) * (t * 4);
            
            death_bubble_timer++;
            if (death_bubble_timer >= 8)
            {
                death_bubble_timer = 0;
                var bx = x + random_range(-100, 100);
                var by = y + random_range(-80, 80);
                instance_create_layer(bx, by, "effects", obj_death_bubble);
            }
        }
        // ==========================================
        // FASE 2: CONVULSÃO (151-270 frames ~ 4s)
        // ==========================================
        else if (death_timer <= 270)
        {
            death_phase = 2;
            var t = (death_timer - 150) / 120;
            var shake_power = 8 + (t * 12);
            death_x_shake = sin(death_timer * 0.5) * shake_power;
            death_y_offset = sin(death_timer * 0.4) * (4 + t * 8);
            
            death_bubble_timer++;
            if (death_bubble_timer >= 4)
            {
                death_bubble_timer = 0;
                var bx = x + random_range(-120, 120);
                var by = y + random_range(-100, 100);
                instance_create_layer(bx, by, "effects", obj_death_bubble);
            }
            
            if (random(100) < 3)
            {
                death_flash_alpha = 0.4;
            }
            else
            {
                death_flash_alpha = lerp(death_flash_alpha, 0, 0.2);
            }
        }
        // ==========================================
        // FASE 3: CLÍMAX (271-330 frames ~ 2s)
        // ==========================================
        else if (death_timer <= 330)
        {
            death_phase = 3;
            death_x_shake = sin(death_timer * 0.8) * 25;
            death_y_offset = sin(death_timer * 0.6) * 15;
            
            death_bubble_timer++;
            if (death_bubble_timer >= 2)
            {
                death_bubble_timer = 0;
                repeat(2)
                {
                    var bx = x + random_range(-150, 150);
                    var by = y + random_range(-120, 120);
                    instance_create_layer(bx, by, "effects", obj_death_bubble);
                }
            }
            
            death_flash_alpha = abs(sin(death_timer * 0.3)) * 0.6;
        }
        // ==========================================
        // FASE 4: SILÊNCIO (331-360 frames ~ 1s)
        // ==========================================
        else if (death_timer <= 360)
        {
            death_phase = 4;
            death_x_shake = lerp(death_x_shake, 0, 0.15);
            death_y_offset = lerp(death_y_offset, 0, 0.15);
            death_flash_alpha = lerp(death_flash_alpha, 0, 0.1);
        }
        // ==========================================
        // FASE 5: AFUNDAMENTO (361+ ~ 5s+)
        // ==========================================
        else
        {
            death_phase = 5;
            death_x_shake = 0;
            
            death_sink_acceleration += 0.008;
            death_sink_speed += death_sink_acceleration;
            death_sink_speed = min(death_sink_speed, 3);
            
            death_y_offset += death_sink_speed;
            
            death_alpha -= 0.003;
            death_alpha = max(0, death_alpha);
            
            image_alpha = death_alpha;
            
            death_bubble_timer++;
            if (death_bubble_timer >= 15)
            {
                death_bubble_timer = 0;
                if (random(100) < 50)
                {
                    var bx = x + random_range(-80, 80);
                    var by = y + random_range(-60, 60);
                    instance_create_layer(bx, by, "effects", obj_death_bubble);
                }
            }
            
            if (death_alpha <= 0)
            {
                p.in_water = false;
                death_active = false;
                instance_destroy();
            }
        }
    break;
}

// ======================================================
// CHECAR MORTE
// ======================================================

if (hp <= 0 && state != 98)
{
    state = 98;
    state_timer = 0;
    
    death_timer = 0;
    death_phase = 0;
    death_active = true;
    
    death_y_offset = 0;
    death_x_shake = 0;
    death_alpha = 1;
    death_flash_alpha = 0;
    
    death_sink_speed = 0;
    death_sink_acceleration = 0;
    
    death_bubble_timer = 0;
    
    current_expression = "hurt";
    expression_timer = 999999;
    
    // Shake bem forte na morte
    with (obj_camera_boss_fixed)
    {
        shake_time = 30;
        shake_strength = 15;
    }
}
