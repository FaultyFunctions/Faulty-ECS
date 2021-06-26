function ShadowComponent(width, height, offset_x, offset_y, color) : IComponent() constructor {
	self.width = width;
	self.height = height;
	self.offset_x = is_undefined(offset_x) ? 0 : offset_x;
	self.offset_y = is_undefined(offset_y) ? 0 : offset_y;
	self.color = is_undefined(color) ? make_color_rgb(21, 19, 43) : color;
}