function WallCollideConsideration() : IConsideration() constructor{
	required_components = [MoveComponent];
	
	static evaluate = function() {
		var _move = component_get(owner, MoveComponent);
		return _move.collided;
	}
}