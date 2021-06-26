function ISystem(requirements) constructor {
	self.__requirements = requirements;
	self.__pausable = true;
	
	self.name = instanceof(self);
	self.entities = [];
	self.entity_count = 0;
	self.manager = other.id;
	
	debug = false;
	
	if (requirements != undefined) {
		// SET UP UPDATE MESSAGES
		if (is_array(requirements)) {
			for (var i = 0; i < array_length(requirements); ++i) {
				manager.system_updater_receiver.on(requirements[i], CH_ENTITY_ADD, function(entity) {
					updateEntities(entity, CH_ENTITY_ADD);
				});
				manager.system_updater_receiver.on(requirements[i], CH_ENTITY_REMOVE, function(entity) {
					updateEntities(entity, CH_ENTITY_REMOVE);
				});
			
			}
		} else {
			manager.system_updater_receiver.on(requirements, CH_ENTITY_ADD, function(entity) {
				updateEntities(entity, CH_ENTITY_ADD);
			});
			manager.system_updater_receiver.on(requirements, CH_ENTITY_REMOVE, function(entity) {
				updateEntities(entity, CH_ENTITY_REMOVE);
			});
		}
	}
	
	static create = undefined;
	
	static beginStep = undefined;
	
	static step = undefined;
	
	static endStep = undefined;
	
	static drawBegin = undefined;
	
	static draw = undefined;
	
	static drawEnd = undefined;
	
	static drawGUI = undefined;
	
	static roomStart = undefined;
	
	static roomEnd = undefined;
	
	static destroy = undefined;
	
	static enterSystem = undefined;
	
	static exitSystem = undefined;
	
	static updateEntities = function(entity, operation) {
		switch (operation) {
			case CH_ENTITY_ADD:
				if (__requirements_met(entity) and !array_contains(entities, entity)) {
					array_push(entities, entity);
					entity_count = array_length(entities);
					if (enterSystem != undefined) {
						enterSystem(entity);
					}
				}
				break;
			case CH_ENTITY_REMOVE:
				var _index = array_find(entities, entity);
				if (_index != -1) {
					array_delete(entities, _index, 1);
					entity_count = array_length(entities);
					if (exitSystem != undefined) {
						exitSystem(entity);
					}
				}
				break;
		}
	}
	
	static pausable = function(value) {
		__pausable = value;
	}
	
	static is_pausable = function() {
		return __pausable;
	}
	
	static __requirements_met = function(entity) {
		var _has_components = true;
		
		if (is_array(__requirements)) {
			for (var i = 0; i < array_length(__requirements); ++i) {
				var _comp_check = entity.__components[$ __requirements[i]];
				_has_components = _has_components and !is_undefined(_comp_check);
			}
		} else {
			var _comp_check = entity.__components[$ __requirements];
			_has_components = !is_undefined(_comp_check);
		}
		return _has_components;
	}
}