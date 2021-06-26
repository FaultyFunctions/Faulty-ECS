function AnimationEndMomentConsideration() : IConsideration() constructor {
	previous_index = 0;
	
	static evaluate = function() {
		var _evaluate = false;
		if (previous_index > owner.image_index) {
			_evaluate = true;
		}
		
		previous_index = owner.image_index;
		return _evaluate;
	}
	
	static reset = function() {
		previous_index = 0;
	}
}