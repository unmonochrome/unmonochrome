/// Collision with obj_player — obj_fase
/// Fim da fase 1 → cutscene boss olho → boss olho

global.loading_target_room = rm_cutscene_boss_olho;

if (!instance_exists(obj_transition))
{
    var trans = instance_create_layer(x, y, layer, obj_transition);
    trans.next_room = rm_loading;
}

instance_destroy();
