/// Script: settings

// ==========================================
// HELPER — garante que TODAS as globais existem (chama em qualquer Create)
// ==========================================
function ensure_settings_defaults()
{
    if (!variable_global_exists("available_resolutions"))
    {
        global.available_resolutions = [
            [1280, 720],
            [1600, 900],
            [1920, 1080],
            [2560, 1440]
        ];
    }
    
    if (!variable_global_exists("fullscreen"))        global.fullscreen = false;
    if (!variable_global_exists("resolution_index"))  global.resolution_index = 1;
    if (!variable_global_exists("volume_master"))     global.volume_master = 1.0;
    if (!variable_global_exists("volume_music"))      global.volume_music = 0.7;
    if (!variable_global_exists("volume_sfx"))        global.volume_sfx = 1.0;
    
    if (!variable_global_exists("key_left"))    global.key_left   = vk_left;
    if (!variable_global_exists("key_right"))   global.key_right  = vk_right;
    if (!variable_global_exists("key_up"))      global.key_up     = vk_up;
    if (!variable_global_exists("key_down"))    global.key_down   = vk_down;
    if (!variable_global_exists("key_jump"))    global.key_jump   = vk_space;
    if (!variable_global_exists("key_attack"))  global.key_attack = ord("X");
    if (!variable_global_exists("key_run"))     global.key_run    = vk_shift;
}

function settings_init()
{
    ensure_settings_defaults();
    settings_load();
    settings_apply();
}

function settings_save()
{
    ensure_settings_defaults();
    
    ini_open("config.ini");
    
    ini_write_real("Display", "fullscreen", global.fullscreen ? 1 : 0);
    ini_write_real("Display", "resolution_index", global.resolution_index);
    
    ini_write_real("Audio", "master", global.volume_master);
    ini_write_real("Audio", "music", global.volume_music);
    ini_write_real("Audio", "sfx", global.volume_sfx);
    
    ini_write_real("Controls", "left",   global.key_left);
    ini_write_real("Controls", "right",  global.key_right);
    ini_write_real("Controls", "up",     global.key_up);
    ini_write_real("Controls", "down",   global.key_down);
    ini_write_real("Controls", "jump",   global.key_jump);
    ini_write_real("Controls", "attack", global.key_attack);
    ini_write_real("Controls", "run",    global.key_run);
    
    ini_close();
}

function settings_load()
{
    ensure_settings_defaults();
    
    if (!file_exists("config.ini")) exit;
    
    ini_open("config.ini");
    
    global.fullscreen = (ini_read_real("Display", "fullscreen", 0) == 1);
    global.resolution_index = ini_read_real("Display", "resolution_index", 1);
    
    global.volume_master = ini_read_real("Audio", "master", 1.0);
    global.volume_music  = ini_read_real("Audio", "music",  0.7);
    global.volume_sfx    = ini_read_real("Audio", "sfx",    1.0);
    
    global.key_left   = ini_read_real("Controls", "left",   vk_left);
    global.key_right  = ini_read_real("Controls", "right",  vk_right);
    global.key_up     = ini_read_real("Controls", "up",     vk_up);
    global.key_down   = ini_read_real("Controls", "down",   vk_down);
    global.key_jump   = ini_read_real("Controls", "jump",   vk_space);
    global.key_attack = ini_read_real("Controls", "attack", ord("X"));
    global.key_run    = ini_read_real("Controls", "run",    vk_shift);
    
    ini_close();
    
    global.resolution_index = clamp(global.resolution_index, 0, array_length(global.available_resolutions) - 1);
    global.volume_master = clamp(global.volume_master, 0, 1);
    global.volume_music  = clamp(global.volume_music,  0, 1);
    global.volume_sfx    = clamp(global.volume_sfx,    0, 1);
}

function settings_apply()
{
    ensure_settings_defaults();
    
    var res = global.available_resolutions[global.resolution_index];
    var rw = res[0];
    var rh = res[1];
    
    if (!global.fullscreen)
    {
        if (window_get_fullscreen())
            window_set_fullscreen(false);
        
        var dw = display_get_width();
        var dh = display_get_height();
        
        var final_w = min(rw, dw);
        var final_h = min(rh, dh);
        
        var pos_x = (dw - final_w) / 2;
        var pos_y = (dh - final_h) / 2;
        
        window_set_rectangle(pos_x, pos_y, final_w, final_h);
    }
    else
    {
        window_set_fullscreen(true);
    }
    
    audio_master_gain(global.volume_master);
    
    if (audio_is_playing(snd_menu))
        audio_sound_gain(snd_menu, global.volume_music * global.volume_master, 0);
}

function settings_get_resolution_string()
{
    var res = global.available_resolutions[global.resolution_index];
    return string(res[0]) + " x " + string(res[1]);
}

function key_to_string(key)
{
    switch (key)
    {
        case vk_left:    return "<";
        case vk_right:   return ">";
        case vk_up:      return "^";
        case vk_down:    return "v";
        case vk_space:   return "ESPACO";
        case vk_shift:   return "SHIFT";
        case vk_control: return "CTRL";
        case vk_alt:     return "ALT";
        case vk_enter:   return "ENTER";
        case vk_escape:  return "ESC";
        case vk_tab:     return "TAB";
        case vk_backspace: return "BACKSP";
        default:
            if (key >= ord("A") && key <= ord("Z"))
                return chr(key);
            if (key >= ord("0") && key <= ord("9"))
                return chr(key);
            if (key >= vk_f1 && key <= vk_f12)
                return "F" + string(key - vk_f1 + 1);
            return "?";
    }
}
