function HealthDepletedConsideration() : IConsideration() constructor {
	required_components = [HealthComponent];
	
	static evaluate = function() {
		var _health = component_get(owner, HealthComponent);
		return (_health.amount <= 0);
	}
}