state_timer++;

// player
var p = instance_find(obj_player,0);
if (!instance_exists(p)) exit;

// HP ratio
var hp_lost = max_hp - hp;
var hp_ratio = hp_lost / max_hp;

// número de mãos
var hand_count = min(3 + hp_lost, 7);

#region CUTSCENE (state 99)
if (state == 99)
{
    // fade in
    fade_alpha = min(1, fade_alpha + fade_speed);

    // descida lenta
    if (y < 1184) y += boss_speed; 
    else y = 1184;

    // countdown depois de pequena pausa
    var countdown_delay = room_speed * 1.5;
    if (state_timer > countdown_delay)
    {
        var countdown = max(0, 3 - floor((state_timer - countdown_delay)/room_speed));
        draw_set_font(fnt_countdown);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(room_width/2, room_height/2, string(countdown));
    }

    // mantém player congelado
    if (instance_exists(p)) p.freeze = true;

    // fim cutscene
    if (state_timer >= room_speed*4.5) // pausa + 3s countdown
    {
        state = 0; // inicia batalha
        state_timer = 0;
        if (instance_exists(p)) p.freeze = false;

        battle_base_x = p.x; // fixa x base para spawn das mãos
        obj_camera.in_cutscene = false;
        obj_camera.cutscene_target = noone;
    }

    exit; // nada mais roda durante cutscene
}
#endregion

#region BATALHA NORMAL
// flutuação horizontal apenas (Y fixo)
float_timer += float_spd;
var cyclo_radius_x_dynamic = 30 + 50*hp_ratio + 100 / obj_camera.zoom_manual;
var ang = float_timer * 2;
var cyc_x = base_x + cos(ang) * cyclo_radius_x_dynamic;

// X segue o player suavemente + flutuação
var follow_speed = 0.08;
x = lerp(x, p.x, follow_speed) + (cyc_x - base_x) * 0.08;

// Y fixo
y = 1184;

// clamp dentro da room
x = clamp(x, sprite_width/2, room_width - sprite_width/2);

// limpa mãos se player errou/acertou
if (wrong_hand_hit || correct_hand_hit)
{
    with(obj_boss_hand_ground) instance_destroy();
    with(obj_boss_hand_warning_ground) instance_destroy();
    state = 0;
    state_timer = 0;
    hands_spawned = false;
    wrong_hand_hit = false;
    correct_hand_hit = false;
}
#endregion

#region ESTADOS DA BATALHA
switch(state)
{
    case 0:
        sprite_index = spr_eye_open;
        if (state_timer >= max(10, room_speed*1.2 - hp_lost*10))
        {
            state = 1;
            state_timer = 0;
            hands_spawned = false;
        }
    break;

    case 1: // === case 1 que você mandou ===
        sprite_index = spr_eye_closed;
        if (!hands_spawned && instance_exists(p))
        {
            hands_spawned = true;
            var target_index = irandom(hand_count-1);
            var start_offset = -300*(hand_count-1)/2;

            for (var i = 0; i < hand_count; i++)
            {
                var offset_x = start_offset + i*300;
                var spawn_x = battle_base_x + offset_x; // usa x fixo

                // spawn warning na posição final da mão (y fixo 1792)
                var w = instance_create_depth(spawn_x, 1792, -15, obj_boss_hand_warning_ground);
                w.spawn_x = spawn_x;              
                w.spawn_y = 1792 + 220; // posição inicial da mão
                w.target_y = 1792;       // posição final da mão
                w.owner = id;
                w.is_target = (i == target_index);
                w.warning_time = max(8, 45 - hp_lost*4);
                w.hand_speed = 0.35 + hp_ratio*0.45;
            }
        }
        state = 2;
        state_timer = 0;
    break;

    case 2:
        sprite_index = spr_eye_closed;
        if (instance_number(obj_boss_hand_ground) <= 0 && instance_number(obj_boss_hand_warning_ground) <= 0)
        {
            state = 0;
            state_timer = 0;
            hands_spawned = false;
        }
    break;

    case 3:
        image_angle = irandom_range(-4,4);
        if (state_timer >= room_speed)
            instance_destroy();
    break;
}
#endregion

#region MORTE
if (hp <= 0 && state != 3)
{
    state = 3;
    state_timer = 0;
    with(obj_boss_hand_ground) instance_destroy();
    with(obj_boss_hand_warning_ground) instance_destroy();
}
#endregion

#region DRAW FADE
if (fade_alpha > 0)
{
    draw_set_alpha(fade_alpha);
    draw_rectangle(0,0,room_width,room_height,false);
    draw_set_alpha(1);
}
#endregion