/// Step Event — obj_selecao

#region INPUT — TECLADO + CONTROLE

// Teclado
var key_up    = keyboard_check_pressed(vk_up);
var key_down  = keyboard_check_pressed(vk_down);
var key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));

// Controle Xbox
var gp_connected = gamepad_is_connected(0);

if (gp_connected)
{
    // D-pad
    var gp_up   = gamepad_button_check_pressed(0, gp_padu);
    var gp_down = gamepad_button_check_pressed(0, gp_padd);
    
    // Analógico esquerdo (com deadzone)
    var gp_axis_v = gamepad_axis_value(0, gp_axislv);
    var deadzone = 0.5;
    
    var analog_up = false;
    var analog_down = false;
    
    if (gp_axis_v < -deadzone)
    {
        if (!variable_instance_exists(id, "analog_was_up") || analog_was_up == false)
        {
            analog_up = true;
            analog_was_up = true;
        }
    }
    else
    {
        analog_was_up = false;
    }
    
    if (gp_axis_v > deadzone)
    {
        if (!variable_instance_exists(id, "analog_was_down") || analog_was_down == false)
        {
            analog_down = true;
            analog_was_down = true;
        }
    }
    else
    {
        analog_was_down = false;
    }
    
    // Botão A para confirmar
    var gp_confirm = gamepad_button_check_pressed(0, gp_face1);
    
    // Combina inputs
    key_up = key_up || gp_up || analog_up;
    key_down = key_down || gp_down || analog_down;
    key_confirm = key_confirm || gp_confirm;
}

// Navegação
if (key_up)
{
    menu_index--;
    if (menu_index < 0) menu_index = menu_total - 1;
}

if (key_down)
{
    menu_index++;
    if (menu_index >= menu_total) menu_index = 0;
}

#endregion

#region BACKGROUND SWITCH

if (menu_index != previous_menu_index)
{
    // desativa todos primeiro
    with (obj_bg_menu1) active = false;
    with (obj_bg_menu2) active = false;
    with (obj_bg_menu3) active = false;

    if (menu_index == 1) // opções
    {
        with (obj_bg_menu2)
        {
            active = true;
            reset_intro();
        }
    }
    else if (menu_index == 2) // créditos
    {
        with (obj_bg_menu3)
        {
            active = true;
            reset_intro();
        }
    }
    else // jogar ou sair
    {
        with (obj_bg_menu1) active = true;
    }

    previous_menu_index = menu_index;
}

#endregion

#region SELETOR FRAME

// menu normal = frame 0
// opções = frame 1
image_index = (menu_index == 1) ? 1 : 0;

#endregion

#region COR DOS BOTÕES

var use_menu2 = (menu_index == 1);

// base (não selecionado)
var base_color = use_menu2 ? c_black : c_white;

with (obj_btn_jogar)    image_blend = base_color;
with (obj_btn_opcoes)   image_blend = base_color;
with (obj_btn_creditos) image_blend = base_color;
with (obj_btn_sair)     image_blend = base_color;

#endregion

#region BOTÃO ATUAL

var target_button = noone;

switch (menu_index)
{
    case 0: target_button = instance_find(obj_btn_jogar, 0); break;
    case 1: target_button = instance_find(obj_btn_opcoes, 0); break;
    case 2: target_button = instance_find(obj_btn_creditos, 0); break;
    case 3: target_button = instance_find(obj_btn_sair, 0); break;
}

#endregion

#region SEGUIR + COR SELECIONADA

if (instance_exists(target_button))
{
    var offset_x = 0;

    // ajuste no "sair"
    if (menu_index == 3)
    {
        offset_x = 20;
    }

    target_x = target_button.x + offset_x;
    target_y = target_button.y;

    // botão selecionado
    with (target_button)
    {
        image_blend = use_menu2 ? c_white : c_black;
    }
}

x = lerp(x, target_x, follow_spd);
y = lerp(y, target_y, follow_spd);

#endregion

/// Step Event — obj_selecao
/// SUBSTITUI APENAS A REGIÃO #region CONFIRMAR
/// Mantenha o resto do código igual

#region CONFIRMAR

if (key_confirm)
{
    if (instance_exists(target_button))
    {
        switch (menu_index)
        {
            case 0: // JOGAR
                global.loading_target_room = rm_game;
                
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_loading;
                }
            break;
            
            case 1: // OPÇÕES
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_opcoes;
                }
            break;
            
            case 2: // CRÉDITOS
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_creditos;
                }
            break;
            
            case 3: // SAIR
                game_end();
            break;
        }
    }
}

#endregion
