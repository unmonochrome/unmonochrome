#region Setup

progress = 0;        // 0 → 1
speed = 0.06;

state = 0;           // 0 = fechando | 1 = esperando

wait_time = room_speed * 1; // 2 segundos
wait_timer = 0;

next_room = room;

#endregion