#region Setup

spr_idle = spr_eye_idle;
spr_open = spr_eye_open;

enum BossEyeState
{
    IDLE,
    SUMMON,
    VULNERABLE,
    DEAD
}

state = BossEyeState.IDLE;
state_timer = 0;

hp = 10;
invulnerable = true;

base_y = y;
float_seed = random(1000);
float_amp = 6;
float_spd = 0.05;

damage_cooldown = 0;

#endregion