/// Step Event — obj_boss_sereia

state_timer++;

var p = instance_find(obj_player, 0);
if (!instance_exists(p)) exit;

// ==========================================
// DETECÇÃO DE DANO + SHAKE + FLASH
// ==========================================
if (hp < last_hp && state != 98)
{
    var damage_taken = last_hp - hp;
    var hp_ratio_shake = hp / max_hp;
    var shake_str = 6 + (1 - hp_ratio_shake) * 6;
    
    with (obj_camera_boss_fixed)
    {
        shake_time = 12;
        shake_strength = shake_str;
    }
    
    hit_flash_timer = hit_flash_max;
    current_expression = "hurt";
    expression_timer = 25;
    
    repeat(8)
    {
        var bx = x + random_range(-100, 100);
        var by = y + random_range(-80, 80);
        instance_create_layer(bx, by, "effects", obj_death_bubble);
    }
}

last_hp = hp;
if (hit_flash_timer > 0) hit_flash_timer--;

// ==========================================
// DIFICULDADE PROGRESSIVA (mais agressiva)
// ==========================================
var hp_ratio = hp / max_hp;
var difficulty = 1 - hp_ratio;

// Menos tempo entre ataques
var idle_duration = lerp(90, 50, difficulty);     // antes 120→75

// Mais bolhas com HP baixo
var bubble_count_mult = 1.2 + difficulty * 0.6;    // antes 1 + 0.3 (+20% base)

// Velocidade dos ataques aumenta mais
var attack_speed_mult = 1.1 + difficulty * 0.4;    // antes 1 + 0.2

// Jato dura mais
var lane_duration = lerp(210, 280, difficulty);    // antes 180→240

// Bolhas mais juntas
var bubble_delay_base = lerp(6, 3, difficulty);    // antes 8→5

// ==========================================
// EXPRESSÕES
// ==========================================
if (expression_timer > 0) expression_timer--;
if (expression_timer <= 0 && current_expression != "idle") current_expression = "idle";

if (current_expression != last_expression)
{
    switch (current_expression)
    {
        case "idle":  sprite_index = spr_sereia_idle; break;
        case "hurt":  sprite_index = spr_sereia_dano; break;
        case "angry": sprite_index = spr_sereia_bravo; break;
    }
    image_index = 0;
    last_expression = current_expression;
}

