#region Draw Opening

var w = display_get_gui_width();
var h = display_get_gui_height();

// easing (mesmo da outra)
var t = progress;
var eased = 1 - power(1 - t, 3);

// quanto ainda está fechado
var close = (w * 0.5) * eased;

// desenha o que ainda cobre
draw_set_color(c_black);
draw_rectangle(0, 0, close, h, false);
draw_rectangle(w - close, 0, w, h, false);

draw_set_color(c_white);

#endregion