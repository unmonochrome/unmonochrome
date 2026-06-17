/// Step Event — obj_boss_healthbar

// ==========================================
// PROCURA O BOSS ATIVO NA ROOM
// ==========================================
if (!instance_exists(boss_ref))
{
    boss_ref = noone;
    
    // Tenta achar boss do olho
    if (instance_exists(obj_boss_eye))
    {
        boss_ref = instance_find(obj_boss_eye, 0);
        boss_name = "Gasppar";
    }
    // Tenta achar boss sereia
    else if (instance_exists(obj_boss_sereia))
    {
        boss_ref = instance_find(obj_boss_sereia, 0);
        boss_name = "Japulia";
    }
}

// ==========================================
// VISIBILIDADE (fade in/out)
// ==========================================
if (instance_exists(boss_ref))
{
    // Esconde durante cutscene de spawn (state 99) e morte (state 3 olho / state 98 sereia)
    var is_spawning = false;
    var is_dying = false;
    
    if (boss_ref.object_index == obj_boss_eye)
    {
        is_spawning = (boss_ref.state == 99);
        is_dying    = (boss_ref.state == 3);
    }
    else if (boss_ref.object_index == obj_boss_sereia)
    {
        is_spawning = (boss_ref.state == 99);
        is_dying    = (boss_ref.state == 98);
    }
    
    if (is_spawning || is_dying)
    {
        alpha_target = 0;
    }
    else
    {
        alpha_target = 1;
    }
}
else
{
    alpha_target = 0;
}

// Fade suave
alpha = lerp(alpha, alpha_target, 0.1);

// ==========================================
// HP REAL → HP MOSTRADO (smooth)
// ==========================================
if (instance_exists(boss_ref))
{
    var real_hp = boss_ref.hp / boss_ref.max_hp;
    real_hp = clamp(real_hp, 0, 1);
    
    // Barra principal: segue rápido
    displayed_hp = lerp(displayed_hp, real_hp, 0.25);
    
    // Ghost bar: segue devagar (mostra dano recente)
    if (ghost_hp > displayed_hp)
    {
        ghost_hp = lerp(ghost_hp, displayed_hp, 0.05);
    }
    else
    {
        ghost_hp = displayed_hp; // se a ghost passou, alinha
    }
}

// ==========================================
// PULSAÇÃO QUANDO HP BAIXO
// ==========================================
pulse_timer += 0.15;
