#macro CAMERA view_camera[0]
#macro CAMERA_X camera_get_view_x(view_camera[0])
#macro CAMERA_Y camera_get_view_y(view_camera[0])
#macro CAMERA_WIDTH camera_get_view_width(view_camera[0])
#macro CAMERA_HEIGHT camera_get_view_height(view_camera[0])

function CameraSystem(requirements) : ISystem(requirements) constructor {
	pausable(false);
	
	static roomStart = function() {
		view_enabled = true;
		view_visible[0] = true;
		camera_set_view_size(CAMERA, 480, 270);
	}
	
	static endStep = function() {
		if (entity_count <= 0) { return; }
		
		var _target_x = 0;
		var _target_y = 0;
		
		// CODE TO GO IN BETWEEN TWO ENTITIES
		//for (var i = 0; i < entity_count; ++i) {
		//	var _entity = entities[i];
			
		//	_target_x += _entity.x - (CAMERA_WIDTH / 2);
		//	_target_y += _entity.y - (CAMERA_HEIGHT / 2);
		//}
		//_target_x /= entity_count;
		//_target_y /= entity_count;
		
		// FOLLOW LATEST TARGET
		var _e = entities[entity_count - 1];
		var _cam_comp = component_get(_e, CameraFollowComponent);
		_target_x += _e.x + _cam_comp.offset_x - (CAMERA_WIDTH / 2);
		_target_y += _e.y + _cam_comp.offset_y - (CAMERA_HEIGHT / 2);
		
		if (_cam_comp.ease) {
			var _current_x = lerp(CAMERA_X, _target_x, _cam_comp.lerp_amt);
			var _current_y = lerp(CAMERA_Y, _target_y, _cam_comp.lerp_amt);
		} else {
			var _current_x = _target_x;
			var _current_y = _target_y;
		}
		
		// CLAMP TO ROOM BORDERS
		if (room_width < CAMERA_WIDTH) {
			_current_x = -(CAMERA_WIDTH - room_width) / 2;
		} else {
			_current_x = clamp(_current_x, 0, room_width - CAMERA_WIDTH);
		}
		if (room_height < CAMERA_HEIGHT) {
			_current_y = -(CAMERA_HEIGHT - room_height) / 2;
		} else {
			_current_y = clamp(_current_y, 0, room_height - CAMERA_HEIGHT);
		}
		
		camera_set_view_pos(CAMERA, _current_x, _current_y);
	}
}