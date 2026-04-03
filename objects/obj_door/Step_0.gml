/// Step Event — obj_door

var p = instance_find(obj_player, 0);

if (instance_exists(p))
{
    if (place_meeting(x, y, p) && keyboard_check_pressed(ord("C")))
    {
        if (!p.transitioning)
        {
            p.transitioning = true;
            p.transition_alpha = 0;
            p.transition_target_room = target_room;
        }
    }
}