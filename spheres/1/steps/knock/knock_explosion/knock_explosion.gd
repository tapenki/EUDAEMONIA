extends "res://generic/projectiles/explosion.gd"

func _physics_process(delta):
	super(delta)
	var room = get_node("/root/Main").room_node
	if is_instance_valid(room) and room.has_node("Doors"):
		for door in room.get_node("Doors").get_children():
			if door.has_method("unlock") and door.locked and (door.global_position - global_position).length() < 50 * global_scale.x + 30:
				door.unlock()
