/*
* Represents a state for an EntityStateMachine. The state contains any number of
* ComponentProviders which are used to add components to the entity when this state is entered.
*/
function StateComponent(name) : IComponent() constructor {
	self.name = name; // Name of the state
	providers = {}; // Provides component data to generate components on enter
	exit_providers = {}; // Provides component data to generate on exit
	transitions = []; // Transition data to determine if we should transition to another state
	
	/// @func addComponent(type);
	static addComponent = function(type) {
		return new StateComponentMapping(self, type, providers);
	}
	
	/// @func addExitComponent(type);
	static addExitComponent = function(type) {
		return new StateComponentMapping(self, type, exit_providers);
	}
	
	/// @func getComponent(type);
	static getComponent = function(type) {
		return providers[$ type];
	}
	
	/// @func hasComponent(type);
	static hasComponent = function(type) {
		return providers[$ type] != undefined;
	}
	
	/// @func addTransition(transition);
	static addTransition = function(transition) {
		array_push(transitions, transition);
		return self;
	}
	
	/// @func addTransitionExt(transition);
	static addTransitionExt = function(transition) {
		var _transition = new StateComponentTransition(self, transition.to_state);
		array_copy(_transition.considerations, 0, transition.considerations, 0, array_length(transition.considerations));
		array_push(transitions, _transition);
		return _transition;
	}
	
	/// @func createTransition(to_state);
	static createTransition = function(to_state) {
		var _transition = new StateComponentTransition(self, to_state);
		array_push(transitions, _transition);
		return _transition;
	}
}

/*
* Used by the StateComponent to create the mappings of components to providers via a fluent interface.
*/
function StateComponentMapping(creating_state, type, providers_struct) constructor {
	self.creating_state = creating_state;
	self.component_type = type;
	self.providers_struct = providers_struct;
	provider = undefined;
	
	// Default
	static withType = function(type) {
		__setProvider(new ComponentTypeProvider(type));
		return self;
	}
	
	// Data gets reset on state changes
	static withData = function(component) {
		__setProvider(new ComponentDataProvider(component));
		return self;
	}
	
	// Data does not get reset on state changes
	static withSingleton = function(component) {
		__setProvider(new ComponentSingletonProvider(component));
		return self;
	}
	
	static __setProvider = function(provider) {
		self.provider = provider;
		providers_struct[$ component_type] = provider;
	}
	
	static endComponent = function() {
		var _creating_state = creating_state;
		// REMOVE CIRCULAR REFERENCE
		variable_struct_remove(self, "creating_state");
		return _creating_state;
	}
	
	withType(type);
}

/*
* This component provider always returns a new instance of a component. An instance
* is created when requested and is of the type passed in to the constructor.
*/
function ComponentTypeProvider(type) constructor {
	component_type = type;
	
	static getComponent = function() {
		return new component_type();
	}
	
	static identifier = function() {
		return component_type;
	}
}

function ComponentDataProvider(data) constructor {
	self.data = data;
	init_data = snap_deep_copy(data);
	
	static getComponent = function() {
		var _names = variable_struct_get_names(data);
		for (var i = 0; i < array_length(_names); i++) {
			if (is_array(init_data[$ _names[i]])) {
				var _init_data = [];
				array_copy(_init_data, 0, init_data[$ _names[i]], 0, array_length(init_data[$ _names[i]]));
				data[$ _names[i]] = _init_data;
			} else if (is_struct(init_data[$ _names[i]])) {
				var _init_data = snap_deep_copy(init_data[$ _names[i]]);
				data[$ _names[i]] = _init_data;
			} else {
				data[$ _names[i]] = init_data[$ _names[i]];
			}
		}
		return data;
	}
	
	static identifier = function() {
		return undefined;
	}
}

function ComponentSingletonProvider(data) constructor {
	self.data = data;
	
	static getComponent = function() {
		return data;
	}
	
	static identifier = function() {
		return data;
	}
}

function StateComponentTransition(creating_state, to_state) constructor {
	self.creating_state = creating_state;
	self.to_state = to_state;
	considerations = [];
	bypass_considerations = [];
	
	/// @func addConsideration(consideration);
	static addConsideration = function(consideration) {
		array_push(considerations, consideration);
		return self;
	}
	
	/// @func addBypassConsideration(consideration);
	static addBypassConsideration = function(consideration) {
		array_push(bypass_considerations, consideration);
		return self;
	}
	
	static endTransition = function() {
		var _creating_state = creating_state;
		// REMOVE CIRCULAR REFERENCE
		if (creating_state != undefined) {
			delete creating_state;
		}
		
		return _creating_state;
	}
}

function IConsideration() constructor {
	owner = other.id;
	required_components = undefined;
	
	static evaluate = undefined;
	static reset = undefined;
	static debugDraw = undefined;
}