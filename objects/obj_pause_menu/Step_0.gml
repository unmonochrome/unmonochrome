/// Step Event — obj_pause_menu

hover_pulse += 0.08;
if (nav_cooldown > 0) nav_cooldown--;
if (input_lock > 0) { input_lock--; exit; }

alpha = lerp(alpha, alpha_target, 0.15);

var gw = display_get_gui_width();
var gh = display_get_gui_height();

var opts = get_options();
var total = array_length(opts);

// MOUSE
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var mouse_moved = (my != mouse_last_y);
mouse_last_y = my;

var start_y = gh / 2 - (total * 70) / 2 + 50;
var spacing = 70;

if (mouse_moved)
{
    for (var i = 0; i < total; i++)
    {
        var oy = start_y + i * spacing;
        if (my > oy - 30 && my < oy + 30 && mx > gw/2 - 350 && mx < gw/2 + 350)
        {
            selected_index = i;
            break;
        }
    }
}

if (mouse_check_button_pressed(mb_left))
    confirm_option();

// TECLADO
var key_up = keyboard_check_pressed(vk_up);
var key_down = keyboard_check_pressed(vk_down);
var key_left = keyboard_check_pressed(vk_left);
var key_right = keyboard_check_pressed(vk_right);
var key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var key_back = keyboard_check_pressed(vk_escape);

if (gamepad_is_connected(0))
{
    key_up = key_up || gamepad_button_check_pressed(0, gp_padu);
    key_down = key_down || gamepad_button_check_pressed(0, gp_padd);
    key_left = key_left || gamepad_button_check_pressed(0, gp_padl);
    key_right = key_right || gamepad_button_check_pressed(0, gp_padr);
    key_confirm = key_confirm || gamepad_button_check_pressed(0, gp_face1);
    key_back = key_back || gamepad_button_check_pressed(0, gp_start) || gamepad_button_check_pressed(0, gp_face2);
}

// Garante que selected_index tá dentro do range
selected_index = clamp(selected_index, 0, total - 1);

if (key_up)
{
    selected_index--;
    if (selected_index < 0) selected_index = total - 1;
}

if (key_down)
{
    selected_index++;
    if (selected_index >= total) selected_index = 0;
}

// ==========================================
// LEFT/RIGHT — só na tela de opções (toggle/slider)
// ==========================================
if (screen == 1)
{
    var current = opts[selected_index];
    
    if (key_left)
    {
        if (current.type == "toggle")
        {
            global.fullscreen = !global.fullscreen;
            settings_apply();
            settings_save();
        }
        else if (current.type == "slider")
        {
            global.volume_master = max(0, global.volume_master - 0.1);
            settings_apply();
            settings_save();
        }
    }
    
    if (key_right)
    {
        if (current.type == "toggle")
        {
            global.fullscreen = !global.fullscreen;
            settings_apply();
            settings_save();
        }
        else if (current.type == "slider")
        {
            global.volume_master = min(1, global.volume_master + 0.1);
            settings_apply();
            settings_save();
        }
    }
}

if (key_confirm) confirm_option();

if (key_back)
{
    // Na sub-tela, ESC volta pro pause principal
    if (screen == 1)
    {
        screen = 0;
        selected_index = 1; // volta no "OPÇÕES"
    }
    else
    {
        unpause();
    }
}

// ==========================================
// CONFIRMAR
// ==========================================
function confirm_option()
{
    var opts = get_options();
    var opt = opts[selected_index];
    
    if (screen == 0)
    {
        // MENU PRINCIPAL
        switch (opt.name)
        {
            case "CONTINUAR":
                unpause();
            break;
            
            case "OPÇÕES":
                screen = 1;
                selected_index = 0;
            break;
            
            case "VOLTAR AO MENU":
                unpause();
                room_goto(rm_menu);
            break;
            
            case "SAIR DO JOGO":
                game_end();
            break;
        }
    }
    else
    {
        // SUB-TELA OPÇÕES
        switch (opt.name)
        {
            case "TELA CHEIA":
                global.fullscreen = !global.fullscreen;
                settings_apply();
                settings_save();
            break;
            
            case "VOLUME":
                // slider — não faz nada com enter
            break;
            
            case "VOLTAR":
                screen = 0;
                selected_index = 1;
            break;
        }
    }
}

function unpause()
{
    instance_activate_all();
    instance_destroy();
}