// ==========================================
// STATE MACHINE
// ==========================================
switch (state)
{
    case 99:
        if (state_timer >= 90)
        {
            state = 0;
            state_timer = 0;
        }
    break;
    
    case 0:
        if (state_timer >= idle_duration)
        {
            var next_attack;
            
            if (debug_attack_sequence)
            {
                next_attack = attack_sequence[attack_sequence_index];
                attack_sequence_index++;
                if (attack_sequence_index >= attack_sequence_length)
                    attack_sequence_index = 0;
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
    // ATAQUE 1 — BOLHAS (mais rápido, mais bolhas)
    // ==================================================
    case 1:
        if (!bubbles_spawned)
        {
            bubbles_spawned = true;
            bubble_pattern = choose(0, 1);
            
            if (bubble_pattern == 0)
            {
                var num_bolhas = round(10 * bubble_count_mult); // antes 8
                
                for (var i = 0; i < num_bolhas; i++)
                {
                    if (i < num_bolhas / 2)
                    {
                        var start_x = -80;
                        var start_y = lerp(150, room_height - 150, i / (num_bolhas / 2));
                        var end_x = room_width + 80;
                        var end_y = lerp(room_height - 150, 150, i / (num_bolhas / 2));
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = i * bubble_delay_base;
                        bubble.speed_projectile = 9; // antes 7
                        bubble.speed_projectile *= attack_speed_mult;
                        bubble.target_scale = 0.9;
                        
                        var dir = point_direction(start_x, start_y, end_x, end_y);
                        bubble.hspd = lengthdir_x(bubble.speed_projectile, dir);
                        bubble.vspd = lengthdir_y(bubble.speed_projectile, dir);
                    }
                    else
                    {
                        var j = i - (num_bolhas / 2);
                        var start_x = room_width + 80;
                        var start_y = lerp(150, room_height - 150, j / (num_bolhas / 2));
                        var end_x = -80;
                        var end_y = lerp(room_height - 150, 150, j / (num_bolhas / 2));
                        
                        var bubble = instance_create_layer(start_x, start_y, "effects", obj_boss_bubble);
                        bubble.spawn_delay = j * bubble_delay_base;
                        bubble.speed_projectile = 9;
                        bubble.speed_projectile *= attack_speed_mult;
                        bubble.target_scale = 0.9;
                        
                        var dir = point_direction(start_x, start_y, end_x, end_y);
                        bubble.hspd = lengthdir_x(bubble.speed_projectile, dir);
                        bubble.vspd = lengthdir_y(bubble.speed_projectile, dir);
                    }
                }
            }
            else
            {
                // PATTERN 1 — vertical com buraco
                var num_colunas = 8; // antes 7 (mais colunas = menos espaço)
                var coluna_segura = irandom(num_colunas - 1);
                
                var player_col = floor(p.x / (room_width / num_colunas));
                player_col = clamp(player_col, 0, num_colunas - 1);
                
                // Reduz a chance do buraco ficar no player (mais punitivo)
                if (random(100) < 50) coluna_segura = player_col; // antes 70
                
                for (var col = 0; col < num_colunas; col++)
                {
                    if (col == coluna_segura) continue;
                    
                    var col_x = (col + 0.5) * (room_width / num_colunas);
                    
                    var bubble_top = instance_create_layer(col_x, -80, "effects", obj_boss_bubble);
                    bubble_top.spawn_delay = col * 2; // antes 3
                    bubble_top.speed_projectile = 7; // antes 6
                    bubble_top.speed_projectile *= attack_speed_mult;
                    bubble_top.target_scale = 0.9;
                    bubble_top.vspd = bubble_top.speed_projectile;
                    
                    var bubble_bot = instance_create_layer(col_x, room_height + 80, "effects", obj_boss_bubble);
                    bubble_bot.spawn_delay = col * 2;
                    bubble_bot.speed_projectile = 7;
                    bubble_bot.speed_projectile *= attack_speed_mult;
                    bubble_bot.target_scale = 0.9;
                    bubble_bot.vspd = -bubble_bot.speed_projectile;
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
    // ATAQUE 2 — JATOS (igual, mas mais frequente via idle menor)
    // ==================================================
    case 2:
        if (!water_lanes_active)
        {
            water_lanes_active = true;
            water_lane_timer = 0;
            
            repeat(15)
            {
                var bx = x + random_range(-150, 150);
                var by = y + random_range(-80, 80);
                instance_create_layer(bx, by, "effects", obj_death_bubble);
            }
            
            with (obj_camera_boss_fixed)
            {
                shake_time = 8;
                shake_strength = 2;
            }
            
            current_expression = "angry";
            expression_timer = 60;
            
            var jato_w = 384;
            var jato_spacing = 400;
            
            var num_jatos = floor(room_width / jato_spacing);
            var total_w = num_jatos * jato_spacing;
            var start_x = (room_width - total_w) / 2;
            
            for (var i = 0; i < num_jatos; i++)
            {
                var spawn_jet = false;
                
                if (water_lane_pattern == 0)
                    spawn_jet = (i mod 2 == 1);
                else
                    spawn_jet = (i mod 2 == 0);
                
                if (spawn_jet)
                {
                    var lane = instance_create_layer(
                        start_x + i * jato_spacing,
                        0,
                        "effects",
                        obj_water_lane
                    );
                    lane.lane_width = jato_w;
                    lane.is_dangerous = true;
                }
            }
        }
        
        water_lane_timer++;
        
        if (water_lane_timer >= lane_duration)
        {
            with (obj_water_lane)
            {
                if (state == 1)
                {
                    peixes_active = false;
                    jato_alpha_target = 0;
                    should_destroy = true;
                    is_dangerous = false;
                }
            }
            
            state = 0;
            state_timer = 0;
            water_lane_pattern = !water_lane_pattern;
        }
    break;
    
    // ==================================================
    // ATAQUE 3 — PEIXES (um pouco mais rápido)
    // ==================================================
    case 3:
        if (!fish_spawned)
        {
            fish_spawned = true;
            
            var num_fish = 3;
            var correct = irandom(num_fish - 1);
            var spacing = room_height / num_fish;
            
            var spawn_x, fish_hspd;
            
            // Velocidade aumenta com HP baixo (mas começa lento pra ainda dar pra ver)
            var base_fish_speed = 7 + difficulty * 4; // 7 → 11
            
            if (fish_direction == 1)
            {
                spawn_x = -300;
                fish_hspd = base_fish_speed;
            }
            else
            {
                spawn_x = room_width + 300;
                fish_hspd = -base_fish_speed;
            }
            
            for (var i = 0; i < num_fish; i++)
            {
                var fy = spacing * i + (spacing / 2);
                var fish = instance_create_layer(spawn_x, fy, "effects", obj_boss_fish);
                fish.is_correct = (i == correct);
                fish.hspd = fish_hspd;
                fish.fish_direction = fish_direction;
                
                if (fish.is_correct) correct_fish_id = fish.id;
            }
            
            fish_direction *= -1;
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
        
        if (death_timer <= 30)
        {
            death_phase = 0;
            
            if (death_timer <= 8) death_flash_alpha = 1 - (death_timer / 8);
            else death_flash_alpha = 0;
            
            if (death_timer <= 12)
            {
                if (death_timer mod 4 == 0) image_alpha = 0.3;
                else image_alpha = 1;
            }
            else image_alpha = 1;
            
            death_x_shake = sin(death_timer * 0.5) * 3;
        }
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
            
            if (random(100) < 3) death_flash_alpha = 0.4;
            else death_flash_alpha = lerp(death_flash_alpha, 0, 0.2);
        }
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
        else if (death_timer <= 360)
        {
            death_phase = 4;
            death_x_shake = lerp(death_x_shake, 0, 0.15);
            death_y_offset = lerp(death_y_offset, 0, 0.15);
            death_flash_alpha = lerp(death_flash_alpha, 0, 0.1);
        }
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
                
                var fb = instance_create_depth(0, 0, -9999, obj_fade_black);
                fb.alpha = 1;
                fb.go_to_loading = true;
                fb.target_room   = rm_creditos;
                
                instance_destroy();
            }
        }
    break;
}

// ==========================================
// CHECAR MORTE
// ==========================================
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
    
    with (obj_camera_boss_fixed)
    {
        shake_time = 30;
        shake_strength = 15;
    }
}
