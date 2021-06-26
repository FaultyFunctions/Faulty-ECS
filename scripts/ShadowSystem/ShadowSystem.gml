function ShadowSystem(requirements) : ISystem(requirements) constructor {
	static shadow_surface = -1;
	pausable(false);
	
	static draw = function() {
		if (!surface_exists(shadow_surface)) {
			shadow_surface = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
		}
		
		surface_set_target(shadow_surface);
		draw_clear_alpha(c_black, 0.0);
		for (var i = 0; i < entity_count; ++i) {
			var _e = entities[i];
			
			var _shadow = component_get(_e, ShadowComponent);
			
			var _x1 = _e.x - (_shadow.width * .5) + _shadow.offset_x;
			var _y1 = _e.y - (_shadow.height * .5) + _shadow.offset_y;
			var _x2 = _e.x + (_shadow.width * .5) + _shadow.offset_x;
			var _y2 = _e.y + (_shadow.height * .5) + _shadow.offset_y;
			
			draw_set_color(_shadow.color);
			draw_ellipse(_x1, _y1, _x2, _y2, false);
			draw_set_color(c_white);
		}
		surface_reset_target();
		
		draw_set_alpha(0.6);
		draw_surface(shadow_surface, 0, 0);
		draw_set_alpha(1.0);
	}
}