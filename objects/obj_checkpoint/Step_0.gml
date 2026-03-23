// ========================================
// ANIMAÇÃO LEVE
// ========================================
#region ANIMATION
pulse += 0.08;
bob += 0.05;
#endregion


// ========================================
// ATIVAÇÃO PELO PLAYER
// ========================================
#region ACTIVATION
if (place_meeting(x, y, obj_player)) {

    // desativa todos os outros checkpoints
    with (obj_checkpoint) {
        active = false;
    }

    // ativa este
    active = true;

    // salva respawn global
    global.spawn_x = x;
    global.spawn_y = y;
}
#endregion


// ========================================
// SPRITE / ESTADO
// ========================================
#region VISUAL STATE
if (active) {
    sprite_index = spr_checkpoint_on;
} else {
    sprite_index = spr_checkpoint_off;
}
#endregion