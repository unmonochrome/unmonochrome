timer++;

if (is_target) sprite_index = spr_hand_ground_target;
else sprite_index = spr_hand_ground;

image_xscale=1; image_yscale=1;

switch(state)
{
    case 0: // subindo rápido
        var fast_spd = 0.35;
        y = lerp(y,target_y,fast_spd);
        if (abs(y-target_y)<2) { y=target_y; state=1; timer=0; can_be_hit=true; }
    break;

    case 1: // parada
        if (timer>=life_time) state=2;
    break;

    case 2: // descendo
        y+=8;
        if (y>room_height+200) instance_destroy();
    break;
}

// colisão com hitbox do player
if (can_be_hit)
{
    var attack = collision_rectangle(
        x-sprite_width/2, y-sprite_height/2,
        x+sprite_width/2, y+sprite_height/2,
        obj_player_hitbox,false,true
    );

    if (attack != noone)
    {
        if (is_target)
        {
            // dano no boss
            if (instance_exists(owner)) owner.hp -= 1;
            with(obj_camera) { shake_time=6; shake_strength=4; }
        }
        else
        {
            // mão errada → sinaliza pro boss destruir tudo
            if (instance_exists(owner)) owner.errada_atingida = true;
        }

        instance_destroy(attack);
        instance_destroy(); // destrói essa mão
    }
}