/// @func ImpulseComponent(force, [direction]);
function ImpulseComponent(force, direction) : IComponent() constructor {
	self.force = force;
	self.direction = direction;
	used = false;
}