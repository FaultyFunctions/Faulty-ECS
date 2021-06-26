function array_find(array, value) {
	for (var i = array_length(array) - 1; i >= 0; --i) {
		if (array[i] == value) {
			return i;
		}
	}
	
	return -1;
}

function array_contains(array, value) {
	return bool(array_find(array, value) + 1);
}

function array_filter(array, func) {
	var _return_array = [];
	
	var _index = 0;
	repeat (array_length(array)) {
		if (func(array[_index], _index, array)) {
			array_push(_return_array, array[_index]);
		}
		++_index;
	}
	
	return _return_array;
}