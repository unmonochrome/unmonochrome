#region Draw Transition

var w = display_get_gui_width();
var h = display_get_gui_height();

// ease out (suave no final)
var t = progress;
var eased = 1 - power(1 - t, 3);

// quanto fechou
var close = (w * 0.5) * eased;

// lados fechando
draw_set_color(c_black);
draw_rectangle(0, 0, close, h, false);
draw_rectangle(w - close, 0, w, h, false);

draw_set_color(c_white);

#endregion