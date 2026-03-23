#region INPUT

if (keyboard_check_pressed(vk_up))
{
    menu_index--;
    if (menu_index < 0) menu_index = menu_total - 1;
}

if (keyboard_check_pressed(vk_down))
{
    menu_index++;
    if (menu_index >= menu_total) menu_index = 0;
}

#endregion


#region BACKGROUND SWITCH

if (menu_index != previous_menu_index)
{
    if (menu_index == 1) // opções
    {
        with (obj_bg_menu1) active = false;

        with (obj_bg_menu2)
        {
            active = true;
            reset_intro();
        }
    }
    else
    {
        with (obj_bg_menu1) active = true;
        with (obj_bg_menu2) active = false;
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


#region CONFIRMAR

if (keyboard_check_pressed(vk_enter))
{
    if (instance_exists(target_button))
    {
        with (target_button)
        {
            menu_activate();
        }
    }
}

#endregion