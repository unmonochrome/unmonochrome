/// Create Event — obj_btn_jogar

#region Setup

image_blend = c_white;

menu_activate = function()
{
    if (!instance_exists(obj_transition))
    {
        // Define a sala alvo (que será carregada APÓS o loading)
        global.loading_target_room = rm_game;
        
        // Cria a transição visual que vai pra rm_loading
        var trans = instance_create_layer(0, 0, "Instances", obj_transition);
        trans.next_room = rm_loading;
    }
};

#endregion

#region Intro Setup

target_x = x;
target_y = y;

x = -sprite_width;
intro_done = false;

intro_delay = 0;
intro_timer = 0;
intro_spd = 0.12;

#endregion

depth = -100;
