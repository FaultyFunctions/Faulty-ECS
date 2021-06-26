/// @func VelocityComponent(speed, [direction])
function VelocityComponent(speed, direction) : IComponent() constructor {
	self.speed = speed;
	self.direction = is_undefined(direction) ? 0 : direction;
}