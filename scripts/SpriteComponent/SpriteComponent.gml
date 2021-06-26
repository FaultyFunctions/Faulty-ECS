enum SpritePlaybackType {
	ONCE,
	LOOP,
	PING_PONG,
	FREEZE
}

/// @func SpriteComponent(sprite_data, [playback_type], [playback_speed], [reset_index]);
function SpriteComponent(sprite_data, playback_type, playback_speed, reset_index) : IComponent() constructor {
	self.sprite_data = sprite_data;
	self.playback_type = (is_undefined(playback_type)) ? SpritePlaybackType.LOOP : playback_type;
	self.playback_speed = (is_undefined(playback_speed)) ? 1 : playback_speed;
	self.reset_index = (is_undefined(reset_index)) ? true : reset_index;
}