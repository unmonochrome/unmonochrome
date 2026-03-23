#region Timers

state_timer++;

if (damage_cooldown > 0) damage_cooldown--;

#endregion


#region Sprite

if (invulnerable)
{
    sprite_index = spr_idle;
}
else
{
    sprite_index = spr_open;
}

#endregion


#region Float

y = base_y + sin((current_time * 0.001 * 60 * float_spd) + float_seed) * float_amp;

#endregion


#region States

switch (state)
{
    case BossEyeState.IDLE:

        if (state_timer >= room_speed)
        {
            state = BossEyeState.SUMMON;
            state_timer = 0;
        }

    break;

    case BossEyeState.SUMMON:

        if (state_timer == 1)
        {
            for (var i = 0; i < 2; i++)
            {
                var spawn_x = choose(220, 420, 620, 820, 1020);

                var hand = instance_create_layer(spawn_x, room_height + 100, layer, obj_boss_mao);
                hand.target_y = room_height - 150;
            }
        }

        if (state_timer >= room_speed * 2)
        {
            state = BossEyeState.VULNERABLE;
            state_timer = 0;
            invulnerable = false;
        }

    break;

    case BossEyeState.VULNERABLE:

        if (state_timer >= room_speed * 2)
        {
            invulnerable = true;
            state = BossEyeState.IDLE;
            state_timer = 0;
        }

    break;

    case BossEyeState.DEAD:

        image_angle = irandom_range(-4, 4);

        if (state_timer >= room_speed)
        {
            instance_destroy();
        }

    break;
}

#endregion


#region Death Check

if (hp <= 0 && state != BossEyeState.DEAD)
{
    state = BossEyeState.DEAD;
    state_timer = 0;
    invulnerable = true;
}

#endregion