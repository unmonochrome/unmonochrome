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
            room_goto_next()
        }
    break;
}

#endregion