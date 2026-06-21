/// Step Event — obj_loading_daltonismo

timer++;

// ==========================================
// CARREGAMENTO REAL (com try-safe — não crasha)
// ==========================================
var processed = 0;

while (loaded_resources < array_length(resources_to_load) && processed < loads_per_step)
{
    var res = resources_to_load[loaded_resources];
    var res_type = res[0];
    var res_id = res[1];
    
    // Cada carregamento é "protegido" — se der erro num, pula pro próximo
    try
    {
        if (res_type == 0 && sprite_exists(res_id))
        {
            sprite_prefetch(res_id);
        }
        else if (res_type == 1 && audio_exists(res_id))
        {
            var s = audio_play_sound(res_id, 0, false);
            audio_sound_gain(s, 0, 0);
            audio_stop_sound(s);
        }
        else if (res_type == 2 && font_exists(res_id))
        {
            var _w = string_width_ext("a", -1, 100);
        }
    }
    catch (e)
    {
        // Se der erro, ignora e continua (não trava o loading)
    }
    
    loaded_resources++;
    processed++;
}

real_progress = (loaded_resources / total_resources) * 100;
real_progress = clamp(real_progress, 0, 100);

// ==========================================
// PROGRESSO VISUAL NATURAL
// ==========================================
variation_timer++;
if (variation_timer >= 10)
{
    variation_timer = 0;
    progress_variation = random_range(-1, 3);
}

if (visual_progress < real_progress - 10)
    progress_variation = random_range(3, 6);

if (visual_progress > real_progress)
{
    visual_progress = real_progress;
    progress_variation = 0;
}

var current_speed = progress_speed_base + progress_variation;

if (visual_progress < 100)
{
    visual_progress += current_speed;
    if (visual_progress > 85) visual_progress += random_range(-0.5, 0.8);
    visual_progress = min(visual_progress, real_progress);
}

// ==========================================
// PONTINHOS
// ==========================================
dot_timer++;
if (dot_timer >= 20)
{
    dot_timer = 0;
    
    if (dots == "") dots = ".";
    else if (dots == ".") dots = "..";
    else if (dots == "..") dots = "...";
    else dots = "";
}

// ==========================================
// FATO FADE IN/OUT
// ==========================================
fact_change_timer++;

if (fact_fade_in)
{
    fact_alpha += 0.03;
    if (fact_alpha >= 1) { fact_alpha = 1; fact_fade_in = false; }
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

// ==========================================
// IR PRA PRÓXIMA ROOM (quando termina)
// ==========================================
if (real_progress >= 100 && visual_progress >= 99 && timer >= min_time)
{
    if (room_exists(target_room))
        room_goto(target_room);
    else
        room_goto(rm_menu); // fallback caso a room não exista
}
