function AnimationSystem(requirements) : ISystem(requirements) constructor {
	static endStep = function() {
		for (var i = 0; i < entity_count; i++) {
			var _entity = entities[i];
			var _sprite_component = component_get(_entity, SpriteComponent);
			var _sprite_data = _sprite_component.sprite_data;
			
			if (component_exists(_entity, FacingDirectionComponent) and is_array(_sprite_data)) {
				var _facing = component_get(_entity, FacingDirectionComponent);
				_entity.sprite_index = _sprite_data[_facing.direction];
			}
			
			// SET PLAYBACK SPEED
			_entity.image_speed = _sprite_component.playback_speed;
			
			// PLAYBACK OPTIONS
			var _playback = _sprite_component.playback_type;
			switch (_playback) {
				case SpritePlaybackType.ONCE:
					// FIXTHIS: IMPLEMENT LATER
					break;
				case SpritePlaybackType.LOOP:
					// GM loops automatically
					break;
				case SpritePlaybackType.PING_PONG:
					// FIXTHIS: IMPLEMENT LATER
					break;
				case SpritePlaybackType.FREEZE:
					_entity.image_speed = 0;
					break;
			}
		}
	}
	
	static enterSystem = function(entity) {
		var _sprite_component = component_get(entity, SpriteComponent);
		var _sprite_data = _sprite_component.sprite_data;
		var _sprite = undefined;
			
		// GRAB CORRECT SPRITE
		if (is_array(_sprite_data)) {
			var _facing_component = component_get(entity, FacingDirectionComponent);
			if (is_undefined(_facing_component)) {
				throw " AnimationSystem: FacingDirectionComponent does not exist on entity.";
			}
			_sprite = _sprite_data[_facing_component.direction];
		} else {
			_sprite = _sprite_data;
		}
			
		// SET SPRITE
		entity.sprite_index = _sprite;
			
		// SET PLAYBACK SPEED
		entity.image_speed = _sprite_component.playback_speed;
		
		if (_sprite_component.reset_index) {
			entity.image_index = 0;
		}
	}
}