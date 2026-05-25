/// Collision with obj_player — obj_fase
/// (fim da fase 1 → vai pro boss do olho VIA LOADING)

// Define qual room carregar
global.loading_target_room = rm_boss_olho;

// Cria a transição visual; quando ela terminar, vai pro loading
if (!instance_exists(obj_transition))
{
    var trans = instance_create_layer(x, y, layer, obj_transition);
    trans.next_room = rm_loading;
}

instance_destroy();
