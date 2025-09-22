extends Entity

func _physics_process(_delta):
	var direction: Vector2
	if is_instance_valid(target):
		direction = global_position.direction_to(target.global_position)
		animation_player.play("walk")
	else:
		target = ability_handler.find_target()
		animation_player.play("RESET")
	var speed = ability_handler.get_move_speed(250)
	velocity = lerp(velocity, direction * speed, 0.5)
	movement()
