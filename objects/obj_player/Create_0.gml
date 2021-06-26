/// @description Player State Definitions

// Inherit the parent event
event_inherited();

var _fsm = new StateMachineComponent();

_fsm.createState("Idle")
	.addComponent(SpriteComponent).withSingleton(new SpriteComponent(spr_player_idle)).endComponent()
	.createTransition("Move")
		.addConsideration(new MoveInputConsideration())
		.endTransition()

_fsm.createState("Move")
	.addComponent(SpriteComponent).withSingleton(new SpriteComponent(spr_player_move)).endComponent()
	.addComponent(VelocityComponent).withData(new VelocityComponent(4)).endComponent()
	.addComponent(PlayerMoveTag).endComponent()
	.createTransition("Idle")
		.addConsideration(new NoMoveInputConsideration())
		.endTransition()

_fsm.setInitialState("Idle");

component_add(id, [
	_fsm,
	new CameraFollowComponent(),
	new MoveComponent(CollisionType.SIMPLE)
]);