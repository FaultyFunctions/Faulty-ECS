for (var i = 0; i < array_length(systems); i++) {
	if (systems[i].roomEnd != undefined) {
		systems[i].roomEnd();
	}
}