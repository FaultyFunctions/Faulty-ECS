function HasNotComponentConsideration(component) : IConsideration() constructor {
	self.component = component;
	
	static evaluate = function() {
		return !component_exists(owner, component);
	}
}