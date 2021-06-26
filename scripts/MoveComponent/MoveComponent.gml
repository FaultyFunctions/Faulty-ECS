enum CollisionType {
	NONE,
	SIMPLE
}

function MoveComponent(collision_type) : IComponent() constructor {
	self.collision_type = collision_type;
	velocity = new Vector2(0, 0);
	enabled = true;
	collided = false;
}

function mask_get_width(inst) {
	inst = is_undefined(inst) ? id : inst;
	var _mask = (inst.mask_index != -1) ? inst.sprite_index : inst.mask_index;
	return sprite_get_bbox_right(_mask) - sprite_get_bbox_left(_mask);
}

function mask_get_height(inst) {
	inst = is_undefined(inst) ? id : inst;
	var _mask = (inst.mask_index != -1) ? inst.sprite_index : inst.mask_index;
	return sprite_get_bbox_bottom(_mask) - sprite_get_bbox_top(_mask);
}

function mask_get_offset_x(inst) {
	inst = is_undefined(inst) ? id : inst;
	var _mask = (inst.mask_index != -1) ? inst.sprite_index : inst.mask_index;
	var _mask_center = (sprite_get_bbox_left(_mask) + sprite_get_bbox_right(_mask)) / 2;
	return (_mask_center - inst.sprite_xoffset)
}

function mask_get_offset_y(inst) {
	inst = is_undefined(inst) ? id : inst;
	var _mask = (inst.mask_index != -1) ? inst.sprite_index : inst.mask_index;
	var _mask_center = (sprite_get_bbox_top(_mask) + sprite_get_bbox_bottom(_mask)) / 2;
	return (_mask_center - inst.sprite_yoffset)
}