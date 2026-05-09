/// Create Event — obj_hud

#region Preload de recursos
// sprites do player
sprite_prefetch(spr_player_idle);
sprite_prefetch(spr_player_run);
sprite_prefetch(spr_player_jump);
sprite_prefetch(spr_player_attack1);

// sprites do boss / mãos
sprite_prefetch(spr_eye_open);
sprite_prefetch(spr_eye_closed);
sprite_prefetch(spr_pupila);
sprite_prefetch(spr_hand_ground);
sprite_prefetch(spr_hand_ground_target);
sprite_prefetch(spr_maochao);

// sons do player
audio_play_sound(snd_step, 0, false);
audio_stop_all();

audio_play_sound(snd_jump, 0, false);
audio_stop_all();

audio_play_sound(snd_attack, 0, false);
audio_stop_all();

audio_play_sound(snd_hurt, 0, false);
audio_stop_all();

audio_play_sound(snd_death, 0, false);
audio_stop_all();
#endregion