/// Step Event — obj_tutorial_sereia

if (input_lock > 0) input_lock--;

state_timer++;

switch (state)
{
    case 0:
        alpha = lerp(alpha, 1, 0.12);
        
        if (state_timer >= fade_duration)
        {
            alpha = 1;
            state = 1;
            state_timer = 0;
        }
    break;
    
    case 1:
        alpha = 1;
        
        if (state_timer >= hold_min_time && input_lock <= 0)
        {
            var key_next = keyboard_check_pressed(vk_space)
                        || keyboard_check_pressed(vk_enter)
                        || keyboard_check_pressed(ord("Z"))
                        || mouse_check_button_pressed(mb_left);
            
            if (gamepad_is_connected(0))
            {
                key_next = key_next 
                        || gamepad_button_check_pressed(0, gp_face1)
                        || gamepad_button_check_pressed(0, gp_start);
            }
            
            if (key_next)
            {
                state = 2;
                state_timer = 0;
            }
        }
    break;
    
    case 2:
        alpha = lerp(alpha, 0, 0.15);
        
        if (state_timer >= fade_duration)
        {
            alpha = 0;
            
            current++;
            
            if (current >= total_tutorials)
            {
                instance_activate_all();
                instance_destroy();
                exit;
            }
            else
            {
                state = 0;
                state_timer = 0;
            }
        }
    break;
}
