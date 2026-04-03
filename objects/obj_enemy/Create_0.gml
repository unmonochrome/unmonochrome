/// Create Event — obj_enemy

#region Movimento
hspd = 0;
vspd = 0;
walkspd = 2;
grav = 0.5;
#endregion

#region Vida
hp = 3;
max_hp = 3;
#endregion

#region Alvo
target = obj_player;
facing = choose(-1, 1);
#endregion

#region Knockback
knockback_x = 0;
hitstun = 0;
hurt_timer = 0;
invincible = 0;
#endregion

#region IA
aggro = false;
aggro_range = 300;
lose_aggro_range = 500;
edge_check = 12;
wall_check = 4;
#endregion

#region Ativação
activated = false;
#endregion

#region Morte
dying = false;
death_timer = 0;
death_timer_max = 20;
death_scale = 1;
death_alpha = 1;
#endregion

#region Visual
image_speed = 0;
#endregion