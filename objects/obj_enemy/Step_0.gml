// ========================================
// TIMERS
// ========================================
#region TIMERS
if (hitstun > 0) {
    hitstun--;
}

if (hurt_timer > 0) {
    hurt_timer--;
}

if (invincible > 0) {
    invincible--;
}
#endregion


// ========================================
// MORTE
// ========================================
#region DEATH
if (hp <= 0) {
    instance_destroy();
}
#endregion


// ========================================
// AGGRO
// ========================================
#region AGGRO
// se tomou dano alguma vez, passa a perseguir
if (hp < 3) {
    aggro = true;
}
#endregion


// ========================================
// IA / MOVIMENTO HORIZONTAL
// ========================================
#region AI
var player = instance_nearest(x, y, target);
var move = 0;

if (hitstun <= 0) {

    if (aggro) {
        // persegue o player
        if (instance_exists(player)) {
            var dist = player.x - x;

            if (abs(dist) > 8) {
                move = sign(dist);
            }
        }
    } else {
        // patrulha
        move = facing;

        // checa parede na frente
        var wall_ahead = place_meeting(x + (facing * wall_check), y, obj_solid);

        // checa chão na frente
        var floor_ahead = place_meeting(x + (facing * edge_check), y + 16, obj_solid);

        // se tem parede ou não tem chão, vira
        if (wall_ahead || !floor_ahead) {
            facing *= -1;
            move = facing;
        }
    }
}
#endregion


// ========================================
// FACING
// ========================================
#region FACING
if (hitstun <= 0) {
    if (move != 0) {
        facing = move;
    }
}
#endregion


// ========================================
// HORIZONTAL MOVEMENT
// ========================================
#region HORIZONTAL MOVEMENT
if (hitstun > 0) {
    hspd = knockback_x;

    if (abs(knockback_x) > 0.1) {
        knockback_x *= 0.85;
    } else {
        knockback_x = 0;
    }
}
else {
    hspd = round(move * walkspd);
}
#endregion


// ========================================
// GRAVITY
// ========================================
#region GRAVITY
vspd += grav;
#endregion


// ========================================
// HORIZONTAL COLLISION
// ========================================
#region HORIZONTAL COLLISION
if (place_meeting(x + hspd, y, obj_solid)) {
    while (!place_meeting(x + sign(hspd), y, obj_solid)) {
        x += sign(hspd);
    }

    hspd = 0;
    knockback_x = 0;

    if (hitstun <= 0) {
        facing *= -1;
    }
}
x += hspd;
#endregion


// ========================================
// VERTICAL COLLISION
// ========================================
#region VERTICAL COLLISION
if (place_meeting(x, y + vspd, obj_solid)) {
    while (!place_meeting(x, y + sign(vspd), obj_solid)) {
        y += sign(vspd);
    }

    vspd = 0;
}
y += vspd;
#endregion