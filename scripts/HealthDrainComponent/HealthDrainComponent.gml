function HealthDrainComponent(amount, rate, delay) : IComponent() constructor {
	self.amount = amount;
	self.rate = rate;
	self.delay = is_undefined(delay) ? 0 : delay;
	time = rate * game_get_speed(gamespeed_fps);
	enabled = true;
}