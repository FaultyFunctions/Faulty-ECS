function HealthComponent(max_health) : IComponent() constructor {
	maximum = max_health;
	amount = max_health;
	
	modify_health_queue = [];
	
	/// @func modifyHealth(amount);
	static modifyHealth = function(amount) {
		array_push(modify_health_queue, amount);
	}
}