function PlayerMoveSystem(requirements) : ISystem(requirements) constructor {
	static step = function() {
		for (var i = 0; i < entity_count; ++i) {
			var _e = entities[i];
			
			var _input_dir = point_direction(0, 0, InputManager.get_x(), InputManager.get_y());
			if (_input_dir != undefined) {
				var _velocity = component_get(_e, VelocityComponent);
				_velocity.direction = _input_dir;
			}
		}
	}
}