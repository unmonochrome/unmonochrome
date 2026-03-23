#region Setup

image_blend = c_white;

menu_activate = function()
{
    game_end();
};

#endregion

#region Intro Setup

target_x = x;
target_y = y;

x = -sprite_width;
intro_done = false;

intro_delay = room_speed * 0.45;
intro_timer = 0;
intro_spd = 0.12;

#endregion

depth = -100;