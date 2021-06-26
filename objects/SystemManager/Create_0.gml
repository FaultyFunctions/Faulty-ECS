#macro CH_ENTITY_ADD "Add_Entity"
#macro CH_ENTITY_REMOVE "Remove_Entity"

/// @description Init
system_updater_receiver = new Receiver([CH_ENTITY_ADD, CH_ENTITY_REMOVE]);
systems = [];

/// @param system[s]
function system_add(system) {
	if (is_array(system)) {
		for (var i = 0; i < array_length(system); i++) {
			array_push(systems, system[i]);
			if (system[i].create != undefined) {
				system[i].create();
			}
		}
	} else {
		array_push(systems, system);
		if (system.create != undefined) {
			system.create();
		}
	}
}

/// @param system[s]/all
function system_destroy(system) {
	if (system == all) {
		for (var i = 0; i < array_length(systems); i++) {
			if (systems[i].destroy != undefined) {
				systems[i].destroy();
			}
			delete begin_step_systems[i];
		}
		array_resize(systems, 0);
	} else if (is_array(system)) {
		for (var i = 0; i < array_length(system); i++) {
			__system_destroy_find(system[i]);
		}
	} else {
		__system_destroy_find(system);
	}
}

__system_destroy_find = function(system) {
	// SEARCH BEGIN STEP SYSTEMS
	for (var i = array_length(systems) - 1; i >= 0; i--) {
		if (systems[i].name == system) {
			if (systems[i].destroy != undefined) {
				systems[i].destroy();
			}
			delete systems[i];
			array_delete(systems, i, 1);
		}
	}
}