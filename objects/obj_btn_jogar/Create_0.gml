#region Setup

image_blend = c_white;

menu_activate = function()
{
    if (!instance_exists(obj_transition))
    {
        var trans = instance_create_layer(0, 0, "Instances", obj_transition);
        trans.next_room = rm_fase1;
    }
};

#endregion

#region Intro Setup

target_x = x;
target_y = y;

x = -sprite_width;
intro_done = false;

intro_delay = 0; // muda em cada botão
intro_timer = 0;
intro_spd = 0.12;

#endregion

depth = -100;