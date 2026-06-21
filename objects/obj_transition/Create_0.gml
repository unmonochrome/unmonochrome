/// Create Event — obj_transition

#region Setup

progress = 0;        // 0 → 1
speed = 0.06;

state = 0;           // 0 = fechando | 1 = esperando

wait_time = room_speed * 1; // 1 segundo
wait_timer = 0;

// Room alvo (se ficar -1, usa room_goto_next)
next_room = -1;

#endregion

depth=-9999;