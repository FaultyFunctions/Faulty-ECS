/// @func CameraFollowComponent([offset_x], [offset_y], [ease], [lerp_amt])
function CameraFollowComponent(offset_x, offset_y, ease, lerp_amt) : IComponent() constructor {
	self.offset_x = is_undefined(offset_x) ? 0 : offset_x;
	self.offset_y = is_undefined(offset_y) ? 0 : offset_y;
	self.ease = is_undefined(ease) ? false : ease;
	self.lerp_amt = is_undefined(lerp_amt) ? 0.1 : lerp_amt;
}