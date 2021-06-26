/// @description Init

// Inherit the parent event
event_inherited();

system_add([
	new AnimationPauseSystem(),
	new AnimationSystem(SpriteComponent)
]);