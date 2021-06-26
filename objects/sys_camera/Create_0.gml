/// @description Init

// Inherit the parent event
event_inherited();

system_add([
	new CameraSystem([CameraFollowComponent]),
	new CameraShakeSystem([CameraShakeComponent])
])