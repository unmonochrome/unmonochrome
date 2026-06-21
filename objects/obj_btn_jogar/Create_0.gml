/// Create Event — obj_btn_jogar

image_blend = c_white;

menu_activate = function()
{
    if (!instance_exists(obj_transition))
    {
        // Agora vai pra rm_cutscene_game (que toca a cutscene e depois manda pro game)
        global.loading_target_room = rm_cutscene_game;
        var trans = instance_create_layer(0, 0, "Instances", obj_transition);
        trans.next_room = rm_loading;
    }
};

target_x = x;
target_y = y;

x = -sprite_width;
intro_done = false;

intro_delay = 0;
intro_timer = 0;
intro_spd = 0.12;

depth = -100;
