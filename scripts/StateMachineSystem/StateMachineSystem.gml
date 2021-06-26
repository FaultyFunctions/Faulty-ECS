function StateMachineSystem(requirements) : ISystem(requirements) constructor {
	static step = function() {
		for (var i = 0; i < array_length(entities); ++i) {
			var _entity = entities[i];
			var _sm = component_get(entities[i], StateMachineComponent);
			++_sm.time;
			
			// INIT
			if (_sm.current_state == undefined) {
				__changeState(_entity, _sm, _sm.initial_state);
			}
			
			// STATE TRANSITIONS & CONSIDERATIONS
			var _transitions = _sm.current_state.transitions;
			for (var j = 0; j < array_length(_transitions); ++j) {
				var _transition = _transitions[j];
				
				// CHECK BYPASS CONSIDERATIONS
				var _bypass_considerations = _transition.bypass_considerations;
				var _bypass_passed = false;
				for (var k = 0; k < array_length(_bypass_considerations); ++k) {
					var _bypass = _bypass_considerations[k];
					
					// ARRAY BYPASSES??
					
					if (__considerationRequirementsMet(_entity, _bypass)) {
						_bypass_passed = _bypass.evaluate();
						if (_bypass_passed) { break; }
					}
				}
				if (_bypass_passed) {
					__changeState(_entity, _sm, _sm.states[$ _transition.to_state]);
					break;
				}
				
				// CHECK CONSIDERATIONS
				var _considerations = _transition.considerations;
				var _considerations_passed = true;
				for (var k = 0; k < array_length(_considerations); ++k) {
					var _consideration = _considerations[k];
					
					if (is_array(_consideration)) {
						var _or_considerations_passed = false;
						for (var l = 0; l < array_length(_consideration); ++l) {
							var _or_consideration = _consideration[l];
							if (__considerationRequirementsMet(_entity, _or_consideration.required_components)) {
								_or_considerations_passed = _or_considerations_passed or _or_consideration.evaluate();
								if (_or_considerations_passed) { break; }
							}
						}
						_considerations_passed = _considerations_passed and _or_considerations_passed;
					} else {
						if (__considerationRequirementsMet(_entity, _consideration)) {
							_considerations_passed = _considerations_passed and _consideration.evaluate();
						}
					}
				}
				if (_considerations_passed) {
					__changeState(_entity, _sm, _sm.states[$ _transition.to_state]);
					break;
				}
			}
		}
	}
	
	static __considerationRequirementsMet = function(entity, requirements) {
		for (var i = 0; i < array_length(requirements); ++i) {
			if (component_exists(entity, requirements[i]) == false) { return false; }
		}
		return true;
	}
	
	static __changeState = function(entity, state_machine, new_state) {
		state_machine.previous_time = state_machine.time;
		state_machine.time = 0;
		var _to_add = {};
		
		if (state_machine.current_state != undefined) {
			// CONSTRUCT WHAT WE WANT TO ADD TO THE ENTITY
			var _new_provider_names = variable_struct_get_names(new_state.providers);
			for (var i = 0; i < array_length(_new_provider_names); ++i) {
				var _t = _new_provider_names[i];
				var _type = real(_t);
				_to_add[$ _type] = new_state.providers[$ _type];
			}
			
			// REMOVE COMPONENTS FROM PREVIOUS STATE
			var _current_provider_names = variable_struct_get_names(state_machine.current_state.providers);
			for (var i = 0; i < array_length(_current_provider_names); ++i) {
				var _t = _current_provider_names[i];
				var _type = real(_t);
				var _other = _to_add[$ _type];
				
				component_remove(entity, _type);
			}
			
			// EXIT COMPONENTS
			var _current_state = state_machine.current_state;
			var _exit_provider_names = variable_struct_get_names(_current_state.exit_providers);
			for (var i = 0; i < array_length(_exit_provider_names); ++i) {
				var _t = _exit_provider_names[i];
				var _type = real(_t);
				_to_add[$ _type] = _current_state.exit_providers[$ _type];
			}
			
			// LOOP OVER CONSIDERATIONS AND RESET IF NEEDED
			var _transitions = _current_state.transitions;
			for (var i = 0; i < array_length(_transitions); ++i) {
				__resetConsiderations(_transitions[i].considerations);
			}
			
			state_machine.previous_state = state_machine.current_state;
		} else {
			_to_add = new_state.providers;
			state_machine.previous_state = new_state;
		}
		
		// ADD COMPONENTS FOR THE STATE TO THE ENTITY
		var _to_add_names = variable_struct_get_names(_to_add);
		for (var i = 0; i < array_length(_to_add_names); ++i) {
			var _t = _to_add_names[i];
			var _type = real(_t);
			component_add(entity, _to_add[$ _type].getComponent());
		}
		
		state_machine.current_state = new_state;
	}
	
	static __resetConsiderations = function(considerations) {
		for (var i = 0; i < array_length(considerations); ++i) {
			var _consideration = considerations[i];
			if (is_array(_consideration)) {
				__resetConsiderations(_consideration);
			} else {
				if (_consideration.reset != undefined) {
					_consideration.reset();
				}
			}
		}
	}
}