function MoveInputConsideration() : IConsideration() constructor {
	static evaluate = function() {
		return (InputManager.get_x() != 0) or (InputManager.get_y() != 0);
	}
}