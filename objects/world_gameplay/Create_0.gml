/// @description Init World
/// This world is used for general gameplay
layer_create(-16000, "Systems");
instance_create_layer(0, 0, "Systems", sys_state_machine);
instance_create_layer(0, 0, "Systems", sys_animation);
instance_create_layer(0, 0, "Systems", sys_player_controller);
instance_create_layer(0, 0, "Systems", sys_stats);
instance_create_layer(0, 0, "Systems", sys_utilities);
instance_create_layer(0, 0, "Systems", sys_camera);
instance_create_layer(0, 0, "Systems", sys_shadows);
instance_create_layer(0, 0, "Systems", sys_movement);