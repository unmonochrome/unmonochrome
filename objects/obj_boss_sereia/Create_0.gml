/// Create Event — obj_boss_sereia

#region HP e Estado
hp = 6;
max_hp = 10;

// Rastreador de HP pra detectar quando levou dano
last_hp = hp;

state = 99;
state_timer = 0;
attack_count = 0;
#endregion

#region DEBUG - Sequência de Ataques
debug_attack_sequence = true;

attack_sequence = [1, 2, 1, 3];

attack_sequence_index = 0;
attack_sequence_length = array_length_1d(attack_sequence);
#endregion

#region Sprite e Posição
sprite_index = spr_sereia_idle;

x = room_width / 2;
y = 950;

base_y = y;
#endregion

#region Movimento Flutuante
float_timer = random(1000);
float_speed = 0.02;
#endregion

#region Expressões
expression_timer = 0;

current_expression = "idle";
last_expression = "";
#endregion

#region Ataque 1: Bolhas
bubble_pattern = 0;
bubbles_spawned = false;
#endregion

#region Ataque 2: Faixas
water_lanes_active = false;
water_lane_timer = 0;
water_lane_duration = 180;
water_lane_pattern = 0;
#endregion

#region Ataque 3: Peixes
fish_spawned = false;
correct_fish_id = -1;
#endregion

#region Morte Cinemática
death_timer = 0;
death_phase = 0;

death_y_offset = 0;
death_x_shake = 0;
death_alpha = 1;

death_sink_speed = 0;
death_sink_acceleration = 0;

death_flash_alpha = 0;
death_active = false;

death_bubble_timer = 0;
#endregion

#region Hit Reaction (feedback visual quando leva dano)
hit_flash_timer = 0;
hit_flash_max = 8;
#endregion

#region Água no Player
var p = instance_find(obj_player, 0);

if (instance_exists(p))
{
    p.in_water = true;
}
#endregion
