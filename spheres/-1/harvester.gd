extends Node2D

var target: Node
var speed = 100

func _physics_process(delta: float) -> void:
	if not target:
		return
	var distance = global_position.distance_to(target.global_position)
	if distance <= 100:
		get_node("/root/Main").travel("hell_entrance_hall", "Entrance0")
		queue_free()
		return
	var to_target = global_position.direction_to(target.global_position)
	global_position += to_target * speed * delta
