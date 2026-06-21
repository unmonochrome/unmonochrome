/// Step Event — obj_opcoes_menu

hover_pulse += 0.08;
if (nav_cooldown > 0) nav_cooldown--;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// MOUSE
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var mouse_moved = (my != mouse_last_y);
mouse_last_y = my;

var start_y = 240;
var spacing = 75;

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
{
    var current_m = options[selected_index];
    if (variable_struct_exists(current_m, "action_confirm"))
        current_m.action_confirm();
    else if (variable_struct_exists(current_m, "action_right"))
        current_m.action_right();
}

// TECLADO
var key_up    = keyboard_check_pressed(vk_up);
var key_down  = keyboard_check_pressed(vk_down);
var key_left  = keyboard_check_pressed(vk_left);
var key_right = keyboard_check_pressed(vk_right);
var key_confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
var key_back = keyboard_check_pressed(vk_escape);

if (gamepad_is_connected(0))
{
    var gp_up    = gamepad_button_check_pressed(0, gp_padu);
    var gp_down  = gamepad_button_check_pressed(0, gp_padd);
    var gp_left  = gamepad_button_check_pressed(0, gp_padl);
    var gp_right = gamepad_button_check_pressed(0, gp_padr);
    
    var gp_axis_v = gamepad_axis_value(0, gp_axislv);
    var gp_axis_h = gamepad_axis_value(0, gp_axislh);
    var dz = 0.5;
    
    if (nav_cooldown <= 0)
    {
        if (gp_axis_v < -dz) { gp_up = true; nav_cooldown = nav_cooldown_max; }
        if (gp_axis_v > dz)  { gp_down = true; nav_cooldown = nav_cooldown_max; }
        if (gp_axis_h < -dz) { gp_left = true; nav_cooldown = nav_cooldown_max; }
        if (gp_axis_h > dz)  { gp_right = true; nav_cooldown = nav_cooldown_max; }
    }
    
    var gp_confirm = gamepad_button_check_pressed(0, gp_face1);
    var gp_back = gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_start);
    
    key_up = key_up || gp_up;
    key_down = key_down || gp_down;
    key_left = key_left || gp_left;
    key_right = key_right || gp_right;
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

var current = options[selected_index];

if (key_left && variable_struct_exists(current, "action_left"))
    current.action_left();

if (key_right && variable_struct_exists(current, "action_right"))
    current.action_right();

if (key_confirm)
{
    if (variable_struct_exists(current, "action_confirm"))
        current.action_confirm();
    else if (variable_struct_exists(current, "action_right"))
        current.action_right();
}

if (key_back) room_goto(rm_menu);
