extends State

@export var next: State

func on_enter() -> void:
	super()
	
	if randi() % 2 == 0:
		user.global_position = Vector2(860, randf_range(40, 560))
		if randi() % 2 == 0:
			user.global_position.x = 40
	else:
		user.global_position = Vector2(randf_range(40, 860), 560)
		if randi() % 2 == 0:
			user.global_position.y = 40
	
	state_handler.change_state(next)
