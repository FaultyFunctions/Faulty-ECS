function HealthSystem(requirements) : ISystem(requirements) constructor {
	static endStep = function() {
		for (var i = 0; i < entity_count; ++i) {
			var _entity = entities[i];
			
			var _health = component_get(_entity, HealthComponent);
			
			// HEALTH DRAIN
			var _drain = component_get(_entity, HealthDrainComponent);
			if (_drain != undefined and _drain.enabled) {
				if (_drain.delay <= 0) {
					--_drain.time;
					if (_drain.time <= 0) {
						_drain.time = _drain.rate * game_get_speed(gamespeed_fps);
						_health.amount -= _drain.amount;
					}
				} else {
					--_drain.delay;
				}
			}
			
			// HEALTH CONSUME
			if (component_exists(_entity, HealthConsumeComponent)) {
				var _consume = component_get(_entity, HealthConsumeComponent);
				_health.amount -= _consume.amount;
				component_remove(_entity, HealthConsumeComponent);
			}
			
			for (var j = 0; j < array_length(_health.modify_health_queue); ++j) {
				_health.amount += _health.modify_health_queue[j];
				_health.amount = clamp(_health.amount, 0, _health.maximum);
			}
			if (array_length(_health.modify_health_queue) > 0) {
				array_resize(_health.modify_health_queue, 0);
			}
		}
	}
}