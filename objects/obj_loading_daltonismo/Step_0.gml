/// Step Event — obj_loading_daltonismo

timer++;

#region Carregamento Real (vários por frame, sem travar)
var processed = 0;

while (loaded_resources < total_resources && processed < loads_per_step)
{
    var res = resources_to_load[loaded_resources];
    var res_type = res[0];
    var res_id = res[1];
    
    // Tipo 0 = Sprite
    if (res_type == 0 && sprite_exists(res_id))
    {
        sprite_prefetch(res_id);
    }
    // Tipo 1 = Som (só "toca" e silencia pra forçar carregamento)
    else if (res_type == 1 && audio_exists(res_id))
    {
        // Trick: cria uma instância silenciosa pra forçar load
        var s = audio_play_sound(res_id, 0, false);
        audio_sound_gain(s, 0, 0);
        audio_stop_sound(s);
    }
    // Tipo 2 = Fonte (já carrega só de referenciar)
    else if (res_type == 2 && font_exists(res_id))
    {
        // Forçar uso pra carregar
        var _w = string_width_ext("a", -1, 100);
    }
    
    loaded_resources++;
    processed++;
}

real_progress = (loaded_resources / total_resources) * 100;
#endregion

#region Progresso Visual (Aleatório e Natural)
variation_timer++;
if (variation_timer >= 10)
{
    variation_timer = 0;
    progress_variation = random_range(-1, 3);
}

if (visual_progress < real_progress - 10)
{
    progress_variation = random_range(3, 6);
}

if (visual_progress > real_progress)
{
    visual_progress = real_progress;
    progress_variation = 0;
}

var current_speed = progress_speed_base + progress_variation;

if (visual_progress < 100)
{
    visual_progress += current_speed;
    
    if (visual_progress > 85)
    {
        visual_progress += random_range(-0.5, 0.8);
    }
    
    visual_progress = min(visual_progress, real_progress);
}
#endregion

#region Animação dos Pontinhos
dot_timer++;
if (dot_timer >= 20)
{
    dot_timer = 0;
    
    if (dots == "") dots = ".";
    else if (dots == ".") dots = "..";
    else if (dots == "..") dots = "...";
    else dots = "";
}
#endregion

#region Troca de Fato (Fade In/Out)
fact_change_timer++;

if (fact_fade_in)
{
    fact_alpha += 0.03;
    
    if (fact_alpha >= 1)
    {
        fact_alpha = 1;
        fact_fade_in = false;
    }
}
else
{
    if (fact_change_timer >= fact_change_interval)
    {
        fact_alpha -= 0.03;
        
        if (fact_alpha <= 0)
        {
            fact_alpha = 0;
            
            var old_index = current_fact_index;
            
            do {
                current_fact_index = irandom(array_length_1d(daltonismo_facts) - 1);
            } until (current_fact_index != old_index || array_length_1d(daltonismo_facts) == 1);
            
            current_fact = daltonismo_facts[current_fact_index];
            
            fact_change_timer = 0;
            fact_fade_in = true;
        }
    }
}
#endregion

#region Ir pra Próxima Room
if (real_progress >= 100 && visual_progress >= 99 && timer >= min_time)
{
    room_goto(target_room);
}
#endregion
