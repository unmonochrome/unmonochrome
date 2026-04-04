// define sprite
sprite_index = is_target ? spr_hand_ground_target : spr_hand_ground;

// subida da mão
if (state == 0)
{
    y = lerp(y, target_y, hand_speed);
    if (abs(y - target_y) < 2)
    {
        y = target_y;
        state = 1;
        timer = 0;
        can_be_hit = true;
    }
}
else if (state == 1)
{
    timer++;
    if (timer >= stay_time)
        instance_destroy();
}

// colisão com hitbox do player
var atk = instance_place(x, y, obj_player_hitbox);
if (atk != noone && can_be_hit)
{
    if (instance_exists(owner))
    {
        if (is_target)
        {
            owner.hp -= 1;
            owner.correct_hand_hit = true;
        }
        else
        {
            owner.wrong_hand_hit = true;
        }
    }

    instance_destroy(atk);
    instance_destroy();
}
