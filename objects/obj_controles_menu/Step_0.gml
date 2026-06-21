/// Step Event — obj_controles_menu

hover_pulse += 0.08;
if (nav_cooldown > 0) nav_cooldown--;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// MODO BIND
if (binding_index >= 0)
{
    binding_timer++;
    
    if (binding_timer >= binding_timeout)
    {
        binding_index = -1;
        binding_timer = 0;
        exit;
    }
    
    if (keyboard_check_pressed(vk_anykey))
    {
        var pressed = keyboard_key;
        
        if (pressed == vk_escape)
        {
            binding_index = -1;
            binding_timer = 0;
            exit;
        }
        
        var ctrl = controles[binding_index];
        variable_global_set(ctrl.control_key, pressed);
        
        settings_save();
        binding_index = -1;
        binding_timer = 0;
    }
    exit;
}

// MOUSE
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var mouse_moved = (my != mouse_last_y);
mouse_last_y = my;

var start_y = 220;
var spacing = 60;

if (mouse_moved)
{
    for (var i = 0; i < total_options; i++)
    {
        var oy = start_y + i * spacing;
        if (my > oy - spacing/2 && my < oy + spacing/2 && mx > gw/2 - 400 && mx < gw/2 + 400)
        {
            selected_index = i;
            break;
        }
    }
}

if (mouse_check_button_pressed(mb_left))
    confirm_controles();

// TECLADO
var key_up    = keyboard_check_pressed(vk_up);
var key_down  = keyboard_check_pressed(vk_down);
var key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var key_back = keyboard_check_pressed(vk_escape);

if (gamepad_is_connected(0))
{
    var gp_up    = gamepad_button_check_pressed(0, gp_padu);
    var gp_down  = gamepad_button_check_pressed(0, gp_padd);
    var gp_confirm = gamepad_button_check_pressed(0, gp_face1);
    var gp_back = gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start);
    
    key_up = key_up || gp_up;
    key_down = key_down || gp_down;
    key_confirm = key_confirm || gp_confirm;
    key_back = key_back || gp_back;
}

if (key_up)
{
    selected_index--;
    if (selected_index < 0) selected_index = total_options - 1;
}

if (key_down)
{
    selected_index++;
    if (selected_index >= total_options) selected_index = 0;
}

if (key_confirm) confirm_controles();
if (key_back) close_controles_menu();

// ==========================================
// FUNÇÕES — declaradas com 'function' tradicional no escopo do objeto
// ==========================================
function confirm_controles()
{
    var n_ctrls = array_length(controles);
    
    if (selected_index < n_ctrls)
    {
        binding_index = selected_index;
        binding_timer = 0;
    }
    else
    {
        var acao_index = selected_index - n_ctrls;
        var acao = acoes[acao_index];
        
        if (acao.name == "RESETAR PADRÃO")
        {
            global.key_left   = vk_left;
            global.key_right  = vk_right;
            global.key_up     = vk_up;
            global.key_down   = vk_down;
            global.key_jump   = vk_space;
            global.key_attack = ord("X");
            global.key_run    = vk_shift;
            settings_save();
        }
        else if (acao.name == "VOLTAR")
        {
            close_controles_menu();
        }
    }
}

function close_controles_menu()
{
    if (from_pause)
    {
        var opc = instance_create_depth(0, 0, -9996, obj_opcoes_menu);
        opc.from_pause = true;
        instance_destroy();
    }
    else
    {
        room_goto(rm_opcoes);
    }
}
