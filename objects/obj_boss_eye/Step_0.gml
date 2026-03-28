#region Timers
state_timer++;
float_timer += float_spd;
#endregion

#region Progressão dinâmica conforme HP
var hp_ratio = 1 - (hp / max_hp); // 0 = full hp, 1 = morto

// número de mãos aumenta até 7
hand_count = min(3 + floor(hp_ratio*4), max_hands);

// flutuação ciclônica mais intensa com HP baixo
var cyclo_x = 30 + 50*hp_ratio;
var cyclo_y = 15 + 25*hp_ratio;
float_spd = 0.02 + 0.05*hp_ratio;

// cooldown agressivo das mãos
hand_spawn_cooldown = max(1, 90 - 60*hp_ratio); // diminui muito com HP baixo
hand_spawn_timer++;
#endregion

#region Seguir player + flutuação ciclônica + distância mínima Y
var p = instance_find(obj_player,0);
if (instance_exists(p))
{
    var follow_speed = 0.08;

    var angle = float_timer*2;
    var circular_x = base_x + cos(angle)*cyclo_x;
    var circular_y = base_y + sin(angle)*cyclo_y;

    // X segue player + ciclônico
    x = lerp(x, p.x, follow_speed) + lerp(0, circular_x - base_x, follow_speed);

    // Y flutua + ciclônico, mantendo distância mínima do player
    var min_y = p.y - 400;
    y = lerp(y, circular_y, follow_speed);
    if (y > min_y) y = min_y;
}
else
{
    var angle = float_timer*2;
    x = lerp(x, base_x + cos(angle)*cyclo_x, 0.08);
    y = lerp(y, base_y + sin(angle)*cyclo_y, 0.08);
}
#endregion

#region Mão errada atingida
if (errada_atingida)
{
    with(obj_boss_hand_ground) instance_destroy();
    with(obj_boss_hand_warning_ground) instance_destroy();
    state = 0;
    state_timer = 0;
    errada_atingida = false;
}
#endregion

#region Boss States
switch(state)
{
    case 0: // olho aberto
        sprite_index = spr_eye_open;
        if (state_timer >= room_speed*2) { state=1; state_timer=0; hands_spawned=false; }
    break;

    case 1: // olho fechado / spawn warnings
        sprite_index = spr_eye_closed;

        if (!hands_spawned && instance_exists(p))
        {
            hands_spawned = true;
            var target_index = irandom(hand_count-1);
            var start_offset = -spacing*(hand_count-1)/2;

            for (var i=0;i<hand_count;i++)
            {
                var offset_x = start_offset + i*spacing;
                var spawn_x = p.x + offset_x;

                var w = instance_create_depth(spawn_x, player_ground_y+40, -15, obj_boss_hand_warning_ground);
                w.spawn_x = spawn_x;
                w.spawn_y = player_ground_y+200;
                w.target_y = player_ground_y+40;
                w.owner = id;
                w.is_target = (i==target_index);

                // mão sobe praticamente instantâneo
                w.speed_up = 1 + 0.5*hp_ratio;
            }
        }

        // cooldown agressivo de reaparecer
        if (hand_spawn_timer >= hand_spawn_cooldown)
        {
            hands_spawned = false;
            hand_spawn_timer = 0;
        }

        state = 2;
        state_timer = 0;
    break;

    case 2: // esperando mãos (não some devagar)
        sprite_index = spr_eye_closed;
        // nada de lerp ou destroy automático → você controla quando desaparecer/animar fumaça
        if (instance_number(obj_boss_hand_ground) <=0 && instance_number(obj_boss_hand_warning_ground)<=0)
        {
            state=0;
            state_timer=0;
        }
    break;

    case 3: // morto
        image_angle = irandom_range(-4,4);
        if (state_timer>=room_speed) instance_destroy();
    break;
}
#endregion

#region Death
if (hp <= 0 && state != 3)
{
    state = 3;
    state_timer = 0;
    with(obj_boss_hand_ground) instance_destroy();
    with(obj_boss_hand_warning_ground) instance_destroy();
}
#endregion