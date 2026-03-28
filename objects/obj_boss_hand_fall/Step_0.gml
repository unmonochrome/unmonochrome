timer++;
switch(state)
{
    case 0: if(timer>=warning_time){state=1; timer=0;} break;
    case 1: y+=fall_speed; if(y>=target_y){y=target_y; state=2; timer=0;} break;
    case 2: if(timer>=12) instance_destroy(); break;
}
if(state==0) draw_sprite(spr_hand_warning,0,x,y);
draw_self();