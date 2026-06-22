/// Step Event — obj_cutscene

// ==========================================
// ESPERA O TUTORIAL TERMINAR antes de tudo
// ==========================================
if (instance_exists(obj_tutorial_game)) exit;

state_timer++;
if (input_lock > 0) input_lock--;

switch (state)
{
    case 0: // ABRE VIDEO
        if (!video_started && video_file != "")
        {
            if (file_exists(video_file))
            {
                video_format = video_open(video_file);
                video_started = true;
                state = 1;
                state_timer = 0;
            }
            else
            {
                state = 2;
                state_timer = 0;
            }
        }
    break;
    
    case 1: // TOCANDO
        var status = video_get_status();
        
        if (video_started && state_timer > 30 && (status == -1 || status == 0))
        {
            state = 2;
            state_timer = 0;
        }
        
        if (input_lock <= 0)
        {
            var skip = keyboard_check_pressed(vk_space)
                    || keyboard_check_pressed(vk_enter)
                    || keyboard_check_pressed(vk_escape)
                    || keyboard_check_pressed(ord("Z"))
                    || mouse_check_button_pressed(mb_left);
            
            if (gamepad_is_connected(0))
            {
                skip = skip
                    || gamepad_button_check_pressed(0, gp_face1)
                    || gamepad_button_check_pressed(0, gp_start);
            }
            
            if (skip)
            {
                state = 2;
                state_timer = 0;
            }
        }
    break;
    
    case 2: // ENCERRA
        if (video_started)
        {
            video_close();
            video_started = false;
        }
        
        if (room_exists(next_room))
            room_goto(next_room);
        else
            room_goto(rm_menu);
    break;
}
