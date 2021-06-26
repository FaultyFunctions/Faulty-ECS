function CameraShakeSystem(requirements) : ISystem(requirements) constructor {
	pausable(false);
	
	static enterSystem = function(entity) {
		for (var i = 0; i < entity_count; ++i) {
			var _entity = entities[i];
			if (_entity != entity) {
				component_remove(_entity, CameraShakeComponent);
			}
		}
		entity_count = array_length(entities);
	}
	
	static endStep = function() {
		if (entity_count != 0) {
			var _entity = entities[0];
			var _shake = component_get(_entity, CameraShakeComponent);
		
			if (_shake.time > 0) {
				var _shake_x = CAMERA_X + choose(-_shake.strength, _shake.strength);
				var _shake_y = CAMERA_Y + choose(-_shake.strength, _shake.strength);
		
				camera_set_view_pos(CAMERA, _shake_x, _shake_y);
				camera_set_view_angle(CAMERA, choose(-0.5, 0.5));
			
				--_shake.time;
			} else {
				camera_set_view_angle(CAMERA, 0);
				component_remove(_entity, CameraShakeComponent);
			}
		}
	}
}