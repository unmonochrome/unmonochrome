/// Create Event — obj_loading_daltonismo

#region Informações sobre Daltonismo
daltonismo_facts = [
    "Daltonismo afeta cerca de 8% dos homens e 0.5% das mulheres.",
    "Existem diferentes tipos de daltonismo: Protanopia, Deuteranopia e Tritanopia.",
    "Pessoas com Protanopia têm dificuldade em distinguir vermelho e verde.",
    "Deuteranopia é o tipo mais comum de daltonismo.",
    "Tritanopia afeta a percepção de azul e amarelo.",
    "John Dalton foi o primeiro cientista a estudar o daltonismo em 1794.",
    "Acromatopsia é a forma mais rara: ver apenas em tons de cinza.",
    "Não existe cura para o daltonismo, mas existem óculos especiais que ajudam.",
    "Daltonismo é geralmente hereditário e ligado ao cromossomo X.",
    "Pessoas daltônicas podem ter carreiras normais na maioria das profissões.",
    "Algumas pessoas com daltonismo conseguem ver nuances que outras não veem.",
    "Testes de Ishihara são a forma mais comum de diagnosticar daltonismo."
];

current_fact_index = irandom(array_length_1d(daltonismo_facts) - 1);
current_fact = daltonismo_facts[current_fact_index];

fact_change_timer = 0;
fact_change_interval = 180;
fact_alpha = 0;
fact_fade_in = true;
#endregion

#region Loading Automático (TODOS os assets do jogo)

// ==========================================
// PEGA TUDO: SPRITES + SONS + FONTES
// ==========================================
var all_sprites = asset_get_ids(asset_sprite);
var all_sounds  = asset_get_ids(asset_sound);
var all_fonts   = asset_get_ids(asset_font);

resources_to_load = [];

// Sprites
for (var i = 0; i < array_length_1d(all_sprites); i++)
{
    array_push(resources_to_load, [0, all_sprites[i]]);
}

// Sons
for (var i = 0; i < array_length_1d(all_sounds); i++)
{
    array_push(resources_to_load, [1, all_sounds[i]]);
}

// Fontes
for (var i = 0; i < array_length_1d(all_fonts); i++)
{
    array_push(resources_to_load, [2, all_fonts[i]]);
}

total_resources = array_length_1d(resources_to_load);
loaded_resources = 0;

real_progress = 0;
visual_progress = 0;
progress_speed_base = 2;
progress_variation = 0;
variation_timer = 0;

// Quantos recursos processar POR FRAME (pra não travar tudo)
loads_per_step = 4;
#endregion

#region Target Room
if (variable_global_exists("loading_target_room"))
{
    target_room = global.loading_target_room;
}
else
{
    target_room = rm_menu;
}

min_time = 60;
timer = 0;

dots = "";
dot_timer = 0;
#endregion

#region Camera
cam_w = 1600;
cam_h = 900;

display_set_gui_size(cam_w, cam_h);

cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_enabled = true;
view_visible[0] = true;
view_set_camera(0, cam);
#endregion
