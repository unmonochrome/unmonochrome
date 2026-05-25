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

#region Target Room
if (variable_global_exists("loading_target_room"))
{
    target_room = global.loading_target_room;
}
else
{
    target_room = rm_menu;
}

min_time = 120;
timer = 0;

dots = "";
dot_timer = 0;
#endregion

#region LOADING INTELIGENTE (baseado na room alvo)

resources_to_load = [];

// ==========================================
// SPRITES POR ROOM (carrega só o necessário)
// ==========================================

if (target_room == rm_game)
{
    // FASE 1 — player + inimigos + cenário
    var sprites_fase1 = [
        // Player
        spr_player_idle, spr_player_run, spr_player_jump, spr_player_attack1,
        // Inimigos
        spr_olhinho, spr_olhinho_ataque, spr_olhinho_mask,
    ];
    
    for (var i = 0; i < array_length(sprites_fase1); i++)
    {
        array_push(resources_to_load, [0, sprites_fase1[i]]);
    }
}
else if (target_room == rm_boss_olho)
{
    // BOSS DO OLHO — player + boss + mãos
    var sprites_boss_olho = [
        // Player
        spr_player_idle, spr_player_run, spr_player_jump, spr_player_attack1,
        // Boss
        spr_olho, spr_olhofechado, spr_pupilanovo,
        // Mãos
        spr_hand_ground, spr_hand_ground_target, spr_hand_warning,
    ];
    
    for (var i = 0; i < array_length(sprites_boss_olho); i++)
    {
        array_push(resources_to_load, [0, sprites_boss_olho[i]]);
    }
}
else if (target_room == rm_sereia)
{
    // BOSS DA SEREIA — player + boss + ataques
    var sprites_sereia = [
        // Player
        spr_player_idle, spr_player_run, spr_player_jump, spr_player_attack1,
        // Boss
        spr_sereia_idle, spr_sereia_dano, spr_sereia_bravo,
        // Ataques
        spr_boss_bubble, spr_boss_fish,
    ];
    
    for (var i = 0; i < array_length(sprites_sereia); i++)
    {
        array_push(resources_to_load, [0, sprites_sereia[i]]);
    }
}

// ==========================================
// SONS (sempre carrega todos — são pequenos)
// ==========================================
var all_sounds = asset_get_ids(asset_sound);

for (var i = 0; i < array_length_1d(all_sounds); i++)
{
    array_push(resources_to_load, [1, all_sounds[i]]);
}

// ==========================================
// FONTES
// ==========================================
var all_fonts = asset_get_ids(asset_font);

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

loads_per_step = 2; // 2 por frame pra não estourar VRAM de uma vez

#endregion

#region Camera + Letterbox
cam_w = 1600;
cam_h = 900;

cam = camera_create_view(0, 0, cam_w, cam_h, 0, noone, 0, 0, 0, 0);
view_set_camera(0, cam);

view_enabled = true;
view_visible[0] = true;

view_wview[0] = cam_w;
view_hview[0] = cam_h;

view_wport[0] = window_get_width();
view_hport[0] = window_get_height();
view_xport[0] = 0;
view_yport[0] = 0;

display_set_gui_size(cam_w, cam_h);

application_surface_draw_enable(false);
#endregion
