/// Create Event — obj_controles_menu

if (!variable_instance_exists(id, "from_pause"))
    from_pause = false;

depth = -9995;

controles = [
    { name: "ESQUERDA", control_key: "key_left" },
    { name: "DIREITA",  control_key: "key_right" },
    { name: "CIMA",     control_key: "key_up" },
    { name: "BAIXO",    control_key: "key_down" },
    { name: "PULAR",    control_key: "key_jump" },
    { name: "ATACAR",   control_key: "key_attack" },
    { name: "CORRER",   control_key: "key_run" },
];

acoes = [
    { name: "RESETAR PADRÃO" },
    { name: "VOLTAR" }
];

selected_index = 0;
total_options = array_length(controles) + array_length(acoes);

nav_cooldown = 0;
nav_cooldown_max = 8;
hover_pulse = 0;

binding_index = -1;
binding_timer = 0;
binding_timeout = 5 * 60;

mouse_last_y = device_mouse_y_to_gui(0);
