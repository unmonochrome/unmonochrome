/// Step Event — obj_cutscene

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
                // Arquivo não existe — pula direto
                state = 2;
                state_timer = 0;
            }
        }
    break;
    
    case 1: // TOCANDO
        var status = video_get_status();
        
        // Vídeo terminou
        if (video_started && state_timer > 30 && (status == -1 || status == 0))
        {
            state = 2;
            state_timer = 0;
        }
        
        // SKIP
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
    
    case 2: // ENCERRA (sem fade, direto)
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
