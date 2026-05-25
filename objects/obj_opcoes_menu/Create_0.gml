/// Create Event — obj_opcoes_menu

// ==========================================
// ESTRUTURA DAS OPÇÕES
// ==========================================
// Cada opção tem: { nome, tipo, ação }
// tipos: "toggle" (liga/desliga), "list" (escolhe da lista), "slider" (0-1), "action" (executa função)

options = [
    {
        name: "TELA CHEIA ",
        type: "toggle",
        get_value: function() { return global.fullscreen ? "LIGADO" : "DESLIGADO"; },
        action_left:  function() { global.fullscreen = !global.fullscreen; settings_apply(); settings_save(); },
        action_right: function() { global.fullscreen = !global.fullscreen; settings_apply(); settings_save(); }
    },
    {
        name: "RESOLUÇÃO",
        type: "list",
        get_value: function() { return settings_get_resolution_string(); },
        action_left:  function() {
            global.resolution_index--;
            if (global.resolution_index < 0)
                global.resolution_index = array_length(global.available_resolutions) - 1;
            settings_apply();
            settings_save();
        },
        action_right: function() {
            global.resolution_index++;
            if (global.resolution_index >= array_length(global.available_resolutions))
                global.resolution_index = 0;
            settings_apply();
            settings_save();
        }
    },
    {
        name: "VOLUME GERAL",
        type: "slider",
        get_value: function() { return string(round(global.volume_master * 100)) + "%"; },
        action_left:  function() {
            global.volume_master = max(0, global.volume_master - 0.1);
            settings_apply();
            settings_save();
        },
        action_right: function() {
            global.volume_master = min(1, global.volume_master + 0.1);
            settings_apply();
            settings_save();
        }
    },
    {
        name: "VOLUME MÚSICA",
        type: "slider",
        get_value: function() { return string(round(global.volume_music * 100)) + "%"; },
        action_left:  function() {
            global.volume_music = max(0, global.volume_music - 0.1);
            settings_apply();
            settings_save();
        },
        action_right: function() {
            global.volume_music = min(1, global.volume_music + 0.1);
            settings_apply();
            settings_save();
        }
    },
    {
        name: "VOLUME EFEITOS",
        type: "slider",
        get_value: function() { return string(round(global.volume_sfx * 100)) + "%"; },
        action_left:  function() {
            global.volume_sfx = max(0, global.volume_sfx - 0.1);
            settings_apply();
            settings_save();
        },
        action_right: function() {
            global.volume_sfx = min(1, global.volume_sfx + 0.1);
            settings_apply();
            settings_save();
        }
    },
    {
        name: "VOLTAR",
        type: "action",
        get_value: function() { return ""; },
        action_confirm: function() {
            room_goto(rm_menu);
        }
    }
];

selected_index = 0;
total_options = array_length(options);

// Cooldown pra navegação (evita scroll super rápido com analógico)
nav_cooldown = 0;
nav_cooldown_max = 8;

// Animação visual
selector_y = 0;
selector_y_target = 0;
hover_pulse = 0;
