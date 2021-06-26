function AnimationEndConsideration() : IConsideration() constructor {
	previous_index = 0;
	
	static evaluate = function() {
		if (previous_index > owner.image_index) {
			return true;
		}
		
		previous_index = owner.image_index;
		return false;
	}
	
	static reset = function() {
		previous_index = 0;
	}
}