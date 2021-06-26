function AnimationFrameConsideration(frame_number, comparison_type) : IConsideration() constructor {
	self.frame_number = frame_number;
	self.comparison_type = comparison_type;
	
	static evaluate = function() {
		switch (comparison_type) {
			case ComparisonType.LT:
				if (floor(owner.image_index) < frame_number) { return true; }
				break;
			case ComparisonType.GT:
				if (floor(owner.image_index) > frame_number) { return true; }
				break;
			case ComparisonType.EQ:
				if (floor(owner.image_index) == frame_number) { return true; }
				break;
			case ComparisonType.LTE:
				if (floor(owner.image_index) <= frame_number) { return true; }
				break;
			case ComparisonType.GTE:
				if (floor(owner.image_index) >= frame_number) { return true; }
				break;
		}
		
		return false;
	}
}