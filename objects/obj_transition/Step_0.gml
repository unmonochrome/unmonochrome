/// Step Event — obj_transition

#region Transition Logic

switch (state)
{
    case 0: // fechando
        progress += speed;

        if (progress >= 1)
        {
            progress = 1;
            state = 1;
        }
    break;

    case 1: // tela preta parada
        wait_timer++;

        if (wait_timer >= wait_time)
        {
            // Se tiver next_room definido, vai pra ela
            // Senão, vai pra próxima room na ordem
            if (next_room != -1 && room_exists(next_room))
            {
                room_goto(next_room);
            }
            else
            {
                room_goto_next();
            }
        }
    break;
}

#endregion
