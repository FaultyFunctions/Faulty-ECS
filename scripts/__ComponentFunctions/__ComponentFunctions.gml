function component_add(entity, component) {
	// ADD COMPONENT DATA TO ENTITY
	if (is_array(component)) {
		for (var i = 0; i < array_length(component); i++) {
			var _index = asset_get_index(instanceof(component[i]));
			entity.__components[$ _index] = component[i];
			// SEND MESSAGE TO SYSTEMS THAT THIS ENTITY HAS CHANGED
			broadcast_channel(_index, CH_ENTITY_ADD, entity);
			asset_add_tags(entity, instanceof(component[i]), asset_object);
		}
	} else {
		var _index = asset_get_index(instanceof(component));
		entity.__components[$ _index] = component;
		// SEND MESSAGE TO SYSTEMS THAT THIS ENTITY HAS CHANGED
		broadcast_channel(_index, CH_ENTITY_ADD, entity);
		asset_add_tags(entity, instanceof(component), asset_object);
	}
}

function component_get(entity, component_name) {
	if (component_name == all) {
		return entity.__components;
	} else {
		return entity.__components[$ component_name];
	}
}

function component_remove(entity, component_name) {
	if (component_name == all) {
		var _names = variable_struct_get_names(entity.__components);
		for (var i = 0; i < array_length(_names); i++) {
			asset_remove_tags(entity, script_get_name(_names[i]), asset_object);
			// SEND MESSAGE TO SYSTEMS THAT THIS ENTITY HAS CHANGED
			broadcast_channel(_names[i], CH_ENTITY_REMOVE, entity);
			delete entity.__components[$ _names[i]];
		}
		entity.__components = {};
	} else if (is_array(component_name)) {
		for (var i = 0; i < array_length(component_name); i++) {
			asset_remove_tags(entity, script_get_name(component_name[i]), asset_object);
			if (variable_struct_exists(entity.__components, component_name[i])) {
				// SEND MESSAGE TO SYSTEMS THAT THIS ENTITY HAS CHANGED
				broadcast_channel(component_name[i], CH_ENTITY_REMOVE, entity);
				delete entity.__components[$ component_name[i]];
			}
		}
	} else {
		asset_remove_tags(entity, script_get_name(component_name), asset_object);
		if (variable_struct_exists(entity.__components, component_name)) {
			// SEND MESSAGE TO SYSTEMS THAT THIS ENTITY HAS CHANGED
			broadcast_channel(component_name, CH_ENTITY_REMOVE, entity);
			delete entity.__components[$ component_name];
			variable_struct_remove(entity.__components, component_name);
		}
	}
}

function component_exists(entity, component) {
	if (variable_instance_exists(entity, "__components")) {
		return variable_struct_exists(entity.__components, component);
	} else {
		return false;
	}
}

function IComponent() constructor {
	debug = false;
}