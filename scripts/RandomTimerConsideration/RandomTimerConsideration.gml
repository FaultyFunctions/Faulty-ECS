/// @func RandomTimerConsideration(min_time, max_time, [in_frames]);
function RandomTimerConsideration(min_time, max_time, in_frames) : IConsideration() constructor {
	self.min_time = (is_undefined(in_frames) or in_frames == false) ? min_time * game_get_speed(gamespeed_fps) : min_time;
	self.max_time = (is_undefined(in_frames) or in_frames == false) ? max_time * game_get_speed(gamespeed_fps) : max_time;
	time = random_range(self.min_time, self.max_time);
	
	static evaluate = function() {
		if (time <= 0) {
			return true;
		} else {
			--time;
			return false;
		}
	}
	
	static reset = function() {
		time = random_range(min_time, max_time);
	}
}