function CounterSystem(requirements) : ISystem(requirements) constructor {
	static enterSystem = function(entity) {
		var _counter = component_get(entity, CounterComponent);
		_counter.time = 0;
	}
	
	static endStep = function() {
		for (var i = 0; i < entity_count; ++i) {
			var _entity = entities[i];
			var _counter = component_get(_entity, CounterComponent);
			
			_counter.time++;
		}
	}
}