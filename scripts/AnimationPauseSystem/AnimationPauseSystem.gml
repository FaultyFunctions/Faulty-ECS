function AnimationPauseSystem() : ISystem() constructor {
	pausable(false);
	
	pause_list = [];
	init_pause = true;
	
	static step = function() {	
		// PAUSE
		if (global.pause == true and init_pause == true) {
			init_pause = false;
			var _instances = [];
			
			// STORE PAUSABLE INSTANCES
			with (all) {
				if (!component_exists(id, UnpausableTag)) {
					array_push(_instances, id);
				}
			}
			
			// LOOP PAUSABLE INSTANCES AND PAUSE THEIR ANIMATION WHILE STORING THEIR IMAGE_SPEED
			for (var i = 0; i < array_length(_instances); ++i) {
				var _inst = _instances[i];
				array_push(pause_list, {
					id: _inst.id,
					image_speed: _inst.image_speed
				});
				_inst.image_speed = 0;
			}
		}
		
		// UNPAUSE AND RESTORE PRIOR IMAGE_SPEED
		if (global.pause == false and init_pause = false) {
			init_pause = true;
			for (var i = 0; i < array_length(pause_list); ++i) {
				pause_list[i].id.image_speed = pause_list[i].image_speed;
			}
			array_resize(pause_list, 0);
		}
	}
}