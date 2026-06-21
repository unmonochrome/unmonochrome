/// Post-Draw Event — obj_cutscene

var ww = window_get_width();
var wh = window_get_height();

var target_aspect = cam_w / cam_h;
var screen_aspect = ww / wh;

var dw, dh, dx, dy;

if (screen_aspect > target_aspect)
{
    dh = wh;
    dw = dh * target_aspect;
    dx = (ww - dw) * 0.5;
    dy = 0;
}
else
{
    dw = ww;
    dh = dw / target_aspect;
    dx = 0;
    dy = (wh - dh) * 0.5;
}

// FUNDO PRETO
draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(0, 0, ww, wh, false);

// VIDEO (surface no índice 1)
if (video_started)
{
    var vid_data = video_draw();
    
    if (is_array(vid_data) && array_length(vid_data) >= 2)
    {
        var vid_surface = vid_data[1];
        
        if (surface_exists(vid_surface))
        {
            var sw = surface_get_width(vid_surface);
            var sh = surface_get_height(vid_surface);
            
            if (sw > 0 && sh > 0)
                draw_surface_stretched(vid_surface, dx, dy, dw, dh);
        }
    }
}

draw_set_color(c_white);
