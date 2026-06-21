/// Create Event — obj_pause_menu

depth = -9997;

instance_deactivate_all(true);

// ==========================================
// 2 telas: 0 = menu principal, 1 = opções
// ==========================================
screen = 0;

// Opções do menu PRINCIPAL
main_options = [
    { name: "CONTINUAR" },
    { name: "OPÇÕES" },
    { name: "VOLTAR AO MENU" },
    { name: "SAIR DO JOGO" }
];

// Opções da SUB-TELA de opções
sub_options = [
    { name: "TELA CHEIA",  type: "toggle" },
    { name: "VOLUME",      type: "slider" },
    { name: "VOLTAR",      type: "action" }
];

selected_index = 0;

nav_cooldown = 0;
hover_pulse = 0;

alpha = 0;
alpha_target = 0.95;

mouse_last_y = device_mouse_y_to_gui(0);

input_lock = 5;

// Helper pra pegar lista atual
function get_options()
{
    return (screen == 0) ? main_options : sub_options;
}
