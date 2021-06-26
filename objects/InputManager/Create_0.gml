/// @description Init Inputs

#macro INPUT_RIGHT ord("D")
#macro INPUT_LEFT ord("A")
#macro INPUT_UP ord("W")
#macro INPUT_DOWN ord("S")

get_x = function() {
	return keyboard_check(INPUT_RIGHT) - keyboard_check(INPUT_LEFT);
}

get_y = function() {
	return keyboard_check(INPUT_DOWN) - keyboard_check(INPUT_UP);
}