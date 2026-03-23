depth = -100;

#region Setup

image_blend = c_white;

menu_activate = function()
{
    if (!instance_exists(obj_transition))
    {
        var trans = instance_create_layer(0, 0, "Instances", obj_transition);
        trans.next_room = rm_creditos;
    }// abrir créditos
};

#endregion

#region Intro Setup

target_x = x;
target_y = y;

x = -sprite_width;
intro_done = false;

intro_delay = room_speed * 0.30;
intro_timer = 0;
intro_spd = 0.12;

#endregion