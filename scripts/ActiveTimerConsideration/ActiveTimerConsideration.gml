/// @func ActiveTimerConsideration(time, [in_frames]);
function ActiveTimerConsideration(time, in_frames) : IConsideration() constructor {
	self.set_time = (is_undefined(in_frames) or in_frames == false) ? time * game_get_speed(gamespeed_fps) : time;
	self.time = set_time;
	
	static evaluate = function() {
		if (time <= 0) {
			return false;
		} else {
			--time;
			return true;
		}
	}
	
	static reset = function() {
		time = set_time;
	}
}