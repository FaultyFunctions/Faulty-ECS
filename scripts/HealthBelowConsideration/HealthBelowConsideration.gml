function HealthBelowConsideration(amount) : IConsideration() constructor {
	required_components = [HealthComponent];
	self.amount = amount;
	
	static evaluate = function() {
		var _health = component_get(owner, HealthComponent);
		return (_health.amount < amount);
	}
}