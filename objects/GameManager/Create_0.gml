/// @description Init Game
global.pause = false;
instance_create_layer(0, 0, "Controllers", InputManager);
instance_create_layer(0, 0, "Controllers", world_gameplay);

room_goto(rm_playroom);