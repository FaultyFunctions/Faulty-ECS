global.zero_vector = new Vector2(0, 0);

/// Mostly ported from: https://github.com/godotengine/godot/blob/master/core/math/vector2.cpp
/// @func Vector2(x/speed, y/direction, non-comp?)
/// @param x/speed
/// @param y/direction
/// @param [non-comp?]
/// @return Vector2 [Vector2]
function Vector2(x, y, non_comp) constructor {
	if (non_comp == true) {
		self.x = lengthdir_x(x, y);
		self.y = lengthdir_y(x, y);
	} else {
		self.x = x;
		self.y = y;
	}
	
	/// @desc Returns a new vector with all components in absolute values.
	static absv = function() {
		return (new Vector2(abs(x), abs(y)));
	}
	
	/// @param {bool}
	/// @desc Returns this vector's angle with respect to the X axis.
	static angle = function() {
		//return (radians) ? arctan2(y, x) : darctan2(y, x);
		return point_direction(0, 0, x, y);
	}
	
	/// @param vector2
	/// @param {bool} return_radians
	/// @desc Returns the angle to the given vector.
	static angle_to = function(vector2, radians) {
		var _check = instanceof(vector2);
		if (is_string(_check)) {
			return (radians) ? arctan2(cross(vector2), dot(vector2)) : darctan2(cross(vector2), dot(vector2));
		} else {
			return undefined;
		}
	}
	
	/// @param vector2
	/// @param {bool} return_radians
	/// @desc Returns the angle between the line connecting the two points and the X axis.
	static angle_to_point = function(vector2, radians) {
		var _check = instanceof(vector2);
		if (is_string(_check)) {
			return (radians) ? arctan2(y - vector2.y, x - vector2.x) : darctan2(y - vector2.y, x - vector2.x);
		} else {
			return undefined;
		}
	}
	
	/// @desc Returns the length (magnitude) of this vector.
	static length = function() {
		return sqrt(x * x + y * y);
	}
	
	/// @desc Returns the squared length (squared magnitude) of this vector. Faster than length().
	static length_squared = function() {
		return (x * x + y * y);
	}
	
	/// @desc Normalizes the vector's components to be between 0 and 1.
	static normalize = function() {
		var _l = length_squared();
		if (_l != 0) {
			_l = sqrt(_l);
			x = x / _l;
			y = y / _l;
		}
	}
	
	/// @desc Returns the vector scaled to unit length.
	static normalized = function() {
		var _vector = new Vector2(self.x, self.y);
		_vector.normalize();
		return _vector;
	}
	
	/// @param normal
	/// @desc Returns the reflected vector based on the normal vector
	static reflect = function(normal) {
		var _dn = self.dot(normal);
		var _mult = normal.multiply(2 * _dn);
		return subtract(_mult);
	}
	
	/// @param vector
	/// @desc Returns a vector from the two vectors added
	static add = function(vector) {
		return new Vector2(self.x + vector.x, self.y + vector.y);
	}
	
	/// @param scalar
	static multiply = function(scalar) {
		return new Vector2(self.x * scalar, self.y * scalar);
	}
	
	/// @param vector
	/// @desc Returns a vector from the two vectors subtracted
	static subtract = function(vector) {
		return new Vector2(self.x - vector.x, self.y - vector.y);
	}
	
	/// @desc Returns true if the vector is normalized, and false otherwise.
	static is_normalized = function() {
		var _epsilon = 0.0001;
		var _difference = abs(length_squared() - 1.0);
		return (_difference < _epsilon);
	}
	
	/// @param vector2
	/// @desc Returns the distance between the two vectors.
	static distance_to = function(vector2) {
		var _check = instanceof(vector2);
		if (is_string(_check)) {
			return sqrt((x - vector2.x) * (x - vector2.x) + (y - vector2.y) * (y - vector2.y));
		} else {
			return undefined;
		}
	}
	
	/// @param vector2
	/// @desc Returns the squared distance between the two vectors. Faster than distance_to().
	static distance_to_squared = function(vector2) {
		var _check = instanceof(vector2);
		if (is_string(_check)) {
			return ((x - vector2.x) * (x - vector2.x) + (y - vector2.y) * (y - vector2.y));
		} else {
			return undefined;
		}
	}
	
	/// @param vector2
	/// @desc Returns the dot product.
	static dot = function(vector2) {
		return (x * vector2.x + y * vector2.y);
	}
	
	/// @param vector2
	/// @desc Returns the cross product.
	static cross = function(vector2) {
		return (x * vector2.x - y * vector2.y);
	}
	
	/// @desc Returns the vector with each component set to one or negative one, depending on the signs of the components, or zero if the component is zero.
	static signv = function() {
		return (new Vector2(sign(x), sign(y)));
	}
	
	/// @desc Returns the vector with all components rounded down.
	static floorv = function() {
		return (new Vector2(floor(x), floor(y)));
	}
	
	/// @desc Returns the vector with all components rounded up.
	static ceilv = function() {
		return (new Vector2(ceil(x), ceil(x)));
	}
	
	/// @desc Returns the vector with all components rounded.
	static roundv = function() {
		return (new Vector2(round(x), round(y)));
	}
	
	/// @param new_direction
	/// @desc Returns the vector rotated by the amount supplied in degrees.
	static rotated = function(new_direction) {
		return new Vector2(lengthdir_x(length(), new_direction), lengthdir_y(length(), new_direction));
	}
	
	/// @param by_amount
	/// @param {bool} by_radians?
	/// @desc Returns the vector rotated by the amount supplied in degrees or radians.
	static rotated2 = function(by_amount, radians) {
		var _sine = (radians) ? sin(by_amount) : dsin(by_amount);
		var _cosi = (radians) ? cos(by_amount) : dcos(by_amount);
		return (new Vector2(x * _cosi - y * _sine, x * _sine + y * _cosi));
	}
	
	/// @param vector2
	/// @desc Returns the vector projected onto the given vector.
	static project = function(vector2) {
		return (vector2 * (dot(vector2) / vector2.length_squared()));
	}
	
	/// @param vector2
	/// @desc Returns this vector with each component snapped to the nearest multiple of step.
	static snapped = function(vector2) {
		return new Vector2(floor(x / vector2.x + 0.5) * vector2.x, floor(y / vector2.y + 0.5) * vector2.y);
	}
	
	/// @param max_length
	/// @desc Returns the vector with a maximum length by limiting its length to length.
	static clamped = function(max_length) {
		var _length = length();
		var _vector = self;
		if (_length > 0 and max_length < _length) {
			_vector.x /= _length;
			_vector.y /= _length;
			_vector.x *= max_length;
			_vector.y *= max_length;
		}
		
		return _vector;
	}
	
	/// @param vector2
	/// @param delta
	/// @desc Moves the vector toward vector2 by the fixed delta amount.
	static move_toward = function(vector2, delta) {
		var _vector = self;
		var _epsilon = 0.0001;
		var _vector_delta = new Vector2(vector2.x - _vector.x, vector2.y - _vector.y);
		var _length = _vector_delta.length();
		
		if (_length <= delta or _length < _epsilon) {
			return new Vector2(vector2.x, vector2.y);
		} else {
			return new Vector2(_vector.x + _vector_delta.x / _length * delta, _vector.y + _vector_delta.y / _length * delta);
		}
	}
	
	/// @param target_direction
	/// @param delta
	/// @desc Moves the vector's direction towards the given direction by the fixed delta amount.
	static turn_toward = function(target_direction, delta) {
		var _direction = point_direction(0, 0, x, y);
		_direction += median(-delta, delta, angle_difference(target_direction, _direction));
		_direction = abs(_direction + 360) mod 360;
		return new Vector2(lengthdir_x(length(), _direction), lengthdir_y(length(), _direction));
	}
	
	/// @param vector2
	/// @desc Returns true if this vector and v are approximately equal.
	static is_approx_equal = function(vector2) {
		var _epsilon = 0.0001;
		var _x_difference= abs(x - vector2.x);
		var _y_difference = abs(y - vector2.y);
		return (_x_difference < _epsilon and _y_difference < _epsilon);
	}
	
	static toString = function() {
		return ("{" + string(x) + ", " + string(y) + "}");
	}
}