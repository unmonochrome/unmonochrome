if (hurt_timer > 0) {
    if ((hurt_timer div 2) mod 2 == 0) {
        draw_self();
    }
} else {
    draw_self();
}