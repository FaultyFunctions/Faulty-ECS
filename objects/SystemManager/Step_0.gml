for (var i = 0; i < array_length(systems); i++) {
	var _system = systems[i];
	if (global.pause and _system.is_pausable()) { continue; }
	
	if (_system.step != undefined) {
		_system.step();
	}
}