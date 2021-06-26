#macro NO_COLLISION 0
#macro OBJ_COLLISION 1
#macro TILE_COLLISION 2

function MovementSystem(requirements) : ISystem(requirements) constructor {
	static endStep = function() {
		for (var i = 0; i < entity_count; i++) {
			var _e = entities[i];
			var _move = component_get(_e, MoveComponent);
			if (_move.enabled == false) { continue; }
			
			// PROCESS VELOCITY COMPONENT
			if (component_exists(_e, VelocityComponent)) {
				var _velocity = component_get(_e, VelocityComponent);
				_move.velocity.x = lengthdir_x(_velocity.speed, _velocity.direction);
				_move.velocity.y = lengthdir_y(_velocity.speed, _velocity.direction);
			} else if (component_exists(_e, FrictionComponent)) {
				var _friction = component_get(_e, FrictionComponent);
				_move.velocity = _move.velocity.move_toward(global.zero_vector, _friction.amount);
			} else {
				//// SAMPLE FLOOR FOR FRICTION VALUES?
				_move.velocity = _move.velocity.move_toward(global.zero_vector, 1);
			}
			
			// PROCESS IMPULSE COMPONENT
			if (component_exists(_e, ImpulseComponent)) {
				var _impulse = component_get(_e, ImpulseComponent);
				var _comp_x = lengthdir_x(_impulse.force, _impulse.direction);
				var _comp_y = lengthdir_y(_impulse.force, _impulse.direction);
				_move.velocity.x += _comp_x;
				_move.velocity.y += _comp_y;
				component_remove(_e, ImpulseComponent);
			}
			
			// PROCESS IMPULSE FACING COMPONENT
			if (component_exists(_e, ImpulseFacingComponent)) {
				var _impulse = component_get(_e, ImpulseFacingComponent);
				var _facing = component_get(_e, FacingDirectionComponent);
				var _comp_x = lengthdir_x(_impulse.force, _facing.direction * 90);
				var _comp_y = lengthdir_y(_impulse.force, _facing.direction * 90);
				_move.velocity.x += _comp_x;
				_move.velocity.y += _comp_y;
				component_remove(_e, ImpulseFacingComponent);
			}
			
			var _collided = false;
			
			switch (_move.collision_type) {
				case CollisionType.NONE:
					_e.x += _move.velocity.x;
					_e.y += _move.velocity.y;
					break;
				case CollisionType.SIMPLE:
					_collided = simpleCollision(_e, _move.velocity);
					break;
			}
			
			_move.collided = _collided;
		}
	}
}

function simpleCollision(entity, velocity) {
	var _xcomp = velocity.x;
	var _ycomp = velocity.y;
	var _xsign = sign(_xcomp);
	var _ysign = sign(_ycomp);
			
	var _repeat_amount = max(abs((_xcomp & ~0) + _xsign), abs((_ycomp & ~0) + _ysign));
	repeat (_repeat_amount) {
		// X COMPONENT
		if (_xcomp != 0) {
			with (entity) {
				var _collision = false;
				var _coll_objects = tag_get_asset_ids("SolidTag", asset_object);
				for (var i = 0; i < array_length(_coll_objects); ++i) {
					if (place_meeting(x + _xsign, y, _coll_objects[i])) { _collision = true; }
				}
			}
			if (!_collision) {
				if (abs(_xcomp) >= 1) { // Subtract 1
					entity.x += _xsign;
					_xcomp -= _xsign;
				} else { // If _xcomp is fractional, subtract the entire _xcomp
					entity.x += _xcomp;
					_xcomp = 0;
				}
			}
		}
			
		// Y COMPONENT
		if (_ycomp != 0) {
			with (entity) {
				var _collision = false;
				var _coll_objects = tag_get_asset_ids("SolidTag", asset_object);
				for (var i = 0; i < array_length(_coll_objects); ++i) {
					if (place_meeting(x, y + _ysign, _coll_objects[i])) { _collision = true; }
				}
			}
			if (!_collision) {
				if (abs(_ycomp) >= 1) { // Subtract 1
					entity.y += _ysign;
					_ycomp -= _ysign;
				} else { // If _xcomp is fractional, subtract the entire _ycomp
					entity.y += _ycomp;
					_ycomp = 0;
				}
			}
		}
			
		// Early Exit
		if ((_xcomp == 0 and _ycomp == 0) or (entity.x == entity.xprevious and entity.y == entity.yprevious)) { break; }
	}
}