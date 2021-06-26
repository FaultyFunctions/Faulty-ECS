/// @func CameraShakeComponent([strength], [time], [frequency])
function CameraShakeComponent(strength, time, frequency) : IComponent() constructor {
	self.strength = is_undefined(strength) ? 4 : strength;
	self.time = is_undefined(time) ? 1 : time;
	self.frequency = is_undefined(frequency) ? 0.02 : frequency;
}