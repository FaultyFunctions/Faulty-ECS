function AnimationFrameBetweenConsideration(frame_min, frame_max) : IConsideration() constructor {
	self.frame_min = frame_min;
	self.frame_max = frame_max;
	
	static evaluate = function() {
		if (owner.image_index >= frame_min and owner.image_index <= frame_max) {
			return true;
		}
		
		return false;
	}
}