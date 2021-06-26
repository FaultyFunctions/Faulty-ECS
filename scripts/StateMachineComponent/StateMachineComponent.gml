/*
* This is a state machine for an entity. The state machine manages a set of states, each of which
* has a set of component providers. When the state machine system changes the state, it removes
* components associated with the previous state and adds components associated with the new state.
*/
function StateMachineComponent() : IComponent() constructor {
	states = {};
	current_state = undefined;
	previous_state = undefined;
	intial_state = undefined;
	time = 0;
	previous_time = 0;
	
	static addState = function(name, state) {
		states[$ name] = state;
		return self;
	}
	
	static createState = function(name) {
		var _state = new StateComponent(name);
		states[$ name] = _state;
		return _state;
	}
	
	static setInitialState = function(name) {
		initial_state = states[$ name];
		return self;
	}
}