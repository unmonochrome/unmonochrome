/// Step Event — obj_selecao

// INPUT TECLADO + CONTROLE
var key_up    = keyboard_check_pressed(vk_up);
var key_down  = keyboard_check_pressed(vk_down);
var key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space);

var gp_connected = gamepad_is_connected(0);

if (gp_connected)
{
    var gp_up   = gamepad_button_check_pressed(0, gp_padu);
    var gp_down = gamepad_button_check_pressed(0, gp_padd);
    
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
    else analog_was_up = false;
    
    if (gp_axis_v > deadzone)
    {
        if (!variable_instance_exists(id, "analog_was_down") || analog_was_down == false)
        {
            analog_down = true;
            analog_was_down = true;
        }
    }
    else analog_was_down = false;
    
    var gp_confirm = gamepad_button_check_pressed(0, gp_face1);
    
    key_up = key_up || gp_up;
    key_down = key_down || gp_down;
    key_confirm = key_confirm || gp_confirm;
}

// ==========================================
// MOUSE — usa bbox real dos botões (já no lugar final)
// ==========================================
// Usa coordenadas da room (não GUI) porque os botões existem na room
var mx = device_mouse_x(0);
var my = device_mouse_y(0);

var buttons = [obj_btn_jogar, obj_btn_opcoes, obj_btn_creditos, obj_btn_sair];

for (var i = 0; i < array_length(buttons); i++)
{
    var btn = instance_find(buttons[i], 0);
    if (instance_exists(btn))
    {
        // Só ativa hover se o botão JÁ chegou na posição final (intro terminou)
        if (!btn.intro_done) continue;
        
        // Usa bbox real (já considera sprite + origin + escala)
        if (mx >= btn.bbox_left && mx <= btn.bbox_right 
         && my >= btn.bbox_top && my <= btn.bbox_bottom)
        {
            menu_index = i;
            
            // Clique = confirma direto
            if (mouse_check_button_pressed(mb_left))
                key_confirm = true;
            
            break;
        }
    }
}

// Navegação por teclado
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

// BACKGROUND SWITCH
if (menu_index != previous_menu_index)
{
    with (obj_bg_menu1) active = false;
    with (obj_bg_menu2) active = false;
    with (obj_bg_menu3) active = false;

    if (menu_index == 1)
    {
        with (obj_bg_menu2) { active = true; reset_intro(); }
    }
    else if (menu_index == 2)
    {
        with (obj_bg_menu3) { active = true; reset_intro(); }
    }
    else
    {
        with (obj_bg_menu1) active = true;
    }

    previous_menu_index = menu_index;
}

image_index = (menu_index == 1) ? 1 : 0;

var use_menu2 = (menu_index == 1);
var base_color = use_menu2 ? c_black : c_white;

with (obj_btn_jogar)    image_blend = base_color;
with (obj_btn_opcoes)   image_blend = base_color;
with (obj_btn_creditos) image_blend = base_color;
with (obj_btn_sair)     image_blend = base_color;

var target_button = noone;

switch (menu_index)
{
    case 0: target_button = instance_find(obj_btn_jogar, 0); break;
    case 1: target_button = instance_find(obj_btn_opcoes, 0); break;
    case 2: target_button = instance_find(obj_btn_creditos, 0); break;
    case 3: target_button = instance_find(obj_btn_sair, 0); break;
}

if (instance_exists(target_button))
{
    var offset_x = 0;
    if (menu_index == 3) offset_x = 20;

    target_x = target_button.x + offset_x;
    target_y = target_button.y;

    with (target_button)
    {
        image_blend = use_menu2 ? c_white : c_black;
    }
}

x = lerp(x, target_x, follow_spd);
y = lerp(y, target_y, follow_spd);

/// SUBSTITUI APENAS O BLOCO #region CONFIRMAR do obj_selecao Step

// CONFIRMAR
if (key_confirm)
{
    if (instance_exists(target_button))
    {
        switch (menu_index)
        {
            case 0:
                // Vai pra cutscene_game (e depois pro game)
                global.loading_target_room = rm_cutscene_game;
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_loading;
                }
            break;
            
            case 1:
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_opcoes;
                }
            break;
            
            case 2:
                if (!instance_exists(obj_transition))
                {
                    var trans = instance_create_layer(0, 0, "Instances", obj_transition);
                    trans.next_room = rm_creditos;
                }
            break;
            
            case 3:
                game_end();
            break;
        }
    }
}
