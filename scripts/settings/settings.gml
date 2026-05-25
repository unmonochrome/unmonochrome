/// Script: settings
/// Funções globais pra carregar, salvar e aplicar configurações

// ==========================================
// INICIALIZAR (chama uma vez no início do jogo)
// ==========================================
function settings_init()
{
    // Resoluções disponíveis (sempre 16:9)
    global.available_resolutions = [
        [1280, 720],
        [1600, 900],
        [1920, 1080],
        [2560, 1440]
    ];
    
    // Valores padrão
    global.fullscreen = false;
    global.resolution_index = 1; // 1600x900 padrão
    global.volume_master = 1.0;
    global.volume_music = 0.7;
    global.volume_sfx = 1.0;
    
    // Carrega config salva (se existir)
    settings_load();
    
    // Aplica
    settings_apply();
}

// ==========================================
// SALVAR
// ==========================================
function settings_save()
{
    ini_open("config.ini");
    
    ini_write_real("Display", "fullscreen", global.fullscreen ? 1 : 0);
    ini_write_real("Display", "resolution_index", global.resolution_index);
    
    ini_write_real("Audio", "master", global.volume_master);
    ini_write_real("Audio", "music", global.volume_music);
    ini_write_real("Audio", "sfx", global.volume_sfx);
    
    ini_close();
}

// ==========================================
// CARREGAR
// ==========================================
function settings_load()
{
    if (!file_exists("config.ini")) exit;
    
    ini_open("config.ini");
    
    global.fullscreen = (ini_read_real("Display", "fullscreen", 0) == 1);
    global.resolution_index = ini_read_real("Display", "resolution_index", 1);
    
    global.volume_master = ini_read_real("Audio", "master", 1.0);
    global.volume_music  = ini_read_real("Audio", "music",  0.7);
    global.volume_sfx    = ini_read_real("Audio", "sfx",    1.0);
    
    ini_close();
    
    global.resolution_index = clamp(
        global.resolution_index,
        0,
        array_length(global.available_resolutions) - 1
    );
    
    global.volume_master = clamp(global.volume_master, 0, 1);
    global.volume_music  = clamp(global.volume_music,  0, 1);
    global.volume_sfx    = clamp(global.volume_sfx,    0, 1);
}

// ==========================================
// APLICAR
// ==========================================
function settings_apply()
{
    var res = global.available_resolutions[global.resolution_index];
    var rw = res[0];
    var rh = res[1];
    
    if (!global.fullscreen)
    {
        // Sai de fullscreen primeiro (se tava)
        if (window_get_fullscreen())
        {
            window_set_fullscreen(false);
        }
        
        // Pega tamanho da tela real (sem barra de tarefas)
        var dw = display_get_width();
        var dh = display_get_height();
        
        // Limita resolução pra não passar do tamanho do monitor
        var final_w = min(rw, dw);
        var final_h = min(rh, dh);
        
        // Calcula posição centralizada
        var pos_x = (dw - final_w) / 2;
        var pos_y = (dh - final_h) / 2;
        
        // ATOMICO: define posição E tamanho de uma vez
        window_set_rectangle(pos_x, pos_y, final_w, final_h);
    }
    else
    {
        window_set_fullscreen(true);
    }
    
    // Volume geral
    audio_master_gain(global.volume_master);
    
    // Música do menu (se tiver tocando)
    if (audio_is_playing(snd_menu))
    {
        audio_sound_gain(snd_menu, global.volume_music * global.volume_master, 0);
    }
}

// ==========================================
// HELPERS
// ==========================================
function settings_get_resolution_string()
{
    var res = global.available_resolutions[global.resolution_index];
    return string(res[0]) + " x " + string(res[1]);
}
