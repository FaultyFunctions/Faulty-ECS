function PreviousStateConsideration(state) : IConsideration() constructor {
	required_components = [StateMachineComponent];
	self.state = state;
	
	static evaluate = function() {
		var _fsm = component_get(owner, StateMachineComponent);
		
		if (_fsm.previous_state.name == state) {
			return true;
		}
		
		return false;
	}
}